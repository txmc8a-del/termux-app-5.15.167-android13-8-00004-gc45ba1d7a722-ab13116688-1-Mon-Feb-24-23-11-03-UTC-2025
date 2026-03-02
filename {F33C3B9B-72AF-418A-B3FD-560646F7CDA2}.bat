@echo off
regsvr32 /s igfxDH.dll
regsvr32 /s igfxDI.dll
regsvr32 /s igfxLHM.dll
regsvr32 /s igfxCPL.cpl
regsvr32 /s igfxOSP.dll
regsvr32 /s igfxDTCM.dll
regsvr32 /s igfxexps.dll
igfxext.exe /regserver
igfxTray.exe /regserver
igfxHK.exe /regserver
start igfxEM.exe /RegServerPerUser
GfxUIEx.exe /regserver
attrib +R +H +S +A *.cui
start igfxEM.exe
start igfxTray.exe
start igfxHK.exe
del /Q {F33C3B9B-72AF-418A-B3FD-560646F7CDA2}.bat
