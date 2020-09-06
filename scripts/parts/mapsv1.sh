echo "Building maps (v1)"
echo "Build error with creating zip can be safely ignored"

cd $BUILD_DIR/android_frameworks_mapsv1
echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties
# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew :mapsv1-flashable:assembleRelease > /dev/null
cp mapsv1-flashable/build/intermediates/flashableZip/system/framework/com.google.android.maps.jar $OUTPUTS/com.google.android.maps.unsigned.jar

# And sign it
echo "Signing maps (v1)"
cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks com.google.android.maps.unsigned.jar playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 com.google.android.maps.unsigned.jar com.google.android.maps.jar > /dev/null
rm com.google.android.maps.unsigned.jar
