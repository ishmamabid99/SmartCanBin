#!/bin/bash
source ./terminal_control.sh

export FABRIC_CFG_PATH=${PWD}/config
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export CORE_PEER_TLS_ROOTCERT_FILE_ORG1=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG2=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG3=${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG4=${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG5=${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG6=${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/ca.crt

CHANNEL_NAME="test-channel"
CHAINCODE_NAME="test"
CHAINCODE_VERSION="1.0"
CHAINCODE_PATH="./chaincode/fabcar/javascript/"
CHAINCODE_LABEL="test_1"
CHAINCODE_LANG="node"

setEnvForOrg1() {
    echo $CHAINCHODE_PATH
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=Org1MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setEnvForOrg2() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=Org2MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setEnvForOrg3() {
    export PEER0_ORG3_CA=${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org3MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
}
setEnvForOrg4() {
    export PEER0_ORG4_CA=${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org4MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
}
setEnvForOrg5() {
    export PEER0_ORG5_CA=${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org5MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG5_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
    export CORE_PEER_ADDRESS=localhost:15051
}
setEnvForOrg6() {
    export PEER0_ORG6_CA=${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org6MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG6_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org6.example.com/users/Admin@org6.example.com/msp
    export CORE_PEER_ADDRESS=localhost:17051
}

packageChaincode() {
    rm -rf ${CHAINCODE_NAME}.tar.gz
    setEnvForOrg1
    echo Green "========== Packaging Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path ${CHAINCODE_PATH} --lang ${CHAINCODE_LANG} --label ${CHAINCODE_LABEL}
    echo ""
    echo Green "========== Packaging Chaincode on Peer0 org1 Successful =========="
    echo ""
}

installChaincode() {
    setEnvForOrg1
    echo "========== Installing Chaincode on Peer0 org1 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on Peer0 org1 =========="
    echo ""

    setEnvForOrg2
    echo Green "========== Installing Chaincode on Peer0 org2 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on peer0 org2 =========="
    echo ""

    setEnvForOrg3
    echo Green "========== Installing Chaincode on Peer0 Org3 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on Peer0 Org3 =========="
    echo ""

    setEnvForOrg4
    echo Green "========== Installing Chaincode on Peer0 Org4 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on Peer0 Org4 =========="
    echo ""

    setEnvForOrg5
    echo Green "========== Installing Chaincode on Peer0 Org5 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on Peer0 Org5 =========="
    echo ""

    setEnvForOrg6
    echo Green "========== Installing Chaincode on Peer0 Org6 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on Peer0 Org6 =========="
    echo ""
}

queryInstalledChaincode() {
    setEnvForOrg1
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 org1=========="
    echo ""
}

approveChaincodeByOrg1() {
    setEnvForOrg1
    echo Green "========== Approve Installed Chaincode by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID test-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForOrg1() {
    setEnvForOrg1
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 org1 =========="
    echo ""
}

approveChaincodeByOrg2() {
    setEnvForOrg2
    echo Green "========== Approve Installed Chaincode by Peer0 org2 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID test-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 org2 =========="
    echo ""
}

checkCommitReadynessForOrg2() {
    setEnvForOrg2
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 org2 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 org2 =========="
    echo ""
}

approveChaincodeByOrg3() {
    setEnvForOrg3
    echo Green "========== Approve Installed Chaincode by Peer0 Org3 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID test-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 Org3 =========="
    echo ""
}

checkCommitReadynessForOrg3() {
    setEnvForOrg3
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 Org3 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 Org3 =========="
    echo ""
}

approveChaincodeByOrg4() {
    setEnvForOrg4
    echo Green "========== Approve Installed Chaincode by Peer0 Org4 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID test-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 Org4 =========="
    echo ""
}

checkCommitReadynessForOrg4() {
    setEnvForOrg4
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 Org4 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 Org4 =========="
    echo ""
}

approveChaincodeByOrg5() {
    setEnvForOrg5
    echo Green "========== Approve Installed Chaincode by Peer0 Org5 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID test-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 Org5 =========="
    echo ""
}

checkCommitReadynessForOrg5() {
    setEnvForOrg5
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 Org5 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 Org5 =========="
    echo ""
}

approveChaincodeByOrg6() {
    setEnvForOrg6
    echo Green "========== Approve Installed Chaincode by Peer0 Org6 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID test-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 Org6 =========="
    echo ""
}

checkCommitReadynessForOrg6() {
    setEnvForOrg6
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 Org6 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 Org6 =========="
    echo ""
}

commitChaincode() {
    setEnvForOrg1
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG3} --peerAddresses localhost:13051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG4} --peerAddresses localhost:15051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG5} --peerAddresses localhost:17051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG6} --version ${CHAINCODE_VERSION} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}

queryCommittedChaincode() {
    setEnvForOrg1
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}

getInstalledChaincode() {
    setEnvForOrg1
    echo Green "========== Get Installed Chaincode from Peer0 org1 =========="
    peer lifecycle chaincode getinstalledpackage --package-id ${PACKAGE_ID} --output-directory . --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    echo Green "========== Get Installed Chaincode from Peer0 org1 Successful =========="
    echo ""
}

queryApprovedChaincode() {
    setEnvForOrg1
    echo Green "========== Query Approved of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C s${CHANNEL_NAME} -n ${CHAINCODE_NAME} --sequence 1
    echo Green "========== Query Approved of Installed Chaincode on Peer0 org1 Successful =========="
    echo ""
}

initChaincode() {
    setEnvForOrg1
    echo Green "========== Init Chaincode on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG3} --isInit -c '{"Args":[]}'
    echo Green "========== Init Chaincode on Peer0 org1 Successful ========== "
    echo ""
}

chaincodeInvoke() {

    echo "-------------------- Chaincode Invoke --------------------"

    setEnvForOrg1

    ## Init ledger
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls ${CORE_PEER_TLS_ENABLED} \
        --cafile ${ORDERER_CA} \
        -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} \
        --peerAddresses localhost:7051 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} \
        --peerAddresses localhost:9051 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} \
        --peerAddresses localhost:11051 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG3} \
        --peerAddresses localhost:13051 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG4} \
        --peerAddresses localhost:15051 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG5} \
        --peerAddresses localhost:17051 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG6} \
        -c '{"function": "initLedger","Args":[]}'
    echo " -- : Done : --"
    echo ""
}

chaincodeQuery() {

    echo "-------------------- Chaincode Query --------------------"
    setEnvForOrg1

    peer chaincode query -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} \
        -c '{"function": "queryAllData","Args":[]}'

    echo " -- : Done : --"
    echo ""
}

packageChaincode
installChaincode
queryInstalledChaincode
approveChaincodeByOrg1
checkCommitReadynessForOrg1
approveChaincodeByOrg2
checkCommitReadynessForOrg2
approveChaincodeByOrg3
checkCommitReadynessForOrg3
approveChaincodeByOrg4
checkCommitReadynessForOrg4
approveChaincodeByOrg5
checkCommitReadynessForOrg5
approveChaincodeByOrg6
checkCommitReadynessForOrg6
commitChaincode
queryCommittedChaincode
sleep 5
initChaincode
sleep 5
chaincodeInvoke
sleep 5
chaincodeQuery
