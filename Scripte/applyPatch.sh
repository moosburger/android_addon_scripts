#!/bin/bash

#ver=0070-ext4-insert-3.18-version-of-fs-ext4-fs-jbd2-and-asso
#M=

cd ./android_device_bq_gohan

#drivers/staging/prima/CORE/


#~ echo - git --stat
#~ git apply --stat ../../Patches/Cyclon/$ver$M.patch

#~ echo - git --check
#~ git apply --check ../../Patches/Cyclon/$ver$M.patch

#~ echo git apply ../../Patches/Cyclon/$ver$M.patch
#~ #/android_kernel_bq_msm8976/drivers/staging/prima/CORE

#CVE-2019-20636
#CVE-2020-3698
#CVE-2020-3699

ext=patch

for i in {0..0}
do

    #cve=2020/01/$i-*
    #cve=2020/08/CVE-2020-12464
    cve=Device_14.1/0035-configs-sec_config-RILD-access-to-new-QMI-HTTP-servi

    echo - git --stat
    git apply --stat ../../../Patches/$cve.$ext

    echo - git --check
    git apply --check ../../../Patches/$cve.$ext

    if [ $? = 1 ]
    then
        echo $i failed
        exit $?
    fi

    cd /media/lta-user/Backup/LOS/packages/android_device_bq_gohan/
    echo $i $cve.patch
    git apply ../../../Patches/$cve.$ext
done
