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