#!/usr/bin/env bash

# config
PLUGIN_DIR=$(pwd -P)
TMP_DIR="${PLUGIN_DIR}/build-tmp"


# remove current vendor directory to prevent "prefixing the prefixed vendor classes"
rm -rvf "${PLUGIN_DIR}/vendor"

# refresh depdendencies / prepare for php-scoper
composer install --no-dev --prefer-dist

# prefix everything
php-scoper add-prefix --output-dir="$TMP_DIR" --force -v

# refresh the autoload index in the build artifact, so, that the vendor/autoload.php is up to date
cd "${TMP_DIR}"
composer dump-autoload --classmap-authoritative --optimize

# kill vendor dir before we replace it
rm -rvf "${PLUGIN_DIR}/vendor"

# move the build artifact to the project vendor dir
mv -fv "${TMP_DIR}/vendor" "${PLUGIN_DIR}/vendor"

# cleanup
rm -rvf "$TMP_DIR"

# refresh autoloader to use our local classes in /lib via psr-4
cd "${PLUGIN_DIR}"
composer dump-autoload --optimize

# feedback
tree "${PLUGIN_DIR}/vendor" -L 1
