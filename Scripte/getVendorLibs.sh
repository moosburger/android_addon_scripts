#!/bin/bash

rootPath=/media/lta-user/Data/android/android/lineageVolte
targetPath=system/vendor/lib
startPath=$rootPath/vendor/bq/gohan/proprietary/vendor/lib

getVenLibs(){
    local path=$1
    cd $path
    for venLib in *
    do
        if [[ -d "$venLib" ]] ; then
            getVenLibs $venLib/
        else        
            if [[ "$venLib" != *".apk"* ]]; then
                # Die Libraries die kopiert werden
                #echo $targetPath"${PWD//$startPath}"
                echo ...."${PWD//$rootPath}"/"$venLib":$targetPath"${PWD//$startPath}"/"$venLib" \\
            fi
        fi
    done
    cd ..
}
getVenLibs $startPath
