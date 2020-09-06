echo "Building DroidGuard"

cd $BUILD_DIR/RemoteDroidGuard
echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties

# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew build > /dev/null
cp app/build/outputs/apk/release/app-release-unsigned.apk $OUTPUTS/app-release-unsigned.apk

# And sign it
echo "Signing DroidGuard"

cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks app-release-unsigned.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 app-release-unsigned.apk DroidGuard.apk > /dev/null
rm app-release-unsigned.apk
