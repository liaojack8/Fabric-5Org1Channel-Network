'use strict';
const os = require('os');
const fs = require('fs');
const path = require('path');
const winston = require('winston');
const {Gateway, FileSystemWallet, X509WalletMixin} = require('fabric-network');

var logger = new (winston.Logger)({transports: [new (winston.transports.Console)()]});

// Call the only test function.
await add();
await query();
console.log('done!')


async function add() {
    const identityLabel = 'Admin@org1.desl.com';
    const wallet = await initAdminWallet(identityLabel);
    const gateway = new Gateway();

    await gateway.connect(path.join(__dirname, './connprofile.json'),
        {
            wallet: wallet,
            identity: identityLabel
        });

    logger.info('Gateway connects get succeed.');

    const network = await gateway.getNetwork('channelall');
    const contract = await network.getContract('mycc');
    // const result = await contract.evaluateTransaction('addMarks', '[Alice]');
    const result = await contract.submitTransaction('addMarks','[Alice,68,84,89]')
    gateway.disconnect();
    
    logger.info('Result', Buffer.from(result).toString());
}

async function query() {
    const identityLabel = 'Admin@org1.desl.com';
    const wallet = await initAdminWallet(identityLabel);
    const gateway = new Gateway();

    await gateway.connect(path.join(__dirname, './connprofile.json'),
        {
            wallet: wallet,
            identity: identityLabel
        });

    logger.info('Gateway connects get succeed.');

    const network = await gateway.getNetwork('channelall');
    const contract = await network.getContract('mycc');
    const result = await contract.evaluateTransaction('queryMarks', '[Alice]');
    // const result = await contract.submitTransaction('addMarks','[Alice,68,84,89]')
    gateway.disconnect();
    
    logger.info('Result', Buffer.from(result).toString());
}
async function initAdminWallet(identityLabel) {
    // Hardcode crypto materials of Admin@org1.desl.com.
    const keyPath = path.join(__dirname, "./crypto-config/peerOrganizations/org1.desl.com/users/Admin@org1.desl.com/msp/keystore/bb00369760c2062266de7790694bfd61d5cd3894e6eb3d87cd7f0f7cc49d006a_sk");
    const keyPEM = Buffer.from(fs.readFileSync(keyPath)).toString();
    const certPath = path.join(__dirname, "./crypto-config/peerOrganizations/org1.desl.com/users/Admin@org1.desl.com/msp/signcerts/Admin@org1.desl.com-cert.pem");
    const certPEM = Buffer.from(fs.readFileSync(certPath)).toString();

    const mspId = 'Org1MSP';
    const identity = X509WalletMixin.createIdentity(mspId, certPEM, keyPEM)

    const wallet = new FileSystemWallet('/tmp/wallet/test1');
    await wallet.import(identityLabel, identity);

    if (await wallet.exists(identityLabel)) {
        logger.info('Identity %s exists.', identityLabel);
    }
    else {
        logger.error('Identity %s does not exist.', identityLabel);
    }
    return wallet;
}