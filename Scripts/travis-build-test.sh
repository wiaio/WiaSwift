#!/bin/sh

set -x -o pipefail

echo "Building"

rm -rf ${HOME}/Library/Developer/Xcode/DerivedData/*

if [[ "$SWIFT_BUILD" == "true" ]]; then
    swift build
    exit 0
fi

# -jobs -- specify the number of concurrent jobs
# `sysctl -n hw.ncpu` -- fetch number of 'logical' cores in macOS machine
user_access_token=${WIA_TEST_USER_ACCESS_TOKEN} xcodebuild -jobs `sysctl -n hw.ncpu` test -workspace WiaSwift.xcworkspace -scheme ${SCHEME} -sdk ${SDK} \
  -destination "platform=${PLATFORM}" ONLY_ACTIVE_ARCH=YES CODE_SIGNING_IDENTITY="" \
   CODE_SIGNING_REQUIRED=NO user_access_token=u_at_QrygMzIlSUaiakTytPOVILpNcTmwMvdO | bundle exec xcpretty -c
