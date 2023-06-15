
#!/usr/bin/env sh

DIST_PROFILE_FILE=${{ secrets.DIST_PROVISION_UUID }}.mobileprovision

# Recreate the certificate from the secure environment variable
echo ${{ secrets.DIST_PROVISION }} | base64 --decode > $DIST_PROFILE_FILE

# copy where Xcode can find it
cp ${DIST_PROFILE_FILE} "$HOME/Library/MobileDevice/Provisioning Profiles/${{ secrets.DIST_PROVISION_UUID }}.mobileprovision"

# clean
rm -fr *.mobileprovision