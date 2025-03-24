#!/bin/bash
# Echo's Redfish Chassis power readings to screen, without using Perf CoPilot
# Requires vars in 'RFvars.cfg' to be configured for URLs and Credentials

while true; do
    # Emit timestamp
    echo
    date

    # Get Readings - CHASSIS
    ./RFchassis.sh

    # DELAY
    sleep 5
done
