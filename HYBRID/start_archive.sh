#!/bin/bash
################################################################

# GLOBALS ###################
# Include the PCP Functions file
source $PWD/pcp_functions.inc

pcp_conf_file="$PWD/pcp_sysbench.cfg"
if ! test -f "${pcp_conf_file}"; then
  echo "PCP Configuration file '${pcp_conf_file}' not found!"
  exit 2
fi
pcp_archive_dir="$PWD/archive.$(date +%Y%m%d%H%M%S)"

# Functions #################
# Files
om_workload_file="/tmp/openmetrics_workload.txt"

# Functions #################
update_om_workload() {
    # Check for proper number of args
    if [ "$#" -ne 7 ]; then
        echo "ERROR on number of parameters in ${FUNCNAME}"
	exit 2
    else
        v_iter_cnt=$1
	v_started=$2
	v_finished=$3
	v_numthreads=$4
        v_runtime=$5
        v_throughput=$6
        v_latency=$7
    fi

    # Prepare for an update to the $om_workload_file (GLOBAL)
    rm -f $om_workload_file
    touch $om_workload_file
    # Update metrics in the openmetric.workload file
    printf "iteration %d\n" "$v_iter_cnt">>$om_workload_file
    printf "started %d\n" "$v_started">>$om_workload_file
    printf "finished %d\n" "$v_finished">>$om_workload_file
    printf "numthreads %d\n" "$v_numthreads">>$om_workload_file
    echo "runtime ${v_runtime}">>$om_workload_file
    echo "throughput ${v_throughput}">>$om_workload_file
    echo "latency ${v_latency}">>$om_workload_file
}

reset_om_metrics() {
    # Initialize openmetric.workload metric values
    r_iteration=0 ; r_started=0 ; r_finished=0
    r_numthreads=0 ; r_runtime="NaN" ; r_throughput="NaN" ; r_latency="NaN"

    # Update the openmetrics.workload 
    update_om_workload "$r_iteration" "$r_started" "$r_finished" \
           "$r_numthreads" "$r_runtime" "$r_throughput" "$r_latency"
}

#############################

# Main #################
# Initialize openmetric.workload metric values
reset_om_metrics

#----------------------------------
# Start PMLOGGER to create ARCHIVE
pcp_verify $pcp_conf_file
##pcp_start $pcp_conf_file $pcp_sample_rate $pcp_archive_dir $pcp_archive_name
pcp_start $pcp_conf_file 5 $pcp_archive_dir sysbenchTEST

