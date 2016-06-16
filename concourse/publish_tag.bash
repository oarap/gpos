#!/bin/bash


set -o pipefail
set -u -e -x

main() {
  local INPUT_DIR=bin_gpos_release
  local OUTPUT_DIR=gpos_github_release_stage
  env LC_ALL=C tar tf $INPUT_DIR/*.tar.gz | grep "libgpos.so." | sort -n | head -n 1 | sed 's/\.\/lib\/libgpos\.so\./v/' > $OUTPUT_DIR/tag.txt
  cp -v $INPUT_DIR/*.tar.gz $OUTPUT_DIR/
  env GIT_DIR=gpos_src/.git git rev-parse HEAD > $OUTPUT_DIR/commit.txt
}

main "$@"
