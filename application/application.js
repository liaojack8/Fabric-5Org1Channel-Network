/**
  * SPDX-License-Identifier: Apache-2.0
 */

/**
 * This is an example based on fabric-sdk-node, it refers content of:
 * https://fabric-sdk-node.github.io/master/index.html
 * https://github.com/hyperledger/fabric-sdk-node
 * https://fabric-sdk-node.github.io/master/tutorial-network-config.html
 * 
 * This program uses connprofile.json, what is a common connection profile.
 * It will utilze InMemoryWallet and Gateway, what is from fabric-network module.
 */

'use strict';
const fs = require('fs');
const path = require('path');
const winston = require('winston');
const {Gateway, FileSystemWallet, InMemoryWallet, X509WalletMixin} = require('fabric-network');

var logger = new (winston.Logger)({transports: [new (winston.transports.Console)()]});

let arg = process.argv[2];
switch (arg) {
    case 'query' : queryFind(process.argv[3]); break;
    case 'add' : invokeAdd(process.argv[3], process.argv[4]); break;
    default: logger.error(`Please run command likes: 'node vstest4.js query [id]' or 'node vstest4.js add'`);
}

async function queryFind(vid) { 
    if (vid == undefined) {
        logger.info('Please speficy a vehicle id for search.')
        return;
    }
    const identityLabel = 'Admin@org1.desl.com';
    const wallet = await initUserWallet(identityLabel);
    const gateway = new Gateway();

    await gateway.connect(path.join(__dirname, './connprofile.json'),
        {
            wallet: wallet,
            identity: identityLabel,
            discovery: {
				enabled: false,
			}
        });

    logger.info('Gateway connects get succeed.');

    const network = await gateway.getNetwork('channelall');
    const contract = await network.getContract('mycc');
    let result = await contract.evaluateTransaction('queryMarks', vid);
    gateway.disconnect();
    
    result = Buffer.from(result).toString()
    logger.info(result == '' ? vid + ' not found' : result)
    return result;
}

async function invokeAdd(id,data) {
    logger.info('Begin to add student data %s %s', id,data);
    const identityLabel = 'Admin@org1.desl.com';
    const wallet = await initUserWallet(identityLabel);
    const gateway = new Gateway();
    await gateway.connect(path.join(__dirname, './connprofile.json'),
        {
            wallet: wallet,
            identity: identityLabel,
            discovery: {
				enabled: false,
			}
        });

    logger.info('Gateway connects get succeed.');

    try {
        const network = await gateway.getNetwork('channelall');
        const contract = await network.getContract('mycc');
        const transaction = contract.createTransaction('addMarks').Submit([id,data]);
        const transactionId = transaction.getTransactionID().getTransactionID();
    
        logger.info('Create a transaction ID: ', transactionId);
        
        const sharingOrgEventHub = await getFirstEventHubForOrg(network, 'DeslOrg1MSP');
        //const vehicleEventHub = await getFirstEventHubForOrg(network, 'VehicleMSP');
        //const onlinePayEventHub = await getFirstEventHubForOrg(network, 'OnlinePayMSP');
    
        let eventFired = 0;
        sharingOrgEventHub.registerTxEvent('all', (txId, code) => {
            logger.info('Event', txId, code);
            if (code === 'VALID' && txId === transactionId) {
                eventFired++;
            }
        }, 
        () => {
            //logger.info('EventHub error.');
        });
        
        const response = await transaction.submit(id,data);
        const succ = (eventFired == 1);
        if (succ) {
            logger.info('A new data %s was created. Response: %s %s', id,data, response.toString());
        }    
        else {
            logger.error('Adding data got failed.');
        }
            
    } 
    catch (err) {
		logger.error('Failed to invoke transaction chaincode on channel. ' + err.stack ? err.stack : err);
    } 
    finally {
		gateway.disconnect();
		logger.info('Gateway disconnected.');
        if (succ){
            return 'A new data %s was created. Response: %s %s', id,data, response.toString()
        }
        else{
            return 'failed'
        }
	}
}
module.export = {queryFind,invokeAdd}