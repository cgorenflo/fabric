#!/bin/bash
source base_parameters.sh

p_addr=$(get_correct_peer_address $(hostname))

export FABRIC_LOGGING_SPEC=INFO
export CORE_PEER_MSPCONFIGPATH=${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/${PEER_DOMAIN}/peers/$p_addr/msp


export CORE_PEER_ID=${p_addr}
export CORE_PEER_ADDRESS=${p_addr}:7051
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=${p_addr}:7051
export CORE_PEER_CHAINCODEADDRESS=${p_addr}:7052

rm /var/hyperledger/production/* -r # clean up data from previous runs
(cd ${FABRIC_ROOT}/peer/ && go install)
peer node start -e #-a $(get_correct_peer_address $(hostname)):10000 --storageAddr $(get_correct_peer_address ${STORAGE_ADDRESS}):10000
