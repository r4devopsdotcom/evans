#!/usr/bin/env bash

OSARCH='darwin/386 darwin/amd64 linux/386 linux/amd64 linux/arm linux/arm64 windows/386 windows/amd64'

mkdir pkg
cd pkg

gox -osarch "$OSARCH" \
  -ldflags="-X github.com/ktr0731/evans/vendor/github.com/ktr0731/go-updater/github.isGitHubReleasedBinary=true" \
  ..

for f in *; do
  if echo "$f" | grep exe > /dev/null 2>&1; then
    mv "$f" evans.exe
  else
    mv "$f" evans
  fi
  tar czvf "$f.tar.gz" evans
  rm -f evans
done
