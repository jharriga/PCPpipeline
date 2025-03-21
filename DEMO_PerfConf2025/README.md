# USAGE
* SUT (System Under Test) requires Packages: 'podman make git'
* HOST requires Packages: 'podman pcp pcp-system-tools'
* On the SUT:
  * 'git clone https://github.com/jharriga/PCPpipeline' ; cd PCPpipeline/DEMO_PC2025
  * Make all scripts executable: 'find . -type f -name "*.sh" -print0 |xargs -0 chmod 755'
  * Edit OpenMetrics/RFvars.cfg with your Redfish url's and credentials
  * Build and run Container: 'make'
  * Start workload: 'podman exec  -w /tmp/test pcp-test ./run_sysbench.sh'  
	When run_sysbench.sh completes, PCP-Archive directory appears on Host
# View Results
* Copy the PCP Archives to Host  
* On the HOST:
  * See Archive Timestamps and Hostname: 'pmloglabel -l <archive-name>'
  * View some metric results: 'pmrep -t 5 -p -a <archive-name> openmetrics.workload.throughput openmetrics.RFchassis denki.rapl'
  * View all metric results: 'pmdumplog -a <archive-name>' > HOLD
# GRAFANA
* On the HOST
  * Run PCP archive-analysis Container: './archive-analysis.sh'   
  * Connect:  http://localhost:3000/dashboards  
  * Select Dashboard: ‘PCP Archive Analysis’ and set Time Window for the PCP Archive   
