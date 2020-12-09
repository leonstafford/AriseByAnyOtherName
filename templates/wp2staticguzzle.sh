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
Dockerfile
LICENSE
Makefile
UPGRADING.md
docs
phpstan-baseline.neon
phpstan.neon.dist
phpunit.xml.dist
psalm.baseline.xml
psalm.xml
tests
"

for DELETIONTARGET in $DELETIONS
do
  echo "Deleting $DELETIONTARGET"
  rm -Rf "${TARGET_DIR:?}/${DELETIONTARGET}"
done

# replace README contents
echo 'Safely namespaced fork of [Guzzle](https://github.com/guzzle/guzzle) for use in [WP2Static](https://github.com/leonstafford/wp2static), generated with [AriseByAnyOtherName](https://github.com/leonstafford/AriseByAnyOtherName).' > "${TARGET_DIR:?}/README.md"
