echo "Building FakeStore"

cd $BUILD_DIR/FakeStore
echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties

# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew build > /dev/null
cp fake-store/build/outputs/apk/release/fake-store-release-unsigned.apk $OUTPUTS/fake-store-release.apk

# And sign it
echo "Signing FakeStore"

cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks fake-store-release.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 fake-store-release.apk FakeStore.apk > /dev/null
rm fake-store-release.apk
