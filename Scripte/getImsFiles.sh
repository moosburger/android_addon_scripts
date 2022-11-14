#!/bin/bash

filter=mmi
startPath=/media/lta-user/Backup/Boards/Roms/Bq-StockRom/
targetPath=/media/lta-user/Data/android/android/packages/modifizierte/StockRom/"$filter"/

getVenLibs(){
    local path=$1
    cd $path
    for venLib in *
    do
        if [[ -d "$venLib" ]] ; then
            getVenLibs $venLib/
        else
            # Die Libraries die kopiert werden
            if [[ "$venLib" == *"$filter"* ]]; then
                if [[ -f "$venLib" ]] ; then
                    echo mkdir -p $targetPath"${PWD//$startPath}" "&&" cp $PWD/"$venLib" '"$_"'
                else
                    # Create links
                    echo mkdir -p $targetPath"${PWD//$startPath}" "&&" ln -sf $PWD/"$venLib" '"$_"'
	        fi
            fi
        fi
    done
    cd ..
}
getVenLibs $startPath
