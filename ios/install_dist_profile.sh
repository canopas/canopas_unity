#!/usr/bin/env sh

DIST_PROFILE_FILE=$DIST_PROVISION_UUID.mobileprovision

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
echo $DIST_PROVISION | base64 --decode > ~/Library/MobileDevice/Provisioning\ Profiles/$DIST_PROFILE_FILE