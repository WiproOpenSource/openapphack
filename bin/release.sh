#!/bin/bash

VERSION="$1"
BRANCH="production"

#sanity
if [[ -z "$VERSION" ]]; then
	echo "Usage: release.sh <version>"
	exit 0
fi

#prepare branch
git checkout master
git branch -D "$BRANCH"
git checkout -b "$BRANCH"

#update version
sed -i "s/0.0.1-SNAPSHOT/$VERSION/g" config.groovy
git add config.groovy
git commit -m "Update version of $BRANCH to $VERSION"

#push branch
git push -f origin "$BRANCH:$BRANCH"

#push tag
git tag "$VERSION"
git push origin "$VERSION"

#bach to master branch
git checkout master
