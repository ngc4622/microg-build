echo "Building F-Droid"

cd $BUILD_DIR/fdroidclient
echo "sdk.dir=$ANDROID_SDK_PATH" > local.properties
echo "sdk-location=$ANDROID_SDK_PATH" >> local.properties

# Add some memory to avoid build problems
echo "org.gradle.jvmargs=-Xmx2048m -XX:+HeapDumpOnOutOfMemoryError" >> gradle.properties
./gradlew assembleRelease > /dev/null
cp /home/tobias/sources/microg/microg/fdroidclient/app/build/outputs/apk/full/release/app-full-release-unsigned.apk $OUTPUTS/FDroid-unsigned.apk

# And sign it
echo "Signing F-Droid"

cd $OUTPUTS
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORES_PATH/playservices.jks FDroid-unsigned.apk playservices
$ANDROID_SDK_PATH/build-tools/29.0.3/zipalign -p -v 4 FDroid-unsigned.apk F-Droid.apk > /dev/null
rm FDroid-unsigned.apk
