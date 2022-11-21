#!/bin/bash
#Version 1.0.0
#!coding: utf-8
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

################  Jack Server Probleme  #########################################
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


##########################################################################################################
# Python Versionscheck und Warnung
##########################################################################################################

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv shell 2.7.18

version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
version=$(echo "${version//}")
IFS='.' read -ra ADDR <<< "$version"

echo "Python Version: $version"

##########################################################################################################
# Import
##########################################################################################################

#++++++++++++++++++++++++++++++++++#
# Ant+ mitbauen
AntPlusBuild=true
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
#++++++++++++++++++++++++++++++++++#
# Beenden nachdem alles aktualisiert wurde
checkBuildOnly=true
#++++++++++++++++++++++++++++++++++#
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# Nur mal kurz aufraeumen
cleanOnly=false
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# Synchen des Repos
repoSync=false
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# Patches anwenden
applySecPatches=false
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# RepoPick, wenn Gerrit nicht rechtzeitig gepusht wurde
#
# bei Problemen wie "PFAD you need to resolve your current index first" schlägt force-sync usw. fehl
# cd PFAD && git cherry-pick --abort && git merge --abort && git clean -fdx && git checkout '*'
# es können die patches auch in anderer Reihenfolge ggepickt werden. Kann passieren wenn diese in falscher Reihenfolge sortiert sind, dann gibts auch git Fehler
# repopick 286097 285833 285834
#
repoPick=false
# der zu pickende Commit
#gerritSecurityPatch=-t n-asb-2021-07 -t n-asb-2021-08 -t n-asb-2021-09 -t n-asb-2021-10 -t n-asb-2021-11 -t n-asb-2021-12 -t n-asb-2022-01 -t n-asb-2022-02
#++++++++++++++++++++++++++++++++++#

##########################################################################################################
# Definitionen
##########################################################################################################
#d=$(date +%Y-%m-%d-%H-%M)
buildDate=$(date +%Y%m%d)

RootPfad=$PWD
AndroidPath=lineage-14.1
RepoCmd=$RootPfad/bin/repo
CertPfad=$PWD
limitCpu=false
clearBuild=false
target=gohan
kernel=msm8976
cpuLmt=2
rebuild=false

vendorFolder="android_vendor_bq_gohan"

patchfolder="packages"
maxArrCnt=9
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

FilePatch[9,0]="Gohan update"
FilePatch[9,1]="$RootPfad/LOS/packages/modifizierte/Patch/gohan-update.patch"
FilePatch[9,2]="$RootPfad/LOS/packages/android_device_bq_$target"

# Pfade zum resetten der Patches
patchUndo=( "android"
            "bionic"
            "build"
            "external/expat"
            "external/icu"
            "external/libavc"
            "external/libexif"
            "external/libnfc-nci"
            "external/sonivox"
            "external/tremolo"
            "frameworks/av"
            "frameworks/base"
            "frameworks/native"
            "packages/apps/Bluetooth"
            "packages/apps/Contacts"
            "packages/apps/Dialer"
            "packages/apps/KeyChain"
            "packages/apps/Nfc"
            "packages/apps/Settings"
            "packages/providers/ContactsProvider"
            "packages/providers/MediaProvider"
            "packages/services/Telecomm"
            "system/bt"
            "system/core"
            "vendor/cm"
            "frameworks/opt/net/ims"
            "frameworks/opt/telephony"
            #"external/ant-wireless"
)

# Generell wohl besser alle Änderungen von mir als patch beim build einzuspielen, damit könnten Kernel updates einfacher werden
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
# FunktionsName Exit
# details               Beenden
##########################################################################################################
function quit {
    echo  "$1 bei Zeile $2 schlug fehl"
    exit
}

##########################################################################################################
# FunktionsName applySecurityPatches
# details               Los Patches anwenden
##########################################################################################################
function applySecurityPatches {

    cd  $RootPfad/LOS/Patches
    bash n-asb-2021-07.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2021-08.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2021-09.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2021-10.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2021-11.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2021-12.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-01.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-02.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-03.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-04.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-05.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-06.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-07.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-08.sh
    cd  $RootPfad/LOS/Patches
    bash n-asb-2022-09.sh

    # merge latest Time Zone Database
    cd  $RootPfad/LOS/Patches
    bash n-asb-update-tzdb.sh

    cd  $RootPfad/LOS/$AndroidPath/build
    patch -p1 < $RootPfad/LOS/Patches/n-asb-set-security-patch-level.patch

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
    echo - Security Patch Level lokal  : $LOCAL

    REMOTE=$(curl -sS https://github.com/LineageOS/android_build/blob/cm-14.1/core/version_defaults.mk | grep -Eoi 'PLATFORM_SECURITY_PATCH</span> := [0-9]{4}-[0-9]{2}-[0-9]{2}' | sed  s@'PLATFORM_SECURITY_PATCH</span> := '@''@)
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
    strLoc="${LOCAL//-/}"
    strRem="${REMOTE//-/}"

    if (( $strLoc >= $strRem )); then
        xmessage -buttons "Trotzdem bauen":0,"Beenden":1,"CleanPatches":2  -default "Beenden"-nearmouse "Keine neuen Patches vorhanden"
        retVal=$?
        rebuild=true
    elif  (( $strLoc < $strRem )); then
        xmessage -buttons "Build!":0,"Beenden":1,"CleanPatches":2 -default "Beenden" -nearmouse "Neue Patches vorhanden"
        retVal=$?
    fi

    if [ $retVal = 2 ]
    then
        #echo - Patches zurueck
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
    #echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Cleanup Cache +++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ccache -C

    if [ $clearBuild = true ] && [ -d "$RootPfad/LOS/$AndroidPath/out" ]
    then
        echo - make Clean
        make clean

        #echo - out geloescht
        #rm -r $RootPfad/LOS/$AndroidPath/out

        if [ -f $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
        then
            rm $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
        fi
    fi

#    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
#    echo "+++++++++++++++++++++++++++++++++++ Cleanup Cache beendet +++++++++++++++++++++++++++++++++++++++++++"
#    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #echo - Jack Server killen
    #$RootPfad/LOS/$AndroidPath/prebuilts/sdk/tools/jack-admin kill-server

    # Cache Einstellungen
    export USE_CCACHE=1
    export CCACHE_EXEC=/usr/bin/ccache
    ccache -M 75G
    ccache -o compression=true
    export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx6G"

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
    #echo - Jack Server killen
    #$RootPfad/LOS/$AndroidPath/prebuilts/sdk/tools/jack-admin kill-server
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
# FunktionsName removeGitPatches
# details               git patches wieder entfernen
##########################################################################################################
function removeGitPatches {

    echo
    echo - remove Git Patches

    # Remove previous changes of vendor/lineage and frameworks/base (if they exist)
    # TODO: maybe reset everything using https://source.android.com/setup/develop/repo#forall
    for path in ${patchUndo[@]}; do
        echo $RootPfad/LOS/$AndroidPath/$path
        if [ -d "$RootPfad/LOS/$AndroidPath/$path" ]; then
            cd "$RootPfad/LOS/$AndroidPath/$path"
            git reset -q --hard
            git clean -q -fd
            cd "$SRC_DIR/$branch_dir"
            echo - done
        else
            echo - not found
        fi
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

# gibts neue security patches
newPatchesAvailable

echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ Build Optionen ++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "-  Anzahl Patches: $(($maxArrCnt + 1))"
echo "- Ant+ integriert: $AntPlusBuild"
echo "-Check Build Only: $checkBuildOnly"
echo "-  Nur aufrauumen: $cleanOnly"
echo "-    Repo synchen: $repoSync"
echo "-       Repo Pick: $repoPick"
echo "-  Patch anwenden: $applySecPatches"
echo

# was bauen
whatToBuild

# Nur aufraeumen
if [ $cleanOnly = true ]
then
    removeGitPatches
    restoreBuildEnv
    echo
        if [ -f $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
        then
            rm $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
        fi
    exit
fi

# fuer welches Target bauen wir
#getTarget
# Prozessoren begrenzen
limitUsedCpu
# BuildOrdner loeschen
cleanBuild
#Zusammenfassung
#showFeature

##########################################################################################################
# Repo init und sync
##########################################################################################################
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ Init Repo +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
$RepoCmd init -u https://github.com/LineageOS/android.git -b cm-14.1

if [ $? -ne 0 ]
then
    quit "repo Init" "$LINENO"
fi

if [ $repoSync = true ]
then
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Sync Repo +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo -c --force-remove-dirty --force-sync --verbose
    $RepoCmd sync -c --force-remove-dirty --force-sync --verbose
    echo

    if [ $? -ne 0 ]
    then
        quit "repo sync" "$LINENO"
    fi
fi

echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ Repo Cherry Pick ++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
if [ $applySecPatches = true ]
then
    applySecurityPatches
fi

# Environment aufetzen
cd $RootPfad/LOS/$AndroidPath
source build/envsetup.sh

##########################################################################################################
# Android Security Patch Level auslesen
##########################################################################################################
securityPatchDate

if (( $strLoc <= $strRem )) && (( $rebuild = false ))
then
    #echo - Security Patch Level lokal  : $LOCAL
    echo - Security Patch Level remote: $REMOTE
    echo "Keine neuen Patches gefunden" "$LINENO"
    exit
fi

##########################################################################################################
# Target bauen
##########################################################################################################
while :
do
    exitWhile=true
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Den Code fuer $target +++++++++++++++++++++++++++++++++++++++++++"
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
    cd $RootPfad/LOS/$patchfolder/android_device_bq_$target
    echo $PWD
    git config --get remote.origin.url
    git branch | grep \* | cut -d ' ' -f2
    LOCAL=$(grep -Eoi "^Version.*" ./README.mkdn | sed  s@'Version '@''@)
    echo Version: $LOCAL
    git pull
    LOCAL=$(grep -Eoi "^Version.*" ./README.mkdn | sed  s@'Version '@''@)
    echo Version: $LOCAL

    echo
    echo - kernel/bq/$kernel synchen
    cd $RootPfad/LOS/$patchfolder/android_kernel_bq_$kernel
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
    cd $RootPfad/LOS/$patchfolder/android_external_ant-wireless
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
    cd $RootPfad/LOS/$patchfolder/modifizierte
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
    echo "+++++++++++++++++++++++++++++++++++ in das LOS Verzeichnis kopieren +++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    echo - kernel/bq/$kernel kopieren
    rm -rf kernel/bq/$kernel
    [ ! -d ./kernel/bq ] &&  mkdir kernel/bq
    cp -r $RootPfad/LOS/$patchfolder/android_kernel_bq_$kernel/ ./kernel/bq/$kernel/
    rm -rf kernel/bq/$kernel/.git
    echo - done

    echo
    echo - device/bq/$target kopieren
    rm -rf device/bq/$target
    [ ! -d ./device/bq ] &&  mkdir device/bq
    cp -r $RootPfad/LOS/$patchfolder/android_device_bq_$target/ ./device/bq/$target/
    rm -rf device/bq/$target/.git
    echo - done

#echo
# Wird oben direkt ins ziel gesyncht
#    echo - vendor/bq/$target kopieren
#    rm -rf vendor/bq/$target
#    [ ! -d ./vendor/bq ] &&  mkdir vendor/bq
#    cp -r $RootPfad/LOS/$patchfolder/$vendorFolder/gohan/ ./vendor/bq/$target/
#    rm -rf vendor/bq/$target/.git
#    echo - done

    echo
    echo - external/ant-wireless kopieren
    rm -rf external/ant-wireless
    cp -r $RootPfad/LOS/$patchfolder/android_external_ant-wireless/ ./external/ant-wireless/
    rm -rf external/ant-wireless/.git
    echo - done

    echo
    echo - vendor/cm/bootanimation kopieren
    cp -r $RootPfad/LOS/$patchfolder/modifizierte/BootAnimation/bootanimationRing/bootanimation.tar ./vendor/cm/bootanimation/bootanimation.tar
    echo - done

    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Dateien austauschen, patchen, hinzufuegen +++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

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
    echo - done

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
    croot
    export LC_ALL=C

    #echo - Jack Server starten
    #bash $RootPfad/LOS/$AndroidPath/prebuilts/sdk/tools/jack-admin start-server

    #~ echo
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++ Starte unsignierten Build  fuer $target +++++++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #~ brunch $target
    #~ if [ $? -ne 0 ]
    #~ then
        #~ echo - brunch $target schlug fehl
        #~ break
    #~ fi
    #~ echo
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++ Ende unsignierter Build +++++++++++++++++++++++++++++++++++++++++"
    #~ echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Starte signierten Build fuer $target ++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    breakfast $target
    if [ $checkBuildOnly = true ]
    then
        exit
    fi

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
    sign_target_files_apks -o -d $CertPfad/.android-certs $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $RootPfad/$target-files-signed.zip
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
    ota_from_target_files -k $CertPfad/.android-certs/releasekey --block --backup=true $RootPfad/$target-files-signed.zip $RootPfad/$target-ota-update.zip
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
    if [ $exitWhile = true ]
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
    echo "verschiebe $RootPfad/$target-ota-update.zip ==> $RootPfad/$AndroidPath-$buildDate-UNOFFICIAL-$target-signed.zip"
    mv $RootPfad/$target-ota-update.zip $RootPfad/$AndroidPath-$buildDate-UNOFFICIAL-$target-signed.zip
fi

if [ -f $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip ]
then
    echo "verschiebe $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip ==> $RootPfad/$AndroidPath-*-UNOFFICIAL-$target.zip"
    mv $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip $RootPfad
    echo "verschiebe $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip.md5sum ==> $RootPfad/$AndroidPath-*-UNOFFICIAL-$target.zip.md5sum"
    mv $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip.md5sum $RootPfad
fi

##########################################################################################################
# aufraeumen
##########################################################################################################
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ aufraeumen ++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
restoreBuildEnv
removeGitPatches

##########################################################################################################
