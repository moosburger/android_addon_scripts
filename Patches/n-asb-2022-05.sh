#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-05
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/08/331108/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..