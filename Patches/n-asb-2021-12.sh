#!/bin/bash
 echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2021-12
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
cd ..
cd lineage14.1

cd external/tremolo
git fetch https://github.com/LineageOS/android_external_tremolo refs/changes/86/319986/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/20/320420/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/88/319988/2 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd frameworks/av
git fetch https://github.com/LineageOS/android_frameworks_av refs/changes/87/319987/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/apps/Settings
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/91/319991/2 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/apps/KeyChain
git fetch https://github.com/LineageOS/android_packages_apps_KeyChain refs/changes/90/319990/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/apps/Contacts
git fetch https://github.com/LineageOS/android_packages_apps_Contacts refs/changes/89/319989/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
