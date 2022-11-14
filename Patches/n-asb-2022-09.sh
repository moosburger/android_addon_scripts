#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-09
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
cd ..
cd lineage14.1

cd android
git fetch https://github.com/LineageOS/android refs/changes/82/338382/1 && git cherry-pick FETCH_HEAD --quiet
cd ..
cd system/bt
git fetch https://github.com/LineageOS/android_system_bt refs/changes/00/338000/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_system_bt refs/changes/98/337998/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_system_bt refs/changes/99/337999/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd external/expat
git fetch https://github.com/LineageOS/android_external_expat refs/changes/84/338384/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_expat refs/changes/85/338385/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_expat refs/changes/86/338386/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/03/338003/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
