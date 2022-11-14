#!/bin/bash


find /media/dejhgp07/Android/LOS/ANT_in_Android -name ".git*" -print0 | xargs -0 rm -rfv

#rm -rfv /media/dejhgp07/Android/LOS/ANT_in_Android/.git


exit

RootPfad=$PWD
#~ #echo +++++++++++++++++++++++++++++++++++ In das Buildverzeichnis +++++++++++++++++++++++++++++++++++
cd $RootPfad/android/lineage
pwd

while :
do
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Den Code fuer $target   +++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    #if [ true = true ]
    #then
        break
    #fi
done


    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Ende signierter Build +++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo

exit


    # Die Buildumgebung wieder zurueck
    replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j\$(grep \"\^processor\" /proc/cpuinfo | wc -l) \"\$@\""
    searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j4 \"\$@\""
    sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/android/lineage/vendor/cm/build/envsetup.sh






exit

    grep 'BOARD_ANT_WIRELESS_DEVICE'  ./device/bq/gohan/BoardConfig.mk
    searchString=".*BOARD_ANT_WIRELESS_DEVICE"
    replaceWith="#BOARD_ANT_WIRELESS_DEVICE"
    sed  -i -e "s:${searchString}:${replaceWith}:g" ./device/bq/gohan/BoardConfig.mk

    grep 'BOARD_ANT_WIRELESS_DEVICE' ./device/bq/gohan/BoardConfig.mk

    # Die Buildumgebung wieder zurueck
    replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j\$(grep \"\^processor\" /proc/cpuinfo | wc -l) \"\$@\""
    searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j4 \"\$@\""
    sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/android/lineage/vendor/cm/build/envsetup.sh

    sed -i 's/#define QPNP_VIB_DEFAULT_VTG_LVL	2500/#define QPNP_VIB_DEFAULT_VTG_LVL	3100/g'  $RootPfad/android/lineage/kernel/bq/msm8976/drivers/platform/msm/qpnp-vibrator.c
    sed -i 's/qcom,max-voltage-uv = <4200000>;/qcom,max-voltage-uv = <4400000>;/g'  $RootPfad/android/lineage/kernel/bq/msm8976/arch/arm/boot/dts/qcom/batterydata-gohan-atl-4v4-3100mah.dtsi
    sed -i 's/qcom,max-voltage-uv = <4200000>;/qcom,max-voltage-uv = <4400000>;/g'  $RootPfad/android/lineage/kernel/bq/msm8976/arch/arm/boot/dts/qcom/batterydata-gohan-ebt-4v4-3100mah.dtsi

    echo Anzahl Prozessoren
    grep -Eoi "mk_timer schedtool -B -n 10 -e ionice .*" $RootPfad/android/lineage/vendor/cm/build/envsetup.sh
    echo Defauklt Vibraionslevel
    grep -Eoi "#define QPNP_VIB_DEFAULT_VTG_LVL	.*"  $RootPfad/android/lineage/kernel/bq/msm8976/drivers/platform/msm/qpnp-vibrator.c
    echo max. Akkuspannung
    grep -Eoi "qcom,max-voltage-uv = .*" $RootPfad/android/lineage/kernel/bq/msm8976/arch/arm/boot/dts/qcom/batterydata-gohan-atl-4v4-3100mah.dtsi
    grep -Eoi "qcom,max-voltage-uv = .*" $RootPfad/android/lineage/kernel/bq/msm8976/arch/arm/boot/dts/qcom/batterydata-gohan-ebt-4v4-3100mah.dtsi

    echo Ant+ zum AirPlaneMode
    grep -Eoi '<string name="def_airplane_mode_radios" translatable.*'  $RootPfad/frameworks/base/packages/SettingsProvider/res/values/defaults.xml
    searchString="<string name=\"def_airplane_mode_radios\" translatable=\"false\">cell,bluetooth,wifi,nfc,wimax,ant</string>"
    replaceWith="<string name=\"def_airplane_mode_radios\" translatable=\"false\">cell,bluetooth,wifi,nfc,wimax</string>"
    sed -i -e "s:${searchString}:${replaceWith}:g" ./frameworks/base/packages/SettingsProvider/res/values/defaults.xml
    grep -Eoi '<string name="def_airplane_mode_radios" translatable.*'  ./frameworks/base/packages/SettingsProvider/res/values/defaults.xml

    grep -Eoi '<string name="airplane_mode_toggleable_radios" translatable.*'  ./frameworks/base/packages/SettingsProvider/res/values/defaults.xml
    searchString="<string name=\"airplane_mode_toggleable_radios\" translatable=\"false\">bluetooth,wifi,nfc,ant</string>"
    replaceWith="<string name=\"airplane_mode_toggleable_radios\" translatable=\"false\">bluetooth,wifi,nfc</string>"
    sed -i -e "s:${searchString}:${replaceWith}:g" ./frameworks/base/packages/SettingsProvider/res/values/defaults.xml
    grep -Eoi '<string name="airplane_mode_toggleable_radios" translatable.*'  ./frameworks/base/packages/SettingsProvider/res/values/defaults.xml

    exit

LOCAL=$(grep -Eoi "PLATFORM_SECURITY_PATCH := .*" ./build/core/version_defaults.mk | sed  s@'PLATFORM_SECURITY_PATCH := '@''@)
REMOTE=$(curl -sS https://github.com/LineageOS/android_build/blob/cm-14.1/core/version_defaults.mk | grep -Eoi 'PLATFORM_SECURITY_PATCH</span> := [0-9]{4}-[0-9]{2}-[0-9]{2}' | sed  s@'PLATFORM_SECURITY_PATCH</span> := '@''@)

echo Security Patch Level lokal vom  : $LOCAL
echo Security Patch Level remote vom: $REMOTE

    if [ $LOCAL = $REMOTE ]; then
        xmessage -buttons "Trotzdem bauen":0,"Beenden":1 -default "Beenden" -nearmouse "Keine neuen Patches vorhanden"
        if [ $? = 1 ]
        then
            echo "Beenden"
            exit
        fi
    else
        xmessage -buttons "Build!":0,"Beenden":1 -default "Beenden" -nearmouse "Neue Patches vorhanden"
        if [ $? = 1 ]
        then
            echo "Beenden"
            exit
        fi
    fi


echo "weiterbauen"