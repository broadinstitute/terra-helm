#!/usr/bin/env bash

TARGET_JOB=$1

git config user.email "broadbot@broadinstitute.org"
git config user.name "broadbot"
git_hash=$(git rev-parse --short "$GITHUB_SHA")

yq w -i  charts/leonardo/values.yaml $TARGET_JOB.imageTag $git_hash
git commit -am "bump $TARGET_JOB version"