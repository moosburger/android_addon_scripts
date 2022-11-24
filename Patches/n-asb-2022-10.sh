#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-10
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/70/341070/1 && git cherry-pick FETCH_HEAD
cd ../..
cd external/libnfc-nci
git fetch https://github.com/LineageOS/android_external_libnfc-nci refs/changes/71/341071/1 && git cherry-pick FETCH_HEAD
cd ../..