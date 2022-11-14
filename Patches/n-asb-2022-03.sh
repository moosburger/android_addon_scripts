#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-03
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
cd ..
cd lineage14.1

cd frameworks/native
git fetch https://github.com/LineageOS/android_frameworks_native refs/changes/93/325993/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/apps/Settings
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/94/325994/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/99/327099/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..