echo "Building NominatimGeocoderBackend"

cd $BUILD_DIR/NominatimGeocoderBackend

echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties
# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew build > /dev/null
cp build/outputs/apk/release/NominatimGeocoderBackend-release-unsigned.apk $OUTPUTS/NominatimGeocoderBackend-release-unsigned.apk

# Sign APK
echo "Signing NominatimGeocoderBackend"

cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks NominatimGeocoderBackend-release-unsigned.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 NominatimGeocoderBackend-release-unsigned.apk NominatimGeocoderBackend.apk > /dev/null
rm NominatimGeocoderBackend-release-unsigned.apk
