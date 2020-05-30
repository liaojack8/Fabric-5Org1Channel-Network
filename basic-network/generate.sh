#!/bin/sh
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
export PATH=$GOPATH/src/github.com/hyperledger/fabric/build/bin:${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}
CHANNEL_NAME=channelall

# remove previous crypto material and config transactions
rm -fr config/*
rm -fr crypto-config/*

# generate crypto material
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

# generate genesis block for orderer
configtxgen -profile FiveOrgOrdererGenesis -outputBlock ./config/genesis.block
if [ "$?" -ne 0 ]; then
  echo "Failed to generate orderer genesis block..."
  exit 1
fi

# generate channel configuration transaction
configtxgen -profile FiveOrgsChannel -outputCreateChannelTx ./config/${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

# generate anchor peer transaction
#FiveOrgsChannel = ChannelAll
configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate ./config/DeslOrg1MSPanchors_${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME -asOrg DeslOrg1MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for DeslOrg1MSP..."
  exit 1
fi
configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate ./config/DeslOrg2MSPanchors_${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME -asOrg DeslOrg2MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for DeslOrg2MSP..."
  exit 1
fi
configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate ./config/DeslOrg3MSPanchors_${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME -asOrg DeslOrg3MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for DeslOrg3MSP..."
  exit 1
fi
configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate ./config/DeslOrg4MSPanchors_${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME -asOrg DeslOrg4MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for DeslOrg4MSP..."
  exit 1
fi
configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate ./config/DeslOrg5MSPanchors_${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME -asOrg DeslOrg5MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for DeslOrg5MSP..."
  exit 1
fi