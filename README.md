# Fabric-5Org1Channel-Network

## How to use?

### Start
```
//at cli-1
git clone
start.sh
```
### Init
```
//switch to cli-2
sudo docker exec -it cli bash
bash etc/hyperledger/deployCC/deploy.sh
bash etc/hyperledger/script/genData.sh
//switch to cli-3
bash etc/hyperledger/script/query.sh
```
### Enable RestfulAPI
```
//switch to cli-4
node rest.js
```
### Stop
```
stop.sh
```
