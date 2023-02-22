#!/bin/bash

echo  "========== Stopping the Containers =========="
cd ./docker/

docker-compose -f docker-compose-ca.yaml stop
docker-compose stop
docker-compose -f docker-compose-ca.yaml down -v
docker-compose -f docker-compose.yaml down -v

docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)

#Remove Old Crypto
cd ..
pwd
echo "========== Clearing Crypto Material =========="
sudo rm -rf organizations/ordererOrganizations/
sudo rm -rf organizations/peerOrganizations/
sudo rm -rf organizations/fabric-ca/
sudo rm -rf channel-artifacts/

#Deleting Chaincode
echo "========== Deleting Chaincode Package =========="
rm -rf test.tar.gz
