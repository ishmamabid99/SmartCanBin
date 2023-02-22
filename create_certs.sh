createCertForOrg1() {
  echo
  echo "Enroll CA admin of org1"
  echo
  mkdir -p ./organizations/peerOrganizations/org1.example.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.example.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.org1.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml

  echo
  echo "Register admin.org1"
  echo

  fabric-ca-client register --caname ca.org1.example.com --id.name org1admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  echo
  echo "Register peer0.org1"
  echo

  fabric-ca-client register --caname ca.org1.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  echo
  echo "Register peer1.org1"
  echo

  fabric-ca-client register --caname ca.org1.example.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  echo
  echo "Register user1.org1"
  echo

  fabric-ca-client register --caname ca.org1.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com

  echo
  echo "Generate Peer0 MSP"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp --csr.hosts peer0.org1.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/config.yaml

  echo
  echo "Generate Peer0 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls --enrollment.profile tls --csr.hosts peer0.org1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/org1.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org1.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org1.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem

  # -----------------------------------------------------------------------------------
  # Peer1
  # -----------------------------------------------------------------------------------

  mkdir -p ./organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com

  echo
  echo "Generate Peer1 MSP"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp --csr.hosts peer1.org1.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp/config.yaml

  echo
  echo "Generate Peer1 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls --enrollment.profile tls --csr.hosts peer1.org1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.key

  mkdir -p ./organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com

  echo
  echo "Generate User1 MSP"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com

  echo
  echo "Generate org1 Admin MSP"
  echo

  fabric-ca-client enroll -u https://org1admin:adminpw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/config.yaml
}

createCertForOrg2() {
  echo
  echo "Enroll CA admin of org2"
  echo
  mkdir -p ./organizations/peerOrganizations/org2.example.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org2.example.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.org2.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml

  echo
  echo "Register admin.org2"
  echo

  fabric-ca-client register --caname ca.org2.example.com --id.name org2admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  echo
  echo "Register peer0.org2"
  echo

  fabric-ca-client register --caname ca.org2.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  echo
  echo "Register peer1.org2"
  echo

  fabric-ca-client register --caname ca.org2.example.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  echo
  echo "Register user1.org2"
  echo

  fabric-ca-client register --caname ca.org2.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com

  echo
  echo "Generate Peer0 MSP"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp --csr.hosts peer0.org2.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/config.yaml

  echo
  echo "Generate Peer0 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls --enrollment.profile tls --csr.hosts peer0.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/org2.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org2.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org2.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/ca/ca.org2.example.com-cert.pem

  # -----------------------------------------------------------------------------------
  # Peer1
  # -----------------------------------------------------------------------------------

  mkdir -p ./organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com

  echo
  echo "Generate Peer1 MSP"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp --csr.hosts peer1.org2.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp/config.yaml

  echo
  echo "Generate Peer1 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls --enrollment.profile tls --csr.hosts peer1.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.key

  mkdir -p ./organizations/peerOrganizations/org2.example.com/users/User1@org2.example.com

  echo
  echo "Generate User1 MSP"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/organizations/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com

  echo
  echo "Generate org2 Admin MSP"
  echo

  fabric-ca-client enroll -u https://org2admin:adminpw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/config.yaml
}

createCertForOrg3() {
  echo
  echo "Enroll CA admin of org3"
  echo
  mkdir -p ./organizations/peerOrganizations/org3.example.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org3.example.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.org3.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml

  echo
  echo "Register peer0.org3"
  echo

  fabric-ca-client register --caname ca.org3.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  echo
  echo "Register peer1.org3"
  echo

  fabric-ca-client register --caname ca.org3.example.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  echo
  echo "Register user1.org3"
  echo

  fabric-ca-client register --caname ca.org3.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  echo
  echo "Register admin.org3"
  echo

  fabric-ca-client register --caname ca.org3.example.com --id.name org3admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com

  echo
  echo "Generate Peer0 MSP"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.org3.example.com -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/msp --csr.hosts peer0.org3.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/msp/config.yaml

  echo
  echo "Generate Peer0 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.org3.example.com -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls --enrollment.profile tls --csr.hosts peer0.org3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/ca/ca.org3.example.com-cert.pem

  # -----------------------------------------------------------------------------------
  # Peer1
  mkdir -p ./organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com

  echo
  echo "Generate Peer1 MSP"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.org3.example.com -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/msp --csr.hosts peer1.org3.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/msp/config.yaml

  echo
  echo "Generate Peer1 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.org3.example.com -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls --enrollment.profile tls --csr.hosts peer1.org3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/server.key

  mkdir -p ./organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com

  echo
  echo "Generate User1 MSP"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca.org3.example.com -M ${PWD}/organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com

  echo
  echo "Generate org3 Admin MSP"
  echo

  fabric-ca-client enroll -u https://org3admin:adminpw@localhost:9054 --caname ca.org3.example.com -M ${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp/config.yaml

}
createCertForOrg4() {
  echo
  echo "Enroll CA admin of org4"
  echo
  mkdir -p ./organizations/peerOrganizations/org4.example.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org4.example.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.org4.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/org4.example.com/msp/config.yaml

  echo
  echo "Register peer0.org4"
  echo

  fabric-ca-client register --caname ca.org4.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  echo
  echo "Register peer1.org4"
  echo

  fabric-ca-client register --caname ca.org4.example.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  echo
  echo "Register user1.org4"
  echo

  fabric-ca-client register --caname ca.org4.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  echo
  echo "Register admin.org4"
  echo

  fabric-ca-client register --caname ca.org4.example.com --id.name org4admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com

  echo
  echo "Generate Peer0 MSP"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp --csr.hosts peer0.org4.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/config.yaml

  echo
  echo "Generate Peer0 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls --enrollment.profile tls --csr.hosts peer0.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/org4.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org4.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org4.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org4.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem

  # -----------------------------------------------------------------------------------
  # Peer1
  mkdir -p ./organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com

  echo
  echo "Generate Peer1 MSP"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp --csr.hosts peer1.org4.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp/config.yaml

  echo
  echo "Generate Peer1 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls --enrollment.profile tls --csr.hosts peer1.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.key

  mkdir -p ./organizations/peerOrganizations/org4.example.com/users/User1@org4.example.com

  echo
  echo "Generate User1 MSP"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/organizations/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org4.example.com/users/Admin@org4.example.com

  echo
  echo "Generate org4 Admin MSP"
  echo

  fabric-ca-client enroll -u https://org4admin:adminpw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/organizations/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org4/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp/config.yaml

}
createCertForOrg5() {
  echo
  echo "Enroll CA admin of org5"
  echo
  mkdir -p ./organizations/peerOrganizations/org5.example.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org5.example.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:12054 --caname ca.org5.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-org5-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-org5-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-org5-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-org5-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/org5.example.com/msp/config.yaml

  echo
  echo "Register peer0.org5"
  echo

  fabric-ca-client register --caname ca.org5.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  echo
  echo "Register peer1.org5"
  echo

  fabric-ca-client register --caname ca.org5.example.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  echo
  echo "Register user1.org5"
  echo

  fabric-ca-client register --caname ca.org5.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  echo
  echo "Register admin.org5"
  echo

  fabric-ca-client register --caname ca.org5.example.com --id.name org5admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com

  echo
  echo "Generate Peer0 MSP"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca.org5.example.com -M ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp --csr.hosts peer0.org5.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp/config.yaml

  echo
  echo "Generate Peer0 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca.org5.example.com -M ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls --enrollment.profile tls --csr.hosts peer0.org5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/org5.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org5.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org5.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org5.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org5.example.com/ca/ca.org5.example.com-cert.pem

  # -----------------------------------------------------------------------------------
  # Peer1
  mkdir -p ./organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com

  echo
  echo "Generate Peer1 MSP"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:12054 --caname ca.org5.example.com -M ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp --csr.hosts peer1.org5.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp/config.yaml

  echo
  echo "Generate Peer1 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:12054 --caname ca.org5.example.com -M ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls --enrollment.profile tls --csr.hosts peer1.org5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/server.key

  mkdir -p ./organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com

  echo
  echo "Generate User1 MSP"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:12054 --caname ca.org5.example.com -M ${PWD}/organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org5.example.com/users/Admin@org5.example.com

  echo
  echo "Generate org4 Admin MSP"
  echo

  fabric-ca-client enroll -u https://org5admin:adminpw@localhost:12054 --caname ca.org5.example.com -M ${PWD}/organizations/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org5/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp/config.yaml

}

createCertForOrg6() {
  echo
  echo "Enroll CA admin of org6"
  echo
  mkdir -p ./organizations/peerOrganizations/org6.example.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org6.example.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:13054 --caname ca.org6.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-org6-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-org6-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-org6-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-13054-ca-org6-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/org6.example.com/msp/config.yaml

  echo
  echo "Register peer0.org6"
  echo

  fabric-ca-client register --caname ca.org6.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  echo
  echo "Register peer1.org6"
  echo

  fabric-ca-client register --caname ca.org6.example.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  echo
  echo "Register user1.org6"
  echo

  fabric-ca-client register --caname ca.org6.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  echo
  echo "Register admin.org6"
  echo

  fabric-ca-client register --caname ca.org6.example.com --id.name org6admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com

  echo
  echo "Generate Peer0 MSP"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:13054 --caname ca.org6.example.com -M ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/msp --csr.hosts peer0.org6.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org6.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/msp/config.yaml

  echo
  echo "Generate Peer0 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:13054 --caname ca.org6.example.com -M ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls --enrollment.profile tls --csr.hosts peer0.org6.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/org6.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org6.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org6.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org6.example.com/tlsca/tlsca.org6.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org6.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org6.example.com/ca/ca.org6.example.com-cert.pem

  # -----------------------------------------------------------------------------------
  # Peer1
  mkdir -p ./organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com

  echo
  echo "Generate Peer1 MSP"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:13054 --caname ca.org6.example.com -M ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/msp --csr.hosts peer1.org6.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org6.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/msp/config.yaml

  echo
  echo "Generate Peer1 TLS-CERTs"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:13054 --caname ca.org6.example.com -M ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls --enrollment.profile tls --csr.hosts peer1.org6.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer1.org6.example.com/tls/server.key

  mkdir -p ./organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com

  echo
  echo "Generate User1 MSP"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:13054 --caname ca.org6.example.com -M ${PWD}/organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  mkdir -p ./organizations/peerOrganizations/org6.example.com/users/Admin@org6.example.com

  echo
  echo "Generate org6 Admin MSP"
  echo

  fabric-ca-client enroll -u https://org6admin:adminpw@localhost:13054 --caname ca.org6.example.com -M ${PWD}/organizations/peerOrganizations/org6.example.com/users/Admin@org6.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org6/tls-cert.pem

  cp ${PWD}/organizations/peerOrganizations/org6.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org6.example.com/users/Admin@org6.example.com/msp/config.yaml

}

createCretificateForOrderer() {
  echo
  echo "Enroll CA admin of Orderer"
  echo
  mkdir -p ./organizations/ordererOrganizations/example.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/example.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register the Orderer Admin"
  echo

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ./organizations/ordererOrganizations/example.com/orderers/orderer.example.com

  echo
  echo "Generate the Orderer MSP"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

  echo
  echo "Generate the orderer TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

  mkdir ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  mkdir ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ./organizations/ordererOrganizations/example.com/orderers/orderer2.example.com

  echo
  echo "Generate the Orderer2 MSP"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/config.yaml

  echo
  echo "Generate the Orderer2 TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls --enrollment.profile tls --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key

  mkdir ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ./organizations/ordererOrganizations/example.com/orderers/orderer3.example.com

  echo
  echo "Generate the Orderer3 MSP"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/msp --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/config.yaml

  echo
  echo "Generate the Orderer3 TLS certs"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls --enrollment.profile tls --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.key

  mkdir ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ./organizations/ordererOrganizations/example.com/users
  mkdir -p ./organizations/ordererOrganizations/example.com/users/Admin@example.com

  echo
  echo "Generate the Admin MSP Orderer"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:11054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml

}

setPermission() {
  sudo chown -hR fustian ${PWD}/organizations/peerOrganizations/org1.example.com/msp ${PWD}/organizations/peerOrganizations/org1.example.com/peers ${PWD}/organizations/peerOrganizations/org1.example.com/users
  sudo chown -hR fustian ${PWD}/organizations/peerOrganizations/org2.example.com/msp ${PWD}/organizations/peerOrganizations/org2.example.com/peers ${PWD}/organizations/peerOrganizations/org2.example.com/users
  sudo chown -hR fustian ${PWD}/organizations/peerOrganizations/org3.example.com/msp ${PWD}/organizations/peerOrganizations/org3.example.com/peers ${PWD}/organizations/peerOrganizations/org3.example.com/users
  sudo chown -hR fustian ${PWD}/organizations/peerOrganizations/org4.example.com/msp ${PWD}/organizations/peerOrganizations/org4.example.com/peers ${PWD}/organizations/peerOrganizations/org4.example.com/users
  sudo chown -hR fustian ${PWD}/organizations/peerOrganizations/org5.example.com/msp ${PWD}/organizations/peerOrganizations/org5.example.com/peers ${PWD}/organizations/peerOrganizations/org5.example.com/users
  sudo chown -hR fustian ${PWD}/organizations/peerOrganizations/org6.example.com/msp ${PWD}/organizations/peerOrganizations/org6.example.com/peers ${PWD}/organizations/peerOrganizations/org6.example.com/users
}

createCertForOrg1
createCertForOrg2
createCertForOrg3
createCertForOrg4
createCertForOrg5
createCertForOrg6
createCretificateForOrderer
setPermission
