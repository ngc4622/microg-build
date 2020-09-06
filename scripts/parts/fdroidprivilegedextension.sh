echo "Building F-Droid privileged extension"

cd $BUILD_DIR/privileged-extension
echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties
# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew assembleRelease > /dev/null
cp app/build/outputs/apk/F-DroidPrivilegedExtension-release-unsigned.apk $OUTPUTS/F-DroidPrivilegedExtension-release-unsigned.apk

# And sign it
cd $OUTPUTS
echo "Signing F-Droid privileged extension"
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks F-DroidPrivilegedExtension-release-unsigned.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 F-DroidPrivilegedExtension-release-unsigned.apk F-DroidPrivilegedExtension.apk > /dev/null
rm F-DroidPrivilegedExtension-release-unsigned.apk
