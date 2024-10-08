#!/bin/bash

set -euo pipefail

if [[ "$BUILDKITE_BRANCH" != "lucene_snapshot"* ]]; then
  echo "Error: This script should only be run on lucene_snapshot branches"
  exit 1
fi

if [[ "$BUILDKITE_BRANCH" == "lucene_snapshot_10" ]]; then
  UPSTREAM="main"
elif [[ "$BUILDKITE_BRANCH" == "lucene_snapshot" ]]; then
  UPSTREAM="8.x"
else
  echo "Error: unknown branch: $BUILDKITE_BRANCH"
  exit 1
fi

echo --- Updating "$BUILDKITE_BRANCH" branch with "$UPSTREAM"

git config --global user.name elasticsearchmachine
git config --global user.email 'infra-root+elasticsearchmachine@elastic.co'

git checkout "$BUILDKITE_BRANCH"
git fetch origin "$UPSTREAM"
git merge --no-edit "origin/$UPSTREAM"
git push origin "$BUILDKITE_BRANCH"
