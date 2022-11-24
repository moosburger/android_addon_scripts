#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-11
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/17/344217/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/56/343956/4 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/57/343957/4 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/88/344188/3 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/89/344189/3 && git cherry-pick FETCH_HEAD
cd ../..
cd packages/services/Telecomm
git fetch https://github.com/LineageOS/android_packages_services_Telecomm refs/changes/53/343953/1 && git cherry-pick FETCH_HEAD
cd ../../..
cd packages/providers/TelephonyProvider
git fetch https://github.com/LineageOS/android_packages_providers_TelephonyProvider refs/changes/54/343954/1 && git cherry-pick FETCH_HEAD
cd ../../..
cd external/libnfc-nci
git fetch https://github.com/LineageOS/android_external_libnfc-nci refs/changes/55/343955/1 && git cherry-pick FETCH_HEAD
cd ../..
cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/58/343958/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_system_bt refs/changes/59/343959/1 && git cherry-pick FETCH_HEAD
cd ../..
cd packages/apps/PackageInstaller
git fetch https://github.com/LineageOS/android_packages_apps_PackageInstaller refs/changes/87/344187/1 && git cherry-pick FETCH_HEAD
cd ../../..

