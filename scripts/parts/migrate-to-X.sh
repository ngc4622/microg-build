cd $BUILD_DIR/android_frameworks_mapsv1
# run in maps v1
sed -i 's|def BUILD_TOOLS_VERSION = "23.0.2"|def BUILD_TOOLS_VERSION = "29.0.3"|g' mapsv1-flashable/build.gradle
sed -i 's|compileSdkVersion 23|compileSdkVersion 29|g' mapsv1-compat-osmdroid/build.gradle
sed -i 's|buildToolsVersion "23.0.2"|buildToolsVersion "29.0.3"|g' mapsv1-compat-osmdroid/build.gradle

cd $BUILD_DIR/radiocells-nlp-android
# run in radiocells
sed -i "s|implementation 'com.android.support:support-annotations:28.0.0'|implementation 'androidx.annotation:annotation:1.0.0'|g" build.gradle
sed -i "s|implementation 'com.android.support:support-compat:28.0.0'|implementation 'androidx.core:core:1.0.0'|g" build.gradle
sed -i "s|implementation 'com.android.support:appcompat-v7:28.0.0'|implementation 'androidx.appcompat:appcompat:1.0.0'|g" build.gradle
echo "android.enableJetifier=true" >> gradle.properties
echo "android.useAndroidX=true" >> gradle.properties

cd $BUILD_DIR/IchnaeaNlpBackend
sed -i 's|compileSdkVersion 27|compileSdkVersion 29|g' build.gradle
