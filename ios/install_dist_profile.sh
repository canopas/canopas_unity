#!/usr/bin/env sh

DIST_PROFILE_FILE=${DIST_PROVISION_UUID}.mobileprovision

# Recreate the certificate from the secure environment variable
echo $DIST_PROVISION | base64 --decode > $DIST_PROFILE_FILE

mkdir -p "$HOME/Library/MobileDevice/Provisioning Profiles"

# copy where Xcode can find it
cp ${DIST_PROFILE_FILE} "$HOME/Library/MobileDevice/Provisioning Profiles/${DIST_PROVISION_UUID}.mobileprovision"

if [ -f "$HOME/Library/MobileDevice/Provisioning Profiles/${DIST_PROVISION_UUID}.mobileprovision" ]; then
    echo "Provisioning profile copied successfully."
else
    echo "Error: Provisioning profile copy failed."
fi

# clean
rm -fr *.mobileprovision