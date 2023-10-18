#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\Downloads\Pictures\Camera Roll\一批超漂亮图标\图标\Audiotool.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Global Const $AW_HOR_POSITIVE = 0x00000001
Global Const $AW_HOR_NEGATIVE = 0x00000002
Global Const $AW_VER_POSITIVE = 0x00000004
Global Const $AW_VER_NEGATIVE = 0x00000008
Global Const $AW_CENTER = 0x00000010
Global Const $AW_HIDE = 0x00010000
Global Const $AW_ACTIVATE = 0x00020000
Global Const $AW_SLIDE = 0x00040000
Global Const $AW_BLEND = 0x00080000
Global $ToolTitle = '软件工具箱 By 稻花香', $dllfile[5]
Global $ver1 = '1.10.0.', $ver2 = 23, $ver3 = '2023.10.2' ;版本信息
Global $curl = @ComSpec & ' /c ' & @ScriptDir & '\dhxtool\tools\curl\curl.exe'
Global $aria2 = @ScriptDir & '\dhxtool\tools\aria2c.exe'
Global $1html = @ScriptDir & '\dhxtool\tools\curl\1.html'
Global $2html = @ScriptDir & '\dhxtool\tools\curl\2.html'
Global $3html = @ScriptDir & '\dhxtool\tools\curl\3.html'
Global $LeftICO[15], $LeftBTN[15]
Global $LeftICOName[15] = ['', 'ruanjian', 'zhedie', 'QQ', 'VX', 'Edge', 'Explorer', 'Taskmgr', 'WinTools', 'regedit', 'Word', 'Excel', 'PPT', 'sousuo', 'shezhi']
Global $LeftICOBKCLR[15] = ['', '0x502050', '0x501F56', '0x6E4A72', '0x6C4A71', '0x6A4A70', '0x674A73', '0x644A70', '0x5E4C6F', '0x5A4D71', '0x534E71', '0x4E4E72', '0x4B4F6F', '0x1C2858', '0x1A2A4E']
Global $rjml[13] = ['\ToolBox\Software\Home\', _
		'\ToolBox\Software\Office\', _
		'\ToolBox\Software\weihu\', _
		'', _
		'\ToolBox\Software\Youhua\', _
		'\ToolBox\Software\Active\', _
		'\ToolBox\Software\Suit\', _
		'\ToolBox\Software\Test\', _
		'\ToolBox\Software\USBboot\', _
		'\ToolBox\Software\Network\', _
		'\ToolBox\Software\SYSApp\', _
		'\ToolBox\Software\VideoMix\', _
		'\ToolBox\Software\Game\']
Global $sfenlei[] = ['在线安装', '文字办公', '平面设计', '程序编程', '电脑维护', '系统优化', '激活破解', '光盘光驱', 'Adobe', '网页网站', '其它套装', '硬件测试', '数据管理', '图片工具', '优盘启动', '网络工具', '系统工具', '音乐工具', '视频工具', '游戏娱乐', '系统驱动']
Global $setting[] = ['关于本工具箱', '窗口参数设置', '工具箱参数设置', '软件参数设置']
Global $findstr[] = ['软件搜索', '常用软件', '软件收藏']
Global $flcolor[] = ['0xA042A3', '0xA042A3', '0xA042A3', '0x9E43A3', '0x9E42A5', '0x9C42A4', '0x9A42A6', '0x9644A6', '0x9145A7', '0x8D47AA', '0x8746AA', '0x7F49AB', '0x754BAF', '0x6E4BAF', '0x644EB3', '0x5E50B2', '0x5751B3', '0x5351B4', '0x4C52B2', '0x4A52B4', '0x4A52B4']
Global $stcolor[] = ['0xC852CD', '0xC852CD', '0xC852CD', '0xC652CD', '0xC551CC', '0xC553CD', '0xC153CE', '0xBD53CF', '0xB656D1', '0xB157D2', '0xAA58D6', '0x9D5BD7', '0x935CDB', '0x885EDA', '0x7D63DE', '0x7562DF', '0x6E64DE', '0x6766DE', '0x5F68DF', '0x5C66E1', '0x5C66E1']
Global $BTN_stfenlei[21], $Form_sft[21], $BTN_setting[4], $Form_set[4], $BTN_findstr[3], $Form_fnd[3]
;==================================================================================================
Func _WinAPI_GetProcAddress($hModule, $vName)
	Local $sType = "str"
	If IsNumber($vName) Then $sType = "word" ; if ordinal value passed
	Local $aCall = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", $hModule, $sType, $vName)
	If @error Or Not $aCall[0] Then Return SetError(@error, @extended, 0)

	Return $aCall[0]
EndFunc   ;==>_WinAPI_GetProcAddress
;==================================================================================================
Func _showMenu($ToolTitle, $idContext)
	If WinGetState($ToolTitle) = 15 Then ControlClick($ToolTitle, '', $idContext)
EndFunc   ;==>_showMenu
;==================================================================================================
Func _ScriptRestart($fExit = 1)
	Local $Pid, $__Restart = False
	If Not $__Restart Then
		If @Compiled Then
			$Pid = Run(@ScriptFullPath & ' ' & $CmdLineRaw, @ScriptDir, Default, 1)
		Else
			$Pid = Run(@AutoItExe & ' "' & @ScriptFullPath & '" ' & $CmdLineRaw, @ScriptDir, Default, 1)
		EndIf
		If @error Then
			Return SetError(@error, 0, 0)
		EndIf
		StdinWrite($Pid, @AutoItPID)
	EndIf
	$__Restart = 1
	If $fExit Then
		Sleep(50)
		Exit
	EndIf
	Return 1
EndFunc   ;==>_ScriptRestart
;==================================================================================================
Func FadeOut($hwnd, $Time = 500, $AW_type = $AW_BLEND)
	DllCall('user32.dll', 'int', 'AnimateWindow', 'hwnd', $hwnd, 'int', $Time, 'long', $AW_type)
EndFunc   ;==>FadeOut
;==================================================================================================
Func _flashbutton($left, $top, $kuan, $gao, $0bmp, $1bmp, $2bmp, $3bmp = "")
	Local $bmp_Btn
	Local $bmp_Dll = DllCall("ComCtl32.dll", "hwnd", "ImageList_Create", "int", $kuan, "int", $gao, "int", 8225, "int", 6, "int", 4)
	If $3bmp = "" Then $3bmp = $0bmp
	Dim $bmp_array[6] = [$0bmp, $1bmp, $2bmp, $3bmp, $0bmp, $0bmp]
	For $i = 0 To 3
		If Not FileExists($bmp_array[$i]) Then Return SetError(@error, 0, -1)
	Next
	Local $DllStt = DllStructCreate("int X;int Y")
	Local $DllSttPtrX = DllStructGetPtr($DllStt, "X")
	Local $DllSttPtrY = DllStructGetPtr($DllStt, "Y")
	For $i = 0 To 5
		DllCall("ComCtl32.dll", "int", "ImageList_GetIconSize", "hwnd", $bmp_Dll[0], "ptr", $DllSttPtrX, "ptr", $DllSttPtrY)
		Local $DllSttDataX = DllStructGetData($DllStt, "X")
		Local $DllSttDataY = DllStructGetData($DllStt, "Y")
		Local $bmp_Dll2 = DllCall("User32.dll", "hwnd", "LoadImage", "hwnd", 0, "str", $bmp_array[$i], "int", 0, "int", $DllSttDataX, "int", $DllSttDataY, "int", 16)
		DllCall("ComCtl32.dll", "int", "ImageList_Add", "hwnd", $bmp_Dll[0], "hwnd", $bmp_Dll2[0], "hwnd", 0)
		DllCall("GDI32.dll", "int", "DeleteObject", "int", $bmp_Dll2[0])
	Next
	$bmp_Btn = GUICtrlCreateButton("", $left, $top, $kuan, $gao, 128)
	If @error Then Return SetError(@error, 0, $bmp_Btn)
	Local $DllStti = DllStructCreate("hwnd ImageList;int Left;int Top;int Right;int Bottom;uint Align")
	DllStructSetData($DllStti, "ImageList", $bmp_Dll[0])
	DllStructSetData($DllStti, "Left", 1)
	DllStructSetData($DllStti, "Top", 1)
	DllStructSetData($DllStti, "Right", 1)
	DllStructSetData($DllStti, "Bottom", 1)
	DllStructSetData($DllStti, "Align", 4)
	DllCall("user32.dll", "lparam", "SendMessage", "hwnd", GUICtrlGetHandle($bmp_Btn), "int", 5634, "wparam", 0, "lparam", DllStructGetPtr($DllStti))
	If @error Then Return SetError(@error, @extended, "")
	Return $bmp_Btn
EndFunc   ;==>_flashbutton
;==================================================================================================
Func ShowMenu($hwnd, $idCtrl, $idContext)
	Local $aPos, $x, $y
	Local $hMenu = GUICtrlGetHandle($idContext)
	$aPos = ControlGetPos($hwnd, "", $idCtrl)
	$x = $aPos[0]
	$y = $aPos[1] + $aPos[3]
	Local $tPoint = DllStructCreate("int;int")
	DllStructSetData($tPoint, 1, $x)
	DllStructSetData($tPoint, 2, $y)
	DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hwnd, "struct*", $tPoint)
	$x = DllStructGetData($tPoint, 1)
	$y = DllStructGetData($tPoint, 2)
	$tPoint = 0
	DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hwnd, "ptr", 0)
EndFunc   ;==>ShowMenu
;==================================================================================================
Func _about($ver1, $ver2, $ver3)
	;MsgBox(262144 + 64, "关于：", "                 稻花香软件工具箱 v" & $ver1 & $ver2 & @CRLF & "                      By 稻花香 " & $ver3 & @CRLF & '     抖音/快手/QQ/微信 搜索 RiceFlyme 进 VIP群获取', 10)
EndFunc   ;==>_about
;==================================================================================================
Func _waterctrl_startup($bmp_file, $hwnd, $start = "", $waterradius = 3, $waterheight = 50, $left = 0, $top = 0)
	Local $sdll_filename, $bmp_pic, $pos, $_pos[5]
	$sdll_filename = @ScriptDir & "\dhxtool\skin\water.dll"
	$dllfile[0] = DllOpen($sdll_filename)
	If $dllfile[0] = -1 Then
		Return SetError(3, 0, "")
		MsgBox(0, 0, 1)
	EndIf
	$dllfile[1] = $sdll_filename
	$bmp_pic = DllCall("user32.dll", "handle", "LoadImageW", "handle", 0, "wstr", $bmp_file, "uint", 0, "int", 0, "int", 0, "uint", 8208)
	$dllfile[2] = $bmp_pic[0]
	DllCall($dllfile[0], "bool", "enablewater", "HWND", $hwnd, "int", $left, "int", $top, "HWND", $dllfile[2], "int", $waterradius, "int", $waterheight)
	$pos = StringSplit($start, ",;|")
	If Not @error And $pos[0] >= 2 Then
		$_pos[1] = $pos[1]
		$_pos[2] = $pos[2]
		If $pos[0] = 2 Then
			$_pos[3] = 10
			$_pos[4] = 500
		ElseIf $pos[0] = 3 Then
			$_pos[3] = $pos[3]
			$_pos[4] = 500
		ElseIf $pos[0] = 4 Then
			$_pos[3] = $pos[3]
			$_pos[4] = $pos[4]
		EndIf
		DllCall($dllfile[0], "bool", "waterblob", "int", $_pos[1], "int", $_pos[2], "int", $_pos[3], "int", $_pos[4])
	Else
		MsgBox(0, 0, 2)
	EndIf
	Local $csize = ControlGetPos($hwnd, "", "#327701")
	Local $wsize = WinGetPos($hwnd)
	$dllfile[3] = $csize[2]
	If $wsize[2] < $csize[2] Then $dllfile[3] = $wsize[2]
	$dllfile[4] = $csize[3]
	If $wsize[3] < $csize[3] Then $dllfile[4] = $wsize[3]
	Return $dllfile
	MsgBox(0, 0, 3)
EndFunc   ;==>_waterctrl_startup
Func _WaterCtrl_Shutdown()
	DllCall($dllfile[0], 'bool', 'flattenwater')
	DllCall($dllfile[0], 'bool', 'disablewater')
	DllClose($dllfile[0])
	FileDelete($dllfile[1])
EndFunc   ;==>_WaterCtrl_Shutdown
;==================================================================================================
Func _WinAPI_ExtractIconEx($sFilePath, $iIndex, $paLarge, $paSmall, $iIcons)
	Local $aCall = DllCall("shell32.dll", "uint", "ExtractIconExW", "wstr", $sFilePath, "int", $iIndex, "struct*", $paLarge, _
			"struct*", $paSmall, "uint", $iIcons)
	If @error Then Return SetError(@error, @extended, 0)

	Return $aCall[0]
EndFunc   ;==>_WinAPI_ExtractIconEx
Func _WinAPI_LoadShell32Icon($iIconID)
	Local $tIcons = DllStructCreate("ptr Data")
	Local $iIcons = _WinAPI_ExtractIconEx("shell32.dll", $iIconID, 0, $tIcons, 1)
	If @error Then Return SetError(@error, @extended, 0)
	If $iIcons <= 0 Then Return SetError(10, 0, 0)

	Return DllStructGetData($tIcons, "Data")
EndFunc   ;==>_WinAPI_LoadShell32Icon
Func _WinAPI_DestroyIcon($hIcon)
	Local $aCall = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $hIcon)
	If @error Then Return SetError(@error, @extended, False)

	Return $aCall[0]
EndFunc   ;==>_WinAPI_DestroyIcon
Func _exit($ahIcons, $Form)
	_WaterCtrl_Shutdown()
	_WinAPI_DestroyIcon($ahIcons)
	GUIDelete($Form)
	Exit
EndFunc   ;==>_exit
;==================================================================================================
Func _NetStatus($1html, $curl, $hStatus)
	If FileExists($1html) Then FileDelete($1html) ;网络状态
	RunWait($curl & ' "https://riceflyme.sharepoint.com/" > ' & $1html, "", @SW_HIDE)
	$sever = FileRead($1html)
	$severlink = StringInStr($sever, 'curl: (6) Could not resolve host:')
	If $sever = '' Or $severlink <> 0 Then
		$Sname = '服务器中断'
		$Sicon = 244
	Else
		$Sname = '准备就绪'
		$Sicon = 277
	EndIf
	_GUICtrlStatusBar_SetText($hStatus, $Sname)
	$ahIcons = _WinAPI_LoadShell32Icon($Sicon)
	_GUICtrlStatusBar_SetIcon($hStatus, 0, $ahIcons)
EndFunc   ;==>_NetStatus

Func OSinfo()
	Local $hModNtdll, $getWinName, $aResult
	$hModNtdll = _WinAPI_LoadLibrary('winbrand.dll') ;系统版本信息
	$getWinName = _WinAPI_GetProcAddress($hModNtdll, "BrandingFormatString")
	$aResult = DllCallAddress('wstr', $getWinName, "wstr", "%WINDOWS_LONG%")
	_WinAPI_FreeLibrary($hModNtdll)
	Return $aResult[0]
EndFunc   ;==>OSinfo

Func OSHuanJing($2html, $curl)
	Local $vhd2 = RunWait(@ComSpec & ' /c "' & @ScriptDir & '\dhxtool\tools\ChkMbrPbr_' & @OSArch & '.exe -ChkVhdFile C: > ' & $2html, "", @SW_HIDE, 2)
	$sever = FileRead($2html)
	$severlink = StringInStr($sever, 'VHD')
	If $severlink <> 0 Then
		Return 'VHD装载'
	Else
		If @HomeDrive = 'X:' Then
			Return 'PE'
		Else
			;Local $portablesys = RegRead('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control', 'PortableOperatingSystem')
			If DriveGetType('C:', 3) = 'USB' Then
				Return 'WTG'
			Else
				Return '桌面'
			EndIf
		EndIf
	EndIf
EndFunc   ;==>OSHuanJing

Func IsGPT()
	Local $output = Run(@ComSpec & ' /c echo list disk | diskpart', '', @SW_HIDE, 2)
	Local $isGPT = False
	While 1
		Local $line = StdoutRead($output)
		If @error Then ExitLoop
		If StringInStr($line, "GPT") Then
			$isGPT = True
			Return 'GPT'
			ExitLoop
		EndIf
	WEnd
	If Not $isGPT Then Return 'MBR'
EndFunc   ;==>IsGPT
;==================================================================================================
Func _IsUEFIBoot()
	Local Const $ERROR_INVALID_FUNCTION = 0x1
	Local $hDLL = DllOpen("Kernel32.dll")
	If @OSBuild > 8000 Then
		Local $aCall = DllCall($hDLL, "int", "GetFirmwareType", "int*", 0)
		DllClose($hDLL)
		If Not @error And $aCall[0] Then
			Switch $aCall[1] ; 1 - bios 2- uefi 3-unknown
				Case 2
					Return 'UEFI'
				Case Else
					Return 'Legacy'
			EndSwitch
		EndIf
		Return 'Legacy'
	Else
		DllCall($hDLL, "dword", "GetFirmwareEnvironmentVariableW", "wstr", "", "wstr", '{00000000-0000-0000-0000-000000000000}', "wstr", Null, "dword", 0)
		DllClose($hDLL)
		If _WinAPI_GetLastError() = $ERROR_INVALID_FUNCTION Then
			Return 'Legacy'
		Else
			Return 'UEFI'
		EndIf
	EndIf
EndFunc   ;==>_IsUEFIBoot
;==================================================================================================
Func _Extract_element($array, $start = 1, $step = 1, $compute = 1, $attach = @CRLF)
	Local $ys = Floor((UBound($array) - $start) / $step), $new
	If $ys = 0 Then
		SetError(-1)
		Return ''
	Else
		If $compute = 1 Then
			For $i = 1 To $ys
				$new &= $array[$start + $i * $step - 1] & $attach
			Next
			$new = StringTrimRight($new, StringLen($attach)) ;需要最后一个元素的附加内容请注释此行代码
			Return $new
		ElseIf $compute = 2 Then
			For $i = 1 To $ys
				$new += $array[$start + $i * $step - 1]
			Next
			Return $new
		EndIf
	EndIf
EndFunc   ;==>_Extract_element
;==================================================================================================
Func CreatMultiBTN($Text, $left, $top, $kuan, $gao, $hangju, $lieju, $hangnum, $sumnum, $sType = -1, $dlcstype = -1, $MenuArray = '', $FontSize = '', $BTNBKColor = '', $BTNColor = '')
	Global $Button[$sumnum + 1][UBound($MenuArray) + 1]
	For $i = 1 To $sumnum
		$Button[$i][0] = GUICtrlCreateButton($Text & $i, $left + $lieju * (Floor(($i - 1) / $hangnum) = 0 ? ($i - 1) : ($i - 1) - Floor(($i - 1) / $hangnum) * $hangnum), _
				$top + $hangju * Floor(($i - 1) / $hangnum), $kuan, $gao, $sType, $dlcstype)
		If $FontSize <> '' Then GUICtrlSetFont(-1, $FontSize)
		If $MenuArray <> '' Then
			$Button[$i][1] = GUICtrlCreateContextMenu($Button[$i][0])
			For $j = 0 To UBound($MenuArray) - 1
				$Button[$i][$j + 1] = GUICtrlCreateMenuItem($MenuArray[$j], $Button[$i][1])
			Next
		EndIf
		If $BTNBKColor <> '' Then GUICtrlSetBkColor($Button[$i][0], $BTNBKColor)
		If $BTNColor <> '' Then GUICtrlSetColor($Button[$i][0], $BTNColor)
	Next
	Return $Button
EndFunc   ;==>CreatMultiBTN
;==================================================================================================
Func _Pan($Dir = "\ToolBox\Software\Adobeall-\", $LimitFree = 8)
	Local $pan[1]
	For $i = 65 To 90
		If FileExists(Chr($i) & ':' & $Dir) Then
			ReDim $pan[UBound($pan) + 1]
			$pan[UBound($pan) - 1] = Chr($i) & ':'
			$pan[0] = UBound($pan)
		EndIf
	Next
	If UBound($pan) = 1 Then
		Local $a_Drive = DriveGetDrive('ALL')
		If @error Then
			Return '' ;未发现可用的驱动器！
		Else
			Local $a_DriveInfo[$a_Drive[0] + 1], $Form_pan, $panIpt, $panBtn, $Drive, $DriveInfo, $DriveFree[$a_Drive[0] + 1]
			For $i = 1 To $a_Drive[0]
				$Drive = $a_Drive[$i]
				$Drive = StringUpper($Drive)
				If DriveGetType($Drive, 2) = 'SSD' Then
					$a_DriveInfo[$i] = $Drive & '   SSD固态'
				Else
					$a_DriveInfo[$i] = $Drive & '    非SSD '
				EndIf
				$a_DriveInfo[$i] &= '   总线:' & DriveGetType($Drive, 3)
				$a_DriveInfo[$i] = StringReplace($a_DriveInfo[$i], 'FileBackedVirtual', 'VHD装载')
				$DriveFree[$i] = Round(DriveSpaceFree($Drive) / 1024, 2)
				$a_DriveInfo[$i] &= '   可用：' & $DriveFree[$i] & 'GB'
			Next
			For $i = 1 To $a_Drive[0]
				If $DriveFree[$i] > $LimitFree Then $DriveInfo &= $a_DriveInfo[$i] & '|'
			Next
			$DriveInfo = StringTrimRight($DriveInfo, 1)
			If $DriveInfo = '' Then
				Return '' ;不存在剩余空间大于' & $LimitFree & 'G的驱动器！
			Else
				$Form_pan = GUICreate('你是第一次运行软件工具箱', 400, 250)
				GUICtrlCreateLabel('   请选择软件存放的分区：', 30, 12, 200)
				GUICtrlSetFont(-1, 12, 400, 2, '微软雅黑')
				$panIpt = GUICtrlCreateCombo('', 19, 35, 350, 20)
				GUICtrlSetFont(-1, 11, 400, 0, '新宋体')
				GUICtrlSetData($panIpt, $DriveInfo, $a_DriveInfo[1])
				$panBtn = GUICtrlCreateButton('确定你的选择', 120, 150, 150, 40, BitOR(0x0001, 0x8000))
				GUICtrlSetFont(-1, 11)
				GUISetState(@SW_SHOW, $Form_pan)
				While 1
					If GUIGetMsg() = $panBtn Then
						$pan = GUICtrlRead($panIpt)
						$pan = StringLeft($pan, 2)
						GUIDelete($Form_pan)
						Return $pan
						ExitLoop
					EndIf
					If GUIGetMsg() = -3 Then
						GUIDelete($Form_pan)
						Exit
					EndIf
				WEnd
			EndIf
		EndIf
	ElseIf UBound($pan) > 2 Then
		Local $a_DriveInfo[$pan[0]], $Form_pan, $panIpt, $panBtn, $Drive, $DriveInfo, $DriveFree[$pan[0]]
		For $i = 1 To $pan[0] - 1
			$Drive = $pan[$i]
			If DriveGetType($Drive, 2) = 'SSD' Then
				$a_DriveInfo[$i] = $Drive & '   SSD固态'
			Else
				$a_DriveInfo[$i] = $Drive & '    非SSD '
			EndIf
			$a_DriveInfo[$i] &= '   总线:' & DriveGetType($Drive, 3)
			$DriveFree[$i] = Round(DriveSpaceFree($Drive) / 1024, 2)
			$a_DriveInfo[$i] &= '   可用：' & $DriveFree[$i] & 'GB'
		Next
		For $i = 1 To $pan[0] - 1
			$DriveInfo &= $a_DriveInfo[$i] & '|'
		Next
		$DriveInfo = StringTrimRight($DriveInfo, 1)
		$Form_pan = GUICreate('你电脑上有多个存放软件工具箱的分区', 400, 250)
		GUICtrlCreateLabel('   请确认存放软件的分区：', 30, 12, 200)
		GUICtrlSetFont(-1, 12, 400, 2, '微软雅黑')
		$panIpt = GUICtrlCreateCombo('', 19, 35, 350, 20)
		GUICtrlSetFont(-1, 11, 400, 0, '新宋体')
		GUICtrlSetData($panIpt, $DriveInfo, $a_DriveInfo[1])
		$panBtn = GUICtrlCreateButton('确定你的选择', 120, 150, 150, 40, BitOR(0x0001, 0x8000))
		GUICtrlSetFont(-1, 11)
		GUISetState(@SW_SHOW, $Form_pan)
		While 1
			If GUIGetMsg() = $panBtn Then
				$pan = GUICtrlRead($panIpt)
				$pan = StringLeft($pan, 2)
				GUIDelete($Form_pan)
				Return $pan
				ExitLoop
			EndIf
			If GUIGetMsg() = -3 Then
				GUIDelete($Form_pan)
				Exit
			EndIf
		WEnd
	Else
		Return $pan[1]
	EndIf
EndFunc   ;==>_Pan
