#!/usr/bin/env bash

TARGET_TAG=$1

git config user.email "broadbot@broadinstitute.org"
git config user.name "broadbot"
git_hash=$(git rev-parse --short "$GITHUB_SHA")

sed -i "s/$TARGET_TAG: .*/$TARGET_TAG: $git_hash/g" charts/leonardo/values.yaml
git commit -am "bump $TARGET_TAG version"