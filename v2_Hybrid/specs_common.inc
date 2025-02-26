#!/bin/bash
# Defines VARs used by all Workloads: <workload>
# read/source'd by run_test.sh
#-------------------------------------------------------

# Define Timings
delay=15             # Fixed DELAY between testruns in FOR Loop
pcp_sample_rate=5    # Sample time for PMLOGGER recorded Metrics

# Define Outputs
pcp_archive_name="${job_label}_${workload}"
pcp_archive_dir="$PWD/archive_${workload}.$(date +%Y%m%d%H%M%S)"
runlog="${pcp_archive_dir}/${pcp_archive_name}.runlog"

