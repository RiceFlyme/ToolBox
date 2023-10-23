#NoTrayIcon
#RequireAdmin
#Region ;**** 编译指令由 by AutoIt3Wrapper_GUI 创建 ****
#AutoIt3Wrapper_Icon=..\..\Downloads\Pictures\Camera Roll\一批超漂亮图标\图标\Audiotool.ico
#AutoIt3Wrapper_Outfile=稻花香工具箱_v1.10.0.25.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=稻花香工具箱
#AutoIt3Wrapper_Res_Description=稻花香工具箱
#AutoIt3Wrapper_Res_Fileversion=1.10.0.25
#AutoIt3Wrapper_Res_ProductName=稻花香工具箱_v1.10.0.25
#AutoIt3Wrapper_Res_ProductVersion=1.10.0.25
#AutoIt3Wrapper_Res_CompanyName=稻花香定制出品
#AutoIt3Wrapper_Res_LegalCopyright=Copyright? 2021-2023 RiceFlyme All rights reserved
#AutoIt3Wrapper_Res_LegalTradeMarks=RiceFlyme
#AutoIt3Wrapper_Res_Language=2052
#AutoIt3Wrapper_Res_Field=InternalName|稻花香工具箱_v1.10.0.25
#EndRegion ;**** 编译指令由 by AutoIt3Wrapper_GUI 创建 ****
#Region ;**** 编译指令由 by AutoIt3Wrapper_GUI 创建 ****
#EndRegion ;**** 编译指令由 by AutoIt3Wrapper_GUI 创建 ****
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <array.au3>
#include <GuiStatusBar.au3>
#include <Date.au3>
#include 'function.au3'
#include 'DirInstall_udf.au3'
If UBound(ProcessList(@ScriptName)) > 2 Then ;禁止重复运行
	MsgBox(48, '警告', '请不要重复运行')
	Exit
EndIf

FileChangeDir(@ScriptDir) ;切到脚本目录，防止被调用时的报错
_DirInstall(@ScriptDir&'\config\config', "@ScriptDir &'\dhxtool'|1",0)
_DirInstall(@ScriptDir&'\config\icon', "@ScriptDir &'\dhxtool'|1",0)
_DirInstall(@ScriptDir&'\config\skin', "@ScriptDir &'\dhxtool'|1",0)
_DirInstall(@ScriptDir&'\config\tools', "@ScriptDir &'\dhxtool'|1",0)
Global $rjPan = _Pan() ;获取工具箱盘符，创建并释放配置文件
For $i = 1 To $sFLNum - 1
	DirCreate($rjPan&$rjml[$i])
Next
If IniRead('dhxtool\config\form.ini', '修订版本', 'Ver', '') <> $ver2 Then
	DirRemove('dhxtool', 1)
	_ScriptRestart()
EndIf

Global $Form_WLCM = GUICreate('', 760, 320, -1, -1, $WS_POPUP, $WS_EX_LAYERED) ;欢迎窗口
GUICtrlCreatePic('dhxtool\skin\欢迎背景.jpg', 0, 0, 760, 320)
GUICtrlSetState(-1, $GUI_DISABLE)
Global $TipData = GUICtrlCreateLabel('软件工具箱正在启动，请稍等...', 180, 210, 355, 25)
GUICtrlSetFont(-1, 15, 700, 2, '华文彩云')
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, 0x025CBC)
GUISetState(@SW_SHOW, $Form_WLCM)

Global $Form = GUICreate($ToolTitle, 1060, 650, -1, -1) ;主窗口
GUICtrlCreatePic("", 0, 0, 1060, 650, -1, 1048576)
GUICtrlSetImage(-1, @ScriptDir & "\dhxtool\skin\主窗口背景.jpg")
GUICtrlSetState(-1, $GUI_DISABLE) ;禁止在窗口内拖动
_WaterCtrl_Startup(@ScriptDir & "\dhxtool\skin\水纹.bmp", $Form, Random(0, 800) & "," & Random(0, 100), Random(3, 8), 50, 260, 0);水纹图片

$LeftICO[0] = GUICreate("", 37, 37, 12, 90, $WS_POPUP, $WS_EX_MDICHILD, $Form);左侧控制按钮
$LeftBTN[0] = GUICtrlCreateIcon(@ScriptDir & '\dhxtool\icon\Form\zhankai.ico', 0, -1, -1, 37, 37)
GUISetBkColor('0x501F56')
GUISwitch($Form)
Global $LeftICOBK = GUICreate("", 37, 395, 12, 130, $WS_POPUP, $WS_EX_MDICHILD, $Form)
WinSetTrans($LeftICOBK, "", 50)
GUISwitch($Form)
For $i = 1 To 14
	$LeftICO[$i] = GUICreate("", 32, 32, 15, 40 * $i + 12, $WS_POPUP, $WS_EX_MDICHILD, $Form)
	$LeftBTN[$i] = GUICtrlCreateIcon(@ScriptDir & '\dhxtool\icon\Form\' & $LeftICOName[$i] & '.ico', 0, -1, -1, 32, 32)
	GUISetBkColor($LeftICOBKCLR[$i])
	GUISwitch($Form)
Next

Global $ahIcons, $vPartEdge[6] = [100, 475, 600, 742, 950, 1060] ;创建状态栏
Global $hStatus = _GUICtrlStatusBar_Create($Form, -1, "", $SBARS_TOOLTIPS)
_GUICtrlStatusBar_SetParts($hStatus, $vPartEdge)
_NetStatus($1html, $curl, $hStatus) ;网络状态
If @OSBuild > 10000 Then
	_GUICtrlStatusBar_SetText($hStatus, '系统信息: ' & OSinfo() & ' ' & @OSArch & ' ' & $OSfx & '-' & @OSBuild & '.' & $OShz, 1)
Else
	Local $bbh = StringSplit(FileGetVersion(@WindowsDir & '\explorer.exe', 'FileVersion'), '.(')
	_GUICtrlStatusBar_SetText($hStatus, '系统信息: ' & OSinfo() & ' ' & @OSArch & ' ' & $bbh[3] & '.' & $bbh[4], 1)
EndIf
_GUICtrlStatusBar_SetText($hStatus, '系统环境: ' & OSHuanJing($2html, $curl), 2)
_GUICtrlStatusBar_SetText($hStatus, '引导模式:' & IsGPT() & ' + ' & _IsUEFIBoot(), 3)
AdlibRegister("_time", 1000) ;当前系统时间
_GUICtrlStatusBar_SetText($hStatus, '版本号：' & $ver1 & $ver2, 5)

For $i = 0 To 20
	$BTN_stfenlei[$i] = GUICtrlCreateButton($sfenlei[$i+1], 60, $i * 30, 200, 29);软件分类按钮
	GUICtrlSetColor(-1, '0xFFFFFF')
	GUICtrlSetBkColor(-1, $flcolor[$i])
	$Form_sft[$i] = GUICreate("", 800, 530, 260, 100, $WS_POPUP, $WS_EX_MDICHILD, $Form);软件区域的子窗口
	GUISetBkColor($stcolor[$i])
	GUISwitch($Form)
Next

GUISwitch($Form_sft[0]);在线安装子窗口内容
GUICtrlCreateIcon(@ScriptDir&'\dhxtool\icon\在线安装\LKY_OfficeTools.ico',-1,2,2,40,40)
GUICtrlCreateLabel('LKY-OfficeTools',48,10,200,28)
GUICtrlSetFont(-1,18,500,0,'微软雅黑')
GUICtrlCreateLabel('12.0MB',270,12,100,25)
GUICtrlSetFont(-1,16,500,0,'微软雅黑')
GUICtrlCreateLabel('v1.1.2.401',385,12,150,25)
GUICtrlSetFont(-1,16,500,0,'微软雅黑')
GUICtrlCreateLabel('单文件',550,12,100,25)
GUICtrlSetFont(-1,16,500,0,'微软雅黑')
GUICtrlCreateButton('获取软件',680,9,100,30)
GUICtrlSetFont(-1,12,500,0,'微软雅黑')
GUICtrlCreateLabel(' 一键快速下载、安装、激活最新版 Microsoft Office 软件。可在安装 Word、PPT、Excel 的同时，根据软件提示，自助安装'&@CRLF& _
					' 其它组件，可以自动识别不同的操作系统架构，自动下载适配版本的 Office。激活 Office 的方式为正版激活模式，不会篡改'&@CRLF& _
					' 任何系统文件。当系统中存在多个冗余 Office 版本时，本工具在用户同意的情况下，可实现自动升级。',5,45,788,60)
GUICtrlSetBkColor(-1,0x9C42A4)
GUICtrlSetFont(-1,11,0,0,'微软雅黑')
GUISwitch($Form)

For $i = 0 To 2
	$BTN_findstr[$i] = GUICtrlCreateButton($findstr[$i], 60, $i * 30, 200, 29);搜索分类按钮
	GUICtrlSetColor(-1, '0xFFFFFF')
	GUICtrlSetBkColor(-1, $flcolor[$i])
	GUICtrlSetState(-1, $GUI_HIDE)
	$Form_fnd[$i] = GUICreate("", 800, 530, 260, 100, $WS_POPUP, $WS_EX_MDICHILD, $Form)
	GUISetBkColor($stcolor[$i])
	GUICtrlCreateLabel($findstr[$i], 295, 250, 210, 30)
	GUICtrlSetFont(-1, 22, 700, 2)
	GUISwitch($Form)
Next
For $i = 0 To 3
	$BTN_setting[$i] = GUICtrlCreateButton($setting[$i], 60, $i * 30, 200, 29);设置分类按钮
	GUICtrlSetColor(-1, '0xFFFFFF')
	GUICtrlSetBkColor(-1, $flcolor[$i])
	GUICtrlSetState(-1, $GUI_HIDE)
	$Form_set[$i] = GUICreate("", 800, 530, 260, 100, $WS_POPUP, $WS_EX_MDICHILD, $Form)
	GUISetBkColor($stcolor[$i])
	GUICtrlCreateLabel($setting[$i], 295, 250, 210, 30)
	GUICtrlSetFont(-1, 22, 700, 2)
	GUISwitch($Form)
Next

Global $about[9];关于界面
$about[1] = GUICtrlCreateLabel('                   关于', 265, 105, 790, 30)
GUICtrlSetFont(-1, 20, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[2] = GUICtrlCreateLabel('处理器：' & RegRead('HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0', 'ProcessorNameString'), 265, 140, 790, 30)
GUICtrlSetFont(-1, 20, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[3] = GUICtrlCreateLabel('系统OS：' & StringReplace(_GUICtrlStatusBar_GetText($hStatus, 1), '系统信息: ', ''), 265, 175, 790, 30)
GUICtrlSetFont(-1, 20, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
Local $sx = StringSplit(RegRead('HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\disk\Enum', '0'), '&\')
$about[4] = GUICtrlCreateLabel('主硬盘：' & StringTrimLeft($sx[4], 5), 265, 210, 790, 30)
GUICtrlSetFont(-1, 22, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[5] = GUICtrlCreateLabel('软件盘：' & Round(DriveSpaceFree($rjPan) / 1024, 2) & 'GB/' & Round(DriveSpaceTotal($rjPan) / 1024, 2) & 'GB', 265, 245, 790, 30)
GUICtrlSetFont(-1, 22, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[6] = GUICtrlCreateLabel('版本号：' & $ver1 & $ver2 & ' / ' & $ver3 & ' / By稻花香', 265, 280, 790, 30)
GUICtrlSetFont(-1, 22, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
If FileReadLine($2html) <> '' Then
	$about[7] = GUICtrlCreateLabel('VHD目录：' & FileReadLine($2html), 265, 315, 790, 30)
	GUICtrlSetFont(-1, 22, 700, 2)
	GUICtrlSetState(-1, $GUI_HIDE)
EndIf
$about[8] = GUICtrlCreateButton('检查更新', 920, 590, 120, 30)
GUICtrlSetState(-1, $GUI_HIDE)
GUIDelete($Form_WLCM)
FadeOut($Form, 1000)
GUISetState(@SW_SHOW, $Form)
GUISetState(@SW_SHOW, $LeftICO[1])
GUISetState(@SW_SHOW, $LeftICO[2])
GUISetState(@SW_SHOW, $LeftICO[13])
GUISetState(@SW_SHOW, $LeftICO[14])
While 1
	$msg = GUIGetMsg()
	For $i = 0 To 20
		If $BTN_stfenlei[$i] == $msg Then
			For $j = 0 To 20
				GUISetState(@SW_HIDE, $Form_sft[$j])
			Next
			GUISetState(@SW_SHOW, $Form_sft[$i])
		EndIf
	Next
	For $i = 0 To 2
		If $BTN_findstr[$i] == $msg Then
			For $j = 0 To 2
				GUISetState(@SW_HIDE, $Form_fnd[$j])
			Next
			GUISetState(@SW_SHOW, $Form_fnd[$i])
		EndIf
	Next
	For $i = 0 To 3
		If $BTN_setting[$i] == $msg Then
			For $j = 0 To 3
				GUISetState(@SW_HIDE, $Form_set[$j])
			Next
			If $i <> 0 Then
				GUISetState(@SW_SHOW, $Form_set[$i])
			Else
				For $k = 1 To 8
					GUICtrlSetState($about[$k], $GUI_SHOW)
				Next
			EndIf
		EndIf
	Next
	Switch $msg
		Case -3
			Local $ExitBox = MsgBox(32 + 1 + 256 + 262144, '退出软件工具箱', '确定要退出软件工具箱吗？', 10)
			If $ExitBox = 1 Then _exit($ahIcons, $Form)
		Case $LeftBTN[0]
			For $i = 12 To 3 Step -1
				GUISetState(@SW_HIDE, $LeftICO[$i])
				Sleep(20)
			Next
			GUISetState(@SW_HIDE, $LeftICOBK)
			GUISetState(@SW_HIDE, $LeftICO[0])
			GUISetState(@SW_SHOW, $LeftICO[2])
		Case $LeftBTN[1]
			For $k = 1 To 8
				GUICtrlSetState($about[$k], $GUI_HIDE)
			Next
			For $i = 0 To 2
				GUISetState(@SW_HIDE, $Form_fnd[$i])
				If GUICtrlGetState($BTN_findstr[$i]) = 80 Then GUICtrlSetState($BTN_findstr[$i], $GUI_HIDE)
			Next
			For $i = 0 To 3
				GUISetState(@SW_HIDE, $Form_set[$i])
				If GUICtrlGetState($BTN_setting[$i]) = 80 Then GUICtrlSetState($BTN_setting[$i], $GUI_HIDE)
			Next
			For $i = 0 To 20
				GUICtrlSetState($BTN_stfenlei[$i], $GUI_SHOW)
			Next
		Case $LeftBTN[2]
			GUISetState(@SW_SHOW, $LeftICOBK)
			GUISetState(@SW_HIDE, $LeftICO[2])
			GUISetState(@SW_SHOW, $LeftICO[0])
			For $i = 3 To 12
				GUISetState(@SW_SHOW, $LeftICO[$i])
				Sleep(20)
			Next
		Case $LeftBTN[13]
			For $k = 1 To 8
				GUICtrlSetState($about[$k], $GUI_HIDE)
			Next
			For $i = 0 To 20
				GUISetState(@SW_HIDE, $Form_sft[$i])
				If GUICtrlGetState($BTN_stfenlei[$i]) = 80 Then GUICtrlSetState($BTN_stfenlei[$i], $GUI_HIDE)
			Next
			For $i = 0 To 3
				GUISetState(@SW_HIDE, $Form_set[$i])
				If GUICtrlGetState($BTN_setting[$i]) = 80 Then GUICtrlSetState($BTN_setting[$i], $GUI_HIDE)
			Next
			For $i = 0 To 2
				GUICtrlSetState($BTN_findstr[$i], $GUI_SHOW)
			Next
		Case $LeftBTN[14]
			For $k = 1 To 8
				GUICtrlSetState($about[$k], $GUI_HIDE)
			Next
			For $i = 0 To 20
				GUISetState(@SW_HIDE, $Form_sft[$i])
				If GUICtrlGetState($BTN_stfenlei[$i]) = 80 Then GUICtrlSetState($BTN_stfenlei[$i], $GUI_HIDE)
			Next
			For $i = 0 To 2
				GUISetState(@SW_HIDE, $Form_fnd[$i])
				If GUICtrlGetState($BTN_findstr[$i]) = 80 Then GUICtrlSetState($BTN_findstr[$i], $GUI_HIDE)
			Next
			For $i = 0 To 3
				GUICtrlSetState($BTN_setting[$i], $GUI_SHOW)
			Next
		Case $about[8]
			Run($curl & ' "https://share.weiyun.com/ChLzhLwn" >' & $3html, '', @SW_HIDE)
			Local $bbh_web = StringSplit(FileReadLine($3html, 378), '#')
			If $bbh_web[2] <> $ver1 & $ver2 Then
				If MsgBox(0, '更新提示', '检测到新版本，版本号为：v' & $bbh_web[2] & '，点击确定后开始下载，链接也会复制到剪切板。') = 1 Then
					ClipPut("https://riceflyme.sharepoint.com/:u:/g/EdwkLVXESE1AuGmY_EREo1MB0b1bAIZgByIZ_4wdO211jw?e=Dh5w8j&download=1")
					InetGet('https://riceflyme.sharepoint.com/:u:/g/EdwkLVXESE1AuGmY_EREo1MB0b1bAIZgByIZ_4wdO211jw?e=Dh5w8j&download=1',@ScriptDir&'\稻花香工具箱_v'&$ver1&$ver2&'.exe')
					Run(@ScriptDir&'\稻花香工具箱_v'&$ver1&$ver2&'.exe')
					Exit
				EndIf
			Else
				MsgBox(0, '提示', '你现在使用的是最新版。')
			EndIf
	EndSwitch
WEnd

Func _time()
	_GUICtrlStatusBar_SetText($hStatus, '系统时间:' & _Now() & ' ' & _DateDayOfWeek(@WDAY, 3), 4)
EndFunc   ;==>_time
