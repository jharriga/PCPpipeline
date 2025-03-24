#!/bin/bash
echo "Starts PCP Archive-analysis container"
echo "To stop container issue: podman stop -l"
echo
# Note the mount point uses local directory $PWD/Archives
podman run \
    --name pcp-archive-analysis -t --rm \
    --security-opt label=disable \
    -p 127.0.0.1:3000:3000 \
    -v $PWD/Archives:/archives \
    quay.io/performancecopilot/archive-analysis
