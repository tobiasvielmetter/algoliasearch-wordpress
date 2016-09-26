#!/usr/bin/env bash

set -eu

rm -rf ./tmp
mkdir tmp
cd tmp

# Clone a fresh copy of the repository
git clone git@github.com:algolia/algoliasearch-wordpress.git .

# Get new tags from the remote
git fetch --tags

# Get the latest tag name
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)

# Checkout the latest tag
git checkout ${latestTag}

cd ..

# Clean & extract the assets intended for the plugin directory
rm -rf assets
mkdir assets

mv tmp/assets/*.png assets/

# Clean the trunk
rm -rf trunk
mkdir trunk

mv tmp/assets trunk/
mv tmp/includes trunk/
mv tmp/languages trunk/
mv tmp/templates trunk/
mv tmp/*.php trunk/
mv tmp/*.txt trunk/
mv tmp/*.json trunk/
mv tmp/CHANGELOG.md trunk/

rm -rf ./tmp

# Push the changes
svn add trunk/*
svn add assets/*
svn commit -m ${latestTag} --username algolia
