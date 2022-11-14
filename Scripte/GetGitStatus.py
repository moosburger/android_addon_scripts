#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# <Jungheinrich\> #######################################################################################
##  \brief       Main fuer die Erzeugung der ChangeLog Datei
#   \details     Erzeugt aus Mercurial und Jira eine ChangeLog Csv Datei, die im angegebenen Archiv gespeichert wird.
#   \file        CreateChangeLog.py
#

  #python get-pip.py
  #pip3 install jira
  #pip3 install wincertstore

#  \copyright  (C) 2014 Jungheinrich GmbH, All rights reserved.
#  \date        Erstellt am: 13.03.2014
#  \author      Gerhard Prexl
#
#  \version     1.1  -  3.07.2018

# <History\> ##########################################################################################
# Version     Datum       Kuerzel      Ticket#     Beschreibung
# 1.0         13.03.2014  GP
#
# History Jungheinrich ################################################################################

# #################################################################################################
# # Python Imports (Standard Library)
# #################################################################################################
import sys
import os
import string
import codecs
import locale
import time
import subprocess
import glob

locale.getpreferredencoding()

# #################################################################################################
# # private Imports
# #################################################################################################

# #################################################################################################
# # UmgebungsVariablen
# #################################################################################################

# #################################################################################################
# # Funktionen
# # Prototypen
# # if __name__ == '__main__':
# #################################################################################################

# #################################################################################################
## \details         Die Einsprungsfunktion, ruft alle Funktionen und Klassen auf.
#   \param[in]    argv
#   \return            -
# #################################################################################################
def _gitBranch(repoDir):

    res = []
    cmd = ['git', 'branch']
    proc = subprocess.Popen(cmd, cwd=repoDir, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    while True:
        stdout = proc.stdout.readline()
        stderr = proc.stderr.readline()

        if not stdout and not stderr:
            break

        res.append(stdout.strip().decode("utf-8"))
        res.append(stderr.strip().decode("utf-8"))

    return res

# #################################################################################################
## \details         Die Einsprungsfunktion, ruft alle Funktionen und Klassen auf.
#   \param[in]    argv
#   \return            -
# #################################################################################################
def _gitCheckout(repoDir, branch):

    res = []
    cmd = ['git', 'checkout', branch]
    proc = subprocess.Popen(cmd, cwd=repoDir, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    while True:
        stdout = proc.stdout.readline()
        stderr = proc.stderr.readline()

        if not stdout and not stderr:
            break

        res.append(stdout.strip().decode("utf-8"))
        res.append(stderr.strip().decode("utf-8"))

    return res

# #################################################################################################
## \details         Die Einsprungsfunktion, ruft alle Funktionen und Klassen auf.
#   \param[in]    argv
#   \return            -
# #################################################################################################
def _gitStatus(repoDir):

    res = []
    cmd = ['git', 'status']
    p = subprocess.Popen(cmd, cwd=repoDir)
    p.wait()

# #################################################################################################
## \details         Die Einsprungsfunktion, ruft alle Funktionen und Klassen auf.
#   \param[in]    argv
#   \return            -
# #################################################################################################
def _gitDeleteBranch(repoDir, branch):

    res = []
    cmd = ['git', 'branch', '-D', branch]
    proc = subprocess.Popen(cmd, cwd=repoDir, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    while True:
        stdout = proc.stdout.readline()
        stderr = proc.stderr.readline()

        if not stdout and not stderr:
            break

        res.append(stdout.strip().decode("utf-8"))
        res.append(stderr.strip().decode("utf-8"))

    return res

# #################################################################################################
## \details         Die Einsprungsfunktion, ruft alle Funktionen und Klassen auf.
#   \param[in]    argv
#   \return            -
# #################################################################################################
def _main(argv):

    #try:
    start = '/media/dejhgp07/Android/LOS/lineage14.1'

    lsFolder = glob.glob(start + "/*/")
    lsFolder.sort()
    for folder in lsFolder:
        iDepth = 0
        for root, dirs, files in os.walk(folder, topdown=True):
            dirs.sort()
            iDepth = iDepth + 1

            if '.git' in root or '/bq/' in root or '/out/' in root or '/lineage/' in root:
                #print ("    continue")
                dirs[:] = []
                continue

            if os.path.exists(root + "/.git/index.lock"):
                os.remove(root + "/.git/index.lock")

            IsOk = False
            result = _gitBranch(root)

            for i in range(0, len(result)):
                #print (f'-{result}\nindex: {i}')
                if 'kein Branch' in result[i]:
                    #print ("{:45}  {}".format(result[i], root))
                    if '*' in result[i]:
                        #IsOk = True
                        dirs[:] = []
                        break

                if 'HEAD losgelöst bei' in result[i]:
                    print ("{:45}  {}".format(result[i], root))
                    print (f'-{result}\nindex: {i}')
                    if '*' in result[i]:

                        # wechsle den branch
                        print(root)
                        newResult = _gitCheckout(root, 'cm-14.1')
                        msg = ''
                        for i in range(0, len(newResult)):
                            msg = "{:45}\n{:45}".format(msg, newResult[i].strip())

                        print (msg)

                        dirs[:] = []
                        break

                if 'cm-14.1' in result[i]:
                    print ("{:45}  {}".format(result[i], root))
                    if '*' in result[i]:
                        #IsOk = True
                        dirs[:] = []
                        #break  wir sind zwar am richtigen branch, aber evtl. gibts noch andere, diese in der nächsten Runde löschen

                if 'fatal:' in result[i]:
                    #weitermachen zum tieferen Ordner
                    break

                if 'lineage-15.1' in result[i] or 'newBuild' in result[i]:
                    print ("{:45}  {}".format(result[i], root))

                    if not '*' in result[i]:
                        # lösche den branch
                        newResult = _gitDeleteBranch(root, result[i])
                        msg = '\n'
                        for i in range(0, len(newResult)):
                            msg = "{}{:45}".format(msg, newResult[i].strip())

                        print (msg)
                        break
                    elif '*' in result[i]:
                        # wechsle den branch
                        newResult = _gitCheckout(root, 'cm-14.1')
                        msg = ''
                        for i in range(0, len(newResult)):
                            msg = "{:45}\n{:45}".format(msg, newResult[i].strip())

                        print (msg)
                        # dann lösche den branch
                        res = result[i].replace('*','')
                        res = res.strip()
                        newResult = _gitDeleteBranch(root, res)
                        msg = ''
                        for i in range(0, len(newResult)):
                            msg = "{:45}\n{:45}".format(msg, newResult[i].strip())

                        print (msg)
                        break

        if len(dirs) > 0:
            print ("           {}".format(folder))

        #~ print ("           {}           {}".format(folder, len(dirs)))

    # #### Fehlerbehandlung #####################################################
    #except:
    #    for info in sys.exc_info():
    #        print("Fehler:", info)

# # Ende Funktion: ' _main' ###########################################################################

# #################################################################################################
# #  Funktion: 'Einsprung beim Aufruf  '
# #################################################################################################
if __name__ == '__main__':

    _main(sys.argv)

# # DateiEnde #####################################################################################
