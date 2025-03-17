SUDO := sudo -H

default: pbuild prun

pbuild:
	$(SUDO) podman build -t pcp-pipeline .

prun:
	$(SUDO) podman run --privileged --rm --name pcp-pipeline --volume .:/tmp/test:z pcp-pipeline
