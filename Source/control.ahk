#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;以管理员模式运行插件
if not A_IsAdmin
{
Run *RunAs "%A_ScriptFullPath%" 
ExitApp
}

HideTrayTip() { 
    TrayTip
}

;管理任务栏图标
IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Icon
Icon:=OutputVar
if (Icon=0)
{
Menu, Tray, NoIcon
}

;若Login设定为0，则需维持先前的触摸板设定
IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Login
Login:=OutputVar

IniWrite,1, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open

if (Login=0)
{
;读取最后一次设定信息
IniRead, OutputVar, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
Open:=OutputVar
if(Open=0)
{
Run C:\Program Files\Trackpad\trackpad\disable.vbs
Menu, Tray, Icon, C:\Program Files\Trackpad\Icon\off.ico, ,1
Menu, Tray, Tip , 关闭（Off）
IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Remind
IniWrite, 0, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
Remind:=OutputVar
if(Remind=1)
{
TrayTip Trackpad, 触摸板已关闭
SetTimer, HideTrayTip, -3000
}
}
}


;关闭插件时开启触摸板
#Persistent  
OnExit("ExitFunc")
OnExit(ObjBindMethod(MyObject, "Exiting"))

ExitFunc(ExitReason, ExitCode)
{
Run C:\Program Files\Trackpad\trackpad\enable.vbs
}
class MyObject
{
    Exiting()
    {
    }
}

#Persistent 
Menu, Tray, Add, 开启触摸板,trackpad_1
Menu, Tray, Add, 关闭触摸板, trackpad_0
Menu, Tray, Add
Menu,Auto,Add,开启自启,MenuHandler_open
Menu,Auto,Add,关闭自启,MenuHandler_close
Menu, Tray, Add, 开机自动启动此插件,:Auto
Menu, Tray, Add
Menu,Iconon,Add,开启,MenuHandler_Iconon
Menu,Iconon,Add,关闭,MenuHandler_Iconoff
Menu, Tray, Add, 开启任务栏图标,:Iconon
Menu, Tray, Add
Menu,Remind,Add,开启,MenuHandler_Remindon
Menu,Remind,Add,关闭,MenuHandler_Remindoff
Menu, Tray, Add, 开启切换通知提醒,:Remind
Menu, Tray, Add
Menu,Login,Add,重新登陆后保持触摸板开启状态,MenuHandler_Loginon
Menu,Login,Add,维持最后一次设定状态,MenuHandler_Loginoff
Menu, Tray, Add, 重新登录状态,:Login
Menu, Tray, Add
Menu, tray, NoStandard
Menu, tray, Standard

IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Icon
A:=OutputVar
if(A=1)
{
Menu, Iconon, Check, 开启
Menu, Iconon, Uncheck, 关闭  
}
if(A=0)
{
Menu, Iconon, Uncheck, 开启
Menu, Iconon, Check, 关闭  
}

IniRead, OutputVar, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
B:=OutputVar
if(B=1)
{
Menu, Tray, Check, 开启触摸板
Menu, Tray, Uncheck, 关闭触摸板  
}
if(B=0)
{
Menu, Tray, Uncheck, 开启触摸板
Menu, Tray, Check, 关闭触摸板  
}

IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Auto
C:=OutputVar
if(C=1)
{
Menu, Auto, Check, 开启自启
Menu, Auto, Uncheck, 关闭自启  
}
if(C=0)
{
Menu, Auto, Uncheck, 开启自启
Menu, Auto, Check, 关闭自启
}

IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Remind
D:=OutputVar
if(D=1)
{
Menu,Remind,Check,开启
Menu,Remind,Uncheck,关闭 
}
if(D=0)
{
Menu,Remind,Uncheck,开启
Menu,Remind,Check,关闭
}

IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Login
E:=OutputVar
if(E=1)
{
Menu,Login,Check,重新登陆后保持触摸板开启状态
Menu,Login,Uncheck,维持最后一次设定状态
}
if(E=0)
{
Menu,Login,Uncheck,重新登陆后保持触摸板开启状态
Menu,Login,Check,维持最后一次设定状态
}
return

F9::
IniRead, OutputVar, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
Open:=OutputVar
if(Open=1)
{
Menu, Tray, Icon, C:\Program Files\Trackpad\Icon\off.ico, ,1
Menu, Tray, Tip , 关闭（Off）
Menu, Tray, Uncheck, 开启触摸板
Menu, Tray, Check, 关闭触摸板
Run C:\Program Files\Trackpad\trackpad\disable.vbs
IniWrite, 0, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Remind
Remind:=OutputVar
if(Remind=1)
{
TrayTip Trackpad, 触摸板已关闭
SetTimer, HideTrayTip, -3000
}
}

if(Open=0)
{
Menu, Tray, Icon, C:\Program Files\Trackpad\Icon\on.ico, ,1
Menu, Tray, Tip , 开启（On）
Menu, Tray, Check, 开启触摸板
Menu, Tray, Uncheck, 关闭触摸板
Run C:\Program Files\Trackpad\trackpad\enable.vbs
IniWrite, 1, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Remind
Remind:=OutputVar
if(Remind=1)
{
TrayTip Trackpad, 触摸板已开启
SetTimer, HideTrayTip, -3000
}  
}
return

trackpad_1:
Menu, Tray, Icon, C:\Program Files\Trackpad\Icon\on.ico, ,1
Menu, Tray, Tip , 开启（On）
Menu, Tray, Check, 开启触摸板
Menu, Tray, Uncheck, 关闭触摸板
Run C:\Program Files\Trackpad\trackpad\enable.vbs
IniWrite, 1, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Remind
Remind:=OutputVar
if(Remind=1)
{
TrayTip Trackpad, 触摸板已开启
SetTimer, HideTrayTip, -3000
}
return

trackpad_0:
Menu, Tray, Icon, C:\Program Files\Trackpad\Icon\off.ico, ,1
Menu, Tray, Tip , 关闭（Off）
Menu, Tray, Uncheck, 开启触摸板
Menu, Tray, Check, 关闭触摸板
Run C:\Program Files\Trackpad\trackpad\disable.vbs
IniWrite, 0, C:\Program Files\Trackpad\Trigger\trackpad.ini, Trackpad, Open
IniRead, OutputVar, C:\Program Files\Trackpad\trackpad.ini, Trackpad, Remind
Remind:=OutputVar
if(Remind=1)
{
TrayTip Trackpad, 触摸板已关闭
SetTimer, HideTrayTip, -3000
}
return

MenuHandler_open:
Run  C:\Program Files\Trackpad\Trigger\Open.bat
Menu, Auto, Check, 开启自启
Menu, Auto, Uncheck, 关闭自启
MsgBox, 开机后会自动启动插件，下次登录生效。
return

MenuHandler_close:
Run  C:\Program Files\Trackpad\Trigger\Close.bat
Menu, Auto, Uncheck, 开启自启
Menu, Auto, Check, 关闭自启
MsgBox, 已关闭插件自启功能。
return

MenuHandler_Iconon:
IniWrite, 1, C:\Program Files\Trackpad\trackpad.ini, Trackpad,Icon
Menu, Iconon, Check, 开启
Menu, Iconon, Uncheck, 关闭
return

MenuHandler_Iconoff:
IniWrite, 0, C:\Program Files\Trackpad\trackpad.ini, Trackpad,Icon
Menu, Tray, NoIcon
return

MenuHandler_Remindon:
IniWrite, 1, C:\Program Files\Trackpad\trackpad.ini, Trackpad,Remind
Menu,Remind,Check,开启
Menu,Remind,Uncheck,关闭
return

MenuHandler_Remindoff:
IniWrite, 0, C:\Program Files\Trackpad\trackpad.ini, Trackpad,Remind
Menu,Remind,Uncheck,开启
Menu,Remind,Check,关闭
return

MenuHandler_Loginon:
IniWrite, 1, C:\Program Files\Trackpad\trackpad.ini, Trackpad,Login
Menu,Login,Check,重新登陆后保持触摸板开启状态
Menu,Login,Uncheck,维持最后一次设定状态
return

MenuHandler_Loginoff:
IniWrite, 0, C:\Program Files\Trackpad\trackpad.ini, Trackpad,Login
Menu,Login,Uncheck,重新登陆后保持触摸板开启状态
Menu,Login,Check,维持最后一次设定状态
return