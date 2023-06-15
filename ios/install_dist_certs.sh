# Unlock the keychain
security unlock-keychain -p $BUILD_KEY_CHAIN_PASS $BUILD_KEY_CHAIN

security set-keychain-settings $BUILD_KEY_CHAIN

security import $CERTIFICATE_P12 -k $BUILD_KEY_CHAIN -P $APPLE_DISTRIBUTION_CERTIFICATE_PASSWORD -T /usr/bin/codesign;

security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k $BUILD_KEY_CHAIN_PASS $BUILD_KEY_CHAIN

# remove certs
rm -fr *.p12