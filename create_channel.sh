#!/bin/bash

export FABRIC_CFG_PATH=${PWD}/config
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export CHANNEL_NAME=test-channel

setEnvForPeer0Org1() {
    export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org1MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setEnvForPeer1Org1() {
    export PEER1_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org1MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
}

setEnvForPeer0Org2() {
    export PEER0_ORG2_CA=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org2MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setEnvForPeer1Org2() {
    export PEER1_ORG2_CA=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org2MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
}

setEnvForPeer0Org3() {
    export PEER0_ORG3_CA=${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org3MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
}

setEnvForPeer1Org3() {
    export PEER1_ORG3_CA=${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org3MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
    export CORE_PEER_ADDRESS=localhost:12051
}

setEnvForPeer0Org4() {
    export PEER0_ORG4_CA=${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org4MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
}

setEnvForPeer1Org4() {
    export PEER1_ORG4_CA=${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org4MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp
    export CORE_PEER_ADDRESS=localhost:14051
}

setEnvForPeer0Org5() {
    export PEER0_ORG5_CA=${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org5MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG5_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
    export CORE_PEER_ADDRESS=localhost:15051
}

setEnvForPeer1Org5() {
    export PEER1_ORG5_CA=${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org5MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG5_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
    export CORE_PEER_ADDRESS=localhost:16051
}
setEnvForPeer0Org6() {
    export PEER0_ORG6_CA=${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org6MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG6_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org6.example.com/users/Admin@org6.example.com/msp
    export CORE_PEER_ADDRESS=localhost:17051
}

setEnvForPeer1Org6() {
    export PEER1_ORG6_CA=${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=Org6MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG6_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org6.example.com/users/Admin@org6.example.com/msp
    export CORE_PEER_ADDRESS=localhost:18051
}

createChannel() {
    setEnvForPeer0Org1

    echo "========== Creating Channel =========="
    echo ""
    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
        --ordererTLSHostnameOverride orderer.example.com \
        -f ./channel-artifacts/$CHANNEL_NAME.tx --outputBlock \
        ./channel-artifacts/${CHANNEL_NAME}.block \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
}

joinChannel() {

    setEnvForPeer0Org1
    echo "========== Peer0Org1 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1Org1
    echo "========== Peer1Org1 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0Org2
    echo "========== Peer0Org2 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1Org2
    echo "========== Peer1Org2 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0Org3
    echo "========== Peer0Org3 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1Org3
    echo "========== Peer1Org3 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""
    setEnvForPeer0Org4
    echo "========== Peer0Org4 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1Org4
    echo "========== Peer1Org4 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0Org5
    echo "========== Peer0Org5 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1Org5
    echo "========== Peer1Org5 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0Org6
    echo "========== Peer0Org6 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1Org6
    echo "========== Peer1Org6 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

}

updateAnchorPeers() {
    setEnvForPeer0Org1
    echo "========== Updating Anchor Peer of Peer0Org1 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0Org2
    echo "========== Updating Anchor Peer of Peer0Org2 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
    setEnvForPeer0Org3
    echo "========== Updating Anchor Peer of Peer0Org3 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
    setEnvForPeer0Org4
    echo "========== Updating Anchor Peer of Peer0Org4 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
    setEnvForPeer0Org5
    echo "========== Updating Anchor Peer of Peer0Org5 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
    setEnvForPeer0Org6
    echo "========== Updating Anchor Peer of Peer0Org6 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
}

createChannel
joinChannel
# peer channel getinfo -c test-channel
updateAnchorPeers
