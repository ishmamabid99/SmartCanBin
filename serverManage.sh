./tear.sh
./generate_all.sh
cd api/Org1Producer
rm -rf walletOrg1
node enrollAdminOrg1.js

cd ..

cd Org2Recycler
rm -rf walletOrg2
node enrollAdminOrg2.js

cd ..

cd Org3Retailer
rm -rf walletOrg3
node enrollAdminOrg3.js

cd ..

cd Org4User
rm -rf walletOrg4
node enrollAdminOrg4.js

cd ..

cd Org5Bin
rm -rf walletOrg5
node enrollAdminOrg5.js

cd ..

cd Org6Segregator
rm -rf walletOrg6
node enrollAdminOrg6.js
