echo "Building OpenBmapNlpBackend"

cd $BUILD_DIR/radiocells-nlp-android

echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties
# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew build > /dev/null
cp build/outputs/apk/release/radiocells-nlp-android-release-unsigned.apk $OUTPUTS/radiocells-nlp-android-release-unsigned.apk

# Sign APK
echo "Signing OpenBmapNlpBackend"

cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks radiocells-nlp-android-release-unsigned.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 radiocells-nlp-android-release-unsigned.apk OpenBmapNlpBackend.apk > /dev/null
rm radiocells-nlp-android-release-unsigned.apk
