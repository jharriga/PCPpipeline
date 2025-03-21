# USAGE
* Requires 'podman' and 'make'
* Make all scripts executable: 'find . -type f -name "*.sh" -print0 |xargs -0 chmod 755'
* Edit OpenMetrics/RFvars.cfg with your Redfish url's and credentials
* Build and run Container: 'make'
* Start workload: 'podman exec  -w /tmp/test pcp-test ./run_sysbench.sh  
	When run_sysbench.sh completes, PCP-Archive directory appears on Host
# View Results
* Utilize 'Dashboards/archive_dates.sh <archive-name>' to see PCP Archive  
  hostname and {start|stop|} timestamps
* View results: 'pmrep -t 5 -p -a <archive-name> openmetrics.workload.throughput openmetrics.RFchassis denki.rapl'
# GRAFANA
* See Archive Timestamps: 'pmloglabel -l <archive-name>'
* Run PCP archive-analysis Container: 'podman run \  
    --name pcp-archive-analysis -t --rm \  
    --security-opt label=disable \  
    -p 127.0.0.1:3000:3000 \  
    -v $PWD/Archives:/archives \  
    quay.io/performancecopilot/archive-analysis'    
* Connect:  http://localhost:3000/dashboards  
* Select Dashboard: ‘PCP archive-analysis (Valkey)’ and set Time Window   
