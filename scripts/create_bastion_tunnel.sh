#!/bin/bash

if [ $# -ne 6 ]; then
  echo "Usage: $0 <bastion_id> <public_key_file> <private_key_file> <cluster_ip> <cluster_port> <region>"
  exit 1
fi

# Get the arguments
bastion_id=$1
public_key_file=$2
private_key_file=$3
cluster_ip=$4
cluster_port=$5
region=$6

# Create a port-forwarding session on the bastion
oci_bastion_session_create() {
  oci bastion session create-port-forwarding \
    --bastion-id "${bastion_id}" \
    --display-name oke-tunnel \
    --ssh-public-key-file "${public_key_file}" \
    --key-type PUB \
    --target-private-ip "${cluster_ip}" \
    --target-port "${cluster_port}" \
    --session-ttl 10800
}

oci_bastion_session_list() {
  oci bastion session list \
    --bastion-id "${bastion_id}" \
    --display-name oke-tunnel \
    --limit 1 \
    --session-lifecycle-state ACTIVE \
    --sort-by timeCreated \
    --sort-order DESC \
    2>/dev/null
}

oci_bastion_session_state() {
  session_id="$1"
  oci bastion session get --session-id "${session_id}" |
    jq -r '.data."lifecycle-state"'
}

oci_bastion_session_init() {
  session_id=$(oci_bastion_session_list | jq -r .data[0].id)
  if [ -z "${session_id}" ]; then
    session_id=$(oci_bastion_session_create | jq -r .data.id)
  fi

  max=10
  count=1
  state=$(oci_bastion_session_state "${session_id}")
  while [[ $state != "ACTIVE" ]]; do
    echo >&2 "Current session state: $state."
    if [[ $count -gt $max ]]; then
      echo >&2 "Maximum attempts reached for session initialization."
      return 1
    fi
    sleep 1
    state=$(oci_bastion_session_state "${session_id}")
    count=$((count + 1))
  done

  echo >&2 "$state"
}

oci_bastion_session_init

# Connect an SSH tunnel
kill $(lsof -t -i:6443)
nohup ssh -i "${private_key_file}" \
  -o HostKeyAlgorithms=+ssh-rsa \
  -o PubkeyAcceptedAlgorithms=+ssh-rsa \
  -N -L 6443:"${cluster_ip}":"${cluster_port}" \
  -p 22 \
  "${session_id}"@host.bastion."${region}".oci.oraclecloud.com >/dev/null 2>&1 &
