#!/bin/bash

set -ex

shopt -s expand_aliases
set +u && source ${CMS_PATH}/cmsset_default.sh; set -u
cmsrel ${CMSSW_RELEASE}
cd ${CMSSW_RELEASE}/src
cmsenv
git cms-init --upstream-only

echo -e "/.gitignore \n /.clang-tidy \n /.clang-format \n /RecoEgamma/EgammaElectronProducers/ \n /RecoEgamma/EgammaTools/ \n /RecoEgamma/ElectronIdentification/ \n" > .git/info/sparse-checkout

git remote add crovelli git@github.com:crovelli/cmssw.git
git fetch crovelli
git checkout -b from-CMSSW_10_2_15__ID-2020Jul26-depth13-700__WithFinalReg crovelli/from-CMSSW_10_2_15__ID-2020Jul26-depth13-700__WithFinalReg
git cms-addpkg TrackingTools/TransientTrack
git cms-merge-topic -u CMSBParking:GsfTransientTracks
git cms-merge-topic -u CMSBParking:fixKinParticleVtxFitter
git clone git@github.com:CMSBParking/BParkingNANO.git  ./PhysicsTools
git cms-addpkg PhysicsTools/NanoAOD
scram b
