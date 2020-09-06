#!/bin/bash

export BUILD_DIR=$(pwd)/microg
export TOP_DIR=$(pwd)
export OUTPUTS=$BUILD_DIR/outputs

export ANDROID_SDK_PATH="/home/$USER/Android/Sdk"
export KEYSTORES_PATH="$TOP_DIR/keystores"

export ANDROID_HOME=$ANDROID_SDK_PATH
export ANDROID_SDK_ROOT=$NADROID_SDK_PATH


if [ -d "$BUILD_DIR" ]; then
    echo "Sources dir found"
    cd $BUILD_DIR
else
    echo "Sources dir not found. Downloading sources..."
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR
    # clone microg
    git clone https://github.com/microg/android_frameworks_mapsv1.git
    git clone https://github.com/microg/android_packages_apps_GmsCore.git
    git clone https://github.com/microg/android_packages_apps_GsfProxy.git
    git clone https://github.com/microg/FakeStore.git
    git clone https://github.com/microg/IchnaeaNlpBackend.git
    git clone https://github.com/ngc4622/NominatimGeocoderBackend.git -b androidX
    git clone https://github.com/openbmap/radiocells-nlp-android.git
    git clone https://github.com/microg/RemoteDroidGuard.git
    # clone F-Droid
    git clone https://gitlab.com/fdroid/fdroidclient.git -b 1.9
    git clone https://gitlab.com/fdroid/privileged-extension.git -b 0.2.11
fi

cd $TOP_DIR

if [ -f "$TOP_DIR/fixup.done" ]; then
    echo "Already done fixups"
else
    echo "Doing some fixups to solve build errors"
    source $TOP_DIR/scripts/parts/migrate-to-X.sh
    touch $TOP_DIR/fixup.done
fi

cd $TOP_DIR

echo "Cleaning output directory"
rm -rf $OUTPUTS
mkdir -p $OUTPUTS

if [ -d "$KEYSTORES_PATH" ]; then
    if [ -f "$KEYSTORES_PATH/playservices.jks" ]; then
        echo "Keystore found";
    else
        echo "Keystore not found. Generating keystore..."
        cd $KEYSTORES_PATH
        keytool -genkey -v -keystore $KEYSTORES_PATH/playservices.jks -alias playservices -keyalg RSA -keysize 4096 -validity 10000
    fi
else
    echo "Keystore not found. Generating keystore..."
    mkdir -p $KEYSTORES_PATH
    cd $KEYSTORES_PATH
    keytool -genkey -v -keystore $KEYSTORES_PATH/playservices.jks -alias playservices -keyalg RSA -keysize 4096 -validity 10000
fi

