#!/bin/bash

set -e

export SCRIPT_DIR=$(dirname ${0})

echo "::group::Installing dependencies..."
wolframscript ${SCRIPT_DIR}/install_dependencies.wls
echo "::endgroup::"

echo "::group::Submitting Paclet..."
wolframscript ${SCRIPT_DIR}/submit_paclet.wls
echo "::endgroup::"