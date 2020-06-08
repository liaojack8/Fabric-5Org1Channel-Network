# Fabric-5Org1Channel-Network

## How to use?

### Start(Create 4 tabs in terminal)
```
//at cli-1
git clone
cd ./basic-network
bash start.sh
```
### Init
```
//switch to cli-2 (Deploy Chaincode)
sudo docker exec -it cli bash
bash etc/hyperledger/deployCC/deploy.sh
//switch to cli-3 (Quick Demo)
bash etc/hyperledger/script/genData.sh
bash etc/hyperledger/script/query.sh
```
### Enable RestfulAPI
```
//switch to cli-4
node rest.js
```
### Stop
```
bash stop.sh
```
#### Extra
To clean all data in the network
```
bash teardown.sh
```
To generate new crypto-config by cryptogen
```
bash generate.sh
```
