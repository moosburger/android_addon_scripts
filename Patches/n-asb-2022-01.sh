#!/bin/bash
 echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-01
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/52/322452/3 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/53/322453/3 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/54/322454/4 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd frameworks/av
git fetch https://github.com/LineageOS/android_frameworks_av refs/changes/22/321222/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
