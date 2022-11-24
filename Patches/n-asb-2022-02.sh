#!/bin/bash
 echo
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-02
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/56/323456/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_system_bt refs/changes/57/323457/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/apps/Settings
git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/58/323458/2 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd external/libexif
git fetch https://github.com/LineageOS/android_external_libexif refs/changes/59/323459/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_libexif refs/changes/60/323460/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_libexif refs/changes/61/323461/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd external/libavc
git fetch https://github.com/LineageOS/android_external_libavc refs/changes/62/323462/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/providers/MediaProvider
git fetch https://github.com/LineageOS/android_packages_providers_MediaProvider refs/changes/48/324248/2 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
