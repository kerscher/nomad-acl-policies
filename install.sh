#!/bin/bash

set -e

errout() {
    printf "Error: %s\n\n" "${1}"
    exit 1
}

has_exe() {
    if ! hash "${1}" 2>/dev/null; then
        errout "${1} not found on PATH. Install and make available."
    fi
}

if [[ -z ${NOMAD_TOKEN} ]]; then
    errout 'ensure NOMAD_TOKEN is set with a management token before executing.'
fi

if [[ -z ${NOMAD_SERVER} ]]; then
    errout 'ensure NOMAD_SERVER points to a valid Nomad server. e.g. http://127.0.0.1:4646'
fi

has_exe curl

for p in dist/*.json; do
    prefix='dist/'
    suffix='.json'
    policy="${p#${prefix}}"
    policy="${policy%${suffix}}"
    curl --silent \
         --request POST \
         --data @"${p}" \
         --header "X-Nomad-Token: ${NOMAD_TOKEN}" \
         "${NOMAD_SERVER}/v1/acl/policy/${policy}"
done
