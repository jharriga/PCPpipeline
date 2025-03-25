Demonstrates hybrid approach to isolate PCP actions from Workload automation
* pcp-pipeline Containerized coordinating PCP pmlogger actions
* User provided Workload, executing in either bare-metal OR containerized

# USAGE
testHYBRID.sh: example script 
* starts archiving
* runs example workload (sysbench)
* stops archiving, creates archive ( see ../archive.timestamp )

# QUESTIONS
* which pcp_spec.cfg file is being used by pcp-start()?
* wrapper elements
  * cmdline
  * regex for openmetrics.workload
  * PCP metric spec
