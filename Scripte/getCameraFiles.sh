#!/bin/bash

startPath=/media/lta-user/Backup/Boards/Roms/Bq-StockRom/
targetPath=/media/lta-user/Data/android/android/packages/modifizierte/StockRom/Camera/

getVenLibs(){
    local path=$1
    cd $path
    for venLib in *
    do
        if [[ -d "$venLib" ]] ; then
            getVenLibs $venLib/
        else
            # Die Libraries die kopiert werden
            if [[ "$venLib" == *"cam"* ]] || [[ "$venLib" == *"chromatix"* ]]; then
                echo mkdir -p $targetPath"${PWD//$startPath}" "&&" cp $PWD/"$venLib" '"$_"'
            fi
        fi
    done
    cd ..
}
getVenLibs $startPath

