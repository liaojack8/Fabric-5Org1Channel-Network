'use strict';
const fs = require('fs');
const path = require('path');
const winston = require('winston');
const Client = require('fabric-client');

var logger = new (winston.Logger)({transports: [new (winston.transports.Console)()]});

// Call the only test function.
test();


async function test() {
    const client = Client.loadFromConfig(path.join(__dirname, './connprofile.json'));
    const channel = client.getChannel('channelall');
    await client.initCredentialStores();

    const mspId = client.getMspid();
    const org1Peers = client.getPeersForOrg(mspId);
    const peer0 = client.getPeer('peer0.org1.desl.com');
    logger.info('The current client instance belongs to organization: %s', mspId);
    logger.info('%s has %d peers: %s', mspId, org1Peers.length, org1Peers.map(peer => peer.getName()));
    logger.info('An expected peer0 is found: %s %s', peer0.getName(), peer0.getUrl());

    const channelName = channel.getName();
    const channelOrderers = channel.getOrderers();
    const channelPeers = channel.getPeers();
    logger.info('The channel name: %s', channelName);
    logger.info('The channel orderers: %s', channelOrderers.map(ord => ord.getName()));
    logger.info('The channel peers: %s', channelPeers.map(peer => peer.getName()));


    // Creata  user object and set as userContext.
    await client.createUser(initAdmin());
    let tx_id = client.newTransactionID();
    // console.log(tx_id)
    const request = {
        chaincodeId : 'f6a0bfc598055a99db0ef21ea2f6dfbcb200a9ce7e575804589b48d7ff2000eb',
        txId: tx_id,    // No txId for query.
        fcn: 'queryMarks',
        args: ['Alice'],
        request_timeout: 30000,
        // Empty list [] will cause exception. and 'null' leads to send to all peers.
        targets: ['peer0.org1.desl.com']
    };

    const result = await channel.queryByChaincode(request); 
    console.log(result)
    result.forEach((res, idx) => {
        // logger.info('Query result %d', idx, Buffer.from(res).toString());
    });
}

function initAdmin() {
    // Hardcode crypto materials of Admin@org1.example.com.
    const keyPath = path.join(__dirname, "../basic-network/crypto-config/peerOrganizations/org1.desl.com/users/Admin@org1.desl.com/msp/keystore/dd0816c6b97befd5529dc962f3456398877bfa8ecc90469dbabad2c8ca52d605_sk");
    const keyPEM = Buffer.from(fs.readFileSync(keyPath)).toString();
    const certPath = path.join(__dirname, "../basic-network/crypto-config/peerOrganizations/org1.desl.com/users/Admin@org1.desl.com/msp/signcerts/Admin@org1.desl.com-cert.pem");
    const certPEM = Buffer.from(fs.readFileSync(certPath)).toString();

    // Create a new user object.
    return {
        username: 'Admin@org1.desl.com',
        mspid: 'DeslOrg1MSP',
        cryptoContent: {
            privateKeyPEM: keyPEM,
            signedCertPEM: certPEM
        }
    };
}