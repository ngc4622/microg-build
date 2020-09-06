echo "Building gms core"

cd $BUILD_DIR/android_packages_apps_GmsCore
echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties
# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew build > /dev/null
cp play-services-core/build/outputs/apk/mapbox/release/play-services-core-mapbox-release-unsigned.apk $OUTPUTS/play-services-core-release.apk


# Sign APK
echo "Signing gms core"

cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks play-services-core-release.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 play-services-core-release.apk com.google.android.gms.apk > /dev/null
rm play-services-core-release.apk
