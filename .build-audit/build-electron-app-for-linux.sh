#!/bin/bash

set -e

# Ensure packages are installed at project root level
yarn

# Export path so that cross-env and electorn-builder can be used
export PATH="$PWD/node_modules/.bin:$PATH"

cd apps/desktop

# yarn build
  # yarn keytar
  node development/build_keytar.js
  # yarn clean:build
  rimraf ./build-electron
  rimraf ./build
  rimraf ./dist
  rimraf ./node_modules/.cache
  # yarn build:rendered
  rm -rf ./build
  rm -rf ./web-build
  webpack build
  mv ./web-build ./build
  rsync -a public/static/ build/static
  # yarn build:main
  # Re-emit 'NODE_ENV=production' here in case the cross-env interferes
  rimraf ./dist
  cross-env NODE_ENV=production node scripts/build.js
  # yarn build:electron --publish never
  # removed -m to exclude Mac and -w for Windows
  electron-builder build -l --config electron-builder.config.js --publish never

# Expect to find something similar to apps/desktop/build-electron/OneKey-Wallet-5.5.0-linux-x86_64.AppImage
find apps/desktop/build-electron/ -name *.AppImage -ls
