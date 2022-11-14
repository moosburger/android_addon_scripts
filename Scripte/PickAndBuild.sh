#!/bin/bash
# -*- coding: utf-8 -*-
#Version 1.0.0
##########################################################################################################
#
##########################################################################################################
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic pop
# repo -> #!/usr/bin/env python3.5.2

#sudo update-alternatives --config python
#Es gibt 2 Auswahlmöglichkeiten für die Alternative python (welche /usr/bin/python bereitstellen).
#
#  Auswahl      Pfad              Priorität Status
#------------------------------------------------------------
#  0            /usr/bin/python3   2         automatischer Modus
#  1            /usr/bin/python2   1         manueller Modus
#  2            /usr/bin/python3   2         manueller Modus
#
#Drücken Sie die Eingabetaste, um die aktuelle Wahl[*] beizubehalten,
#oder geben Sie die Auswahlnummer ein:

#~ Jack Server Probleme:
#~ Neustarten vom Server
#~ /prebuilts/sdk/tools/jack-admin kill-server ./prebuilts/sdk/tools/jack-admin start-server

#~ Max parallele zugriffe reduzieren
#~ jack.server.max-service=4 auf 2 oder 1

#~ In der Java Datei ./etc/java-8-openjdk/security/java.security
#~ unter
#~ jdk.tls.disabledAlgorithms
#~ die beiden TLSv1, TLSv1.1 entfernen

#~ repopick.py Zeile 366

        #~ else:
            #~ print(item['project'])
            #~ print(item['branch'])

            #~ #'platform/frameworks/opt/net/voip': {'refs/tags/android-7.1.2_r36': 'frameworks/opt/net/voip'},
            #~ if item['project'] == u'LineageOS/android_frameworks_opt_net_voip':
                #~ project_path = project_name_to_data[u'platform/frameworks/opt/net/voip'][u'refs/tags/android-7.1.2_r36']

            #~ else:


# /buld/core/version_defaults.mk


##########################################################################################################
# Python Versionscheck und Warnung
##########################################################################################################
version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
version=$(echo "${version//}")
IFS='.' read -ra ADDR <<< "$version"

if [[ "${ADDR[0]}" -eq "3" ]]
then
    echo "Python Version $version!"
    echo
    echo  "Mit 'sudo update-alternatives --config python' im Terminal umstellen"
    echo
    exit
fi

##########################################################################################################
# Import
##########################################################################################################
# source ./lineageos-gerrit-repopick-topic.sh

#++++++++++++++++++++++++++++++++++#
#++++++++++++++++++++++++++++++++++#
# Beenden nachdem alles aktualisiert wurde
checkBuildOnly=false
#++++++++++++++++++++++++++++++++++#
#++++++++++++++++++++++++++++++++++#

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
#
# bei Problemen wie "PFAD you need to resolve your current index first" schlägt force-sync usw. fehl
# cd PFAD && git cherry-pick --abort && git merge --abort && git clean -fdx && git checkout '*'
# es können die patches auch in anderer Reihenfolge ggepickt werden. Kann passieren wenn diese in falscher Reihenfolge sortiert sind, dann gibts auch git Fehler
# repopick 286097 285833 285834
#
#++++++++++++++++++++++++++++++++++#
repoPick=false
quitAfterPick=false
#++++++++++++++++++++++++++++++++++#

# der zu pickende Commit
declare -A gerritSecurityPatch

# Ab 09 sind neu , 07 und 08 bereits gemerged
gerritSecurityPatch[0]=n-asb-2021-09
gerritSecurityPatch[1]=n-asb-2021-10
gerritSecurityPatch[2]=n-asb-2021-11
gerritSecurityPatch[3]=n-asb-2021-12
gerritSecurityPatch[4]=n-asb-2022-01
gerritSecurityPatch[5]=n-asb-2022-02
gerritSecurityPatch[6]=n-asb-2022-03
gerritSecurityPatch[7]=n-asb-2022-04
gerritSecurityPatch[8]=n-asb-2022-05
gerritSecurityPatch[9]=n-asb-2022-06
gerritSecurityPatch[10]=n-asb-2022-07

minRepoCnt=0
gerritSecurityPatch[11]=n-asb-2022-08
gerritSecurityPatch[12]=n-asb-2022-09
maxRepoCnt=12


PlatformSecurityPatch="2022-07-05"
#++++++++++++++++++++++++++++++++++#


##########################################################################################################
# Definitionen
##########################################################################################################
#d=$(date +%Y-%m-%d-%H-%M)
buildDate=$(date +%Y%m%d)

RootPfad=$PWD
AndroidPath=lineage14.1
#CertPfad=/media/dejhgp07/Android
CertPfad=$PWD
limitCpu=true
clearBuild=true
target=gohan
kernel=msm8976
cpuLmt=2
rebuild=false

vendorFolder="android_vendor_bq_gohan"
patchfolder="packages"
maxArrCnt=8
declare -A FilePatch

FilePatch[0,0]="ApnSettings"
FilePatch[0,1]="$RootPfad/LOS/packages/modifizierte/ApnSetting/ApnSettings.patch"
FilePatch[0,2]="$RootPfad/LOS/$AndroidPath/packages/apps/Settings/"

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

#FilePatch[9,0]="Gohan update"
#FilePatch[9,1]="$RootPfad/LOS/packages/Patch/gohan-update.patch"
#FilePatch[9,2]="$RootPfad/LOS/packages/android_device_bq_$target"

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
    searchString=$(grep "PLATFORM_SECURITY_PATCH := .*" ./build/core/version_defaults.mk)
    LOCAL=$(grep -Eoi "PLATFORM_SECURITY_PATCH := .*" ./build/core/version_defaults.mk | sed  s@'PLATFORM_SECURITY_PATCH := '@''@)

    #echo - $LOCAL

    replaceWith="${searchString/$LOCAL/"$PlatformSecurityPatch"}"
    if [ -z "$LOCAL" ]
    then
        replaceWith="$searchString $PlatformSecurityPatch"
    fi

    sed -i -e "s/${searchString}/${replaceWith}/g" $RootPfad/LOS/$AndroidPath/build/core/version_defaults.mk

    echo -  Security Patch Level old  : $LOCAL
    echo -  Security Patch Level new  : $PlatformSecurityPatch
}

##########################################################################################################
# FunktionsName  whatToBuild
# details               wie und was bauen
##########################################################################################################
function whatToBuild {

    retVal=0
    xmessage -buttons "Build!":0,"Beenden":1,"CleanPatches":2 -default "Beenden" -nearmouse "LOS Bauen"
    retVal=$?

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
    if [ $retVal = 0 ]
    then
        rebuild=true
    fi

    retVal=0
    xmessage -buttons "RepoPick":0,"Keines":1,"RepoPick ohne Build":2 -default "Keines" -nearmouse "Repo Aktionen"
    retVal=$?
    if [ $retVal = 0 ]
    then
        repoPick=true
    fi
    if [ $retVal = 2 ]
    then
        repoPick=true
        quitAfterPick=true
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

        if [ -f $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
        then
            rm $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
        fi
    fi

    # Cache Einstellungen
    export USE_CCACHE=1
    ccache -M 75G
    export CCACHE_COMPRESS=1
    export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx6G jack.server.max-service=1"

    #Jack Server killen
    $RootPfad/LOS/$AndroidPath/prebuilts/sdk/tools/jack-admin kill-server


    #$RootPfad/LOS/$AndroidPath/prebuilts/sdk/tools/jack-admin start-server
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
    echo $searchString
    sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/LOS/$AndroidPath/vendor/cm/build/envsetup.sh
    #auslesen
    grep -Eoi "mk_timer schedtool -B -n 10 -e ionice .*" $RootPfad/LOS/$AndroidPath/vendor/cm/build/envsetup.sh
    echo
    #Jack Server killen
    $RootPfad/LOS/$AndroidPath/prebuilts/sdk/tools/jack-admin kill-server
}

##########################################################################################################
# FunktionsName applyGitPatches
# details               git patches anwenden
##########################################################################################################
function applyGitPatches {

    echo - apply Git Patches

    for ((i=0;i<=$maxArrCnt;i++))
    do
        echo
        echo - "${FilePatch[$i,0]}"
        cve="${FilePatch[$i,1]}"
        cd "${FilePatch[$i,2]}"
        echo $cve

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

    for ((i=0;i<=$maxArrCnt;i++))
    do
        echo
        echo - "${FilePatch[$i,0]}"
        cve="${FilePatch[$i,1]}"
        cd "${FilePatch[$i,2]}"
        echo $PWD

        # suppress error
        exec 3>&2
        exec 2> /dev/null

        git apply -R $cve
        git clean -fd
        git clean -f
        git checkout .
        git checkout lineage-15.1

        # restore stderr
        exec 2>&3
    done

    resetBranches
}

##########################################################################################################
# FunktionsName resetBranches
# details               die Branches resetten
##########################################################################################################
function resetBranches {

    echo
    echo - reset Branches

    rm -rf $RootPfad/LOS/$AndroidPath/frameworks/av/
    rm -rf $RootPfad/LOS/$AndroidPath/frameworks/base/
    rm -rf $RootPfad/LOS/$AndroidPath/frameworks/opt/net/ims/
    rm -rf $RootPfad/LOS/$AndroidPath/frameworks/opt/telephony/
    rm -rf $RootPfad/LOS/$AndroidPath/packages/apps/Settings/

    cp -r $RootPfad/LOS/origin/android_frameworks_av/ $RootPfad/LOS/$AndroidPath/frameworks/av/
    cp -r $RootPfad/LOS/origin/android_frameworks_base/ $RootPfad/LOS/$AndroidPath/frameworks/base/
    cp -r $RootPfad/LOS/origin/android_frameworks_opt_net_ims/ $RootPfad/LOS/$AndroidPath/frameworks/opt/net/ims/
    cp -r $RootPfad/LOS/origin/android_frameworks_opt_telephony/ $RootPfad/LOS/$AndroidPath/frameworks/opt/telephony/
    cp -r $RootPfad/LOS/origin/android_packages_apps_Settings/ $RootPfad/LOS/$AndroidPath/packages/apps/Settings/
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

# was bauen
whatToBuild

# Nur aufräumen
if [ $cleanOnly = true ]
then
    #removeGitPatches
    resetBranches
    restoreBuildEnv
    echo
        if [ -f $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
        then
            rm $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
        fi
    exit
fi

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
    quit "repo Init" "$LINENO"
fi

    # Environment aufetzen
    source build/envsetup.sh
    if [ $repoPick = true ]
    then
        echo
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        echo "+++++++++++++++++++++++++++++++++++ Repo Cherry Pick ++++++++++++++++++++++++++++++++++++++++++++++++"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

        for ((k=$minRepoCnt;k<=maxRepoCnt;k++))
        do
            echo
            echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            cve=${gerritSecurityPatch[$k]}
            echo $cve
            echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            echo repopick -t $cve
            repopick -q -t $cve

            searchString='n-asb-'
            replaceWith="${cve/$searchString/""}"
            PlatformSecurityPatch="$replaceWith-05"
        done
    fi

##########################################################################################################
# Android Security Patch Level auslesen
##########################################################################################################
securityPatchDate

if [ $quitAfterPick = true ]
then
    exit
fi

#exit

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
        quit "breakfast $target" "$LINENO"
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

    #~ echo - device/bq/$target synchen
    #~ cd $RootPfad/LOS/$patchfolder/android_device_bq_$target
    #~ echo $PWD
    #~ git config --get remote.origin.url
    #~ git branch | grep \* | cut -d ' ' -f2
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.mkdn | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ git pull
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.mkdn | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ echo

    #~ echo - kernel/bq/$kernel synchen
    #~ cd $RootPfad/LOS/$patchfolder/android_kernel_bq_$kernel
    #~ echo $PWD
    #~ git config --get remote.origin.url
    #~ git branch | grep \* | cut -d ' ' -f2
    #~ LOCAL=$(grep -Eoi "EXTRAVERSION .*" ./Makefile | sed  s@'EXTRAVERSION ='@''@)
    #~ echo Version: 3.10.108$LOCAL
    #~ git pull
    #~ LOCAL=$(grep -Eoi "EXTRAVERSION .*" ./Makefile | sed  s@'EXTRAVERSION ='@''@)
    #~ echo Version: 3.10.108$LOCAL
    #~ echo

    #~ echo - external/ant-wireless synchen
    #~ cd $RootPfad/LOS/$patchfolder/android_external_ant-wireless
    #~ echo $PWD
    #~ git config --get remote.origin.url
    #~ git branch | grep \* | cut -d ' ' -f2
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ git pull
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ echo

    #~ echo - vendor/bq/$target synchen
    #~ cd $RootPfad/LOS/$AndroidPath/vendor/bq/$target
    #~ echo $PWD
    #~ git config --get remote.origin.url
    #~ git branch | grep \* | cut -d ' ' -f2
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ git pull
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ echo

    #~ echo - die modifizierten Dateien, die in das LOS kopiert werden
    #~ cd $RootPfad/LOS/$patchfolder/modifizierte
    #~ echo $PWD
    #~ git config --get remote.origin.url
    #~ git branch | grep \* | cut -d ' ' -f2
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ git pull
    #~ LOCAL=$(grep -Eoi "^Version.*" ./README.md | sed  s@'Version '@''@)
    #~ echo Version: $LOCAL
    #~ echo

    #zurueck in den Pfad
    cd $lstPath

##########################################################################################################
# Files austauschen, patchen, hinzufuegen
##########################################################################################################
    #~ echo
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++ in das LOS Verzeichnis kopieren   +++++++++++++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    #~ echo - kernel/bq/$kernel kopieren
    #~ rm -rf kernel/bq/$kernel
    #~ [ ! -d ./kernel/bq ] &&  mkdir kernel/bq
    #~ cp -r $RootPfad/LOS/$patchfolder/android_kernel_bq_$kernel/ ./kernel/bq/$kernel/
    #~ rm -rf kernel/bq/$kernel/.git
    #~ echo - done

    #~ echo
    #~ echo - device/bq/$target kopieren
    #~ rm -rf device/bq/$target
    #~ [ ! -d ./device/bq ] &&  mkdir device/bq
    #~ cp -r $RootPfad/LOS/$patchfolder/android_device_bq_$target/ ./device/bq/$target/
    #~ rm -rf device/bq/$target/.git
    #~ echo - done

#    echo
# Wird oben direkt ins ziel gesyncht
#    echo - vendor/bq/$target kopieren
#    rm -rf vendor/bq/$target
#    [ ! -d ./vendor/bq ] &&  mkdir vendor/bq
#    cp -r $RootPfad/LOS/$patchfolder/$vendorFolder/gohan/ ./vendor/bq/$target/
#    rm -rf vendor/bq/$target/.git
#    echo - done

    #~ echo
    #~ echo - external/ant-wireless kopieren
    #~ rm -rf external/ant-wireless
    #~ cp -r $RootPfad/LOS/$patchfolder/android_external_ant-wireless/ ./external/ant-wireless/
    #~ rm -rf external/ant-wireless/.git
    #~ echo - done

    #~ echo
    #~ echo - vendor/cm/bootanimation kopieren
    #~ cp -r $RootPfad/LOS/$patchfolder/modifizierte/BootAnimation/bootanimationRing/bootanimation.tar ./vendor/cm/bootanimation/bootanimation.tar
    #~ echo - done

    #~ echo
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++ Dateien austauschen, patchen, hinzufuegen   +++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    ########################################################
    # nach dem synch patchen
    ########################################################
    applyGitPatches

    #zurueck in den Pfad
    cd $lstPath

    echo
    echo - Ims Lib kopieren
    [ ! -d $RootPfad/LOS/$AndroidPath/out/target/product/$target/system/lib ] &&  mkdir -p $RootPfad/LOS/$AndroidPath/out/target/product/$target/system/lib/arm
    cp $RootPfad/LOS/$AndroidPath/vendor/bq/$target/imsBq/vendor/app/ims/lib/libimsmedia_jni.so $RootPfad/LOS/$AndroidPath/out/target/product/$target/system/lib/libimsmedia_jni.so
    cp $RootPfad/LOS/$AndroidPath/vendor/bq/$target/imsBq/vendor/app/ims/lib/libimscamera_jni.so $RootPfad/LOS/$AndroidPath/out/target/product/$target/system/lib/libimscamera_jni.so

    if [ $checkBuildOnly = true ]
    then
        exit
    fi

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
    echo $PWD
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


##########################################################################################################
# Exit aus der while
##########################################################################################################
    if [ true = true ]
    then
        break
    fi
done

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
echo "+++++++++++++++++++++++++++++++++++ aufraeumen +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
restoreBuildEnv
removeGitPatches

##########################################################################################################
