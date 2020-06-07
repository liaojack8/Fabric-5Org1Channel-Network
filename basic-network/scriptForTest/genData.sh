# Switch to Org1
CORE_PEER_GOSSIP_USELEADERELECTION=true
CORE_PEER_LOCALMSPID=DeslOrg1MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.desl.com/msp
CORE_PEER_ADDRESS=peer0.org1.desl.com:7051
#Insert data for testing
echo ["Alice","68","84","89"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Alice","68","84","89"]}'
echo ["Fabric","QAQ","TAT","QQQQQQ"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Fabric","QAQ","TAT","QQQQQQ"]}'
echo ["Peter","1001","942","463"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Peter","1001","942","463"]}'
echo ["Alex","Time Capsule","52","17"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Alex","Time Capsule","52","17"]}'
echo ["Ian","93","21","75"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Ian","93","21","75"]}'
echo ["Jack","crack","0000","eeeeeeeeeeeeeeeeeeee"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Jack","crack","0000","eeeeeeeeeeeeeeeeeeee"]}'
echo ["Jimmy","Heeee","84","iufcdbs"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Jimmy","Heeee","84","iufcdbs"]}'
echo ["Tina","1","2","3"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Tina","1","2","3"]}'
echo ["Betty","6","2","8"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Betty","6","2","8"]}'
echo ["Queena","954","4256345","203"]
peer chaincode invoke -C channelall -n mycc -c '{"function":"addData","Args":["Queena","954","4256345","203"]}'