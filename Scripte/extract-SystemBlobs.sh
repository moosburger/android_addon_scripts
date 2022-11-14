#!/bin/bash



############## ALS ROOT ##########################


# Wenn breakfast gohan schon mal ausgeführt wurde
Target=crDroidAndroid
#Target=VoLTE_dump
# Target=oneplus3_dump
# Target=BqGohan_dump
# Target=tenshi_dump

RootPfad=/media/dejhgp07/Android/

cd $RootPfad/Boards/dumps/$Target
python $RootPfad/Boards/dumps/$Target/sdat2img.py system.transfer.list system.new.dat system.img

#Verzeichnis wechseln oder volle Pfade
#kdesudo mount $RootPfad/Boards/dumps/$Target/system.img $RootPfad/Boards/dumps/$Target/system/
#kdesudo mount system.img ./system

# cd $RootPfad/android/lineage/device/bq/gohan/




# ./extract-files.sh $RootPfad/Boards/dumps/$Target/
#sudo umount $RootPfad/Boards/dumps/$Target/system/


#sudo mount /media/lta-user/Backup/Boards/dumps/tenshi_dump/system.img /media/lta-user/Backup/Boards/dumps/tenshi_dump/system/
#./extract-files.sh /media/lta-user/Backup/android/Boards/tenshi_dump/
#sudo umount /media/lta-user/Backup/Boards/dumps/tenshi_dump/system/