echo "Building Mozilla Backend"

cd $BUILD_DIR/IchnaeaNlpBackend

echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties
# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew build > /dev/null
cp build/outputs/apk/release/IchnaeaNlpBackend-release-unsigned.apk $OUTPUTS/IchnaeaNlpBackend-release-unsigned.apk

# Sign APK
echo "Signing Mozilla Backend"
cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks IchnaeaNlpBackend-release-unsigned.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 IchnaeaNlpBackend-release-unsigned.apk IchnaeaNlpBackend.apk > /dev/null
rm IchnaeaNlpBackend-release-unsigned.apk
