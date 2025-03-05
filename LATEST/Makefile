SUDO := sudo -H

default: pbuild prun

pbuild:
	$(SUDO) podman build -t pcp-hybrid .

prun:
	$(SUDO) podman run --privileged --rm --name pcp-pipeline --volume .:/tmp/test:z pcp-hybrid

