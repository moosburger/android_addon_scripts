#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-12
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd frameworks/base
#git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/52/322452/3 && git cherry-pick FETCH_HEAD
#git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/53/322453/3 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/19/345519/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/20/345520/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/21/345521/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/22/345522/1 && git cherry-pick FETCH_HEAD
cd ../..
cd frameworks/minikin
git fetch https://github.com/LineageOS/android_frameworks_minikin refs/changes/23/345523/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_minikin refs/changes/24/345524/1 && git cherry-pick FETCH_HEAD
cd ../../..
cd packages/apps/Bluetooth
#git fetch https://github.com/LineageOS/android_packages_apps_Bluetooth refs/changes/25/345525/1 && git cherry-pick FETCH_HEAD
#git fetch https://github.com/LineageOS/android_packages_apps_Bluetooth refs/changes/25/345525/2 && git cherry-pick FETCH_HEAD
cd ../../..
cd packages/services/Telecomm
git fetch https://github.com/LineageOS/android_packages_services_Telecomm refs/changes/26/345526/1 && git cherry-pick FETCH_HEAD
cd ../../..
cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/27/345527/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_system_bt refs/changes/28/345528/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_system_bt refs/changes/30/345530/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_system_bt refs/changes/29/345529/1 && git cherry-pick FETCH_HEAD
cd ../../..
cd packages/apps/Settings
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/79/345679/1 && git cherry-pick FETCH_HEAD
cd ../../..
