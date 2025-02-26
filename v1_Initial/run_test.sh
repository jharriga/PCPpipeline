#!/bin/bash
# Script which runs the designated <workload> and creates a PCP
# Archive with metrics as specified in the $pcp_conf_file
# NOTE: the number of samples runs is hard-coded to 5
###################################################################

# Include the PCP Functions file
# PRE-REQ: pcp-zeroconf must be installed and PMCD running or runtime aborts
#          $ sudo dnf install pcp-zeroconf
#          $ sudo systemctl start pmcd
source $PWD/pcp_functions.inc

# Read the one (required) cmdline arg: WORKLOAD
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <workload>"
    exit 1
fi

##arg1="sysbench"                # TBD: parse from invocation
workload=$1

# VERIFY the required <workload> files are available/installed
#     <pcp_conf_file>; <spec_file>; <command>

# PCP Dirs and Files
# NOTE: pcp_archive_name is set in Workload Spec file
pcp_archive_dir="$PWD/archive_${workload}.$(date +%Y%m%d%H%M%S)"
pcp_conf_file="$PWD/pcp_${workload}.cfg"
if ! test -f "${pcp_conf_file}"; then
  echo "PCP Configuration file '${pcp_conf_file}' not found!"
  exit 2
fi

# Include the WORKLOAD Specification file <spec_file>
# Defines VARs which specify workload settings 
spec_file="$PWD/specs_${workload}.inc"
if ! test -f "${spec_file}"; then
  echo "Workload specification file '${spec_file}' not found!"
  exit 2
fi
source $spec_file 

# Be verbose for DEBUG
##echo "Command: ${cmdline[0]}"
echo "Command string: ${cmdline[@]}"
echo "Exec string: ${exec_str}"
##echo "Number of threads for this set of runs: ${thread_cnt}"

# Verify workload is available on the system and in $PATH
if ! which "${workload[0]}" > /dev/null; then
  echo "Command '${cmdline[0]}' not found!"
  exit 2
fi

##echo "DEBUG: early exit"
##exit 3

#----------------------------------
# Start PMLOGGER to create ARCHIVE
pcp_verify $pcp_conf_file
pcp_start $pcp_conf_file $pcp_sample_rate $pcp_archive_dir $pcp_archive_name

# Loop - repeat Workload for 5 samples
echo -n "Executing workload: Sample "
for sample_ctr in {1..5}; do
        echo -n "${sample_ctr} "
        sleep $delay
        return=$(eval "$exec_str")            # Run the Workload
done

echo                             # complete the new-line

# Terminate PMLOGGER. Flush buffers by sending SIGUSR1 signal
pcp_stop

# Verify PCP ARCHIVE was created and list contents
echo; echo "${pcp_archive_dir}"
ls -l "${pcp_archive_dir}"

echo; echo "------------------"

echo "DONE"

