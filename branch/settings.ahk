;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#SingleInstance,Force 
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetKeyDelay,0 
SetWinDelay,0 
SetWorkingDir, %A_ScriptDir%
FileRead, EnterKeys, %A_WorkingDir%\bank\enter.csv
FileRead, TabKeys, %A_WorkingDir%\bank\tab.csv
FileRead, SpaceKeys, %A_WorkingDir%\bank\space.csv
FileList =
Loop, %A_WorkingDir%\replacements\*.txt
{
	FileList = %FileList%%A_LoopFileName%|
}
StringReplace, FileList, FileList, .txt,,All
MsgBox, %FileList%

Goto, Settings

SETTINGS:
Gui, Destroy
;Gui, +Owner -SysMenu ;suppresses taskbar button, always on top, removes minimize/close
Gui, Add, Text,x15 y20, Hotstring:
Gui, Add, ListBox, x13 y35 r20 W100 vChoice gShowString,%FileList%
Gui, Add, Text,x+20 y40, Text:
Gui, Add, Edit, xp y55 r15 W400 vFullText, Enter your replacement text here...
Gui, Add, Text,,Execute with:
Gui, Add, Checkbox, vEnterCbox yp xp+75, Enter
Gui, Add, Checkbox, vTabCbox yp xp+60, Tab
Gui, Add, Checkbox, vSpaceCbox yp xp+60, Space
Gui,Add,Button,w80 GButtonSave yp xp+100,&Save
Gui, Add, Button,w80 default xp-50 yp+80,&OK
Gui, Add, Button,w80 xp+100 GButtonCancel,&Cancel
Gui, Show, W600 H400
return

ShowString:
GuiControlGet,ActiveChoice,,Choice
if ActiveChoice in %EnterKeys%
{
	;MsgBox,Yep
	GuiControl,,EnterCbox,1
}
else
	GuiControl,,EnterCbox,0
if ActiveChoice in %TabKeys%
{
	;MsgBox,Yep
	GuiControl,,TabCbox,1
}
else
	GuiControl,,TabCbox,0
if ActiveChoice in %SpaceKeys%
{
	;MsgBox,Yep
	GuiControl,,SpaceCbox,1
}
else
	GuiControl,,SpaceCbox,0

;MsgBox, Hi
FileRead, Text, %A_WorkingDir%\replacements\%ActiveChoice%.txt
;MsgBox,%ActiveChoice%
GuiControl,,FullText,%Text%
return

ButtonSave:
GuiControlGet,ActiveChoice,,Choice
GuiControlGet,SaveText,,FullText
;MsgBox, %SaveText%
FileDelete, %A_WorkingDir%\replacements\%ActiveChoice%.txt
FileAppend,%SaveText%,%A_WorkingDir%\replacements\%ActiveChoice%.txt
GuiControlGet,ActiveChoice,,Choice
GuiControlGet,EnterCbox,,EnterCbox
GuiControlGet,TabCbox,,TabCbox
GuiControlGet,SpaceCbox,,SpaceCbox
Gosub,SAVE
;;
return

ButtonCancel:
Gui, Destroy
return

ButtonOK:
Gui, Submit
If RString<>
{
	if FullText<>
	{
		IfNotExist, %A_WorkingDir%\replacements\%RString%.txt
		{
			if EnterCbox = 1 
			{
				FileAppend,%Rstring%`,, %A_WorkingDir%\bank\enter.csv
				FileRead, EnterKeys, %A_WorkingDir%\bank\enter.csv
				FileAppend,%FullText%,%A_WorkingDir%\replacements\%Rstring%.txt
			}
			if TabCbox = 1
			{
				FileAppend,%Rstring%`,, %A_WorkingDir%\bank\tab.csv
				FileRead, TabKeys, %A_WorkingDir%\bank\tab.csv
				IfNotExist, %A_WorkingDir%\replacements\%RString%.txt
					FileAppend,%FullText%,%A_WorkingDir%\replacements\%Rstring%.txt
			}
			if SpaceCbox = 1
			{
				FileAppend,%Rstring%`,, %A_WorkingDir%\bank\space.csv
				FileRead, SpaceKeys, %A_WorkingDir%\bank\space.csv
				IfNotExist, %A_WorkingDir%\replacements\%RString%.txt
					FileAppend,%FullText%,%A_WorkingDir%\replacements\%Rstring%.txt
			}
		}
		else
		{
			MsgBox %Rstring% replacment already exists
		}
		;MsgBox You entered text in both
	}
	else
		MsgBox Only replacement
}
return

SAVE:
if EnterCbox = 1
{
	if ActiveChoice in %EnterKeys%
	{
	}
	else
	{
		FileAppend,%ActiveChoice%`,, %A_WorkingDir%\bank\enter.csv
		FileRead, EnterKeys, %A_WorkingDir%\bank\enter.csv
	}
}
else
{
	if ActiveChoice in %EnterKeys%
	{
		StringReplace, EnterKeys, EnterKeys, %ActiveChoice%`,,,All
		FileDelete, %A_WorkingDir%\bank\enter.csv
		FileAppend,%EnterKeys%, %A_WorkingDir%\bank\enter.csv
		FileRead, EnterKeys, %A_WorkingDir%\bank\enter.csv
	}
;	else
;	{
;		FileAppend,%ActiveChoice%`,, %A_WorkingDir%\bank\enter.csv
;		FileRead, EnterKeys, %A_WorkingDir%\bank\enter.csv
;	}
}
if TabCbox = 1
{
	if ActiveChoice in %TabKeys%
	{
	}
	else
	{
		FileAppend,%ActiveChoice%`,, %A_WorkingDir%\bank\tab.csv
		FileRead, TabKeys, %A_WorkingDir%\bank\tab.csv
	}
}
else
{
	if ActiveChoice in %TabKeys%
	{
		StringReplace, TabKeys, TabKeys, %ActiveChoice%`,,,All
		FileDelete, %A_WorkingDir%\bank\tab.csv
		FileAppend,%TabKeys%, %A_WorkingDir%\bank\tab.csv
		FileRead, TabKeys, %A_WorkingDir%\bank\tab.csv
	}
;	else
;	{
;		FileAppend,%ActiveChoice%`,, %A_WorkingDir%\bank\enter.csv
;		FileRead, EnterKeys, %A_WorkingDir%\bank\enter.csv
;	}
}
if SpaceCbox = 1
{
	if ActiveChoice in %SpaceKeys%
	{
	}
	else
	{
		FileAppend,%ActiveChoice%`,, %A_WorkingDir%\bank\space.csv
		FileRead, SpaceKeys, %A_WorkingDir%\bank\space.csv
	}
}
else
{
	if ActiveChoice in %SpaceKeys%
	{
		StringReplace, SpaceKeys, SpaceKeys, %ActiveChoice%`,,,All
		FileDelete, %A_WorkingDir%\bank\space.csv
		FileAppend,%SpaceKeys%, %A_WorkingDir%\bank\space.csv
		FileRead, SpaceKeys, %A_WorkingDir%\bank\space.csv
	}
;	else
;	{
;		FileAppend,%ActiveChoice%`,, %A_WorkingDir%\bank\enter.csv
;		FileRead, EnterKeys, %A_WorkingDir%\bank\enter.csv
;	}
}
return