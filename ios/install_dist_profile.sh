#!/usr/bin/env sh

DIST_PROFILE_FILE=${DIST_PROVISION_UUID}.mobileprovision

# Recreate the certificate from the secure environment variable
echo $DIST_PROVISION | base64 --decode > $DIST_PROFILE_FILE

# copy where Xcode can find it
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ${DIST_PROFILE_FILE} ~/Library/MobileDevice/Provisioning\ Profiles

# clean
rm -fr *.mobileprovision