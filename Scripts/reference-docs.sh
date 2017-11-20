#!/bin/sh

echo "Generating Jazzy Reference Documentation"

bundle exec jazzy \
  --clean \
  --author Wia \
  --author_url https://www.wia.io \
  --github_url https://github.com/wiaio/WiaSwift \
  --github-file-prefix https://github.com/wiaio/WiaSwift/tree/${WIA_SDK_VERSION} \
  --module-version ${WIA_SDK_VERSION} \
  --module WiaSwift \
  --theme apple

