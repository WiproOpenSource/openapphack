#!/bin/bash

RELEASE=$(grep 'openapphackVersion' config.groovy | sed 's_openapphackVersion = __g' | tr -d "'")

if [[ "$RELEASE" == "0.0.1-SNAPSHOT" ]]; then
	RELEASE="0.0.1-build-$DRONE_BUILD_NUMBER"
	sed -i "s/0.0.1-SNAPSHOT/$RELEASE/g" config.groovy
fi

echo "Release: $RELEASE"

./gradlew -Penv="$DRONE_BRANCH"
git add -f build
git commit -m "Release: $RELEASE"
