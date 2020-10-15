#!/usr/bin/env bash

TARGET_TAG=$1

git config user.email "broadbot@broadinstitute.org"
git config user.name "broadbot"
git_hash=$(git rev-parse --short "$GITHUB_SHA")

# Code borrowed from https://github.com/fsaintjacques/semver-tool/blob/master/src/semver
NAT='0|[1-9][0-9]*'
ALPHANUM='[0-9]*[A-Za-z-][0-9A-Za-z-]*'
IDENT="$NAT|$ALPHANUM"
FIELD='[0-9A-Za-z-]+'

SEMVER_REGEX="\
^[vV]?\
($NAT)\\.($NAT)\\.($NAT)\
(\\-(${IDENT})(\\.(${IDENT}))*)?\
(\\+${FIELD}(\\.${FIELD})*)?$"

function bumpVersion {
  local version=$1
  if [[ "$version" =~ $SEMVER_REGEX ]]; then
    # if a second argument is passed, store the result in var named by $2
    local major=${BASH_REMATCH[1]}
    local minor=${BASH_REMATCH[2]}
    local patch=$((${BASH_REMATCH[3]} + 1))
    NEW_VERSION=$major.$minor.$patch
  else
    error "version $version does not match the semver scheme 'X.Y.Z(-PRERELEASE)(+BUILD)'. See help for more information."
  fi
}

oldVersion=$(cat charts/leonardo/Chart.yaml|grep version|cut -d' ' -f 2)
bumpVersion $oldVersion
sed -i "s/version: .*/version: $NEW_VERSION/g" charts/leonardo/Chart.yaml
sed -i "s/$TARGET_TAG: .*/$TARGET_TAG: $git_hash/g" charts/leonardo/values.yaml
git commit -am "bump $TARGET_TAG version"