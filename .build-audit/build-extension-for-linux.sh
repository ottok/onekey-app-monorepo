#!/bin/bash

set -e

# Ensure packages are installed at project root level
yarn

# Export path so that cross-env and electorn-builder can be used
export PATH="$PWD/node_modules/.bin:$PATH"

cd apps/ext

# yarn build:all
  # yarn clean
    # yarn clean:build
    rimraf ./build
    rimraf .tamagui
    rimraf ./node_modules/.cache
  # yarn build
  # Re-emit 'NODE_ENV=production' here in case the cross-env interferes
  cross-env NODE_ENV=production webpack build
node ../../development/webpack/ext/zip.js

# Expect to find something similar to OneKey-Wallet-5.5.0-chrome_v3-extension.zip
find apps/ext/build/_dist/ -name *.zip -ls
