#!/bin/sh

export CI=true
export CODEBUILD=true

export CODEBUILD_GIT_BRANCH="$(git symbolic-ref HEAD --short 2>/dev/null)"
if [ "$CODEBUILD_GIT_BRANCH" = "" ] ; then
  CODEBUILD_GIT_BRANCH="$(git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }')";
  export CODEBUILD_GIT_BRANCH=${CODEBUILD_GIT_BRANCH#remotes/origin/};
fi

export CODEBUILD_PULL_REQUEST=false
if [ "${CODEBUILD_GIT_BRANCH#pr-}" != "$CODEBUILD_GIT_BRANCH" ] ; then
  export CODEBUILD_PULL_REQUEST=${CODEBUILD_GIT_BRANCH#pr-};
fi

echo CODEBUILD_GIT_BRANCH

