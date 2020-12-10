#!/bin/sh

TARGET_DIR="$1"

# template/script to apply to a repo, for stripping files and other
# transformations

# delete files not needed in our fork
DELETIONS=".editorconfig
.gitattributes
.github
.php_cs.dist
CHANGELOG.md
LICENSE
Makefile
phpstan-baseline.neon
phpstan.neon.dist
phpunit.xml.dist
psalm.baseline.xml
tests
"

for DELETIONTARGET in $DELETIONS
do
  echo "Deleting $DELETIONTARGET"
  rm -Rf "${TARGET_DIR:?}/${DELETIONTARGET}"
done

# replace README contents
echo 'Safely namespaced fork of [guzzle/psr7](https://github.com/guzzle/psr7) for use in [WP2Static](https://github.com/leonstafford/wp2static), generated with [AriseByAnyOtherName](https://github.com/leonstafford/AriseByAnyOtherName).' > "${TARGET_DIR:?}/README.md"

ORIGINAL_DESCRIPTION='PSR-7 message implementation that also provides common utility methods'
NEW_DESCRIPTION='Safely namespaced guzzle psr7 for WP2Static'

# replace description in composer.json
  gsed -i "s/$ORIGINAL_DESCRIPTION/$NEW_DESCRIPTION/g" \
   "${TARGET_DIR:?}/composer.json" 

