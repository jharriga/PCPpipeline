#!/bin/bash
# Defines VARs which specify <workload>
# read/source'd by run_test.sh
#-------------------------------------------------------

# Define Timings
delay=15             # Fixed DELAY between testruns in FOR Loop
pcp_sample_rate=5    # Sample time for PMLOGGER recorded Metrics

# Define Workload
##runtime=100          # Runtime duration for each workload testrun
runtime=10          # shorten for DEBUG
thread_cnt=$(nproc)                       # uses all cores
## use an array to build up cmdline with runtime args
cmdline=( sysbench cpu run --time="$runtime" --threads="$thread_cnt" )

# Define Outputs
pcp_archive_name="${thread_cnt}threads"
pcp_archive_dir="$PWD/archive_${workload}.$(date +%Y%m%d%H%M%S)"
runlog="${pcp_archive_dir}/${pcp_archive_name}.runlog"

# TBD: utilize OPENMETRICS to record <workload> key metrics
parsing=">>$runlog 2>&1"                # specific to $workload output
exec_str="${cmdline[@]} ${parsing}"

