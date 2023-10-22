#include-once
#include <File.au3>
#include "DirInstall_pl.au3"
#OnAutoItStartRegister "qkpl" ;ע�� AutoIt ����ʱ���õĺ���ok������Ϊ˫���� ;����󲻻�����AutoItҲ�Ͳ���ִ��
;==========================================================================================
; ˵��:��������װ��ָ���ļ���(�ɺ����ļ���)�������Ľű�������.
; �﷨:��_DirInstall("Դ�ļ���"[, "Ŀ��·��|�Ƿ��½���Ŀ¼"[, ��־[, "�ͷź�����"]]])
; ����:��"Դ�ļ���" - ��Ҫ������װ���ָ���ļ���
;��������"Ŀ��·��|�Ƿ��½���Ŀ¼" - [��ѡ] Ŀ���ļ��С�Ŀ��·����Ĭ��Ϊ '@TempDir'��ע������
;�������������һ������(������)���Ƿ��½���Ŀ¼��1 = �½�ͬԴ�ļ�����Ŀ¼(Ĭ��)��0 = ���½���
;����������־ - [��ѡ] 1 = �����Ѵ��ڵ��ļ���0 = �������Ѵ��ڵ��ļ�(Ĭ��)
;���������ͷź����� - [��ѡ] �����Ҫ�ڴ���ʱ���ͷ��ļ�(�������ؼ�)����������һ����Ӧ�˴��
;���������ļ���Ψһ�ĺ�����(�˺�����������ű��ڵ���һ����������������ļ��в�ͬ������Ҳ��ͬ)
; ע��:��DirInstall_pl.au3 Ϊ�����udf������ļ�������ɾ������������
;��������Ϊʹ DirInstall_pl.au3 ������ȷ�Ĵ���ű�������exe֮ǰ������������һ�νű��������Ҫ
;���������ڴ���ʱ���ͷ��ļ������ȴ���һ��(ֻ����һ�μ��ɣ��ڶ��λ���ʾ����)�������󲢲��Ḵ��
;����������Ŀ��·�����˹����ڱ����Ż���Ч��
; ����:��Afan -- http://www.autoit.net.cn
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
			MsgBox(0, '����', '�ò��� "' & $cf & '" �����Ƿ��ַ����뷵���޸� ')
			Return
		ElseIf StringInStr(FileRead('DirInstall_pl.au3'), 'Func ' & $cf & '()') <> 0 Then
			MsgBox(0, '����?', '�ò��� "' & $cf & '" ��ʹ�ù�,������������ݲ�ͬ�뷵���޸� ')
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