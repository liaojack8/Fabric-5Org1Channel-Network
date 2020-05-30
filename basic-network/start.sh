#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

sudo docker-compose -f docker-compose.yml down

sudo docker-compose -f docker-compose.yml up -d ca.desl.com orderer.desl.com couchdb peer0.org1.desl.com peer0.org2.desl.com peer0.org3.desl.com peer0.org4.desl.com peer0.org5.desl.com
sudo docker ps -a

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=5
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

#Creating CLI Container
sudo docker-compose -f ./docker-compose.yml up -d cli

#Exec run.sh
# sudo docker exec -it cli "./etc/hyperledger/channelCode/run.sh"
