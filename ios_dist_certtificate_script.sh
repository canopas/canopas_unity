#!/usr/bin/env sh

CERTIFICATE_P12=dist_certificate.p12

# Recreate the certificate from the secure environment variable
echo ${{ secrets.APPLE_DISTRIBUTION_CERT_N_KEY }} | base64 --decode > $CERTIFICATE_P12

# Unlock the keychain
security unlock-keychain -p ${{ secrets.BUILD_KEY_CHAIN_PASS }} ${{ secrets.BUILD_KEY_CHAIN }}

security set-keychain-settings ${{ secrets.BUILD_KEY_CHAIN }}

security import $CERTIFICATE_P12 -k ${{ secrets.BUILD_KEY_CHAIN }} -P ${{ secrets.APPLE_DISTRIBUTION_CERTIFICATE_PASSWORD }} -T /usr/bin/codesign;

security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k ${{ secrets.BUILD_KEY_CHAIN_PASS }} ${{ secrets.BUILD_KEY_CHAIN }}

# remove certs
rm -fr *.p12