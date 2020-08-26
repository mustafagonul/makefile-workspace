#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $DIR/../config.sh

sshpass -p "${PASSWORD}" ssh -p $PORT $SSH_PARAMS "$ENDPOINT" $@
