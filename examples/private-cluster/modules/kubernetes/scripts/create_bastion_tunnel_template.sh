#!/bin/bash

# Create a port-forwarding session on the bastion
oci_bastion_session_create() {
  oci bastion session create-port-forwarding \
    --bastion-id ${bastion_id} \
    --display-name oke-tunnel \
    --ssh-public-key-file ${public_key_file} \
    --key-type PUB \
    --target-private-ip ${cluster_ip} \
    --target-port ${cluster_port} \
    --session-ttl 10800
}

oci_bastion_session_list() {
  oci bastion session list \
    --bastion-id ${bastion_id} \
    --display-name oke-tunnel \
    --limit 1 \
    --session-lifecycle-state ACTIVE \
    --sort-by timeCreated \
    --sort-order DESC \
    2>/dev/null
}

oci_bastion_session_state() {
  session_id="$1"
  oci bastion session get --session-id $session_id |
    jq -r '.data."lifecycle-state"'
}

oci_bastion_session_init() {
  session_id=$(oci_bastion_session_list | jq -r .data[0].id)
  created_new_session=false
  if [ -z "$session_id" ]; then
    session_id=$(oci_bastion_session_create | jq -r .data.id)
    created_new_session=true
  fi

  max=10
  count=1
  state=$(oci_bastion_session_state "$session_id")
  while [[ $state != "ACTIVE" ]]; do
    echo >&2 "Current session state: $state."
    if [[ $count -gt $max ]]; then
      echo >&2 "Maximum attempts reached for session initialization."
      return 1
    fi
    sleep 1
    state=$(oci_bastion_session_state "$session_id")
    count=$((count + 1))
  done

  # Sleep for 10 seconds if a new session created, as there might be initial delays even if the state is ACTIVE.
  if [ "$created_new_session" = true ]; then
    sleep 10
  fi

  echo >&2 "$state $session_id"
}

oci_bastion_session_init

# Connect an SSH tunnel
if lsof -t -i:6443; then
  kill "$(lsof -t -i:6443)"
fi
nohup ssh -i ${private_key_file} \
  -o HostKeyAlgorithms=+ssh-rsa \
  -o PubkeyAcceptedAlgorithms=+ssh-rsa \
  -N -L 6443:${cluster_ip}:${cluster_port} \
  -p 22 \
  -o StrictHostKeyChecking=no \
  "$session_id"@host.bastion.${region}.oci.oraclecloud.com >/dev/null 2>&1 &
