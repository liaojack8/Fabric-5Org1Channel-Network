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
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Create the channel
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org1.desl.com:7051" peer0.org1.desl.com peer channel create -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/channelall.tx
# Join peer0.org1.desl.com to the channel.
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org1.desl.com:7051" peer0.org1.desl.com peer channel join -b channelall.block
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org1.desl.com:7051" peer0.org1.desl.com peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg1MSPanchors_channelall.tx
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg2MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org2.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.desl.com:7051" peer0.org2.desl.com peer channel join -b channelall.block
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg2MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org2.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.desl.com:7051" peer0.org2.desl.com peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg2MSPanchors_channelall.tx
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg3MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org3.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org3.desl.com:7051" peer0.org3.desl.com peer channel join -b channelall.block
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg3MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org3.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org3.desl.com:7051" peer0.org3.desl.com peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg3MSPanchors_channelall.tx
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg4MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org4.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org4.desl.com:7051" peer0.org4.desl.com peer channel join -b channelall.block
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg4MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org4.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org4.desl.com:7051" peer0.org4.desl.com peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg4MSPanchors_channelall.tx
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg5MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org5.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org5.desl.com:7051" peer0.org5.desl.com peer channel join -b channelall.block
# sudo docker exec -e "CORE_PEER_LOCALMSPID=DeslOrg5MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org5.desl.com/msp" -e "CORE_PEER_ADDRESS=peer0.org5.desl.com:7051" peer0.org5.desl.com peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg5MSPanchors_channelall.tx

#Creating CLI Container
sudo docker-compose -f ./docker-compose.yml up -d cli

