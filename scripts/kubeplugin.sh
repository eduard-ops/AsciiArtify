#!/bin/bash


# Usage: bash scripts/kubeplugin.sh <namespace> <resource>
# example: bash kubeplugin.sh kube-system pod
# metrics-service should be available by column

# Define command-line arguments
NAMESPACE=$1
RESOURCE=$2

# Retrieve resource usage statistics from Kubernetes
kubectl top $RESOURCE -n $NAMESPACE | tail -n +2 | {
  # Print table header
  echo "RESOURCE_TYPE NAMESPACE NAME CPU MEMORY"

  # Loop through each line of the output
  while read -r line; do
    # Extract CPU and memory usage from the output
    NAME=$(echo "$line" | awk '{print $1}')
    CPU=$(echo "$line" | awk '{print $2}')
    MEMORY=$(echo "$line" | awk '{print $3}')

    # Output the statistics in a formatted table
    echo "$RESOURCE $NAMESPACE $NAME $CPU $MEMORY"
  done
} | column -t
