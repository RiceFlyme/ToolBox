#include-once
#include <File.au3>
#include "DirInstall_pl.au3"
#OnAutoItStartRegister "qkpl" ;注册 AutoIt 启动时调用的函数ok，必须为双引号 ;编译后不会启动AutoIt也就不会执行
;==========================================================================================
; 说明:　包含并装入指定文件夹(可含子文件夹)到编译后的脚本程序中.
; 语法:　_DirInstall("源文件夹"[, "目标路径|是否新建根目录"[, 标志[, "释放函数名"]]])
; 参数:　"源文件夹" - 需要包含并装入的指定文件夹
;　　　　"目标路径|是否新建根目录" - [可选] 目标文件夹。目标路径：默认为 '@TempDir'。注：外面
;　　　　必须带一对引号(包括宏)。是否新建根目录：1 = 新建同源文件夹名目录(默认)；0 = 不新建。
;　　　　标志 - [可选] 1 = 覆盖已存在的文件。0 = 不覆盖已存在的文件(默认)
;　　　　释放函数名 - [可选] 如果需要在触发时才释放文件(比如点击控件)，则需填入一个对应此打包
;　　　　文件夹唯一的函数名(此函数名不能与脚本内的任一函数名重名，打包文件夹不同函数名也不同)
; 注意:　DirInstall_pl.au3 为跟随此udf必须的文件，不能删除，否则会出错。
;　　　　为使 DirInstall_pl.au3 生成正确的打包脚本，编译exe之前需至少先运行一次脚本，如果需要
;　　　　在触发时才释放文件还需先触发一次(只触发一次即可，第二次会提示重名)，触发后并不会复制
;　　　　到目标路径，此功能在编译后才会生效。
; 作者:　Afan -- http://www.autoit.net.cn
;=========================================================================================
Func _DirInstall($Dirl, $mbDir = '@TempDir|1', $fg = 0, $cf = '') 
	If @Compiled = 1 Then 
		If $cf <> '' Then 
			Call($cf) 
		EndIf
		Return
	EndIf
	Global $sfdir 
	Dim $fgqz 
	$fgqz = StringSplit($mbDir, '|')
	If @error = 1 Then 
		If $mbDir = '' Then 
			$mbDir = '@TempDir'
			$sfdir = 1
		ElseIf $mbDir <> '' Then
			$mbDir = $mbDir
			$sfdir = 1
		EndIf
	Else 
		If $fgqz[1] = '' Then $mbDir = '@TempDir' 
		If $fgqz[1] <> '' Then $mbDir = $fgqz[1] 
		If $fgqz[2] = '' Then $sfdir = 1 
		If $fgqz[2] <> '' Then $sfdir = $fgqz[2] 
	EndIf
	If $fg = '' Then $fg = 0 
	Global $scDir = StringRegExp($Dirl, "(.*)\\.+\\?", 3) 
	If @error <> 0 Then 
		$scDir = @ScriptDir
	Else 
		$scDir = $scDir[0]
	EndIf
	If StringRegExp($Dirl, "\\$", 0) = 1 Then $Dirl = StringTrimRight($Dirl, 1) 
	Global $atmp = @ScriptDir & "\DirInstall_pl.au3" 
	If $cf <> '' Then 
		If StringRegExp($cf, '^(\d|\w|_)+$', 0) = 0 Then
			MsgBox(0, '错误', '该参数 "' & $cf & '" 包含非法字符，请返回修改 ')
			Return
		ElseIf StringInStr(FileRead('DirInstall_pl.au3'), 'Func ' & $cf & '()') <> 0 Then
			MsgBox(0, '问题?', '该参数 "' & $cf & '" 已使用过,如所打包的内容不同请返回修改 ')
			Return
		EndIf
		FileWriteLine($atmp, 'Func ' & $cf & '()') 
		Toplau3($Dirl, $mbDir, $fg) 
		FileWriteLine($atmp, 'Endfunc') 
		Return
	EndIf
	Toplau3($Dirl, $mbDir, $fg) 
EndFunc   ;==>_DirInstall

Func Toplau3($Dirl, $mbDir, $fg)
	Dim $xdDir, $scDir, $atmp, $htstr = 'FileInstall("', $sfdir, $xdDirj, $xdDiry
	$search = FileFindFirstFile($Dirl & "\*")
	If $search = -1 Then Return -1
	While 1
		$file = FileFindNextFile($search)
		If @error Then 
			FileClose($search)
			Return
		ElseIf $file = "." Or $file = ".." Then
			ContinueLoop
		ElseIf StringInStr(FileGetAttrib($Dirl & "\" & $file), "D") Then
			Toplau3($Dirl & "\" & $file, $mbDir, $fg)
			ContinueLoop 
		EndIf
		If StringRegExp($Dirl, "\w:.*", 0) = 1 Then 
			$xdDiry = StringTrimLeft(StringReplace($Dirl, $scDir, ''), 1) 
			If $sfdir = 1 Then $xdDir = $xdDiry & '\' 
		Else 
			$xdDiry = StringReplace($Dirl, $scDir, '') 
			If $sfdir = 1 Then $xdDir = $xdDiry & '\' 
		EndIf
		If $sfdir = 0 Then 
			$fgxg = StringSplit($xdDiry, '\') 
			If @error = 1 Then $xdDir = '' 
			If @error <> 1 Then $xdDir = $fgxg[2] & '\' 
		EndIf
		$xdDirj = StringTrimRight($xdDir, 1) 
		If StringInStr($mbDir, '@') = 0 Then 
			If IsDeclared("_" & $xdDiry) = 0 Then 
				If $xdDir = '' Then FileWriteLine($atmp, 'DirCreate("' & $mbDir & '")') 
				If $xdDir <> '' Then FileWriteLine($atmp, 'DirCreate("' & $mbDir & "\" & $xdDirj & '")') 
				Assign("_" & $xdDiry, 0) 
			EndIf 
			FileWriteLine($atmp, $htstr & $Dirl & "\" & $file & '", ' & '"' & $mbDir & "\" & $xdDir & $file & '", ' & $fg & ")")
		Else
			If IsDeclared("_" & $xdDiry) = 0 Then
				If $xdDir = '' Then FileWriteLine($atmp, 'DirCreate( ' & $mbDir & ')')
				If $xdDir <> '' Then FileWriteLine($atmp, 'DirCreate( ' & $mbDir & ' & "\' & $xdDirj & '")')
				Assign("_" & $xdDiry, 0)
			EndIf
			FileWriteLine($atmp, $htstr & $Dirl & "\" & $file & '", ' & $mbDir & ' & "\' & $xdDir & $file & '", ' & $fg & ")")
		EndIf
	WEnd
EndFunc   ;==>Toplau3

Func qkpl()
	Local $atmp = @ScriptDir & "\DirInstall_pl.au3"
	Local $fO = FileOpen($atmp, 2)
	FileClose($fO)
EndFunc   ;==>qkpl