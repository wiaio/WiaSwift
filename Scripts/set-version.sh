#!/bin/bash


echo "WIA_SDK_VERSION=$1" > Config.xcconfig
echo "WIA_SDK_VERSION=$1" > .env
echo "export WIA_SDK_VERSION=$1" > .envrc
direnv allow
