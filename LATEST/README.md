BUILD  
sut# dnf install podman git make  
sut# git clone https://github.com/jharriga/PCPpipeline  

CONFIGURE  
Adapt <workload> configuration files  
“Workloads/specs_<workload>.inc” for runtime, …  
“Workloads/pcp_<workload>.cfg” for PCP metrics  

RUN <workload> and Create PCP-Archive  
sut# chmod 755 run_test.sh  
sut# make			← builds and then runs container  
sut# podman exec -w /tmp/test pcp-pipeline ./run_test.sh <workload>  
