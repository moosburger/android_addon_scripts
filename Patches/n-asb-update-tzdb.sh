#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-update-tzdb
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cd ..
cd lineage14.1

cd bionic
git fetch https://github.com/LineageOS/android_bionic refs/changes/73/317173/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_bionic refs/changes/74/317174/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_bionic refs/changes/20/318520/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_bionic refs/changes/21/318521/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_bionic refs/changes/18/330718/1 && git cherry-pick FETCH_HEAD --quiet
cd ..
cd external/icu
git fetch https://github.com/LineageOS/android_external_icu refs/changes/75/317175/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_icu refs/changes/76/317176/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_icu refs/changes/22/318522/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_icu refs/changes/23/318523/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_icu refs/changes/19/330719/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_icu refs/changes/20/330720/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_icu refs/changes/21/330721/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
