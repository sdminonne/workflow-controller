#!/bin/zsh

if [ -z "$1" ]; then
    echo "please provide the version as parameter: ./release.sh <version>\n"
    exit 1
fi

GIT_ROOT=$(git rev-parse --show-toplevel)
GIT_REMOTE="origin"
if [ -n "$2" ]; then
    GIT_REMOTE=$2
fi

zsh $GIT_ROOT/hack/helm-release.sh $1 workflow-controller

# Update CHANGELOG.md file
ssed -i.bak "5i## Release $1\n" CHANGELOG.md

git commit -am "release $1"
git tag -f $1
