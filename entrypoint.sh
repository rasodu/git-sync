#!/bin/sh

set -e

if [[ ! -v SSH_PRIVATE_KEY_DESTINATION && -n "$SSH_PRIVATE_KEY" ]]
then
  SSH_PRIVATE_KEY_DESTINATION=$SSH_PRIVATE_KEY
fi

mkdir -p /root/.ssh

if [[ -n "$SSH_PRIVATE_KEY" ]]
then
  echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
fi

if [ -n "$SSH_PRIVATE_KEY_DESTINATION" ]
then
  echo "$SSH_PRIVATE_KEY_DESTINATION" > /root/.ssh/id_rsa_destination
  chmod 600 /root/.ssh/id_rsa_destination
fi

mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true 

sh -c "/git-sync.sh $*"
