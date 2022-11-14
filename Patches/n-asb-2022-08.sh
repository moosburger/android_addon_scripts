#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-08
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
cd ..
cd lineage14.1

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/71/334871/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/72/334872/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/73/334873/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/apps/Settings
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/74/334874/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/75/334875/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/providers/ContactsProvider
git fetch https://github.com/LineageOS/android_packages_providers_ContactsProvider refs/changes/76/334876/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/77/334877/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..

