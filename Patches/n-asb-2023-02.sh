#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2023-02
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/50/348650/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/51/348651/1 && git cherry-pick FETCH_HEAD
cd ../..
cd external/expat
git fetch https://github.com/LineageOS/android_external_expat refs/changes/49/348649/1 && git cherry-pick FETCH_HEAD
cd ../..
cd packages/apps/Nfc
git fetch https://github.com/LineageOS/android_packages_apps_Nfc refs/changes/53/348653/1 && git cherry-pick FETCH_HEAD
cd ../../..
#cd packages/apps/Bluetooth
#Fix OPP comparison
#git fetch https://github.com/LineageOS/android_packages_apps_Bluetooth refs/changes/52/348652/1 && git cherry-pick FETCH_HEAD
#cd ../../..
cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/54/348654/1 && git cherry-pick FETCH_HEAD
cd ../../..
