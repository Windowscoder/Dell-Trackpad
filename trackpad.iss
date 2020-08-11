; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "���ܴ��ذ�"
#define MyAppVersion "3.0"
#define MyAppPublisher "��ֻƻ��"
#define MyAppExeName "control.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{59BE1617-63C7-4650-B2F4-518DA38B6845}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName=C:\\Program Files\Trackpad
DisableDirPage=yes
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
OutputDir=C:\Users\18622\Desktop
OutputBaseFilename=���ܴ��ذ�
SetupIconFile=C:\Users\18622\Desktop\trackpad.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "C:\Users\18622\Desktop\Trackpad\control.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\18622\Desktop\Trackpad\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Run]
Filename: "schtasks.exe"; Parameters: "/delete /TN Trackpad /F"
Filename: "schtasks.exe"; Parameters: "/delete /TN Trackpad_Unlocked /F"
Filename: "schtasks.exe"; Parameters: "/delete /TN Trackpad_Protect /F"
Filename: "schtasks.exe"; Parameters: "/create /XML ""{app}\trigger\Trackpad.xml"" /TN Trackpad"
Filename: "schtasks.exe"; Parameters: "/create /XML ""{app}\trigger\Trackpad_Unlocked.xml"" /TN Trackpad_Unlocked"
Filename: "schtasks.exe"; Parameters: "/create /XML ""{app}\trigger\Protect_Trackpad.xml"" /TN Trackpad_Protect"
Filename: "{app}\Trigger\move.exe"
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

 [UninstallRun] 
Filename: "{app}\Trigger\uninstall.exe"
Filename: "schtasks.exe"; Parameters: "/delete /TN Trackpad /F"
Filename: "schtasks.exe"; Parameters: "/delete /TN Trackpad_Unlocked /F"
Filename: "schtasks.exe"; Parameters: "/delete /TN Trackpad_Protect /F"