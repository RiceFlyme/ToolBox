#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\Downloads\Pictures\Camera Roll\һ����Ư��ͼ��\ͼ��\Audiotool.ico
#AutoIt3Wrapper_Outfile=�����㹤����_v1.10.0.22.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=�����㹤����
#AutoIt3Wrapper_Res_Description=�����㹤����
#AutoIt3Wrapper_Res_Fileversion=1.10.0.23
#AutoIt3Wrapper_Res_ProductName=�����㹤����_v1.10.0.23
#AutoIt3Wrapper_Res_ProductVersion=1.10.0.23
#AutoIt3Wrapper_Res_CompanyName=�����㶨�Ƴ�Ʒ
#AutoIt3Wrapper_Res_LegalCopyright=Copyright? 2021-2023 RiceFlyme All rights reserved
#AutoIt3Wrapper_Res_LegalTradeMarks=RiceFlyme
#AutoIt3Wrapper_Res_Language=2052
#AutoIt3Wrapper_Res_Field=InternalName|�����㹤����_v1.10.0.23
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Majia_Mode=0|
#include <function.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <array.au3>
#include <GuiStatusBar.au3>
#include <Date.au3>
If UBound(ProcessList(@ScriptName)) > 2 Then ;��ֹ�ظ�����
	MsgBox(48, '����', '�벻Ҫ�ظ�����')
	Exit
EndIf

FileChangeDir(@ScriptDir) ;�е��ű�Ŀ¼����ֹ������ʱ�ı���
DirCreate('dhxtool\config\')
DirCreate('dhxtool\skin\')
DirCreate('dhxtool\tools\curl\')
DirCreate('dhxtool\icon\Form\')
FileInstall('config\config\form.ini', 'dhxtool\config\')
FileInstall('config\skin\��ӭ����.jpg', 'dhxtool\skin\')
FileInstall('config\skin\��ʾ����.jpg', 'dhxtool\skin\')
FileInstall('config\skin\�����ڱ���.jpg', 'dhxtool\skin\')
FileInstall('config\skin\ˮ��.bmp', 'dhxtool\skin\')
FileInstall('config\tools\water.dll', 'dhxtool\skin\')
FileInstall('config\icon\Form\ruanjian.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\shezhi.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\sousuo.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\zhankai.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\zhedie.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\Edge.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\EXCEL.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\Explorer.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\PPT.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\QQ.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\regedit.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\Taskmgr.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\VX.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\WinTools.ico', 'dhxtool\icon\Form\')
FileInstall('config\icon\Form\Word.ico', 'dhxtool\icon\Form\')
FileInstall("config\tools\curl\curl.exe", 'dhxtool\tools\curl\')
FileInstall("config\tools\curl\curl-ca-bundle.crt", 'dhxtool\tools\curl\')
FileInstall("config\tools\curl\libcurl.def", 'dhxtool\tools\curl\')
FileInstall("config\tools\curl\libcurl.dll", 'dhxtool\tools\curl\')
FileInstall("config\tools\aria2c.exe", 'dhxtool\tools\')
FileInstall("config\tools\ChkMbrPbr_x64.exe", 'dhxtool\tools\')
FileInstall("config\tools\ChkMbrPbr_x86.exe", 'dhxtool\tools\')
Global $rjPan = _Pan() ;��ȡ�������̷����������ͷ������ļ�

If IniRead('dhxtool\config\form.ini', '�޶��汾', 'Ver', '') <> $ver2 Then
	DirRemove('dhxtool', 1)
	_ScriptRestart()
EndIf

Global $Form_WLCM = GUICreate('', 760, 320, -1, -1, $WS_POPUP, $WS_EX_LAYERED) ;��ӭ����
GUICtrlCreatePic('dhxtool\skin\��ӭ����.jpg', 0, 0, 760, 320)
GUICtrlSetState(-1, $GUI_DISABLE)
Global $TipData = GUICtrlCreateLabel('����������������������Ե�...', 180, 210, 355, 25)
GUICtrlSetFont(-1, 15, 700, 2, '���Ĳ���')
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, 0x025CBC)
GUISetState(@SW_SHOW, $Form_WLCM)

Global $Form = GUICreate($ToolTitle, 1060, 650, -1, -1) ;������
GUICtrlCreatePic("", 0, 0, 1060, 650, -1, 1048576)
GUICtrlSetImage(-1, @ScriptDir & "\dhxtool\skin\�����ڱ���.jpg")
GUICtrlSetState(-1, $GUI_DISABLE) ;��ֹ�ڴ������϶�
_WaterCtrl_Startup(@ScriptDir & "\dhxtool\skin\ˮ��.bmp", $Form, Random(0, 800) & "," & Random(0, 100), Random(3, 8), 50, 260, 0)

$LeftICO[0] = GUICreate("", 37, 37, 12, 90, $WS_POPUP, $WS_EX_MDICHILD, $Form)
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

Global $ahIcons, $vPartEdge[6] = [100, 475, 600, 742, 950, 1060] ;����״̬��
Global $hStatus = _GUICtrlStatusBar_Create($Form, -1, "", $SBARS_TOOLTIPS)
_GUICtrlStatusBar_SetParts($hStatus, $vPartEdge)
_NetStatus($1html, $curl, $hStatus) ;����״̬
If @OSBuild > 10000 Then
	_GUICtrlStatusBar_SetText($hStatus, 'ϵͳ��Ϣ: ' & OSinfo() & ' ' & @OSArch & ' ' & RegRead('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'DisplayVersion') & '-' & @OSBuild & '.' & RegRead('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'UBR'), 1)
Else
	Local $bbh = StringSplit(FileGetVersion(@WindowsDir & '\explorer.exe', 'FileVersion'), '.(')
	_GUICtrlStatusBar_SetText($hStatus, 'ϵͳ��Ϣ: ' & OSinfo() & ' ' & @OSArch & ' ' & $bbh[3] & '.' & $bbh[4], 1)
EndIf
_GUICtrlStatusBar_SetText($hStatus, 'ϵͳ����: ' & OSHuanJing($2html, $curl), 2)
_GUICtrlStatusBar_SetText($hStatus, '����ģʽ:' & IsGPT() & ' + ' & _IsUEFIBoot(), 3)
AdlibRegister("_time", 1000) ;��ǰϵͳʱ��
_GUICtrlStatusBar_SetText($hStatus, '�汾�ţ�' & $ver1 & $ver2, 5)

For $i = 0 To 20
	$BTN_stfenlei[$i] = GUICtrlCreateButton($sfenlei[$i], 60, $i * 30, 200, 29)
	GUICtrlSetColor(-1, '0xFFFFFF')
	GUICtrlSetBkColor(-1, $flcolor[$i])
	$Form_sft[$i] = GUICreate("", 800, 530, 260, 100, $WS_POPUP, $WS_EX_MDICHILD, $Form)
	GUISetBkColor($stcolor[$i])
	GUICtrlCreateLabel($sfenlei[$i], 295, 250, 210, 30)
	GUICtrlSetFont(-1, 22, 700, 2)
	GUISwitch($Form)
Next
For $i = 0 To 2
	$BTN_findstr[$i] = GUICtrlCreateButton($findstr[$i], 60, $i * 30, 200, 29)
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
	$BTN_setting[$i] = GUICtrlCreateButton($setting[$i], 60, $i * 30, 200, 29)
	GUICtrlSetColor(-1, '0xFFFFFF')
	GUICtrlSetBkColor(-1, $flcolor[$i])
	GUICtrlSetState(-1, $GUI_HIDE)
	$Form_set[$i] = GUICreate("", 800, 530, 260, 100, $WS_POPUP, $WS_EX_MDICHILD, $Form)
	GUISetBkColor($stcolor[$i])
	GUICtrlCreateLabel($setting[$i], 295, 250, 210, 30)
	GUICtrlSetFont(-1, 22, 700, 2)
	GUISwitch($Form)
Next
Global $about[9]
$about[1] = GUICtrlCreateLabel('                   ����', 265, 105, 790, 30)
GUICtrlSetFont(-1, 20, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[2] = GUICtrlCreateLabel('��������' & RegRead('HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0', 'ProcessorNameString'), 265, 140, 790, 30)
GUICtrlSetFont(-1, 20, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[3] = GUICtrlCreateLabel('ϵͳOS��' & StringReplace(_GUICtrlStatusBar_GetText($hStatus, 1), 'ϵͳ��Ϣ: ', ''), 265, 175, 790, 30)
GUICtrlSetFont(-1, 20, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
Local $sx = StringSplit(RegRead('HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\disk\Enum', '0'), '&\')
$about[4] = GUICtrlCreateLabel('��Ӳ�̣�' & StringTrimLeft($sx[4], 5), 265, 210, 790, 30)
GUICtrlSetFont(-1, 22, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[5] = GUICtrlCreateLabel('����̣�' & Round(DriveSpaceFree($rjPan) / 1024, 2) & 'GB/' & Round(DriveSpaceTotal($rjPan) / 1024, 2) & 'GB', 265, 245, 790, 30)
GUICtrlSetFont(-1, 22, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
$about[6] = GUICtrlCreateLabel('�汾�ţ�' & $ver1 & $ver2 & ' / ' & $ver3 & ' / By������', 265, 280, 790, 30)
GUICtrlSetFont(-1, 22, 700, 2)
GUICtrlSetState(-1, $GUI_HIDE)
If FileReadLine($2html) <> '' Then
	$about[7] = GUICtrlCreateLabel('VHDĿ¼��' & FileReadLine($2html), 265, 315, 790, 30)
	GUICtrlSetFont(-1, 22, 700, 2)
	GUICtrlSetState(-1, $GUI_HIDE)
EndIf
$about[8] = GUICtrlCreateButton('������', 920, 590, 120, 30)
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
			Local $ExitBox = MsgBox(32 + 1 + 256 + 262144, '�˳����������', 'ȷ��Ҫ�˳������������', 10)
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
				If MsgBox(0, '������ʾ', '��⵽�°汾���汾��Ϊ��v' & $bbh_web[2] & '�����ȷ����ʼ���أ�����Ҳ�Ḵ�Ƶ����а塣') = 1 Then
					ClipPut("https://riceflyme.sharepoint.com/:u:/g/EdwkLVXESE1AuGmY_EREo1MB0b1bAIZgByIZ_4wdO211jw?e=Dh5w8j&download=1")
					InetGet('https://riceflyme.sharepoint.com/:u:/g/EdwkLVXESE1AuGmY_EREo1MB0b1bAIZgByIZ_4wdO211jw?e=Dh5w8j&download=1',@ScriptDir&'\�����㹤����_v'&$ver1&$ver2&'.exe')
					Run(@ScriptDir&'\�����㹤����_v'&$ver1&$ver2&'.exe')
					Exit
				EndIf
			Else
				MsgBox(0, '��ʾ', '������ʹ�õ������°档')
			EndIf
	EndSwitch
WEnd

Func _time()
	_GUICtrlStatusBar_SetText($hStatus, 'ϵͳʱ��:' & _Now() & ' ' & _DateDayOfWeek(@WDAY, 3), 4)
EndFunc   ;==>_time
