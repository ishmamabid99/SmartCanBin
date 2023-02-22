#!/bin/bash
source ./terminal_control.sh

export FABRIC_CFG_PATH=${PWD}/configtx/
echo "$FABRIC_CFG_PATH"

SYS_CHANNEL=test-sys-channel
echo "System Channel Name: "$SYS_CHANNEL
echo ""

CHANNEL_NAME=test-channel
echo "Application Channel Name: "$CHANNEL_NAME
echo ""

mkdir -p ./channel-artifacts

# Generate System Genesis Block using configtxgen tool
echo "========== Generating System Genesis Block =========="
echo ""

configtxgen -configPath ./configtx/ -profile TestOrdererGenesis -channelID $SYS_CHANNEL -outputBlock ./channel-artifacts/genesis.block

echo "========== System Genesis Block Generated =========="
echo ""

echo "========== Generating Channel Configuration Block =========="
echo ""

configtxgen -profile TestChannel -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/test-channel.tx -channelID $CHANNEL_NAME

echo "========== Channel Configuration Block Generated =========="
echo ""

echo "========== Generating Anchor Peer Update For Org1MSP =========="
echo ""

configtxgen -profile TestChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
echo "========== Anchor Peer Update For Org1MSP Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For Org2MSP =========="
echo ""

configtxgen -profile TestChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg Org2MSP
echo "========== Anchor Peer Update For Org2MSP Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For Org3MSP =========="
echo ""

configtxgen -profile TestChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg Org3MSP

echo "========== Anchor Peer Update For Org3MSP Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For Org4MSP =========="
echo ""

configtxgen -profile TestChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg Org4MSP

echo "========== Anchor Peer Update For Org4MSP Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For Org5MSP =========="
echo ""

configtxgen -profile TestChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/Org5MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg Org5MSP

echo "========== Anchor Peer Update For Org5MSP Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For Org6MSP =========="
echo ""

configtxgen -profile TestChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/Org6MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg Org6MSP

echo "========== Anchor Peer Update For Org6MSP Sucessful =========="
echo ""
