#!/bin/bash

# Copyright MontFerret Team 2020
version=$(curl -sI https://github.com/MontFerret/lab/releases/latest | grep location | awk -F"/" '{ printf "%s", $NF }' | tr -d '\r')
if [ ! $version ]; then
    echo "Failed while attempting to install lab-cli. Please manually install:"
    echo ""
    echo "1. Open your web browser and go to https://github.com/MontFerret/lab/releases"
    echo "2. Download the latest release for your platform."
    echo "3. chmod +x ./lab"
    echo "4. mv ./lab /usr/local/bin"
    exit 1
fi

hasCli() {
    has=$(which lab)

    if [ "$?" = "0" ]; then
        echo
        echo "You already have the lab!"
        export n=5
        echo "Overwriting in $n seconds... Press Control+C to cancel."
        echo
        sleep $n
    fi

    hasCurl=$(which curl)

    if [ "$?" = "1" ]; then
        echo "You need curl to use this script."
        exit 1
    fi

    hasTar=$(which tar)

    if [ "$?" = "1" ]; then
        echo "You need tar to use this script."
        exit 1
    fi
}

checkHash(){
    sha_cmd="sha256sum"

    if [ ! -x "$(command -v $sha_cmd)" ]; then
        sha_cmd="shasum -a 256"
    fi

    if [ -x "$(command -v $sha_cmd)" ]; then

    (cd $targetDir && curl -sSL $baseUrl/lab_checksums.txt | $sha_cmd -c >/dev/null)
        if [ "$?" != "0" ]; then
            # rm $targetFile
            echo "Binary checksum didn't match. Exiting"
            exit 1
        fi
    fi
}

getPackage() {
    uname=$(uname)
    userid=$(id -u)

    platform=""
    case $uname in
    "Darwin")
    platform="_darwin"
    ;;
    "Linux")
    platform="_linux"
    ;;
    esac

    uname=$(uname -m)
    arch=""
    case $uname in
    "x86_64")
    arch="_x86_64"
    ;;
    esac
    case $uname in
    "aarch64")
    arch="_arm64"
    ;;
    esac

    if [ "$arch" == "" ]; then
        echo "${$arch} is not supported. Exiting"
        exit 1
    fi

    suffix=$platform$arch
    targetDir="/tmp/lab$suffix"

    if [ "$userid" != "0" ]; then
        targetDir="$(pwd)/lab$suffix"
    fi

    if [ ! -d $targetDir ]; then
        mkdir $targetDir
    fi

    targetFile="$targetDir/lab"

    if [ -e $targetFile ]; then
        rm $targetFile
    fi

    baseUrl=https://github.com/MontFerret/lab/releases/download/$version
    url=$baseUrl/lab$suffix.tar.gz
    echo "Downloading package $url as $targetFile"

    curl -sSL $url | tar xz -C $targetDir

    if [ "$?" = "0" ]; then

    # checkHash

    chmod +x $targetFile

    echo "Download complete."

    echo

    mv $targetFile /usr/local/bin/lab

    if [ "$?" = "0" ]; then
        echo "New version of lab installed to /usr/local/bin"
    fi

    if [ -d $targetDir ]; then
        rm -rf $targetDir
    fi

    lab --version
    fi
}

hasCli
getPackage