#!/bin/bash

sudo configtxgen -inspectBlock ../channel-artifacts/genesis.block > genesisBlockOutput.json

sudo configtxgen -configPath ../configtx/ -printOrg Org1MSP > org1Output.json 

sudo configtxgen -inspectChannelCreateTx ../channel-artifacts/test-channel.tx > channelTxOutput.json