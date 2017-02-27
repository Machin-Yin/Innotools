; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{02E0A592-74C8-42E2-95D6-D24D8FC0625F}
AppName=一铭云打印
AppVersion=1.0 beta4.5
;AppVerName=一铭云打印 1.0 beta4.5
AppPublisher=EmindSoft
AppPublisherURL=http://www.emindsoft.com.cn/
AppSupportURL=http://www.emindsoft.com.cn/
AppUpdatesURL=http://www.emindsoft.com.cn/
DefaultDirName={pf}\一铭云打印
DisableProgramGroupPage=yes
DisableStartupPrompt=yes
OutputDir=C:\Users\yin\Desktop
OutputBaseFilename=一铭云打印
SetupIconFile=C:\Users\yin\Desktop\xpok\image\desk.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; 
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; OnlyBelowVersion: 0,6.1

[Files]
Source: "C:\Users\yin\Desktop\xpok\一铭云打印服务.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\yin\Desktop\xpok\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "C:\Users\yin\Desktop\xpok\psvince.dll"; Flags: dontcopy noencryption
Source: "C:\Users\yin\Desktop\xpok\psvince.dll"; DestDir: "{app}";

[Icons]
Name: "{commonprograms}\一铭云打印"; Filename: "{app}\一铭云打印服务.exe"
Name: "{commondesktop}\一铭云打印"; Filename: "{app}\一铭云打印服务.exe";Tasks: desktopicon;IconFilename: "{app}\image\desk.ico" 
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\一铭云打印"; Filename: "{app}\一铭云打印服务.exe"; Tasks: quicklaunchicon;IconFilename: "{app}\image\desk.ico"
;Name: "{group}\一铭云打印"; Filename: "{app}\一铭云打印服务.exe"
;Name: "{userdesktop}\一铭云打印"; Filename: "{app}\一铭云打印服务.exe"; Tasks: desktopicon;IconFilename: "{app}\image\desk.ico"

[Run]
Filename: "{app}\一铭云打印服务.exe"; Description: "{cm:LaunchProgram,一铭云打印}"; Flags: nowait postinstall skipifsilent

[code]
function IsModuleLoaded(modulename: AnsiString ):  Boolean;
external 'IsModuleLoaded@files:psvince.dll stdcall';
function InitializeSetup():boolean;
var
   IsAppRunning: boolean;
   KeynotExist:boolean;   
   ResultCode: Integer;   
   uicmd: String; 
begin
    Result := true;
// 安装时判断客户端是否正在运行
   begin
    Result:= true;//安装程序继续
    IsAppRunning:= IsModuleLoaded('一铭云打印服务.exe');
    while IsAppRunning do
       begin
        if MsgBox('安装程序检测到“一铭云打印”正在运行！' #13#13 '您必须先关闭它,然后单击“确定”继续安装，否则按“取消”退出！', mbConfirmation, MB_OKCANCEL) = IDOK then
         begin
         IsAppRunning:= IsModuleLoaded('一铭云打印服务.exe')
         Result:= true;
         end else begin
         IsAppRunning:= false;
         Result:= false;//安装程序退出
         Exit;
         end;
       end;
     end;
     begin   
        KeynotExist:= true;   
        if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{02E0A592-74C8-42E2-95D6-D24D8FC0625F}_is1', 'UninstallString', uicmd) then   
        begin   
          KeynotExist:= false; 
          MsgBox('安装程序检测到“一铭云打印”已经安装！您必须先卸载它，然后再安装本程序。', mbError, MB_OK);  
          //Exec(RemoveQuotes(uicmd), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);   
        end;   
        Result:= KeynotExist   
     end;
end;
// 卸载时判断xxx是否正在运行
function IsModuleLoadedU(modulename: AnsiString ): Boolean;
external 'IsModuleLoaded@{app}\psvince.dll stdcall uninstallonly';
function InitializeUninstall(): boolean;
var
  IsAppRunning: boolean;
begin
  Result :=true;  //卸载程序继续
  IsAppRunning:= IsModuleLoadedU('一铭云打印服务.exe');
  while IsAppRunning do
  begin
    if Msgbox('卸载程序检测到“一铭云打印”正在运行。'  #13#13 '您必须先关闭它，然后单击“确定”继续卸载，否则按“取消”退出！', mbConfirmation, MB_OKCANCEL) = IDOK then
    begin
      IsAppRunning:= IsModuleLoadedU('一铭云打印服务.exe');
      Result :=true; //卸载程序继续
    end else begin
      Result :=false; //卸载程序退出
      Exit;
    end;
  end;
  UnloadDLL(ExpandConstant('{app}\psvince.dll'));
end;
  

