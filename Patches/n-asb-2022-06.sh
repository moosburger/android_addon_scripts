#!/bin/bash
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2022-06
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
cd ..
cd lineage14.1

cd frameworks/base
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/44/332444/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/45/332445/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/46/332446/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/48/332448/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/49/332449/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_frameworks_base refs/changes/47/332447/2 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd packages/apps/Bluetooth
git fetch https://github.com/LineageOS/android_packages_apps_Bluetooth refs/changes/51/332451/1 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_packages_apps_Bluetooth refs/changes/52/332452/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/apps/Contacts
git fetch https://github.com/LineageOS/android_packages_apps_Contacts refs/changes/53/332453/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/apps/Dialer
git fetch https://github.com/LineageOS/android_packages_apps_Dialer refs/changes/54/332454/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/apps/Nfc
git fetch https://github.com/LineageOS/android_packages_apps_Nfc refs/changes/55/332455/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd packages/services/Telecomm
git fetch https://github.com/LineageOS/android_packages_services_Telecomm refs/changes/56/332456/1 && git cherry-pick FETCH_HEAD --quiet
cd ../../..
cd external/libnfc-nci
git fetch https://github.com/LineageOS/android_external_libnfc-nci refs/changes/58/332458/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_libnfc-nci refs/changes/59/332459/2 && git cherry-pick FETCH_HEAD --quiet
git fetch https://github.com/LineageOS/android_external_libnfc-nci refs/changes/60/332460/2 && git cherry-pick FETCH_HEAD --quiet
cd ../..
cd system/core
git fetch https://github.com/LineageOS/android_system_core refs/changes/57/332457/1 && git cherry-pick FETCH_HEAD --quiet
cd ../..
