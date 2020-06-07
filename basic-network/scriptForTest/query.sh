# Switch to Org1
CORE_PEER_GOSSIP_USELEADERELECTION=true
CORE_PEER_LOCALMSPID=DeslOrg1MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.desl.com/msp
CORE_PEER_ADDRESS=peer0.org1.desl.com:7051
#Insert data for testing
echo Fabric
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Fabric"]}'
echo Alice
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Alice"]}'
echo Peter
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Peter"]}'
echo Alex
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Alex"]}'
echo Ian
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Ian"]}'
echo Jack
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Jack"]}'
echo Jimmy
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Jimmy"]}'
echo Tina
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Tina"]}'
echo Betty
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Betty"]}'
echo Queena
peer chaincode query -o orderer.dsel.com:7050 -C channelall -n mycc -c '{"function":"queryData","Args":["Queena"]}'