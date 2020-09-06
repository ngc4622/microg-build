echo "Building GSFProxy"

cd $BUILD_DIR/android_packages_apps_GsfProxy
echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties
# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew build > /dev/null
cp services-framework-proxy/build/outputs/apk/services-framework-proxy-release-unsigned.apk $OUTPUTS/services-framework-proxy-release-unsigned.apk

# Sign APK
echo "Signing GSFProxy"
cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks services-framework-proxy-release-unsigned.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 services-framework-proxy-release-unsigned.apk GSFProxy.apk > /dev/null
rm services-framework-proxy-release-unsigned.apk
