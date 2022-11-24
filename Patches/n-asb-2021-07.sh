 #!/bin/bash
 echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo  - n-asb-2021-07
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo

cd build
git fetch https://github.com/LineageOS/android_build refs/changes/97/313397/2 && git cherry-pick FETCH_HEAD --quiet
cd ..
