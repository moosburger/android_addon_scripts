#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2023-01
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/48/346948/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/50/346950/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/51/346951/1 && git cherry-pick FETCH_HEAD
cd ../..
cd packages/apps/Nfc
git fetch https://github.com/LineageOS/android_packages_apps_Nfc refs/changes/53/346953/1 && git cherry-pick FETCH_HEAD
cd ../../..
cd packages/services/Telephony
git fetch https://github.com/LineageOS/android_packages_services_Telephony refs/changes/54/346954/1 && git cherry-pick FETCH_HEAD
cd ../../..
cd system/bt
# BT: Once AT command is retrieved, return from method.
git fetch https://github.com/LineageOS/android_system_bt refs/changes/52/346952/1 && git cherry-pick FETCH_HEAD
cd ../../..

