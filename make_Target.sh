#!/bin/bash
#Version 1.0.0
##########################################################################################################
#
##########################################################################################################
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic pop
# repo -> #!/usr/bin/env python3.5.2

##########################################################################################################
# Import
##########################################################################################################
source ./lineageos-gerrit-repopick-topic.sh

#++++++++++++++++++++++++++++++++++#
# Nur mal kurz aufräumen
cleanOnly=false
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# Synchen des Repos
repoSync=true
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# RepoPick, wenn Gerrit nicht rechtzeitig gepusht wurde
repoPick=false
# der zu pickende Commit
gerritSecurityPatch=n-asb-2020-08
#++++++++++++++++++++++++++++++++++#

##########################################################################################################
# Definitionen
##########################################################################################################
#d=$(date +%Y-%m-%d-%H-%M)
buildDate=$(date +%Y%m%d)

RootPfad=$PWD
AndroidPath=lineage14.1
CertPfad=/media/lta-user/Backup
limitCpu=false
clearBuild=false
target=gohan
kernel=msm8976
cpuLmt=2

maxArrCnt=9
declare -A FilePatch
#FilePatch[0,0]="Gohan update"
#FilePatch[0,1]="$RootPfad/LOS/packages/Patch/gohan-update.patch"
#FilePatch[0,2]="$RootPfad/LOS/packages/android_device_bq_$target"

FilePatch[1,0]="Ant+"
FilePatch[1,1]="$RootPfad/LOS/packages/modifizierte/Ant+/ant+AirplaneMode.patch"
FilePatch[1,2]="$RootPfad/LOS/$AndroidPath/frameworks/base"

FilePatch[2,0]="Base Ims"
FilePatch[2,1]="$RootPfad/LOS/packages/modifizierte/Ims/Base_Ims.patch"
FilePatch[2,2]="$RootPfad/LOS/$AndroidPath/frameworks/base"

FilePatch[3,0]="Opt_Net_Ims"
FilePatch[3,1]="$RootPfad/LOS/packages/modifizierte/Ims/Opt_Net_Ims.patch"
FilePatch[3,2]="$RootPfad/LOS/$AndroidPath/frameworks/opt/net/ims"

FilePatch[4,0]="Opt_Telephony_ims"
FilePatch[4,1]="$RootPfad/LOS/packages/modifizierte/Ims/Opt_Telephony_Ims.patch"
FilePatch[4,2]="$RootPfad/LOS/$AndroidPath/frameworks/opt/telephony"

FilePatch[5,0]="BqKamera Hack"
FilePatch[5,1]="$RootPfad/LOS/packages/modifizierte/CameraHack/cameraHack.patch"
FilePatch[5,2]="$RootPfad/LOS/$AndroidPath/frameworks/base"

FilePatch[6,0]="Signature Spoofing"
FilePatch[6,1]="$RootPfad/LOS/packages/modifizierte/microG/microG.patch"
FilePatch[6,2]="$RootPfad/LOS/$AndroidPath/frameworks/base"

FilePatch[7,0]="VPN Uebersetzungen"
FilePatch[7,1]="$RootPfad/LOS/packages/modifizierte/Translations/cm_strings.patch"
FilePatch[7,2]="$RootPfad/LOS/$AndroidPath/packages/apps/Settings"

FilePatch[8,0]="Lautstaerke Aenderungen"
FilePatch[8,1]="$RootPfad/LOS/packages/modifizierte/Loudness/default_volume_tables.patch"
FilePatch[8,2]="$RootPfad/LOS/$AndroidPath/frameworks/av"

FilePatch[9,0]="ApnSettings"
FilePatch[9,1]="$RootPfad/LOS/packages/modifizierte/ApnSetting/ApnSettings.patch"
FilePatch[9,2]="$RootPfad/LOS/$AndroidPath/packages/apps/Settings/"

##########################################################################################################
#
#
#
#
##########################################################################################################
# Start Functionblock
##########################################################################################################
#
#
#
#
##########################################################################################################
# FunktionsName getTarget
# details               Auswahl des zu bauenden Bq Targets
##########################################################################################################
function getTarget {
    xmessage -buttons "gohan":0,"tenshi":1 -default "gohan" -nearmouse "Target auswaehlen"
    if [ $? = 1 ]
    then
        target=tenshi
        kernel=msm8937
        privApp=false
        paramPatch=false
    fi
}

##########################################################################################################
# FunktionsName limitUsedCpu
# details               weitere Apps
##########################################################################################################
function limitUsedCpu {
    xmessage -buttons "Nein":0,"Ja":1 -default "Nein" -nearmouse "Anzahl der Prozessoren begrenzen?"
    if [ $? = 1 ]
    then
        limitCpu=true
    fi
}

##########################################################################################################
# FunktionsName cleanBuild
# details               weitere Apps
##########################################################################################################
function cleanBuild {
    xmessage -buttons "Nein":0,"Ja":1 -default "Nein" -nearmouse "Den Build Ordner vorher loeschen?"
    if [ $? = 1 ]
    then
        clearBuild=true
    fi
}

##########################################################################################################
# FunktionsName showFeature
# details               zeigtdie Zusammenfassung
##########################################################################################################
function showFeature {

    msgBuild="nicht geloescht"
    if [ $clearBuild = true ]
    then
        msgBuild="geloescht"
    fi

    msgCpu="unbegrenzt"
    if [ $limitCpu = true ]
    then
        msgCpu="begrenzt"
    fi

    #~ xmessage -buttons "Passt":0,"Abbruch":1 -default "Abbruch" -nearmouse "Target: $target$msgPrivApp$msgParamPatch. Prozessorzahl $msgCpu, Buildverzeichnis $msgBuild"
    xmessage -buttons "Passt":0,"Abbruch":1 -default "Abbruch" -nearmouse "Target: $target. Prozessorzahl $msgCpu, Buildverzeichnis $msgBuild"
    if [ $? = 1 ]
    then
        exit
    fi
}

##########################################################################################################
# FunktionsName Exit
# details               Beenden
##########################################################################################################
function quit {
    echo  "$1 bei Zeile $2 schlug fehl"
    exit
}

##########################################################################################################
# FunktionsName  securityPatchDate
# details               der PatchStand auf der Platte
##########################################################################################################
function securityPatchDate {
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Patch Datum +++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    #grep "PLATFORM_SECURITY_PATCH := " ./build/core/version_defaults.mk
    LOCAL=$(grep -Eoi "PLATFORM_SECURITY_PATCH := .*" ./build/core/version_defaults.mk | sed  s@'PLATFORM_SECURITY_PATCH := '@''@)
    echo -  Security Patch Level lokal  : $LOCAL
    echo
}

##########################################################################################################
# FunktionsName  newPatchesAvailable
# details               gibts einen neueren PatchStand
##########################################################################################################
function newPatchesAvailable {
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Security Patches ++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    LOCAL=$(grep -Eoi "PLATFORM_SECURITY_PATCH := .*" ./build/core/version_defaults.mk | sed  s@'PLATFORM_SECURITY_PATCH := '@''@)
    REMOTE=$(curl -sS https://github.com/LineageOS/android_build/blob/cm-14.1/core/version_defaults.mk | grep -Eoi 'PLATFORM_SECURITY_PATCH</span> := [0-9]{4}-[0-9]{2}-[0-9]{2}' | sed  s@'PLATFORM_SECURITY_PATCH</span> := '@''@)

    echo - Security Patch Level lokal  : $LOCAL
    echo - Security Patch Level remote: $REMOTE

    # wenn laenge = 0 keine verbindung zum server
    if [ ${#REMOTE} = 0 ]
    then
        echo - Keine Verbindung zum Server
        exit
    fi
    if [ ${#LOCAL} = 0 ]
    then
        echo - Kein Repo gefunden, manuell synchen!
        exit
    fi
}

##########################################################################################################
# FunktionsName  whatToBuild
# details               wie und was bauen
##########################################################################################################
function whatToBuild {

    retVal=0
    if [ $LOCAL = $REMOTE ]; then
        xmessage -buttons "Trotzdem bauen":0,"Beenden":1,"CleanPatches":2  -default "Beenden"-nearmouse "Keine neuen Patches vorhanden"
        retVal=$?
    else
        xmessage -buttons "Build!":0,"Beenden":1,"CleanPatches":2 -default "Beenden" -nearmouse "Neue Patches vorhanden"
        retVal=$?
    fi

    if [ $retVal = 2 ]
    then
        echo - Patches zurueck
        cleanOnly=true
    fi
    if [ $retVal = 1 ]
    then
        echo - Beenden
        exit
    fi
}

##########################################################################################################
# FunktionsName prepCache
# details               Cache loeschen und vorbereiten
##########################################################################################################
function prepCache {
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Cleanup Cache +++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    ccache -C

    if [ $clearBuild = true ] && [ -d "$RootPfad/LOS/$AndroidPath/out" ]
    then
        echo - make Clean
        make clean

        echo - out geloescht
        rm -r $RootPfad/LOS/$AndroidPath/out
        rm $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock

    fi

#    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
#    echo "+++++++++++++++++++++++++++++++++++ Cleanup Cache beendet +++++++++++++++++++++++++++++++++++++++++++"
#    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # Cache Einstellungen
    export USE_CCACHE=1
    #ccache -M 75G
    export CCACHE_COMPRESS=1
    export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
    echo
}

##########################################################################################################
# FunktionsName restoreBuildEnv
# details               die geaenderten Scripte wiederherstellen
##########################################################################################################
function restoreBuildEnv {

    echo
    echo - Anzahl Prozessoren
    # Die Buildumgebung wieder zurueck
    replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j\$(grep \"\^processor\" /proc/cpuinfo | wc -l) \"\$@\""
    #searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j4 \"\$@\""
    searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j$cpuLmt \"\$@\""
    echo searchString
    sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/LOS/$AndroidPath/vendor/cm/build/envsetup.sh
    #auslesen
    grep -Eoi "mk_timer schedtool -B -n 10 -e ionice .*" $RootPfad/LOS/$AndroidPath/vendor/cm/build/envsetup.sh
}

##########################################################################################################
# FunktionsName applyGitPatches
# details               git patches anwenden
##########################################################################################################
function applyGitPatches {

    echo - apply Git Patches

    for ((i=1;i<=$maxArrCnt;i++))
    do
        echo
        echo - "${FilePatch[$i,0]}"
        cve="${FilePatch[$i,1]}"
        cd "${FilePatch[$i,2]}"
        echo $PWD

        #echo - git --stat $cve
        git apply --stat $cve --whitespace=nowarn --ignore-space-change --ignore-whitespace

        #echo - git --check
        # suppress error
        exec 3>&2
        exec 2> /dev/null
        git apply --check $cve --whitespace=nowarn --ignore-space-change --ignore-whitespace
        gitError=$?

        # restore stderr
        exec 2>&3

        if [ $gitError != 1 ]
        then
            git apply $cve  --whitespace=nowarn --ignore-space-change --ignore-whitespace
        fi
    done
}

##########################################################################################################
# FunktionsName applyGitPatches
# details               git patches wieder entfernen
##########################################################################################################
function removeGitPatches {

    echo
    echo - remove Git Patch

    for ((i=1;i<=$maxArrCnt;i++))
    do
        echo
        echo - "${FilePatch[$i,0]}"
        cve="${FilePatch[$i,1]}"
        cd "${FilePatch[$i,2]}"
        echo $PWD

        #git apply --remove $cve
        git clean -fd
        git clean -f
        git checkout .
        git checkout cm-14.1
    done
}

##########################################################################################################
#
#
#
#
##########################################################################################################
# End Functionblock
##########################################################################################################
#
#
#
#
##########################################################################################################

##########################################################################################################
# Wechsel ins Buildverzeichnis
##########################################################################################################
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ In das Buildverzeichnis +++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

cd $RootPfad/LOS/$AndroidPath
pwd
echo

# gibts neue security patches
newPatchesAvailable

# was bauen
whatToBuild

# Nur aufräumen
if [ $cleanOnly = true ]
then
    removeGitPatches
    exit
fi

# fuer welches Target bauen wir
#getTarget
# Prozessoren begrenzen
limitUsedCpu
# BuildOrdner loeschen
cleanBuild
#Zusammenfassung
showFeature

##########################################################################################################
# Repo init und sync
##########################################################################################################
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ Init Repo +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
repo init -u https://github.com/LineageOS/android.git -b cm-14.1

if [ $? -ne 0 ]
then
    quit "repo Init" "397"
fi

if [ $repoSync = true ]
then
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Sync Repo +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo  - sync

    if [ $repoPick = true ]
    then
        echo --force-remove-dirty --force-sync
        repo sync --force-remove-dirty --force-sync --verbose
    else
        repo sync --verbose
        #--force-sync
        echo
    fi

    if [ $? -ne 0 ]
    then
        quit "repo sync" "443"
    fi

    # Environment aufetzen
    source build/envsetup.sh
    if [ $repoPick = true ]
    then
        echo
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        echo "+++++++++++++++++++++++++++++++++++ Repo Cherry Pick ++++++++++++++++++++++++++++++++++++++++++++++++"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        echo - repoPick
        #repopick_topic $gerritSecurityPatch
        repopick -t $gerritSecurityPatch
        if [ $? -ne 0 ]
        then
            quit "repopick" "456"
        fi
    fi
fi

##########################################################################################################
# Android Security Patch Level auslesen
##########################################################################################################
securityPatchDate

##########################################################################################################
# Target bauen
##########################################################################################################
while :
do
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Den Code fuer $target   +++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #syncht den Code fuer gohan
    breakfast $target
    echo
    if [ $? -ne 0 ]
    then
        quit "breakfast $target" "461"
    fi

##########################################################################################################
# Cache
##########################################################################################################
    prepCache

##########################################################################################################
# Build auf x Cpu Cores begrenzen
##########################################################################################################
    if [ $limitCpu = true ]
    then
        searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j\$(grep \"\^processor\" /proc/cpuinfo | wc -l) \"\$@\""
        #replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j4 \"\$@\""
        replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j$cpuLmt \"\$@\""
        sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/LOS/$AndroidPath/vendor/cm/build/envsetup.sh
    fi
 ##########################################################################################################
# meine git Repos synchen
##########################################################################################################
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ sync git repo +++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    #Backup aktuellen Pfad
    lstPath=$PWD

    echo - device/bq/$target synchen
    cd $RootPfad/LOS/packages/android_device_bq_$target
    echo $PWD
    git config --get remote.origin.url
    git branch | grep \* | cut -d ' ' -f2
    LOCAL=$(grep -Eoi "^Version.*" ./README.mkdn | sed  s@'Version '@''@)
    echo Version: $LOCAL
    git pull
    LOCAL=$(grep -Eoi "^Version.*" ./README.mkdn | sed  s@'Version '@''@)
    echo Version: $LOCAL
    echo

    echo - kernel/bq/msm8976 synchen
    cd $RootPfad/LOS/packages/android_kernel_bq_msm8976
    #cd $RootPfad/Kernels/android_kernel_bq_msm8976
    echo $PWD
    git config --get remote.origin.url
    git branch | grep \* | cut -d ' ' -f2
    LOCAL=$(grep -Eoi "EXTRAVERSION .*" ./Makefile | sed  s@'EXTRAVERSION ='@''@)
    echo Version: 3.10.108$LOCAL
    git pull
    LOCAL=$(grep -Eoi "EXTRAVERSION .*" ./Makefile | sed  s@'EXTRAVERSION ='@''@)
    echo Version: 3.10.108$LOCAL
    echo

    echo - external/ant-wireless synchen
    cd $RootPfad/LOS/packages/android_external_ant-wireless
    echo $PWD
    git config --get remote.origin.url
    git branch | grep \* | cut -d ' ' -f2
    LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    echo Version: $LOCAL
    git pull
    LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    echo Version: $LOCAL
    echo

    echo - vendor/bq/$target synchen
    cd $RootPfad/LOS/$AndroidPath/vendor/bq/$target
    echo $PWD
    git config --get remote.origin.url
    git branch | grep \* | cut -d ' ' -f2
    LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    echo Version: $LOCAL
    git pull
    LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    echo Version: $LOCAL
    echo

    echo - die modifizierten Dateien, die in das LOS kopiert werden
    cd $RootPfad/LOS/packages/modifizierte
    echo $PWD
    git config --get remote.origin.url
    git branch | grep \* | cut -d ' ' -f2
    LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    echo Version: $LOCAL
    git pull
    LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    echo Version: $LOCAL
    echo

    #zurueck in den Pfad
    cd $lstPath

##########################################################################################################
# Files austauschen, patchen, hinzufuegen
##########################################################################################################
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Dateien austauschen, patchen, hinzufuegen   +++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    echo - kernel/bq/msm8976 kopieren
    rm -rf kernel/bq/msm8976
    cp -r $RootPfad/LOS/packages/android_kernel_bq_msm8976/ ./kernel/bq/msm8976/
    #cp -r $RootPfad/Kernels/android_kernel_bq_msm8976/ ./kernel/bq/msm8976/
    rm -rf kernel/bq/msm8976/.git

    ########################################################
    # nach dem synch patchen
    ########################################################
    applyGitPatches

    #zurueck in den Pfad
    cd $lstPath

    echo
    echo - device/bq/$target kopieren
    rm -rf device/bq/$target
    cp -r $RootPfad/LOS/packages/android_device_bq_gohan/ ./device/bq/$target/
    rm -rf device/bq/$target/.git
    echo - done

    echo
    echo - external/ant-wireless kopieren
    rm -rf external/ant-wireless
    cp -r $RootPfad/LOS/packages/android_external_ant-wireless/ ./external/ant-wireless/
    rm -rf external/ant-wireless/.git
    echo - done

    echo
    echo - vendor/cm/bootanimation kopieren
    cp -r $RootPfad/LOS/packages/modifizierte/BootAnimation/bootanimationRing/bootanimation.tar ./vendor/cm/bootanimation/bootanimation.tar
    echo - done

#exit

#########################################################################################################
#
##########################################################################################################
# Build
##########################################################################################################
#
##########################################################################################################
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Starte unsignierten Build  fuer $target +++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    croot
    export LC_ALL=C
    brunch $target
    if [ $? -ne 0 ]
    then
        echo - brunch $target schlug fehl
        break
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Ende unsignierter Build  ++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Starte signierten Build fuer $target +++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    mka target-files-package otatools
    if [ $? -ne 0 ]
    then
        echo - otatools $target schlug fehl
        break
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ APK +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
    croot
    python ./build/tools/releasetools/sign_target_files_apks -o -d $CertPfad/.android-certs $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $RootPfad/$target-files-signed.zip
    if [ $? -ne 0 ]
    then
        echo - $target APK signieren schlug fehl
        break
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ OTA +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
    python ./build/tools/releasetools/ota_from_target_files -k $CertPfad/.android-certs/releasekey --block --backup=true $RootPfad/$target-files-signed.zip $RootPfad/$target-ota-update.zip
    if [ $? -ne 0 ]
    then
        echo - $target OTA signieren schlug fehl
        break
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Ende signierter Build +++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
    if [ true = true ]
    then
        break
    fi
done

##########################################################################################################
# Android Security Patch Level auslesen
##########################################################################################################
securityPatchDate

##########################################################################################################
# Build verschieben
##########################################################################################################
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ verschiebe Build ++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
if [ -f $RootPfad/$target-files-signed.zip ]
then
    rm $RootPfad/$target-files-signed.zip
fi

# Kopieren und umbenennen
if [ -f $RootPfad/$target-ota-update.zip ]
then
    echo "verschiebe $RootPfad/$target-ota-update.zip ==> $RootPfad/lineage-14.1-$buildDate-UNOFFICIAL-$target-signed.zip"
    mv $RootPfad/$target-ota-update.zip $RootPfad/lineage-14.1-$buildDate-UNOFFICIAL-$target-signed.zip
fi

if [ -f $OUT/lineage-14.1-*-UNOFFICIAL-$target.zip ]
then
    echo "verschiebe $OUT/lineage-14.1-*-UNOFFICIAL-$target.zip ==> $RootPfad/lineage-14.1-*-UNOFFICIAL-$target.zip"
    mv $OUT/lineage-14.1-*-UNOFFICIAL-$target.zip $RootPfad
    echo "verschiebe $OUT/lineage-14.1-*-UNOFFICIAL-$target.zip.md5sum ==> $RootPfad/lineage-14.1-*-UNOFFICIAL-$target.zip.md5sum"
    mv $OUT/lineage-14.1-*-UNOFFICIAL-$target.zip.md5sum $RootPfad
fi

##########################################################################################################
# aufräumen
##########################################################################################################
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ aufräumen +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
restoreBuildEnv
removeGitPatches

##########################################################################################################
