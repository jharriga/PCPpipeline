#!/bin/bash

# Start pmlogger in background - on Container
podman exec -w /tmp/test pcp-test ./HYBRID/start_archive.sh&

# Run workload - on Host
runtime=100
thread_cnt=$(nproc)

sysbench cpu run --time="$runtime" --threads="$thread_cnt"
##sysbench cpu run --time=30 --threads=4

# Stop pmlogger - on Container
podman exec -w /tmp/test pcp-test ./HYBRID/stop_archive.sh

