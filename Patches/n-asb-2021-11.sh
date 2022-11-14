#!/bin/bash
 echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2021-11
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
cd ..
cd lineage14.1

cd external/libnfc-nci
git fetch https://github.com/LineageOS/android_external_libnfc-nci refs/changes/15/318515/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/16/318516/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/17/318517/2 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/apps/Settings
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/19/318519/2 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/apps/Contacts
git fetch https://github.com/LineageOS/android_packages_apps_Contacts refs/changes/18/318518/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
