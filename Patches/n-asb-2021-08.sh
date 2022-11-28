 #!/bin/bash
 echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2021-08
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd external/sqlite
git fetch https://github.com/LineageOS/android_external_sqlite refs/changes/66/314466/1 && git cherry-pick FETCH_HEAD
git fetch https://github.com/LineageOS/android_external_sqlite refs/changes/67/314467/3 && git cherry-pick FETCH_HEAD
cd ../..
#cd packages/apps/Settings
#git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/68/314468/2 && git cherry-pick FETCH_HEAD
#git fetch https://github.com/LineageOS/android_packages_apps_Settings refs/changes/69/314469/2 && git cherry-pick FETCH_HEAD
#cd ../../..
cd packages/services/Telephony
git fetch https://github.com/LineageOS/android_packages_services_Telephony refs/changes/70/314470/1 && git cherry-pick FETCH_HEAD
cd ../../..
