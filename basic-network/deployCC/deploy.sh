# Create the channel
CORE_PEER_LOCALMSPID=DeslOrg1MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.desl.com/msp
CORE_PEER_ADDRESS=peer0.org1.desl.com:7051
peer channel create -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/channelall.tx
# Join peer0.org1.desl.com to the channel.
CORE_PEER_LOCALMSPID=DeslOrg1MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.desl.com/msp
CORE_PEER_ADDRESS=peer0.org1.desl.com:7051
peer channel join -b channelall.block
peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg1MSPanchors_channelall.tx
peer channel list
peer chaincode install -n mycc -v 1.0 -p "/opt/gopath/src/github.com/mycc" -l "node"
peer chaincode instantiate -o orderer.desl.com:7050 -C channelall -n mycc -l "node" -v 1.0 -c '{"Args":[]}'
# Join peer0.org2.desl.com to the channel.
CORE_PEER_LOCALMSPID=DeslOrg2MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org2.desl.com/msp
CORE_PEER_ADDRESS=peer0.org2.desl.com:7051
peer channel join -b channelall.block
peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg2MSPanchors_channelall.tx
peer channel list
# Join peer0.org3.desl.com to the channel.
CORE_PEER_LOCALMSPID=DeslOrg3MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org3.desl.com/msp
CORE_PEER_ADDRESS=peer0.org3.desl.com:7051
peer channel join -b channelall.block
peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg3MSPanchors_channelall.tx
peer channel list
# Join peer0.org4.desl.com to the channel.
CORE_PEER_LOCALMSPID=DeslOrg4MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org4.desl.com/msp
CORE_PEER_ADDRESS=peer0.org4.desl.com:7051
peer channel join -b channelall.block
 peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg4MSPanchors_channelall.tx
peer channel list
# Join peer0.org5.desl.com to the channel.
CORE_PEER_LOCALMSPID=DeslOrg5MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org5.desl.com/msp
CORE_PEER_ADDRESS=peer0.org5.desl.com:7051
peer channel join -b channelall.block
peer channel update -o orderer.desl.com:7050 -c channelall -f /etc/hyperledger/configtx/DeslOrg5MSPanchors_channelall.tx
peer channel list