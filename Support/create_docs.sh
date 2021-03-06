#!/bin/bash

echo -e "Executing create_docs"

if [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then
    echo -e "Generating Jazzy output \n"
    
    jazzy --clean --author "Jonathan Landon" --author_url https://ovenbits.com --github_url https://github.com/jlandon/Alexandria --xcodebuild-arguments "-scheme,Alexandria" --module Alexandria --root-url https://jlandon.github.io/Alexandria --theme apple
    

    pushd docs

    echo -e "Creating gh-pages\n"
    git init
    git config user.email "travis@travis-ci.org"
    git config user.name "travis-ci"
    git add -A
    git commit -m "Publishing documentation from Travis build of $TRAVIS_COMMIT"
    git push --force --quiet "https://${GH_TOKEN}@github.com/jlandon/Alexandria.git" master:gh-pages > /dev/null 2>&1
    echo -e "Published documentation to gh-pages.\n"

    popd
fi
