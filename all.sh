#!/bin/bash

# shellcheck disable=SC2086

set -euo pipefail

"${TRUNK_PATH}" install \
  --ci

if [[ -n ${PRE_CHECK_COMMAND} ]]; then
  eval ${PRE_CHECK_COMMAND}
fi

if [[ -z ${INPUT_TRUNK_TOKEN} ]]; then
  "${TRUNK_PATH}" check \
    --ci \
    --all \
    --github-commit "${GITHUB_SHA}" \
    --github-label "${INPUT_LABEL}" \
    --github-annotate \
    ${INPUT_ARGUMENTS}
else
  "${TRUNK_PATH}" check \
    --all \
    --upload \
    --series "${INPUT_UPLOAD_SERIES:-${GITHUB_REF_NAME}}" \
    --token "${INPUT_TRUNK_TOKEN}" \
    ${INPUT_ARGUMENTS}
fi
