#!/bin/bash
# Defines VARs which specify the SYSBENCH CPU <workload>
# read/source'd by run_test.sh
# Inserted before '../specs_common.inc'
#-------------------------------------------------------

# Define Workload
runtime=100          # Runtime duration for each workload testrun
##runtime=10          # shorten for DEBUG
thread_cnt=$(nproc)                            # use all cores
job_label="${runtime}s_${thread_cnt}threads"   # forms $pcp_archive_name
## use an array to build up cmdline with runtime args
cmdline=( sysbench cpu run --time="$runtime" --threads="$thread_cnt" )

# TBD: utilize OPENMETRICS to record <workload> key metrics
parsing=">>$runlog 2>&1"                # specific to $workload output
exec_str="${cmdline[@]} ${parsing}"

