#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Menu, Tray, NoIcon

IniRead, OutputVar, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
Open:=OutputVar

if (Open=1)
{
Run C:\Program Files\Trackpad\trackpad\enable.vbs
return
}

if(Open=0)
{
Run C:\Program Files\Trackpad\trackpad\disable.vbs
return
}