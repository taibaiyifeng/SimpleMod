; #FUNCTION# ====================================================================================================================
; Name ..........: Rk Debug GUI Control
; Description ...: This file is used for RK Debug GUI functions of debug will be here.
; Author ........: mmajid
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================


Func btnTestHeroBoostOCR()
	SetLog("Test Hero Time OCR", $COLOR_DEBUG)
	;For Debug Purpose set run state to true temporarily
	Local $wasRunState = $g_bRunState
	$g_bRunState = True
	CheckHeroBoost()
	$g_bRunState = $wasRunState
EndFunc   ;==>btnTestHeroBoostOCR

Func btnTestBuilderTimeOCR()
	SetLog("Test Builder Time OCR", $COLOR_DEBUG)

	Local $wasTotalBuilderCount = $g_iTotalBuilderCount
	Local $wasFreeBuilderCount = $g_iFreeBuilderCount
	Local $wasRunState = $g_bRunState
	;For Debug Purpose set these values temporarily
	$g_iTotalBuilderCount=1
	$g_iFreeBuilderCount=0
	$g_bRunState = True

	checkMainScreen()
	getBuilderTime()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_iTotalBuilderCount = $wasTotalBuilderCount
	$g_iFreeBuilderCount = $wasFreeBuilderCount
EndFunc   ;==>btnTestHeroBoostOCR