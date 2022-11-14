#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-07
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
cd ..
cd lineage14.1

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/35/334035/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/32/334032/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_system_bt refs/changes/33/334033/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_system_bt refs/changes/34/334034/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/apps/KeyChain
git fetch https://github.com/LineageOS/android_packages_apps_KeyChain refs/changes/36/334036/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/apps/Settings
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/37/334037/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
