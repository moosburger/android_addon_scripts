#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-FixPython
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd vendor/cm
git fetch https://github.com/LineageOS/android_build refs/changes/00/324000/1 && git checkout FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_vendor_cm refs/changes/01/324001/5 && git checkout FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_minikin refs/changes/04/324004/5 && git checkout FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_v8 refs/changes/07/324007/2 && git checkout FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_system_sepolicy refs/changes/10/324010/2 && git checkout FETCH_HEAD --quiet
cd ../..
