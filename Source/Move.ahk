﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
if not A_IsAdmin
{
Run *RunAs "%A_ScriptFullPath%" 
ExitApp
}

FileMove, C:\Program Files\Trackpad\devcon.exe ,C:\Windows\System32\devcon.exe
return