; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True: redraws bot window after config was applied, $TypeReadSave = "Read" : Read GUI Values and set Variables. $TypeReadSave = "Save" : Set the GUI Settings with the Variables
; Return values .: NA
; Author ........:
; Modified ......: CodeSlinger69 (01-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func applyConfig($bRedrawAtExit = True, $TypeReadSave = "Read") ;Applies the data from config to the controls in GUI

	Static $iApplyConfigCount = 0
	$iApplyConfigCount += 1
	If $g_bApplyConfigIsActive Then
		SetDebugLog("applyConfig(), already running, exit")
		Return
	EndIf
	$g_bApplyConfigIsActive = True
	SetDebugLog("applyConfig(), call number " & $iApplyConfigCount)

	setMaxDegreeOfParallelism($g_iThreads)
	setProcessingPoolSize($g_iGlobalThreads)

	; Saved window positions
	If $g_bAndroidEmbedded = False Then
		If $g_iFrmBotPosX > -30000 And $g_iFrmBotPosY > -30000 And $g_bFrmBotMinimized = False _
			And $g_iFrmBotPosX <> $g_WIN_POS_DEFAULT And $g_iFrmBotPosY <> $g_WIN_POS_DEFAULT Then WinMove($g_hFrmBot, "", $g_iFrmBotPosX, $g_iFrmBotPosY)
		If $g_iAndroidPosX > -30000 And $g_iAndroidPosY > -30000 And $g_bIsHidden = False _
			And $g_iAndroidPosX <> $g_WIN_POS_DEFAULT And $g_iAndroidPosY <> $g_WIN_POS_DEFAULT Then HideAndroidWindow(False, False, Default, "applyConfig", 0)
	Else
		If $g_iFrmBotDockedPosX > -30000 And $g_iFrmBotDockedPosY > -30000 And $g_bFrmBotMinimized = False _
			And $g_iFrmBotDockedPosX <> $g_WIN_POS_DEFAULT And $g_iFrmBotDockedPosY <> $g_WIN_POS_DEFAULT Then WinMove($g_hFrmBot, "", $g_iFrmBotDockedPosX, $g_iFrmBotDockedPosY)
	EndIf

	If $g_iGuiMode <> 1 Then
		If $g_iGuiMode = 2 Then ; mini mode controls
			Switch $TypeReadSave
				Case "Read"
					GUICtrlSetState($g_hChkBackgroundMode, $g_bChkBackgroundMode = True ? $GUI_CHECKED : $GUI_UNCHECKED)
				Case "Save"
					$g_bChkBackgroundMode = (GUICtrlRead($g_hChkBackgroundMode) = $GUI_CHECKED)
			EndSwitch
		EndIf
		UpdateBotTitle()
		$g_bApplyConfigIsActive = False
		Return
	EndIf

	; Move with redraw disabled causes ghost window in VMWare, so move first then disable redraw
	Local $bWasRdraw = SetRedrawBotWindow(False, Default, Default, Default, "applyConfig")
	; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	; <><><><> Bot / Profile (global settings) <><><><>
	ApplyConfig_Profile($TypeReadSave)
	; <><><><> Bot / Android <><><><>
	ApplyConfig_Android($TypeReadSave)
	; <><><><> Log window <><><><>
	ApplyConfig_600_1($TypeReadSave)
	; <><><><> Village / Misc <><><><>
	ApplyConfig_600_6($TypeReadSave)
	; <><><><> Village / Achievements <><><><>
	ApplyConfig_600_9($TypeReadSave)
	; <><><><> Village / Donate - Request <><><><>
	ApplyConfig_600_11($TypeReadSave)
	; <><><><> Village / Donate - Donate <><><><>
	ApplyConfig_600_12($TypeReadSave)
	; <><><><> Village / Donate - Schedule <><><><>
	ApplyConfig_600_13($TypeReadSave)
	; <><><><> Village / Upgrade - Lab <><><><>
	ApplyConfig_600_14($TypeReadSave)
	; <><><><> Village / Upgrade - Heroes <><><><>
	ApplyConfig_600_15($TypeReadSave)
	; <><><><> Village / Upgrade - Buildings <><><><>
	ApplyConfig_600_16($TypeReadSave)
	; <><><><> Village / Upgrade - Auto Upgrade <><><><>
	ApplyConfig_auto($TypeReadSave)
	; <><><><> Village / Upgrade - Walls <><><><>
	ApplyConfig_600_17($TypeReadSave)
	; <><><><> Village / Notify <><><><>
	ApplyConfig_600_18($TypeReadSave)
	; <><><><> Village / Notify <><><><>
	ApplyConfig_600_19($TypeReadSave)
	; <><><> Attack Plan / Train Army / Boost <><><>
	ApplyConfig_600_22($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Bully <><><><>
	ApplyConfig_600_26($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / Search <><><><>
	ApplyConfig_600_28($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Search <><><><>
	ApplyConfig_600_28_DB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / Search <><><><>
	ApplyConfig_600_28_LB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Search <><><><>
	ApplyConfig_600_28_TS($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / Attack <><><><>
	ApplyConfig_600_29($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack <><><><>
	ApplyConfig_600_29_DB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack <><><><>
	ApplyConfig_600_29_LB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Attack <><><><>
	ApplyConfig_600_29_TS($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / End Battle <><><><>
	ApplyConfig_600_30($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / End Battle <><><><>
	ApplyConfig_600_30_DB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / End Battle <><><><>
	ApplyConfig_600_30_LB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / TH Snipe / End Battle <><><><>
	ApplyConfig_600_30_TS($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Collectors <><><><>
	ApplyConfig_600_31($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / Trophy Settings <><><><>
	ApplyConfig_600_32($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Drop Order Troops <><><><>
	ApplyConfig_600_33($TypeReadSave)
	; <><><><> Bot / Options <><><><>
	ApplyConfig_600_35_1($TypeReadSave)
	; <><><><> Bot / Profile / Switch Account <><><><>
	ApplyConfig_600_35_2($TypeReadSave)
	; <><><> Attack Plan / Train Army / Troops/Spells <><><>
	; Quick train
	ApplyConfig_600_52_1($TypeReadSave)
	; troop/spell levels and counts
	ApplyConfig_600_52_2($TypeReadSave)
	; <><><> Attack Plan / Train Army / Train Order <><><>
	ApplyConfig_600_54($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / SmartZap <><><><>
	ApplyConfig_600_56($TypeReadSave)
	; <><><> Attack Plan / Train Army / Options <><><>
	ApplyConfig_641_1($TypeReadSave)

	; <><><><> Attack Plan / Strategies <><><><>
	; <<< nothing here >>>

	; <><><><> Bot / Profiles <><><><>
	PopulatePresetComboBox()
	MakeSavePresetMessage()
	GUICtrlSetState($g_hLblLoadPresetMessage, $GUI_SHOW)
	GUICtrlSetState($g_hTxtPresetMessage, $GUI_HIDE)
	GUICtrlSetState($g_hBtnGUIPresetLoadConf, $GUI_HIDE)
	GUICtrlSetState($g_hBtnGUIPresetDeleteConf, $GUI_HIDE + $GUI_DISABLE)
	GUICtrlSetState($g_hChkDeleteConf, $GUI_HIDE + $GUI_UNCHECKED)
	GUICtrlSetState($g_hChkDeleteConf, $GUI_HIDE)

	; <><><><> Bot / Stats <><><><>
	; <<< nothing here >>>

	ApplyConfig_RKMod($TypeReadSave)

	; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


	ApplyConfig_Debug($TypeReadSave)

	; Reenabling window redraw - Keep this last....
	If $bRedrawAtExit Then SetRedrawBotWindow($bWasRdraw, Default, Default, Default, "applyConfig")

	$g_bApplyConfigIsActive = False
EndFunc   ;==>applyConfig

Func ApplyConfig_Profile($TypeReadSave)
	; <><><><> Bot / Processor/Threads Advanced <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetData($g_hTxtGlobalActiveBotsAllowed, $g_iGlobalActiveBotsAllowed)
			GUICtrlSetData($g_hTxtGlobalThreads, $g_iGlobalThreads)
		Case "Save"
			$g_iGlobalActiveBotsAllowed = Int(GUICtrlRead($g_hTxtGlobalActiveBotsAllowed))
			If $g_iGlobalActiveBotsAllowed < 1 Then
				$g_iGlobalActiveBotsAllowed = 1 ; ensure that at least one bot can run
			EndIf
			$g_iGlobalThreads = Int(GUICtrlRead($g_hTxtGlobalThreads))
	EndSwitch
EndFunc   ;==>ApplyConfig_Profile

Func ApplyConfig_Android($TypeReadSave)
	; <><><><> Bot / Android <><><><>
	Switch $TypeReadSave
		Case "Read"
			SetCurSelCmbCOCDistributors()
			UpdateBotTitle()
			_GUICtrlComboBox_SetCurSel($g_hCmbAndroidBackgroundMode, $g_iAndroidBackgroundMode)
			GUICtrlSetState($g_hChkAndroidAdbClickDragScript, $g_bAndroidAdbClickDragScript ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAndroidCloseWithBot, $g_bAndroidCloseWithBot ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAndroidRebootHours, $g_iAndroidRebootHours)
			_GUICtrlComboBox_SetCurSel($g_hCmbSuspendAndroid, AndroidSuspendFlagsToIndex($g_iAndroidSuspendModeFlags))
		Case "Save"
			cmbCOCDistributors()
			cmbAndroidBackgroundMode()
			$g_bAndroidAdbClickDragScript = (GUICtrlRead($g_hChkAndroidAdbClickDragScript) = $GUI_CHECKED ? True : False)
			$g_bAndroidCloseWithBot = (GUICtrlRead($g_hChkAndroidCloseWithBot) = $GUI_CHECKED ? True : False)
			$g_iAndroidRebootHours = Int(GUICtrlRead($g_hTxtAndroidRebootHours)) ; Hours are entered
			cmbSuspendAndroid()
	EndSwitch
EndFunc   ;==>ApplyConfig_Android

Func ApplyConfig_Debug($TypeReadSave)
	; <><><><> Bot / Debug <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkDebugSetlog, $g_bDebugSetlog ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugAndroid, $g_bDebugAndroid ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugClick, $g_bDebugClick ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugFunc, ($g_bDebugFuncTime And $g_bDebugFuncCall) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugDisableZoomout, $g_bDebugDisableZoomout ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugDisableVillageCentering, $g_bDebugDisableVillageCentering ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugDeadbaseImage, $g_bDebugDeadBaseImage ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugOCR, $g_bDebugOcr ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugImageSave, $g_bDebugImageSave ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkdebugBuildingPos, $g_bDebugBuildingPos ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkdebugTrain, $g_bDebugSetlogTrain ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugOCRDonate, $g_bDebugOCRdonate ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkdebugAttackCSV, $g_bDebugAttackCSV ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkMakeIMGCSV, $g_bDebugMakeIMGCSV ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDebugSmartZap, $g_bDebugSmartZap ? $GUI_CHECKED : $GUI_UNCHECKED)
			If $g_bDevMode Then
				GUICtrlSetState($g_hChkDebugFunc, $GUI_ENABLE)
				GUICtrlSetState($g_hChkDebugDisableZoomout, $GUI_ENABLE)
				GUICtrlSetState($g_hChkDebugDisableVillageCentering, $GUI_ENABLE)
				GUICtrlSetState($g_hChkDebugDeadbaseImage, $GUI_ENABLE)
				GUICtrlSetState($g_hChkDebugOCR, $GUI_ENABLE)
				GUICtrlSetState($g_hChkDebugImageSave, $GUI_ENABLE)
				GUICtrlSetState($g_hChkdebugBuildingPos, $GUI_ENABLE)
				GUICtrlSetState($g_hChkdebugTrain, $GUI_ENABLE)
				GUICtrlSetState($g_hChkDebugOCRDonate, $GUI_ENABLE)
				GUICtrlSetState($g_hChkdebugAttackCSV, $GUI_ENABLE)
				GUICtrlSetState($g_hChkMakeIMGCSV, $GUI_ENABLE)
				GUICtrlSetState($g_hChkDebugSmartZap, $GUI_ENABLE)
			EndIf
		Case "Save"
			$g_bDebugSetlog = (GUICtrlRead($g_hChkDebugSetlog) = $GUI_CHECKED)
			$g_bDebugAndroid = (GUICtrlRead($g_hChkDebugAndroid) = $GUI_CHECKED)
			$g_bDebugClick = (GUICtrlRead($g_hChkDebugClick) = $GUI_CHECKED)
			If $g_bDevMode Then
				Local $bDebugFunc = (GUICtrlRead($g_hChkDebugFunc) = $GUI_CHECKED)
				$g_bDebugFuncTime = $bDebugFunc
				$g_bDebugFuncCall = $bDebugFunc
				$g_bDebugDisableZoomout = (GUICtrlRead($g_hChkDebugDisableZoomout) = $GUI_CHECKED)
				$g_bDebugDisableVillageCentering = (GUICtrlRead($g_hChkDebugDisableVillageCentering) = $GUI_CHECKED)
				$g_bDebugDeadBaseImage = (GUICtrlRead($g_hChkDebugDeadbaseImage) = $GUI_CHECKED)
				$g_bDebugOcr = (GUICtrlRead($g_hChkDebugOCR) = $GUI_CHECKED)
				$g_bDebugImageSave = (GUICtrlRead($g_hChkDebugImageSave) = $GUI_CHECKED)
				$g_bDebugBuildingPos = (GUICtrlRead($g_hChkdebugBuildingPos) = $GUI_CHECKED)
				$g_bDebugSetlogTrain = (GUICtrlRead($g_hChkdebugTrain) = $GUI_CHECKED)
				$g_bDebugOCRdonate = (GUICtrlRead($g_hChkDebugOCRDonate) = $GUI_CHECKED)
				$g_bDebugAttackCSV = (GUICtrlRead($g_hChkdebugAttackCSV) = $GUI_CHECKED)
				$g_bDebugMakeIMGCSV = (GUICtrlRead($g_hChkMakeIMGCSV) = $GUI_CHECKED)
				$g_bDebugSmartZap = (GUICtrlRead($g_hChkDebugSmartZap) = $GUI_CHECKED)
			EndIf
	EndSwitch
EndFunc   ;==>ApplyConfig_Debug

Func ApplyConfig_600_1($TypeReadSave)
	; <><><><> Log window <><><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbLogDividerOption, $g_iCmbLogDividerOption)
			cmbLog()
			; <><><><> Bottom panel <><><><>
			GUICtrlSetState($g_hChkBackgroundMode, $g_bChkBackgroundMode = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			UpdateChkBackground() ;Applies it to hidden button
		Case "Save"
			$g_iCmbLogDividerOption = _GUICtrlComboBox_GetCurSel($g_hCmbLogDividerOption)
			; <><><><> Bottom panel <><><><>
			$g_bChkBackgroundMode = (GUICtrlRead($g_hChkBackgroundMode) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_1

Func ApplyConfig_600_6($TypeReadSave)
	; <><><><> Village / Misc <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkBotStop, $g_bChkBotStop ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkBotStop()
			_GUICtrlComboBox_SetCurSel($g_hCmbBotCommand, $g_iCmbBotCommand)
			_GUICtrlComboBox_SetCurSel($g_hCmbBotCond, $g_iCmbBotCond)
			_GUICtrlComboBox_SetCurSel($g_hCmbHoursStop, $g_iCmbHoursStop)
			cmbBotCond()
			GUICtrlSetData($g_hTxtRestartGold, $g_iTxtRestartGold)
			GUICtrlSetData($g_hTxtRestartElixir, $g_iTxtRestartElixir)
			GUICtrlSetData($g_hTxtRestartDark, $g_iTxtRestartDark)
			GUICtrlSetState($g_hChkTrap, $g_bChkTrap ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCollect, $g_bChkCollect ? $GUI_CHECKED : $GUI_UNCHECKED)
			ChkCollect()
			GUICtrlSetState($g_hChkCollectCartFirst, $g_bChkCollectCartFirst ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtCollectGold, $g_iTxtCollectGold)
			GUICtrlSetData($g_hTxtCollectElixir, $g_iTxtCollectElixir)
			GUICtrlSetData($g_hTxtCollectDark, $g_iTxtCollectDark)
			GUICtrlSetState($g_hChkTombstones, $g_bChkTombstones ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCleanYard, $g_bChkCleanYard ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkGemsBox, $g_bChkGemsBox ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTreasuryCollect, $g_bChkTreasuryCollect ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkFreeMagicItems, $g_bChkCollectFreeMagicItems ? $GUI_CHECKED : $GUI_UNCHECKED)
			ChkTreasuryCollect()
			GUICtrlSetData($g_hTxtTreasuryGold, $g_iTxtTreasuryGold)
			GUICtrlSetData($g_hTxtTreasuryElixir, $g_iTxtTreasuryElixir)
			GUICtrlSetData($g_hTxtTreasuryDark, $g_iTxtTreasuryDark)

			GUICtrlSetState($g_hChkCollectBuilderBase, $g_bChkCollectBuilderBase ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkStartClockTowerBoost, $g_bChkStartClockTowerBoost ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCTBoostBlderBz, $g_bChkCTBoostBlderBz ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkStartClockTowerBoost()
			GUICtrlSetState($g_hChkBBSuggestedUpgrades, $g_iChkBBSuggestedUpgrades = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkBBSuggestedUpgradesIgnoreGold, $g_iChkBBSuggestedUpgradesIgnoreGold = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkBBSuggestedUpgradesIgnoreElixir, $g_iChkBBSuggestedUpgradesIgnoreElixir = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkBBSuggestedUpgradesIgnoreHall, $g_iChkBBSuggestedUpgradesIgnoreHall = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

			GUICtrlSetState($g_hChkPlacingNewBuildings, $g_iChkPlacingNewBuildings = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

			chkActivateBBSuggestedUpgrades()
			chkActivateBBSuggestedUpgradesGold()
			chkActivateBBSuggestedUpgradesElixir()
			chkPlacingNewBuildings()

			GUICtrlSetState($g_hChkClanGamesAir, $g_bChkClanGamesAir ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesGround, $g_bChkClanGamesGround ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesMisc, $g_bChkClanGamesMisc ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesEnabled, $g_bChkClanGamesEnabled ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGames60, $g_bChkClanGames60 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesPurge, $g_bChkClanGamesPurge ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesStopBeforeReachAndPurge, $g_bChkClanGamesStopBeforeReachAndPurge ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesDebug, $g_bChkClanGamesDebug ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesLoot, $g_bChkClanGamesLoot ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesBattle, $g_bChkClanGamesBattle ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesDestruction, $g_bChkClanGamesDestruction ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesAirTroop, $g_bChkClanGamesAirTroop ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesGroundTroop, $g_bChkClanGamesGroundTroop ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanGamesMiscellaneous, $g_bChkClanGamesMiscellaneous ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hcmbPurgeLimit, $g_iPurgeMax)

			chkActivateClangames()
			chkPurgeLimits()

		Case "Save"
			$g_bChkBotStop = (GUICtrlRead($g_hChkBotStop) = $GUI_CHECKED)
			$g_iCmbBotCommand = _GUICtrlComboBox_GetCurSel($g_hCmbBotCommand)
			$g_iCmbBotCond = _GUICtrlComboBox_GetCurSel($g_hCmbBotCond)
			$g_iCmbHoursStop = _GUICtrlComboBox_GetCurSel($g_hCmbHoursStop)
			$g_iTxtRestartGold = GUICtrlRead($g_hTxtRestartGold)
			$g_iTxtRestartElixir = GUICtrlRead($g_hTxtRestartElixir)
			$g_iTxtRestartDark = GUICtrlRead($g_hTxtRestartDark)
			$g_bChkTrap = (GUICtrlRead($g_hchkTrap) = $GUI_CHECKED)
			$g_bChkCollect = (GUICtrlRead($g_hChkCollect) = $GUI_CHECKED)
			$g_bChkCollectCartFirst = (GUICtrlRead($g_hChkCollectCartFirst) = $GUI_CHECKED)
			$g_iTxtCollectGold = GUICtrlRead($g_hTxtCollectGold)
			$g_iTxtCollectElixir = GUICtrlRead($g_hTxtCollectElixir)
			$g_iTxtCollectDark = GUICtrlRead($g_hTxtCollectDark)
			$g_bChkTombstones = (GUICtrlRead($g_hChkTombstones) = $GUI_CHECKED)
			$g_bChkCleanYard = (GUICtrlRead($g_hChkCleanYard) = $GUI_CHECKED)
			$g_bChkCollectFreeMagicItems = (GUICtrlRead($g_hChkFreeMagicItems) = $GUI_CHECKED)
			$g_bChkGemsBox = (GUICtrlRead($g_hChkGemsBox) = $GUI_CHECKED)
			$g_bChkTreasuryCollect = (GUICtrlRead($g_hChkTreasuryCollect) = $GUI_CHECKED)
			$g_iTxtTreasuryGold = GUICtrlRead($g_hTxtTreasuryGold)
			$g_iTxtTreasuryElixir = GUICtrlRead($g_hTxtTreasuryElixir)
			$g_iTxtTreasuryDark = GUICtrlRead($g_hTxtTreasuryDark)

			$g_bChkCollectBuilderBase = (GUICtrlRead($g_hChkCollectBuilderBase) = $GUI_CHECKED)
			$g_bChkStartClockTowerBoost = (GUICtrlRead($g_hChkStartClockTowerBoost) = $GUI_CHECKED)
			$g_bChkCTBoostBlderBz = (GUICtrlRead($g_hChkCTBoostBlderBz) = $GUI_CHECKED)
			$g_iChkBBSuggestedUpgrades = (GUICtrlRead($g_hChkBBSuggestedUpgrades) = $GUI_CHECKED) ? 1 : 0
			$g_iChkBBSuggestedUpgradesIgnoreGold = (GUICtrlRead($g_hChkBBSuggestedUpgradesIgnoreGold) = $GUI_CHECKED) ? 1 : 0
			$g_iChkBBSuggestedUpgradesIgnoreElixir = (GUICtrlRead($g_hChkBBSuggestedUpgradesIgnoreElixir) = $GUI_CHECKED) ? 1 : 0
			$g_iChkBBSuggestedUpgradesIgnoreHall = (GUICtrlRead($g_hChkBBSuggestedUpgradesIgnoreHall) = $GUI_CHECKED) ? 1 : 0

			$g_iChkPlacingNewBuildings = (GUICtrlRead($g_hChkPlacingNewBuildings) = $GUI_CHECKED) ? 1 : 0

			$g_bChkClanGamesAir = (GUICtrlRead($g_hChkClanGamesAir) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesGround = (GUICtrlRead($g_hChkClanGamesGround) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesMisc = (GUICtrlRead($g_hChkClanGamesMisc) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesEnabled = (GUICtrlRead($g_hChkClanGamesEnabled) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGames60 = (GUICtrlRead($g_hChkClanGames60) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesPurge = (GUICtrlRead($g_hChkClanGamesPurge) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesStopBeforeReachAndPurge = (GUICtrlRead($g_hChkClanGamesStopBeforeReachAndPurge) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesDebug = (GUICtrlRead($g_hChkClanGamesDebug) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesLoot = (GUICtrlRead($g_hChkClanGamesLoot) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesBattle = (GUICtrlRead($g_hChkClanGamesBattle) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesDestruction = (GUICtrlRead($g_hChkClanGamesDestruction) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesAirTroop = (GUICtrlRead($g_hChkClanGamesAirTroop) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesGroundTroop = (GUICtrlRead($g_hChkClanGamesGroundTroop) = $GUI_CHECKED) ? 1 : 0
			$g_bChkClanGamesMiscellaneous = (GUICtrlRead($g_hChkClanGamesMiscellaneous) = $GUI_CHECKED) ? 1 : 0
			$g_iPurgeMax = _GUICtrlComboBox_GetCurSel($g_hcmbPurgeLimit)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_6

Func ApplyConfig_600_9($TypeReadSave)
	; <><><><> Village / Achievements <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkUnbreakable, $g_iUnbrkMode = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtUnbreakable, $g_iUnbrkWait)
			GUICtrlSetData($g_hTxtUnBrkMinGold, $g_iUnbrkMinGold)
			GUICtrlSetData($g_hTxtUnBrkMinElixir, $g_iUnbrkMinElixir)
			GUICtrlSetData($g_hTxtUnBrkMinDark, $g_iUnbrkMinDark)
			GUICtrlSetData($g_hTxtUnBrkMaxGold, $g_iUnbrkMaxGold)
			GUICtrlSetData($g_hTxtUnBrkMaxElixir, $g_iUnbrkMaxElixir)
			GUICtrlSetData($g_hTxtUnBrkMaxDark, $g_iUnbrkMaxDark)
			chkUnbreakable()
		Case "Save"
			$g_iUnbrkMode = GUICtrlRead($g_hChkUnbreakable) = $GUI_CHECKED ? 1 : 0
			$g_iUnbrkWait = GUICtrlRead($g_hTxtUnbreakable)
			$g_iUnbrkMinGold = GUICtrlRead($g_hTxtUnBrkMinGold)
			$g_iUnbrkMinElixir = GUICtrlRead($g_hTxtUnBrkMinElixir)
			$g_iUnbrkMinDark = GUICtrlRead($g_hTxtUnBrkMinDark)
			$g_iUnbrkMaxGold = GUICtrlRead($g_hTxtUnBrkMaxGold)
			$g_iUnbrkMaxElixir = GUICtrlRead($g_hTxtUnBrkMaxElixir)
			$g_iUnbrkMaxDark = GUICtrlRead($g_hTxtUnBrkMaxDark)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_9

Func ApplyConfig_600_11($TypeReadSave)
	; <><><><> Village / Donate - Request <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkRequestTroopsEnable, $g_bRequestTroopsEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			; Request Type - Demen
			GUICtrlSetState($g_hChkRequestType_Troops, $g_abRequestType[0] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkRequestType_Spells, $g_abRequestType[1] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkRequestType_Siege, $g_abRequestType[2] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtRequestCountCCTroop, $g_iRequestCountCCTroop)
			GUICtrlSetData($g_hTxtRequestCountCCSpell, $g_iRequestCountCCSpell)
			_GUICtrlComboBox_SetCurSel($g_hCmbClanCastleSpell, $g_iClanCastleSpellsWaitFirst)
			_GUICtrlComboBox_SetCurSel($g_hCmbClanCastleSpell2, $g_iClanCastleSpellsWaitSecond)
			For $i = 0 To 2
				_GUICtrlComboBox_SetCurSel($g_ahCmbClanCastleTroop[$i] , $g_aiClanCastleTroopWaitType[$i])
				GUICtrlSetData($g_ahTxtClanCastleTroop[$i], $g_aiClanCastleTroopWaitQty[$i])
			Next
			chkRequestCountCC()
			chkRequestCCHours()
			GUICtrlSetData($g_hTxtRequestCC, $g_sRequestTroopsText)
			For $i = 0 To 23
				GUICtrlSetState($g_ahChkRequestCCHours[$i], $g_abRequestCCHours[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			;------------------ADDED By Simple Mod - START------------------
			; Request defense CC (Demen)
          	GUICtrlSetState($g_hChkRequestCCDefense, $g_bRequestCCDefense ? $GUI_CHECKED : $GUI_UNCHECKED)
           	chkRequestDefense()
			GUICtrlSetData($g_hTxtRequestCCDefense, $g_sRequestCCDefenseText)
			_GUICtrlComboBox_SetCurSel($g_hCmbRequestCCDefenseWhen, $g_bRequestCCDefenseWhenPB ? 0 : 1)
            GUICtrlSetData($g_hTxtRequestCCDefenseTime, $g_iRequestDefenseTime)

			; ================================================== Russian Request - by Simple Mod ======================================== ;

			GUICtrlSetState($g_hChkRusLang2, $g_bChkRusLang2 ? $GUI_CHECKED : $GUI_UNCHECKED)
   		    chkRusLang2()
			;------------------ADDED By Simple Mod - END------------------
		Case "Save"
			$g_bRequestTroopsEnable = (GUICtrlRead($g_hChkRequestTroopsEnable) = $GUI_CHECKED)
			$g_sRequestTroopsText = GUICtrlRead($g_hTxtRequestCC)
			; Request Type - Demen
			$g_abRequestType[0] = (GUICtrlRead($g_hChkRequestType_Troops) = $GUI_CHECKED)
			$g_abRequestType[1] = (GUICtrlRead($g_hChkRequestType_Spells) = $GUI_CHECKED)
			$g_abRequestType[2] = (GUICtrlRead($g_hChkRequestType_Siege) = $GUI_CHECKED)
			$g_iRequestCountCCTroop = GUICtrlRead($g_hTxtRequestCountCCTroop)
			$g_iRequestCountCCSpell = GUICtrlRead($g_hTxtRequestCountCCSpell)
			$g_iClanCastleSpellsWaitFirst = _GUICtrlComboBox_GetCurSel($g_hCmbClanCastleSpell)
			$g_iClanCastleSpellsWaitSecond = _GUICtrlComboBox_GetCurSel($g_hCmbClanCastleSpell2)
			For $i = 0 To 2
				$g_aiClanCastleTroopWaitType[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbClanCastleTroop[$i])
				$g_aiClanCastleTroopWaitQty[$i] = GUICtrlRead($g_ahTxtClanCastleTroop[$i])
			Next
			For $i = 0 To 23
				$g_abRequestCCHours[$i] = (GUICtrlRead($g_ahChkRequestCCHours[$i]) = $GUI_CHECKED)
			Next
			;------------------ADDED By Simple Mod - START------------------
			; Request defense CC (Demen)
           		 $g_bRequestCCDefense = (GUICtrlRead($g_hChkRequestCCDefense) = $GUI_CHECKED)
            		$g_sRequestCCDefenseText = GUICtrlRead($g_hTxtRequestCCDefense)
			$g_bRequestCCDefenseWhenPB = (_GUICtrlComboBox_GetCurSel($g_hCmbRequestCCDefenseWhen) = 0)
            		$g_iRequestDefenseTime = GUICtrlRead($g_hTxtRequestCCDefenseTime)

			; ================================================== Russian Request - by Simple Mod ================================= ;

			$g_bChkRusLang2 = (GUICtrlRead($g_hChkRusLang2) = $GUI_CHECKED)
			;------------------ADDED By Simple Mod - END------------------
	EndSwitch
EndFunc   ;==>ApplyConfig_600_11

Func ApplyConfig_600_12($TypeReadSave)
	; <><><><> Village / Donate - Donate <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkDonate, $g_bChkDonate ? $GUI_CHECKED : $GUI_UNCHECKED)
			Doncheck()
			For $i = 0 To $eTroopCount - 1 + $g_iCustomDonateConfigs
				GUICtrlSetState($g_ahChkDonateTroop[$i], $g_abChkDonateTroop[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
				If $g_abChkDonateTroop[$i] Then
					_DonateControls($i)
				Else
					GUICtrlSetBkColor($g_ahLblDonateTroop[$i], $GUI_BKCOLOR_TRANSPARENT)
				EndIf

				If $g_abChkDonateAllTroop[$i] Then
					GUICtrlSetState($g_ahChkDonateAllTroop[$i], $GUI_CHECKED)
					_DonateAllControls($i, True)
				Else
					GUICtrlSetState($g_ahChkDonateAllTroop[$i], $GUI_UNCHECKED)
				EndIf

				GUICtrlSetData($g_ahTxtDonateTroop[$i], $g_asTxtDonateTroop[$i])
				GUICtrlSetData($g_ahTxtBlacklistTroop[$i], $g_asTxtBlacklistTroop[$i])
			Next

			For $i = 0 To $eSpellCount - 1
				If $i <> $eSpellClone Then
					GUICtrlSetState($g_ahChkDonateSpell[$i], $g_abChkDonateSpell[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
					If $g_abChkDonateSpell[$i] Then
						_DonateControlsSpell($i)
					Else
						GUICtrlSetBkColor($g_ahLblDonateSpell[$i], $GUI_BKCOLOR_TRANSPARENT)
					EndIf

					If $g_abChkDonateAllSpell[$i] Then
						GUICtrlSetState($g_ahChkDonateAllSpell[$i], $GUI_CHECKED)
						_DonateAllControlsSpell($i, True)
					Else
						GUICtrlSetState($g_ahChkDonateAllSpell[$i], $GUI_UNCHECKED)
					EndIf
				EndIf

				If $i <> $eSpellClone Then
					GUICtrlSetData($g_ahTxtDonateSpell[$i], $g_asTxtDonateSpell[$i])
					GUICtrlSetData($g_ahTxtBlacklistSpell[$i], $g_asTxtBlacklistSpell[$i])
				EndIf
			Next

			For $i = $eSiegeWallWrecker to $eSiegeMachineCount - 1
				Local $index = $eTroopCount + $g_iCustomDonateConfigs
				GUICtrlSetState($g_ahChkDonateTroop[$index + $i], $g_abChkDonateTroop[$index + $i] ? $GUI_CHECKED : $GUI_UNCHECKED)
				If $g_abChkDonateTroop[$index + $i] Then
					_DonateControls($index + $i)
				Else
					GUICtrlSetBkColor($g_ahLblDonateTroop[$index + $i], $GUI_BKCOLOR_TRANSPARENT)
				EndIf

				GUICtrlSetData($g_ahTxtDonateTroop[$index + $i], $g_asTxtDonateTroop[$index + $i])
				GUICtrlSetData($g_ahTxtBlacklistTroop[$index + $i], $g_asTxtBlacklistTroop[$index + $i])
			Next

			For $i = 0 To 2
				_GUICtrlComboBox_SetCurSel($g_ahCmbDonateCustomA[$i], $g_aiDonateCustomTrpNumA[$i][0])
				GUICtrlSetData($g_ahTxtDonateCustomA[$i], $g_aiDonateCustomTrpNumA[$i][1])
			Next
			cmbDonateCustomA()

			For $i = 0 To 2
				_GUICtrlComboBox_SetCurSel($g_ahCmbDonateCustomB[$i], $g_aiDonateCustomTrpNumB[$i][0])
				GUICtrlSetData($g_ahTxtDonateCustomB[$i], $g_aiDonateCustomTrpNumB[$i][1])
			Next
			cmbDonateCustomB()

			For $i = 0 To 2
				_GUICtrlComboBox_SetCurSel($g_ahCmbDonateCustomC[$i], $g_aiDonateCustomTrpNumC[$i][0])
				GUICtrlSetData($g_ahTxtDonateCustomC[$i], $g_aiDonateCustomTrpNumC[$i][1])
			Next
			cmbDonateCustomC()

			For $i = 0 To 2
				_GUICtrlComboBox_SetCurSel($g_ahCmbDonateCustomD[$i], $g_aiDonateCustomTrpNumD[$i][0])
				GUICtrlSetData($g_ahTxtDonateCustomD[$i], $g_aiDonateCustomTrpNumD[$i][1])
			Next
			cmbDonateCustomD()

			GUICtrlSetState($g_hChkExtraAlphabets, $g_bChkExtraAlphabets ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkExtraChinese, $g_bChkExtraChinese ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkExtraKorean, $g_bChkExtraKorean ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkExtraPersian, $g_bChkExtraPersian ? $GUI_CHECKED : $GUI_UNCHECKED)

			GUICtrlSetData($g_hTxtGeneralBlacklist, $g_sTxtGeneralBlacklist)

		Case "Save"
			$g_bChkDonate = (GUICtrlRead($g_hChkDonate) = $GUI_CHECKED)
			For $i = 0 To $eTroopCount - 1 + $g_iCustomDonateConfigs
				$g_abChkDonateTroop[$i] = (GUICtrlRead($g_ahChkDonateTroop[$i]) = $GUI_CHECKED)
				$g_abChkDonateAllTroop[$i] = (GUICtrlRead($g_ahChkDonateAllTroop[$i]) = $GUI_CHECKED)
				$g_asTxtDonateTroop[$i] = GUICtrlRead($g_ahTxtDonateTroop[$i])
				$g_asTxtBlacklistTroop[$i] = GUICtrlRead($g_ahTxtBlacklistTroop[$i])
			Next

			For $i = 0 To $eSpellCount - 1
				If $i <> $eSpellClone Then
					$g_abChkDonateSpell[$i] = (GUICtrlRead($g_ahChkDonateSpell[$i]) = $GUI_CHECKED)
					$g_abChkDonateAllSpell[$i] = (GUICtrlRead($g_ahChkDonateAllSpell[$i]) = $GUI_CHECKED)
					$g_asTxtDonateSpell[$i] = GUICtrlRead($g_ahTxtDonateSpell[$i])
					$g_asTxtBlacklistSpell[$i] = GUICtrlRead($g_ahTxtBlacklistSpell[$i])
				EndIf
			Next

			For $i = $eSiegeWallWrecker to $eSiegeMachineCount - 1
				Local $index = $eTroopCount + $g_iCustomDonateConfigs
				$g_abChkDonateTroop[$index + $i] = (GUICtrlRead($g_ahChkDonateTroop[$index + $i]) = $GUI_CHECKED)
				$g_asTxtDonateTroop[$index + $i] = GUICtrlRead($g_ahTxtDonateTroop[$index + $i])
				$g_asTxtBlacklistTroop[$index + $i] = GUICtrlRead($g_ahTxtBlacklistTroop[$index + $i])
			Next

			For $i = 0 To 2
				$g_aiDonateCustomTrpNumA[$i][0] = _GUICtrlComboBox_GetCurSel($g_ahCmbDonateCustomA[$i])
				$g_aiDonateCustomTrpNumA[$i][1] = GUICtrlRead($g_ahTxtDonateCustomA[$i])
				$g_aiDonateCustomTrpNumB[$i][0] = _GUICtrlComboBox_GetCurSel($g_ahCmbDonateCustomB[$i])
				$g_aiDonateCustomTrpNumB[$i][1] = GUICtrlRead($g_ahTxtDonateCustomB[$i])
				$g_aiDonateCustomTrpNumC[$i][0] = _GUICtrlComboBox_GetCurSel($g_ahCmbDonateCustomC[$i])
				$g_aiDonateCustomTrpNumC[$i][1] = GUICtrlRead($g_ahTxtDonateCustomC[$i])
				$g_aiDonateCustomTrpNumD[$i][0] = _GUICtrlComboBox_GetCurSel($g_ahCmbDonateCustomD[$i])
				$g_aiDonateCustomTrpNumD[$i][1] = GUICtrlRead($g_ahTxtDonateCustomD[$i])
			Next

			$g_bChkExtraAlphabets = (GUICtrlRead($g_hChkExtraAlphabets) = $GUI_CHECKED)
			$g_bChkExtraChinese = (GUICtrlRead($g_hChkExtraChinese) = $GUI_CHECKED)
			$g_bChkExtraKorean = (GUICtrlRead($g_hChkExtraKorean) = $GUI_CHECKED)
			$g_bChkExtraPersian = (GUICtrlRead($g_hChkExtraPersian) = $GUI_CHECKED)

			$g_sTxtGeneralBlacklist = GUICtrlRead($g_hTxtGeneralBlacklist)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_12

Func ApplyConfig_600_13($TypeReadSave)
	; <><><><> Village / Donate - Schedule <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkDonateHoursEnable, $g_bDonateHoursEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDonateHours()
			For $i = 0 To 23
				GUICtrlSetState($g_ahChkDonateHours[$i], $g_abDonateHours[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			_GUICtrlComboBox_SetCurSel($g_hCmbFilterDonationsCC, $g_iCmbDonateFilter)
			GUICtrlSetState($g_hChkSkipDonateNearFullTroopsEnable, $g_bDonateSkipNearFullEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSkipDonateNearFullTroopsPercentage, $g_iDonateSkipNearFullPercent)
			chkskipDonateNearFulLTroopsEnable()

			GUICtrlSetState($g_hChkUseCCBalanced, $g_bUseCCBalanced = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbCCDonated, $g_iCCDonated - 1)
			_GUICtrlComboBox_SetCurSel($g_hCmbCCReceived, $g_iCCReceived - 1)
			chkBalanceDR()
			; ================================================== GTFO - Added by Simple Mod ======================================== ;

			GUICtrlSetState($g_hChkGTFOClanHop, $g_bChkGTFOClanHop = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkGTFOReturnClan, $g_bChkGTFOReturnClan = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtCyclesGTFO, $g_iTxtCyclesGTFO)
			GUICtrlSetState($g_hChkUseGTFO, $g_bChkUseGTFO = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtMinSaveGTFO_Elixir, $g_iTxtMinSaveGTFO_Elixir)
			GUICtrlSetData($g_hTxtMinSaveGTFO_DE, $g_iTxtMinSaveGTFO_DE)
			GUICtrlSetData($g_hTxtClanID, $g_sTxtClanID)
			ApplyGTFO()

			GUICtrlSetState($g_hChkUseKickOut, $g_bChkUseKickOut = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDonatedCap, $g_iTxtDonatedCap)
			GUICtrlSetData($g_hTxtReceivedCap, $g_iTxtReceivedCap)
			GUICtrlSetState($g_hChkKickOutSpammers, $g_bChkKickOutSpammers = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtKickLimit, $g_iTxtKickLimit)
			ApplyKickOut()

		Case "Save"
			$g_bDonateHoursEnable = (GUICtrlRead($g_hChkDonateHoursEnable) = $GUI_CHECKED)
			For $i = 0 To 23
				$g_abDonateHours[$i] = (GUICtrlRead($g_ahChkDonateHours[$i]) = $GUI_CHECKED)
			Next
			$g_iCmbDonateFilter = _GUICtrlComboBox_GetCurSel($g_hCmbFilterDonationsCC)
			$g_bDonateSkipNearFullEnable = (GUICtrlRead($g_hChkSkipDonateNearFullTroopsEnable) = $GUI_CHECKED)
			$g_iDonateSkipNearFullPercent = Number(GUICtrlRead($g_hTxtSkipDonateNearFullTroopsPercentage))
			$g_bUseCCBalanced = (GUICtrlRead($g_hChkUseCCBalanced) = $GUI_CHECKED)
			$g_iCCDonated = _GUICtrlComboBox_GetCurSel($g_hCmbCCDonated) + 1
			$g_iCCReceived = _GUICtrlComboBox_GetCurSel($g_hCmbCCReceived) + 1
			; ================================================== GTFO - Added by Simple Mod =========================================== ;
			$g_bChkGTFOClanHop = (GUICtrlRead($g_hChkGTFOClanHop) = $GUI_CHECKED)
			$g_bChkGTFOReturnClan = (GUICtrlRead($g_hChkGTFOReturnClan) = $GUI_CHECKED)

			$g_iTxtCyclesGTFO = Number(GUICtrlRead($g_hTxtCyclesGTFO))
			$g_sTxtClanID = GUICtrlRead($g_hTxtClanID)

			$g_bChkUseGTFO = (GUICtrlRead($g_hChkUseGTFO) = $GUI_CHECKED)
			$g_iTxtMinSaveGTFO_Elixir = Number(GUICtrlRead($g_hTxtMinSaveGTFO_Elixir))
			$g_iTxtMinSaveGTFO_DE = Number( GUICtrlRead($g_hTxtMinSaveGTFO_DE))

			$g_bChkUseKickOut = (GUICtrlRead($g_hChkUseKickOut) = $GUI_CHECKED)
			$g_iTxtDonatedCap = Number(GUICtrlRead($g_hTxtDonatedCap))
			$g_iTxtReceivedCap = Number(GUICtrlRead($g_hTxtReceivedCap))
			$g_bChkKickOutSpammers = (GUICtrlRead($g_hChkKickOutSpammers) = $GUI_CHECKED)
			$g_iTxtKickLimit = Number(GUICtrlRead($g_hTxtKickLimit))

	EndSwitch
EndFunc   ;==>ApplyConfig_600_13

Func ApplyConfig_600_14($TypeReadSave)
	; <><><><> Village / Upgrade - Lab <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkAutoLabUpgrades, $g_bAutoLabUpgradeEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
			_GUICtrlSetImage($g_hPicLabUpgrade, $g_sLibIconPath, $g_avLabTroops[$g_iCmbLaboratory][4])
			chkLab()

	EndSwitch
EndFunc   ;==>ApplyConfig_600_14

Func ApplyConfig_600_15($TypeReadSave)
	; <><><><> Village / Upgrade - Heroes <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkUpgradeKing, $g_bUpgradeKingEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUpgradeKing()
			chkDBKingWait()
			chkABKingWait()
			GUICtrlSetState($g_hChkUpgradeQueen, $g_bUpgradeQueenEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUpgradeQueen()
			chkDBQueenWait()
			chkABQueenWait()
			GUICtrlSetState($g_hChkUpgradeWarden, $g_bUpgradeWardenEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUpgradeWarden()
			chkDBWardenWait()
			chkABWardenWait()
			_GUICtrlComboBox_SetCurSel($g_hCmbHeroReservedBuilder, $g_iHeroReservedBuilder)
			cmbHeroReservedBuilder()
		Case "Save"
			$g_bUpgradeKingEnable = (GUICtrlRead($g_hChkUpgradeKing) = $GUI_CHECKED)
			$g_bUpgradeQueenEnable = (GUICtrlRead($g_hChkUpgradeQueen) = $GUI_CHECKED)
			$g_bUpgradeWardenEnable = (GUICtrlRead($g_hChkUpgradeWarden) = $GUI_CHECKED)
			$g_iHeroReservedBuilder = _GUICtrlComboBox_GetCurSel($g_hCmbHeroReservedBuilder)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_15

Func ApplyConfig_600_16($TypeReadSave)
	; <><><><> Village / Upgrade - Buildings <><><><>
	Switch $TypeReadSave
		Case "Read"
			For $iz = 0 To UBound($g_avBuildingUpgrades, 1) - 1 ; Apply the buildings upgrade variable to GUI
				_GUICtrlSetImage($g_hPicUpgradeStatus[$iz], $g_sLibIconPath, $g_aiPicUpgradeStatus[$iz]) ; Set GUI status pic
				If $g_avBuildingUpgrades[$iz][2] > 0 Then
					GUICtrlSetData($g_hTxtUpgradeValue[$iz], _NumberFormat($g_avBuildingUpgrades[$iz][2])) ; Set GUI loot value to match $g_avBuildingUpgrades variable
				Else
					GUICtrlSetData($g_hTxtUpgradeValue[$iz], "") ; Set GUI loot value to blank
				EndIf
				GUICtrlSetData($g_hTxtUpgradeName[$iz], $g_avBuildingUpgrades[$iz][4]) ; Set GUI unit name $g_avBuildingUpgrades variable
				GUICtrlSetData($g_hTxtUpgradeLevel[$iz], $g_avBuildingUpgrades[$iz][5]) ; Set GUI unit level to match $g_avBuildingUpgrades variable
				GUICtrlSetData($g_hTxtUpgradeTime[$iz], StringStripWS($g_avBuildingUpgrades[$iz][6], $STR_STRIPALL)) ; Set GUI upgrade time to match $g_avBuildingUpgrades variable

				Switch $g_avBuildingUpgrades[$iz][3] ;Set GUI Upgrade Type to match $g_avBuildingUpgrades variable
					Case "Gold"
						_GUICtrlSetImage($g_hPicUpgradeType[$iz], $g_sLibIconPath, $eIcnGold)
					Case "Elixir"
						_GUICtrlSetImage($g_hPicUpgradeType[$iz], $g_sLibIconPath, $eIcnElixir)
					Case "Dark"
						_GUICtrlSetImage($g_hPicUpgradeType[$iz], $g_sLibIconPath, $eIcnDark)
					Case Else
						_GUICtrlSetImage($g_hPicUpgradeType[$iz], $g_sLibIconPath, $eIcnBlank)
				EndSwitch

				GUICtrlSetState($g_hChkUpgrade[$iz], $g_abBuildingUpgradeEnable[$iz] ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetState($g_hChkUpgradeRepeat[$iz], $g_abUpgradeRepeatEnable[$iz] ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetData($g_hTxtUpgradeEndTime[$iz], $g_avBuildingUpgrades[$iz][7]) ; Set GUI upgrade End time to match $g_avBuildingUpgrades variable
			Next
			GUICtrlSetData($g_hTxtUpgrMinGold, $g_iUpgradeMinGold)
			GUICtrlSetData($g_hTxtUpgrMinElixir, $g_iUpgradeMinElixir)
			GUICtrlSetData($g_hTxtUpgrMinDark, $g_iUpgradeMinDark)
		Case "Save"
			For $iz = 0 To UBound($g_avBuildingUpgrades, 1) - 1 ; Apply the buildings upgrade variable to GUI
				$g_abBuildingUpgradeEnable[$iz] = (GUICtrlRead($g_hChkUpgrade[$iz]) = $GUI_CHECKED)
				$g_abUpgradeRepeatEnable[$iz] = (GUICtrlRead($g_hChkUpgradeRepeat[$iz]) = $GUI_CHECKED)
			Next
			$g_iUpgradeMinGold = Number(GUICtrlRead($g_hTxtUpgrMinGold))
			$g_iUpgradeMinElixir = Number(GUICtrlRead($g_hTxtUpgrMinElixir))
			$g_iUpgradeMinDark = Number(GUICtrlRead($g_hTxtUpgrMinDark))
	EndSwitch
EndFunc   ;==>ApplyConfig_600_16

Func ApplyConfig_auto($TypeReadSave)
	; Auto Upgrade
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkAutoUpgrade, $g_iChkAutoUpgrade = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			For $i = 0 To 12
				GUICtrlSetState($g_hChkUpgradesToIgnore[$i], $g_iChkUpgradesToIgnore[$i] = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			For $i = 0 To 2
				GUICtrlSetState($g_hChkResourcesToIgnore[$i], $g_iChkResourcesToIgnore[$i] = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			GUICtrlSetData($g_hTxtSmartMinGold, $g_iTxtSmartMinGold)
			GUICtrlSetData($g_hTxtSmartMinElixir, $g_iTxtSmartMinElixir)
			GUICtrlSetData($g_hTxtSmartMinDark, $g_iTxtSmartMinDark)
			chkAutoUpgrade()
		Case "Save"
			$g_iChkAutoUpgrade = GUICtrlRead($g_hChkAutoUpgrade) = $GUI_CHECKED ? 1 : 0
			For $i = 0 To 12
				$g_iChkUpgradesToIgnore[$i] = GUICtrlRead($g_hChkUpgradesToIgnore[$i]) = $GUI_CHECKED ? 1 : 0
			Next
			For $i = 0 To 2
				$g_iChkResourcesToIgnore[$i] = GUICtrlRead($g_hChkResourcesToIgnore[$i]) = $GUI_CHECKED ? 1 : 0
			Next
			$g_iTxtSmartMinGold = GUICtrlRead($g_hTxtSmartMinGold)
			$g_iTxtSmartMinElixir = GUICtrlRead($g_hTxtSmartMinElixir)
			$g_iTxtSmartMinDark = GUICtrlRead($g_hTxtSmartMinDark)
    EndSwitch
EndFunc   ;==>ApplyConfig_auto

Func ApplyConfig_600_17($TypeReadSave)
	; <><><><> Village / Upgrade - Walls <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkWalls, $g_bAutoUpgradeWallsEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtWallMinGold, $g_iUpgradeWallMinGold)
			GUICtrlSetData($g_hTxtWallMinElixir, $g_iUpgradeWallMinElixir)
			Switch $g_iUpgradeWallLootType
				Case 0
					GUICtrlSetState($g_hRdoUseGold, $GUI_CHECKED)
				Case 1
					GUICtrlSetState($g_hRdoUseElixir, $GUI_CHECKED)
				Case 2
					GUICtrlSetState($g_hRdoUseElixirGold, $GUI_CHECKED)
			EndSwitch
			GUICtrlSetState($g_hChkSaveWallBldr, $g_bUpgradeWallSaveBuilder ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbWalls, $g_iCmbUpgradeWallsLevel)
		Case "Save"
			$g_bAutoUpgradeWallsEnable = (GUICtrlRead($g_hChkWalls) = $GUI_CHECKED)
			$g_iUpgradeWallMinGold = Number(GUICtrlRead($g_hTxtWallMinGold))
			$g_iUpgradeWallMinElixir = Number(GUICtrlRead($g_hTxtWallMinElixir))
			If GUICtrlRead($g_hRdoUseGold) = $GUI_CHECKED Then
				$g_iUpgradeWallLootType = 0
			ElseIf GUICtrlRead($g_hRdoUseElixir) = $GUI_CHECKED Then
				$g_iUpgradeWallLootType = 1
			ElseIf GUICtrlRead($g_hRdoUseElixirGold) = $GUI_CHECKED Then
				$g_iUpgradeWallLootType = 2
			EndIf
			$g_bUpgradeWallSaveBuilder = (GUICtrlRead($g_hChkSaveWallBldr) = $GUI_CHECKED)
			$g_iCmbUpgradeWallsLevel = _GUICtrlComboBox_GetCurSel($g_hCmbWalls)
			; ================================================== Wall/Building Upgrading Priority by Simple Mod	========================;
			$g_iChkUpgrPriority = GUICtrlRead($g_hChkUpgrPriority) = $GUI_CHECKED ? 1 : 0
			$g_iCmbUpgrdPriority = _GUICtrlComboBox_GetCurSel($g_hCmbUpgrdPriority)
			For $i = 4 To 13
				$g_aiWallsCurrentCount[$i] = Number(GUICtrlRead($g_ahWallsCurrentCount[$i]))
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_600_17

Func ApplyConfig_600_18($TypeReadSave)
	; <><><><> Village / Notify <><><><>
	Switch $TypeReadSave
		Case "Read"

			GUICtrlSetState($g_hChkNotifyTGEnable, $g_bNotifyTGEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkPBTGenabled()
			GUICtrlSetData($g_hTxtNotifyTGToken, $g_sNotifyTGToken)
			;Remote Control
			GUICtrlSetState($g_hChkNotifyRemote, $g_bNotifyRemoteEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtNotifyOrigin, $g_sNotifyOrigin)
			;Alerts
			GUICtrlSetState($g_hChkNotifyAlertMatchFound, $g_bNotifyAlertMatchFound ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertLastRaidIMG, $g_bNotifyAlerLastRaidIMG ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertUpgradeWall, $g_bNotifyAlertUpgradeWalls ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertOutOfSync, $g_bNotifyAlertOutOfSync ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertTakeBreak, $g_bNotifyAlertTakeBreak ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertAnotherDevice, $g_bNotifyAlertAnotherDevice ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertLastRaidTXT, $g_bNotifyAlerLastRaidTXT ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertCampFull, $g_bNotifyAlertCampFull ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertVillageStats, $g_bNotifyAlertVillageReport ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertLastAttack, $g_bNotifyAlertLastAttack ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertBuilderIdle, $g_bNotifyAlertBulderIdle ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertMaintenance, $g_bNotifyAlertMaintenance ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertBAN, $g_bNotifyAlertBAN ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyBOTUpdate, $g_bNotifyAlertBOTUpdate ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNotifyAlertSmartWaitTime, $g_bNotifyAlertSmartWaitTime ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			; Telegram
			$g_bNotifyTGEnable = (GUICtrlRead($g_hChkNotifyTGEnable) = $GUI_CHECKED)
			$g_sNotifyTGToken = GUICtrlRead($g_hTxtNotifyTGToken)
			;Remote Control
			$g_bNotifyRemoteEnable = (GUICtrlRead($g_hChkNotifyRemote) = $GUI_CHECKED)
			$g_sNotifyOrigin = GUICtrlRead($g_hTxtNotifyOrigin)
			;Alerts
			$g_bNotifyAlertMatchFound = (GUICtrlRead($g_hChkNotifyAlertMatchFound) = $GUI_CHECKED)
			$g_bNotifyAlerLastRaidIMG = (GUICtrlRead($g_hChkNotifyAlertLastRaidIMG) = $GUI_CHECKED)
			$g_bNotifyAlertUpgradeWalls = (GUICtrlRead($g_hChkNotifyAlertUpgradeWall) = $GUI_CHECKED)
			$g_bNotifyAlertOutOfSync = (GUICtrlRead($g_hChkNotifyAlertOutOfSync) = $GUI_CHECKED)
			$g_bNotifyAlertTakeBreak = (GUICtrlRead($g_hChkNotifyAlertTakeBreak) = $GUI_CHECKED)
			$g_bNotifyAlertAnotherDevice = (GUICtrlRead($g_hChkNotifyAlertAnotherDevice) = $GUI_CHECKED)
			$g_bNotifyAlerLastRaidTXT = (GUICtrlRead($g_hChkNotifyAlertLastRaidTXT) = $GUI_CHECKED)
			$g_bNotifyAlertCampFull = (GUICtrlRead($g_hChkNotifyAlertCampFull) = $GUI_CHECKED)
			$g_bNotifyAlertVillageReport = (GUICtrlRead($g_hChkNotifyAlertVillageStats) = $GUI_CHECKED)
			$g_bNotifyAlertLastAttack = (GUICtrlRead($g_hChkNotifyAlertLastAttack) = $GUI_CHECKED)
			$g_bNotifyAlertBulderIdle = (GUICtrlRead($g_hChkNotifyAlertBuilderIdle) = $GUI_CHECKED)
			$g_bNotifyAlertMaintenance = (GUICtrlRead($g_hChkNotifyAlertMaintenance) = $GUI_CHECKED)
			$g_bNotifyAlertBAN = (GUICtrlRead($g_hChkNotifyAlertBAN) = $GUI_CHECKED)
			$g_bNotifyAlertBOTUpdate = (GUICtrlRead($g_hChkNotifyBOTUpdate) = $GUI_CHECKED)
			$g_bNotifyAlertSmartWaitTime = (GUICtrlRead($g_hChkNotifyAlertSmartWaitTime) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_18

Func ApplyConfig_600_19($TypeReadSave)
	; <><><><> Village / Notify <><><><>
	Switch $TypeReadSave
		Case "Read"
			;Schedule
			GUICtrlSetState($g_hChkNotifyOnlyHours, $g_bNotifyScheduleHoursEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkNotifyHours()
			For $i = 0 To 23
				GUICtrlSetState($g_hChkNotifyhours[$i], $g_abNotifyScheduleHours[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next

			GUICtrlSetState($g_hChkNotifyOnlyWeekDays, $g_bNotifyScheduleWeekDaysEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkNotifyWeekDays()
			For $i = 0 To 6
				GUICtrlSetState($g_hChkNotifyWeekdays[$i], $g_abNotifyScheduleWeekDays[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
		Case "Save"
			$g_bNotifyScheduleHoursEnable = (GUICtrlRead($g_hChkNotifyOnlyHours) = $GUI_CHECKED)
			For $i = 0 To 23
				$g_abNotifyScheduleHours[$i] = (GUICtrlRead($g_hChkNotifyhours[$i]) = $GUI_CHECKED)
			Next
			$g_bNotifyScheduleWeekDaysEnable = (GUICtrlRead($g_hChkNotifyOnlyWeekDays) = $GUI_CHECKED)
			For $i = 0 To 6
				$g_abNotifyScheduleWeekDays[$i] = (GUICtrlRead($g_hChkNotifyWeekdays[$i]) = $GUI_CHECKED)
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_600_19

Func ApplyConfig_600_22($TypeReadSave)
	; <><><> Attack Plan / Train Army / Boost <><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostBarracks, $g_iCmbBoostBarracks)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostSpellFactory, $g_iCmbBoostSpellFactory)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostBarbarianKing, $g_iCmbBoostBarbarianKing)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostArcherQueen, $g_iCmbBoostArcherQueen)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostWarden, $g_iCmbBoostWarden)
			For $i = 0 To 23
				GUICtrlSetState($g_hChkBoostBarracksHours[$i], $g_abBoostBarracksHours[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			; ================================================== Boost for Magic Spell by Simple Mod ================================= ;

			GUICtrlSetState($g_hChkBoostBMagic, $g_iChkBoostBMagic = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostBrMagic, $g_iCmbBoostBrMagic)
			chkBoostBMagic()
			BoostBrMagic()
			GUICtrlSetState($g_hChkBoostCMagic, $g_iChkBoostCMagic = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostClMagic, $g_iCmbBoostClMagic)
			chkBoostCMagic()
			BoostClMagic()

			; ================================================== One Gem Boost by Simple Mod ================================= ;

			GUICtrlSetState($g_hChkOneGemBoostBarracks, $g_bChkOneGemBoostBarracks ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkOneGemBoostSpells, $g_bChkOneGemBoostSpells ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkOneGemBoostHeroes, $g_bChkOneGemBoostHeroes ? $GUI_CHECKED : $GUI_UNCHECKED)

		Case "Save"

			$g_iCmbBoostBarracks = _GUICtrlComboBox_GetCurSel($g_hCmbBoostBarracks)
			$g_iCmbBoostSpellFactory = _GUICtrlComboBox_GetCurSel($g_hCmbBoostSpellFactory)
			$g_iCmbBoostBarbarianKing = _GUICtrlComboBox_GetCurSel($g_hCmbBoostBarbarianKing)
			$g_iCmbBoostArcherQueen = _GUICtrlComboBox_GetCurSel($g_hCmbBoostArcherQueen)
			$g_iCmbBoostWarden = _GUICtrlComboBox_GetCurSel($g_hCmbBoostWarden)
			For $i = 0 To 23
				$g_abBoostBarracksHours[$i] = (GUICtrlRead($g_hChkBoostBarracksHours[$i]) = $GUI_CHECKED)
			Next
			; ================================================== Boost for Magic Spell by Simple Mod ================================= ;

			$g_iChkBoostBMagic = GUICtrlRead($g_hChkBoostBMagic) = $GUI_CHECKED ? 1 : 0
			$g_iCmbBoostBrMagic = _GUICtrlComboBox_GetCurSel($g_hCmbBoostBrMagic)
			$g_iChkBoostCMagic = GUICtrlRead($g_hChkBoostCMagic) = $GUI_CHECKED ? 1 : 0
			$g_iCmbBoostClMagic = _GUICtrlComboBox_GetCurSel($g_hCmbBoostClMagic)

			; ================================================== One Gem Boost by Simple Mod ================================= ;

			$g_bChkOneGemBoostBarracks = (GUICtrlRead($g_hChkOneGemBoostBarracks) = $GUI_CHECKED)
			$g_bChkOneGemBoostSpells = (GUICtrlRead($g_hChkOneGemBoostSpells) = $GUI_CHECKED)
			$g_bChkOneGemBoostHeroes = (GUICtrlRead($g_hChkOneGemBoostHeroes) = $GUI_CHECKED)

	EndSwitch
EndFunc   ;==>ApplyConfig_600_22

Func ApplyConfig_600_26($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Bully <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkBully, $g_abAttackTypeEnable[$TB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtATBullyMode, $g_iAtkTBEnableCount)
			_GUICtrlComboBox_SetCurSel($g_hCmbBullyMaxTH, $g_iAtkTBMaxTHLevel)
			CmbBullyMaxTH()
			GUICtrlSetState($g_hRadBullyUseDBAttack, $g_iAtkTBMode = 0 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hRadBullyUseLBAttack, $g_iAtkTBMode = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_abAttackTypeEnable[$TB] = (GUICtrlRead($g_hChkBully) = $GUI_CHECKED)
			$g_iAtkTBEnableCount = GUICtrlRead($g_hTxtATBullyMode)
			$g_iAtkTBMaxTHLevel = _GUICtrlComboBox_GetCurSel($g_hCmbBullyMaxTH)
			$g_iAtkTBMode = (GUICtrlRead($g_hRadBullyUseDBAttack) = $GUI_CHECKED ? 0 : 1)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_26

Func ApplyConfig_600_28($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / Search <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkSearchReduction, $g_bSearchReductionEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSearchReduction()
			GUICtrlSetData($g_hTxtSearchReduceCount, $g_iSearchReductionCount)
			GUICtrlSetData($g_hTxtSearchReduceGold, $g_iSearchReductionGold)
			GUICtrlSetData($g_hTxtSearchReduceElixir, $g_iSearchReductionElixir)
			GUICtrlSetData($g_hTxtSearchReduceGoldPlusElixir, $g_iSearchReductionGoldPlusElixir)
			GUICtrlSetData($g_hTxtSearchReduceDark, $g_iSearchReductionDark)
			GUICtrlSetData($g_hTxtSearchReduceTrophy, $g_iSearchReductionTrophy)
			If $g_iSearchDelayMin > $g_iSearchDelayMax Then $g_iSearchDelayMax = $g_iSearchDelayMin ; check for illegal condition
			GUICtrlSetData($g_hSldVSDelay, $g_iSearchDelayMin)
			GUICtrlSetData($g_hLblVSDelay, $g_iSearchDelayMin)
			GUICtrlSetData($g_hSldMaxVSDelay, $g_iSearchDelayMax)
			GUICtrlSetData($g_hLblMaxVSDelay, $g_iSearchDelayMax)
			GUICtrlSetState($g_hChkAttackNow, $g_bSearchAttackNowEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkAttackNow()
			_GUICtrlComboBox_SetCurSel($g_hCmbAttackNowDelay, $g_iSearchAttackNowDelay)
			GUICtrlSetState($g_hChkRestartSearchLimit, $g_bSearchRestartEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtRestartSearchlimit, $g_iSearchRestartLimit)
			ChkRestartSearchLimit()
			GUICtrlSetState($g_hChkRestartSearchPickupHero, $g_bSearchRestartPickupHero ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAlertSearch, $g_bSearchAlertMe ? $GUI_CHECKED : $GUI_UNCHECKED)



			; ================================================== ; Return Home by Time - by Simple Mod  ======================================== ;
			GUICtrlSetState($g_hChkReturnTimerEnable, $g_bReturnTimerEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtReturnTimer, $g_iTxtReturnTimer)
			chkReturnTimer()

			; ================================================== ; Attack Priority - by Simple Mod  ======================================== ;

			GUICtrlSetState($g_hChkAttackPriority, $g_bChkAttackPriority ? $GUI_CHECKED : $GUI_UNCHECKED)

		Case "Save"
			$g_bSearchReductionEnable = (GUICtrlRead($g_hChkSearchReduction) = $GUI_CHECKED)
			$g_iSearchReductionCount = GUICtrlRead($g_hTxtSearchReduceCount)
			$g_iSearchReductionGold = GUICtrlRead($g_hTxtSearchReduceGold)
			$g_iSearchReductionElixir = GUICtrlRead($g_hTxtSearchReduceElixir)
			$g_iSearchReductionGoldPlusElixir = GUICtrlRead($g_hTxtSearchReduceGoldPlusElixir)
			$g_iSearchReductionDark = GUICtrlRead($g_hTxtSearchReduceDark)
			$g_iSearchReductionTrophy = GUICtrlRead($g_hTxtSearchReduceTrophy)
			$g_iSearchDelayMin = GUICtrlRead($g_hSldVSDelay)
			$g_iSearchDelayMax = GUICtrlRead($g_hSldMaxVSDelay)
			$g_bSearchAttackNowEnable = (GUICtrlRead($g_hChkAttackNow) = $GUI_CHECKED)
			$g_iSearchAttackNowDelay = _GUICtrlComboBox_GetCurSel($g_hCmbAttackNowDelay)
			$g_bSearchRestartEnable = (GUICtrlRead($g_hChkRestartSearchLimit) = $GUI_CHECKED)
			$g_iSearchRestartLimit = GUICtrlRead($g_hTxtRestartSearchlimit)
			$g_bSearchRestartPickupHero = (GUICtrlRead($g_hChkRestartSearchPickupHero) = $GUI_CHECKED)
			$g_bSearchAlertMe = (GUICtrlRead($g_hChkAlertSearch) = $GUI_CHECKED)

			; ================================================== ; Return Home by Time - by Simple Mod  ======================================== ;

			$g_bReturnTimerEnable = (GUICtrlRead($g_hChkReturnTimerEnable) = $GUI_CHECKED)
			$g_iTxtReturnTimer = GUICtrlRead($g_hTxtReturnTimer)

			; ================================================== ; Attack Priority - by Simple Mod  ======================================== ;

			$g_bChkAttackPriority = (GUICtrlRead($g_hChkAttackPriority) = $GUI_CHECKED)

	EndSwitch
EndFunc   ;==>ApplyConfig_600_28

Func ApplyConfig_600_28_DB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Search <><><><>
	Switch $TypeReadSave
		Case "Read"
			; Search - Start Search If
			GUICtrlSetState($g_hChkDBActivateSearches, $g_abSearchSearchesEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBSearchesMin, $g_aiSearchSearchesMin[$DB])
			GUICtrlSetData($g_hTxtDBSearchesMax, $g_aiSearchSearchesMax[$DB])
			GUICtrlSetState($g_hChkDBActivateTropies, $g_abSearchTropiesEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDBActivateTropies()
			GUICtrlSetData($g_hTxtDBTropiesMin, $g_aiSearchTrophiesMin[$DB])
			GUICtrlSetData($g_hTxtDBTropiesMax, $g_aiSearchTrophiesMax[$DB])
			GUICtrlSetState($g_hChkDBActivateCamps, $g_abSearchCampsEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDBActivateCamps()
			GUICtrlSetData($g_hTxtDBArmyCamps, $g_aiSearchCampsPct[$DB])

			chkDBActivateSearches()
			GUICtrlSetState($g_hChkDeadbase, $g_abAttackTypeEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)

			GUICtrlSetState($g_hChkDBKingWait, BitAND($g_aiSearchHeroWaitEnable[$DB], $eHeroKing) = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBQueenWait, BitAND($g_aiSearchHeroWaitEnable[$DB], $eHeroQueen) = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBWardenWait, BitAND($g_aiSearchHeroWaitEnable[$DB], $eHeroWarden) = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBNotWaitHeroes, $g_aiSearchNotWaitHeroesEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			$g_iHeroWaitAttackNoBit[$DB][0] = GUICtrlRead($g_hChkDBKingWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$DB][1] = GUICtrlRead($g_hChkDBQueenWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$DB][2] = GUICtrlRead($g_hChkDBWardenWait) = $GUI_CHECKED ? 1 : 0
			GUICtrlSetState($g_hChkDBSpellsWait, $g_abSearchSpellsWaitEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDBSpellsWait()
			GUICtrlSetState($g_hChkDBWaitForCastle, $g_abSearchCastleWaitEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			; Search - Filters
			_GUICtrlComboBox_SetCurSel($g_hCmbDBMeetGE, $g_aiFilterMeetGE[$DB])
			GUICtrlSetData($g_hTxtDBMinGold, $g_aiFilterMinGold[$DB])
			GUICtrlSetData($g_hTxtDBMinElixir, $g_aiFilterMinElixir[$DB])
			GUICtrlSetData($g_hTxtDBMinGoldPlusElixir, $g_aiFilterMinGoldPlusElixir[$DB])
			cmbDBGoldElixir()
			GUICtrlSetState($g_hChkDBMeetDE, $g_abFilterMeetDEEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinDarkElixir, $g_aiFilterMeetDEMin[$DB])
			chkDBMeetDE()
			GUICtrlSetState($g_hChkDBMeetTrophy, $g_abFilterMeetTrophyEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinTrophy, $g_aiFilterMeetTrophyMin[$DB])
			GUICtrlSetData($g_hTxtDBMaxTrophy, $g_aiFilterMeetTrophyMax[$DB])
			chkDBMeetTrophy()
			GUICtrlSetState($g_hChkDBMeetTH, $g_abFilterMeetTH[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDBTH, $g_aiFilterMeetTHMin[$DB])
			$g_aiMaxTH[$DB] = $g_asTHText[$g_aiFilterMeetTHMin[$DB]]
			chkDBMeetTH()
			CmbDBTH()
			GUICtrlSetState($g_hChkDBMeetTHO, $g_abFilterMeetTHOutsideEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxMortar[$DB], $g_abFilterMaxMortarEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxWizTower[$DB], $g_abFilterMaxWizTowerEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxAirDefense[$DB], $g_abFilterMaxAirDefenseEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxXBow[$DB], $g_abFilterMaxXBowEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxInferno[$DB], $g_abFilterMaxInfernoEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxEagle[$DB], $g_abFilterMaxEagleEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakMortar[$DB], $g_aiFilterMaxMortarLevel[$DB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakWizTower[$DB], $g_aiFilterMaxWizTowerLevel[$DB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakAirDefense[$DB], $g_aiFilterMaxAirDefenseLevel[$DB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakXBow[$DB], $g_aiFilterMaxXBowLevel[$DB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakInferno[$DB], $g_aiFilterMaxInfernoLevel[$DB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakEagle[$DB], $g_aiFilterMaxEagleLevel[$DB])
			chkDBWeakBase()
			GUICtrlSetState($g_ahChkMeetOne[$DB], $g_abFilterMeetOneConditionEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_abAttackTypeEnable[$DB] = (GUICtrlRead($g_hChkDeadbase) = $GUI_CHECKED)
			; Search - Start Search If
			$g_abSearchSearchesEnable[$DB] = (GUICtrlRead($g_hChkDBActivateSearches) = $GUI_CHECKED)
			$g_aiSearchSearchesMin[$DB] = GUICtrlRead($g_hTxtDBSearchesMin)
			$g_aiSearchSearchesMax[$DB] = GUICtrlRead($g_hTxtDBSearchesMax)
			$g_abSearchTropiesEnable[$DB] = (GUICtrlRead($g_hChkDBActivateTropies) = $GUI_CHECKED)
			$g_aiSearchTrophiesMin[$DB] = GUICtrlRead($g_hTxtDBTropiesMin)
			$g_aiSearchTrophiesMax[$DB] = GUICtrlRead($g_hTxtDBTropiesMax)
			$g_abSearchCampsEnable[$DB] = (GUICtrlRead($g_hChkDBActivateCamps) = $GUI_CHECKED)
			$g_aiSearchCampsPct[$DB] = Int(GUICtrlRead($g_hTxtDBArmyCamps))
			$g_iHeroWaitAttackNoBit[$DB][0] = GUICtrlRead($g_hChkDBKingWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$DB][1] = GUICtrlRead($g_hChkDBQueenWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$DB][2] = GUICtrlRead($g_hChkDBWardenWait) = $GUI_CHECKED ? 1 : 0
			$g_aiSearchNotWaitHeroesEnable[$DB] = GUICtrlRead($g_hChkDBNotWaitHeroes) = $GUI_CHECKED ? 1 : 0
			chkNotWaitHeroes()
			$g_abSearchSpellsWaitEnable[$DB] = (GUICtrlRead($g_hChkDBSpellsWait) = $GUI_CHECKED)
			$g_abSearchCastleWaitEnable[$DB] = (GUICtrlRead($g_hChkDBWaitForCastle) = $GUI_CHECKED)
			; Search - Filters
			$g_aiFilterMeetGE[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbDBMeetGE)
			$g_aiFilterMinGold[$DB] = GUICtrlRead($g_hTxtDBMinGold)
			$g_aiFilterMinElixir[$DB] = GUICtrlRead($g_hTxtDBMinElixir)
			$g_aiFilterMinGoldPlusElixir[$DB] = GUICtrlRead($g_hTxtDBMinGoldPlusElixir)
			$g_abFilterMeetDEEnable[$DB] = (GUICtrlRead($g_hChkDBMeetDE) = $GUI_CHECKED)
			$g_aiFilterMeetDEMin[$DB] = GUICtrlRead($g_hTxtDBMinDarkElixir)
			$g_abFilterMeetTrophyEnable[$DB] = (GUICtrlRead($g_hChkDBMeetTrophy) = $GUI_CHECKED)
			$g_aiFilterMeetTrophyMin[$DB] = GUICtrlRead($g_hTxtDBMinTrophy)
			$g_aiFilterMeetTrophyMax[$DB] = GUICtrlRead($g_hTxtDBMaxTrophy)
			$g_abFilterMeetTH[$DB] = (GUICtrlRead($g_hChkDBMeetTH) = $GUI_CHECKED)
			$g_aiFilterMeetTHMin[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbDBTH)
			$g_aiMaxTH[$DB] = $g_asTHText[$g_aiFilterMeetTHMin[$DB]]
			$g_abFilterMeetTHOutsideEnable[$DB] = (GUICtrlRead($g_hChkDBMeetTHO) = $GUI_CHECKED)
			$g_abFilterMaxMortarEnable[$DB] = (GUICtrlRead($g_ahChkMaxMortar[$DB]) = $GUI_CHECKED)
			$g_abFilterMaxWizTowerEnable[$DB] = (GUICtrlRead($g_ahChkMaxWizTower[$DB]) = $GUI_CHECKED)
			$g_abFilterMaxAirDefenseEnable[$DB] = (GUICtrlRead($g_ahChkMaxAirDefense[$DB]) = $GUI_CHECKED)
			$g_abFilterMaxXBowEnable[$DB] = (GUICtrlRead($g_ahChkMaxXBow[$DB]) = $GUI_CHECKED)
			$g_abFilterMaxInfernoEnable[$DB] = (GUICtrlRead($g_ahChkMaxInferno[$DB]) = $GUI_CHECKED)
			$g_abFilterMaxEagleEnable[$DB] = (GUICtrlRead($g_ahChkMaxEagle[$DB]) = $GUI_CHECKED)
			$g_aiFilterMaxMortarLevel[$DB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakMortar[$DB])
			$g_aiFilterMaxWizTowerLevel[$DB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakWizTower[$DB])
			$g_aiFilterMaxAirDefenseLevel[$DB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakAirDefense[$DB])
			$g_aiFilterMaxXBowLevel[$DB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakXBow[$DB])
			$g_aiFilterMaxInfernoLevel[$DB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakInferno[$DB])
			$g_aiFilterMaxEagleLevel[$DB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakEagle[$DB])
			$g_abFilterMeetOneConditionEnable[$DB] = (GUICtrlRead($g_ahChkMeetOne[$DB]) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_28_DB

Func ApplyConfig_600_28_LB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / Search <><><><>
	Switch $TypeReadSave
		Case "Read"
			; Search - Start Search If
			GUICtrlSetState($g_hChkABActivateSearches, $g_abSearchSearchesEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtABSearchesMin, $g_aiSearchSearchesMin[$LB])
			GUICtrlSetData($g_hTxtABSearchesMax, $g_aiSearchSearchesMax[$LB])
			GUICtrlSetState($g_hChkABActivateTropies, $g_abSearchTropiesEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkABActivateTropies()
			GUICtrlSetData($g_hTxtABTropiesMin, $g_aiSearchTrophiesMin[$LB])
			GUICtrlSetData($g_hTxtABTropiesMax, $g_aiSearchTrophiesMax[$LB])
			GUICtrlSetState($g_hChkABActivateCamps, $g_abSearchCampsEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkABActivateCamps()
			GUICtrlSetData($g_hTxtABArmyCamps, $g_aiSearchCampsPct[$LB])

			chkABActivateSearches()
			GUICtrlSetState($g_hChkActivebase, $g_abAttackTypeEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)

			GUICtrlSetState($g_hChkABKingWait, BitAND($g_aiSearchHeroWaitEnable[$LB], $eHeroKing) = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABQueenWait, BitAND($g_aiSearchHeroWaitEnable[$LB], $eHeroQueen) = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABWardenWait, BitAND($g_aiSearchHeroWaitEnable[$LB], $eHeroWarden) = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABNotWaitHeroes, $g_aiSearchNotWaitHeroesEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			$g_iHeroWaitAttackNoBit[$LB][0] = GUICtrlRead($g_hChkABKingWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$LB][1] = GUICtrlRead($g_hChkABQueenWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$LB][2] = GUICtrlRead($g_hChkABWardenWait) = $GUI_CHECKED ? 1 : 0
			GUICtrlSetState($g_hChkABSpellsWait, $g_abSearchSpellsWaitEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkABSpellsWait()
			GUICtrlSetState($g_hChkABWaitForCastle, $g_abSearchCastleWaitEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			; Search - Filters
			_GUICtrlComboBox_SetCurSel($g_hCmbABMeetGE, $g_aiFilterMeetGE[$LB])
			GUICtrlSetData($g_hTxtABMinGold, $g_aiFilterMinGold[$LB])
			GUICtrlSetData($g_hTxtABMinElixir, $g_aiFilterMinElixir[$LB])
			GUICtrlSetData($g_hTxtABMinGoldPlusElixir, $g_aiFilterMinGoldPlusElixir[$LB])
			cmbABGoldElixir()
			GUICtrlSetState($g_hChkABMeetDE, $g_abFilterMeetDEEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtABMinDarkElixir, $g_aiFilterMeetDEMin[$LB])
			chkABMeetDE()
			GUICtrlSetState($g_hChkABMeetTrophy, $g_abFilterMeetTrophyEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtABMinTrophy, $g_aiFilterMeetTrophyMin[$LB])
			GUICtrlSetData($g_hTxtABMaxTrophy, $g_aiFilterMeetTrophyMax[$LB])
			chkABMeetTrophy()
			GUICtrlSetState($g_hChkABMeetTH, $g_abFilterMeetTH[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbABTH, $g_aiFilterMeetTHMin[$LB])
			$g_aiMaxTH[$LB] = $g_asTHText[$g_aiFilterMeetTHMin[$LB]]
			chkABMeetTH()
			CmbABTH()
			GUICtrlSetState($g_hChkABMeetTHO, $g_abFilterMeetTHOutsideEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxMortar[$LB], $g_abFilterMaxMortarEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxWizTower[$LB], $g_abFilterMaxWizTowerEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxAirDefense[$LB], $g_abFilterMaxAirDefenseEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxXBow[$LB], $g_abFilterMaxXBowEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxInferno[$LB], $g_abFilterMaxInfernoEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkMaxEagle[$LB], $g_abFilterMaxEagleEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakMortar[$LB], $g_aiFilterMaxMortarLevel[$LB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakWizTower[$LB], $g_aiFilterMaxWizTowerLevel[$LB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakAirDefense[$LB], $g_aiFilterMaxAirDefenseLevel[$LB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakXBow[$LB], $g_aiFilterMaxXBowLevel[$LB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakInferno[$LB], $g_aiFilterMaxInfernoLevel[$LB])
			_GUICtrlComboBox_SetCurSel($g_ahCmbWeakEagle[$LB], $g_aiFilterMaxEagleLevel[$LB])
			chkABWeakBase()
			GUICtrlSetState($g_ahChkMeetOne[$LB], $g_abFilterMeetOneConditionEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_abAttackTypeEnable[$LB] = (GUICtrlRead($g_hChkActivebase) = $GUI_CHECKED)
			; Search - Start Search If
			$g_abSearchSearchesEnable[$LB] = (GUICtrlRead($g_hChkABActivateSearches) = $GUI_CHECKED)
			$g_aiSearchSearchesMin[$LB] = GUICtrlRead($g_hTxtABSearchesMin)
			$g_aiSearchSearchesMax[$LB] = GUICtrlRead($g_hTxtABSearchesMax)
			$g_abSearchTropiesEnable[$LB] = (GUICtrlRead($g_hChkABActivateTropies) = $GUI_CHECKED)
			$g_aiSearchTrophiesMin[$LB] = GUICtrlRead($g_hTxtABTropiesMin)
			$g_aiSearchTrophiesMax[$LB] = GUICtrlRead($g_hTxtABTropiesMax)
			$g_abSearchCampsEnable[$LB] = (GUICtrlRead($g_hChkABActivateCamps) = $GUI_CHECKED)
			$g_aiSearchCampsPct[$LB] = Int(GUICtrlRead($g_hTxtABArmyCamps))
			$g_iHeroWaitAttackNoBit[$LB][0] = GUICtrlRead($g_hChkABKingWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$LB][1] = GUICtrlRead($g_hChkABQueenWait) = $GUI_CHECKED ? 1 : 0
			$g_iHeroWaitAttackNoBit[$LB][2] = GUICtrlRead($g_hChkABWardenWait) = $GUI_CHECKED ? 1 : 0
			$g_aiSearchNotWaitHeroesEnable[$LB] = GUICtrlRead($g_hChkABNotWaitHeroes) = $GUI_CHECKED ? 1 : 0
			ChkNotWaitHeroes()
			$g_abSearchSpellsWaitEnable[$LB] = (GUICtrlRead($g_hChkABSpellsWait) = $GUI_CHECKED)
			$g_abSearchCastleWaitEnable[$LB] = (GUICtrlRead($g_hChkABWaitForCastle) = $GUI_CHECKED)
			; Search - Filters
			$g_aiFilterMeetGE[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbABMeetGE)
			$g_aiFilterMinGold[$LB] = GUICtrlRead($g_hTxtABMinGold)
			$g_aiFilterMinElixir[$LB] = GUICtrlRead($g_hTxtABMinElixir)
			$g_aiFilterMinGoldPlusElixir[$LB] = GUICtrlRead($g_hTxtABMinGoldPlusElixir)
			$g_abFilterMeetDEEnable[$LB] = (GUICtrlRead($g_hChkABMeetDE) = $GUI_CHECKED)
			$g_aiFilterMeetDEMin[$LB] = GUICtrlRead($g_hTxtABMinDarkElixir)
			$g_abFilterMeetTrophyEnable[$LB] = (GUICtrlRead($g_hChkABMeetTrophy) = $GUI_CHECKED)
			$g_aiFilterMeetTrophyMin[$LB] = GUICtrlRead($g_hTxtABMinTrophy)
			$g_aiFilterMeetTrophyMax[$LB] = GUICtrlRead($g_hTxtABMaxTrophy)
			$g_abFilterMeetTH[$LB] = (GUICtrlRead($g_hChkABMeetTH) = $GUI_CHECKED)
			$g_aiFilterMeetTHMin[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbABTH)
			$g_aiMaxTH[$LB] = $g_asTHText[$g_aiFilterMeetTHMin[$LB]]
			$g_abFilterMeetTHOutsideEnable[$LB] = (GUICtrlRead($g_hChkABMeetTHO) = $GUI_CHECKED)
			$g_abFilterMaxMortarEnable[$LB] = (GUICtrlRead($g_ahChkMaxMortar[$LB]) = $GUI_CHECKED)
			$g_abFilterMaxWizTowerEnable[$LB] = (GUICtrlRead($g_ahChkMaxWizTower[$LB]) = $GUI_CHECKED)
			$g_abFilterMaxAirDefenseEnable[$LB] = (GUICtrlRead($g_ahChkMaxAirDefense[$LB]) = $GUI_CHECKED)
			$g_abFilterMaxXBowEnable[$LB] = (GUICtrlRead($g_ahChkMaxXBow[$LB]) = $GUI_CHECKED)
			$g_abFilterMaxInfernoEnable[$LB] = (GUICtrlRead($g_ahChkMaxInferno[$LB]) = $GUI_CHECKED)
			$g_abFilterMaxEagleEnable[$LB] = (GUICtrlRead($g_ahChkMaxEagle[$LB]) = $GUI_CHECKED)
			$g_aiFilterMaxMortarLevel[$LB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakMortar[$LB])
			$g_aiFilterMaxWizTowerLevel[$LB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakWizTower[$LB])
			$g_aiFilterMaxAirDefenseLevel[$LB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakAirDefense[$LB])
			$g_aiFilterMaxXBowLevel[$LB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakXBow[$LB])
			$g_aiFilterMaxInfernoLevel[$LB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakInferno[$LB])
			$g_aiFilterMaxEagleLevel[$LB] = _GUICtrlComboBox_GetCurSel($g_ahCmbWeakEagle[$LB])
			$g_abFilterMeetOneConditionEnable[$LB] = (GUICtrlRead($g_ahChkMeetOne[$LB]) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_28_LB

Func ApplyConfig_600_28_TS($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Search <><><><>
	Switch $TypeReadSave
		Case "Read"
			; Search - Start Search If
			GUICtrlSetState($g_hChkTSActivateSearches, $g_abSearchSearchesEnable[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtTSSearchesMin, $g_aiSearchSearchesMin[$TS])
			GUICtrlSetData($g_hTxtTSSearchesMax, $g_aiSearchSearchesMax[$TS])
			GUICtrlSetState($g_hChkTSActivateTropies, $g_abSearchTropiesEnable[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTSActivateTropies()
			GUICtrlSetData($g_hTxtTSTropiesMin, $g_aiSearchTrophiesMin[$TS])
			GUICtrlSetData($g_hTxtTSTropiesMax, $g_aiSearchTrophiesMax[$TS])
			GUICtrlSetState($g_hChkTSActivateCamps, $g_abSearchCampsEnable[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTSActivateCamps()
			GUICtrlSetData($g_hTxtTSArmyCamps, $g_aiSearchCampsPct[$TS])

			chkTSActivateSearches()
			GUICtrlSetState($g_hChkTHSnipe, $g_abAttackTypeEnable[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Search - Filters
			_GUICtrlComboBox_SetCurSel($g_hCmbTSMeetGE, $g_aiFilterMeetGE[$TS])
			GUICtrlSetData($g_hTxtTSMinGold, $g_aiFilterMinGold[$TS])
			GUICtrlSetData($g_hTxtTSMinElixir, $g_aiFilterMinElixir[$TS])
			GUICtrlSetData($g_hTxtTSMinGoldPlusElixir, $g_aiFilterMinGoldPlusElixir[$TS])
			cmbTSGoldElixir()
			GUICtrlSetState($g_hChkTSMeetDE, $g_abFilterMeetDEEnable[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtTSMinDarkElixir, $g_aiFilterMeetDEMin[$TS])
			chkTSMeetDE()
			GUICtrlSetData($g_hTxtSWTTiles, $g_iAtkTSAddTilesWhileTrain)
			GUICtrlSetData($g_hTxtTHaddTiles, $g_iAtkTSAddTilesFullTroops)
		Case "Save"
			$g_abAttackTypeEnable[$TS] = (GUICtrlRead($g_hChkTHSnipe) = $GUI_CHECKED)
			; Search - Start Search If
			$g_abSearchSearchesEnable[$TS] = (GUICtrlRead($g_hChkTSActivateSearches) = $GUI_CHECKED)
			$g_aiSearchSearchesMin[$TS] = GUICtrlRead($g_hTxtTSSearchesMin)
			$g_aiSearchSearchesMax[$TS] = GUICtrlRead($g_hTxtTSSearchesMax)
			$g_abSearchTropiesEnable[$TS] = (GUICtrlRead($g_hChkTSActivateTropies) = $GUI_CHECKED)
			$g_aiSearchTrophiesMin[$TS] = GUICtrlRead($g_hTxtTSTropiesMin)
			$g_aiSearchTrophiesMax[$TS] = GUICtrlRead($g_hTxtTSTropiesMax)
			$g_abSearchCampsEnable[$TS] = (GUICtrlRead($g_hChkTSActivateCamps) = $GUI_CHECKED)
			$g_aiSearchCampsPct[$TS] = Int(GUICtrlRead($g_hTxtTSArmyCamps))
			; Search - Filters
			$g_aiFilterMeetGE[$TS] = _GUICtrlComboBox_GetCurSel($g_hCmbTSMeetGE)
			$g_aiFilterMinGold[$TS] = GUICtrlRead($g_hTxtTSMinGold)
			$g_aiFilterMinElixir[$TS] = GUICtrlRead($g_hTxtTSMinElixir)
			$g_aiFilterMinGoldPlusElixir[$TS] = GUICtrlRead($g_hTxtTSMinGoldPlusElixir)
			$g_abFilterMeetDEEnable[$TS] = (GUICtrlRead($g_hChkTSMeetDE) = $GUI_CHECKED)
			$g_aiFilterMeetDEMin[$TS] = GUICtrlRead($g_hTxtTSMinDarkElixir)
			$g_iAtkTSAddTilesWhileTrain = GUICtrlRead($g_hTxtSWTTiles)
			$g_iAtkTSAddTilesFullTroops = GUICtrlRead($g_hTxtTHaddTiles)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_28_TS

Func ApplyConfig_600_29($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / Attack <><><><>
	Switch $TypeReadSave
		Case "Read"
			radHerosApply()
			GUICtrlSetState($g_hChkAttackPlannerEnable, $g_bAttackPlannerEnable = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackPlannerCloseCoC, $g_bAttackPlannerCloseCoC = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackPlannerCloseAll, $g_bAttackPlannerCloseAll = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackPlannerSuspendComputer, $g_bAttackPlannerSuspendComputer = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackPlannerRandom, $g_bAttackPlannerRandomEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbAttackPlannerRandom, ($g_iAttackPlannerRandomTime - 1))
			GUICtrlSetState($g_hChkAttackPlannerDayLimit, $g_bAttackPlannerDayLimit = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkAttackPlannerEnable()
			GUICtrlSetData($g_hCmbAttackPlannerDayMin, $g_iAttackPlannerDayMin)
			GUICtrlSetData($g_hCmbAttackPlannerDayMax, $g_iAttackPlannerDayMax)
			_cmbAttackPlannerDayLimit()
			For $i = 0 To 6
				GUICtrlSetState($g_ahChkAttackWeekdays[$i], $g_abPlannedAttackWeekDays[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			For $i = 0 To 23
				GUICtrlSetState($g_ahChkAttackHours[$i], $g_abPlannedattackHours[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			GUICtrlSetState($g_hChkDropCCHoursEnable, $g_bPlannedDropCCHoursEnable = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDropCCHoursEnable()

			For $i = 0 To 23
				GUICtrlSetState($g_ahChkDropCCHours[$i], $g_abPlannedDropCCHours[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
		Case "Save"
			If GUICtrlRead($g_hRadAutoQueenAbility) = $GUI_CHECKED Then
				$g_iActivateQueen = 0
			ElseIf GUICtrlRead($g_hRadManQueenAbility) = $GUI_CHECKED Then
				$g_iActivateQueen = 1
			ElseIf GUICtrlRead($g_hRadBothQueenAbility) = $GUI_CHECKED Then
				$g_iActivateQueen = 2
			EndIf
			$g_iDelayActivateQueen = Int(GUICtrlRead($g_hTxtManQueenAbility) * 1000)

			If GUICtrlRead($g_hRadAutoKingAbility) = $GUI_CHECKED Then
				$g_iActivateKing = 0
			ElseIf GUICtrlRead($g_hRadManKingAbility) = $GUI_CHECKED Then
				$g_iActivateKing = 1
			ElseIf GUICtrlRead($g_hRadBothKingAbility) = $GUI_CHECKED Then
				$g_iActivateKing = 2
			EndIf
			$g_iDelayActivateKing = Int(GUICtrlRead($g_hTxtManKingAbility) * 1000)

			If GUICtrlRead($g_hRadAutoWardenAbility) = $GUI_CHECKED Then
				$g_iActivateWarden = 0
			ElseIf GUICtrlRead($g_hRadManWardenAbility) = $GUI_CHECKED Then
				$g_iActivateWarden = 1
			ElseIf GUICtrlRead($g_hRadBothWardenAbility) = $GUI_CHECKED Then
				$g_iActivateWarden = 2
			EndIf
			$g_iDelayActivateWarden = Int(GUICtrlRead($g_hTxtManWardenAbility) * 1000)

			$g_bAttackPlannerEnable = (GUICtrlRead($g_hChkAttackPlannerEnable) = $GUI_CHECKED)
			$g_bAttackPlannerCloseCoC = (GUICtrlRead($g_hChkAttackPlannerCloseCoC) = $GUI_CHECKED)
			$g_bAttackPlannerCloseAll = (GUICtrlRead($g_hChkAttackPlannerCloseAll) = $GUI_CHECKED)
			$g_bAttackPlannerSuspendComputer = (GUICtrlRead($g_hChkAttackPlannerSuspendComputer) = $GUI_CHECKED)
			$g_bAttackPlannerRandomEnable = (GUICtrlRead($g_hChkAttackPlannerRandom) = $GUI_CHECKED)
			$g_iAttackPlannerRandomTime = (_GUICtrlComboBox_GetCurSel($g_hCmbAttackPlannerRandom) + 1)
			$g_bAttackPlannerDayLimit = (GUICtrlRead($g_hChkAttackPlannerDayLimit) = $GUI_CHECKED)
			$g_iAttackPlannerDayMin = GUICtrlRead($g_hCmbAttackPlannerDayMin)
			$g_iAttackPlannerDayMax = GUICtrlRead($g_hCmbAttackPlannerDayMax)
			Local $string = ""
			For $i = 0 To 6
				$g_abPlannedAttackWeekDays[$i] = (GUICtrlRead($g_ahChkAttackWeekdays[$i]) = $GUI_CHECKED)
			Next
			Local $string = ""
			For $i = 0 To 23
				$g_abPlannedattackHours[$i] = (GUICtrlRead($g_ahChkAttackHours[$i]) = $GUI_CHECKED)
			Next

			$g_bPlannedDropCCHoursEnable = (GUICtrlRead($g_hChkDropCCHoursEnable) = $GUI_CHECKED)

			Local $string = ""
			For $i = 0 To 23
				$g_abPlannedDropCCHours[$i] = GUICtrlRead($g_ahChkDropCCHours[$i]) = $GUI_CHECKED ? 1 : 0
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_600_29

Func ApplyConfig_600_29_DB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack <><><><>
	Switch $TypeReadSave
		Case "Read"
			; Attack
			_GUICtrlComboBox_SetCurSel($g_hCmbDBAlgorithm, $g_aiAttackAlgorithm[$DB])
			cmbDBAlgorithm()
			_GUICtrlComboBox_SetCurSel($g_hCmbDBSelectTroop, $g_aiAttackTroopSelection[$DB])
			GUICtrlSetState($g_hChkDBKingAttack, BitAND($g_aiAttackUseHeroes[$DB], $eHeroKing) = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBQueenAttack, BitAND($g_aiAttackUseHeroes[$DB], $eHeroQueen) = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBWardenAttack, BitAND($g_aiAttackUseHeroes[$DB], $eHeroWarden) = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)
			Local $temp1, $temp2, $temp3
			$temp1 = GUICtrlRead($g_hChkDBKingAttack) = $GUI_CHECKED ? $eHeroKing : $eHeroNone
			$temp2 = GUICtrlRead($g_hChkDBQueenAttack) = $GUI_CHECKED ? $eHeroQueen : $eHeroNone
			$temp3 = GUICtrlRead($g_hChkDBWardenAttack) = $GUI_CHECKED ? $eHeroWarden : $eHeroNone
			$g_aiAttackUseHeroes[$DB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
			GUICtrlSetState($g_hChkDBDropCC, $g_abAttackDropCC[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBLightSpell, $g_abAttackUseLightSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBHealSpell, $g_abAttackUseHealSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBRageSpell, $g_abAttackUseRageSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBJumpSpell, $g_abAttackUseJumpSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBFreezeSpell, $g_abAttackUseFreezeSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBCloneSpell, $g_abAttackUseCloneSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBPoisonSpell, $g_abAttackUsePoisonSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBEarthquakeSpell, $g_abAttackUseEarthquakeSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBHasteSpell, $g_abAttackUseHasteSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBSkeletonSpell, $g_abAttackUseSkeletonSpell[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTHSnipeBeforeDBEnable, $g_bTHSnipeBeforeEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTHSnipeBeforeDBEnable()
			GUICtrlSetData($g_hTxtTHSnipeBeforeDBTiles, $g_iTHSnipeBeforeTiles[$DB])
			LoadDBSnipeAttacks() ; recreate combo box values
			_GUICtrlComboBox_SetCurSel($g_hCmbTHSnipeBeforeDBScript, _GUICtrlComboBox_FindStringExact($g_hCmbTHSnipeBeforeDBScript, $g_iTHSnipeBeforeScript[$DB]))

			_GUICtrlComboBox_SetCurSel($g_hCmbDBSiege, $g_aiAttackUseSiege[$DB])
		Case "Save"
			$g_aiAttackAlgorithm[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbDBAlgorithm)
			$g_aiAttackTroopSelection[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbDBSelectTroop)
			Local $temp1, $temp2, $temp3
			$temp1 = GUICtrlRead($g_hChkDBKingAttack) = $GUI_CHECKED ? $eHeroKing : $eHeroNone
			$temp2 = GUICtrlRead($g_hChkDBQueenAttack) = $GUI_CHECKED ? $eHeroQueen : $eHeroNone
			$temp3 = GUICtrlRead($g_hChkDBWardenAttack) = $GUI_CHECKED ? $eHeroWarden : $eHeroNone
			$g_aiAttackUseHeroes[$DB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
			$g_abAttackDropCC[$DB] = (GUICtrlRead($g_hChkDBDropCC) = $GUI_CHECKED)
			$g_abAttackUseLightSpell[$DB] = (GUICtrlRead($g_hChkDBLightSpell) = $GUI_CHECKED)
			$g_abAttackUseHealSpell[$DB] = (GUICtrlRead($g_hChkDBHealSpell) = $GUI_CHECKED)
			$g_abAttackUseRageSpell[$DB] = (GUICtrlRead($g_hChkDBRageSpell) = $GUI_CHECKED)
			$g_abAttackUseJumpSpell[$DB] = (GUICtrlRead($g_hChkDBJumpSpell) = $GUI_CHECKED)
			$g_abAttackUseFreezeSpell[$DB] = (GUICtrlRead($g_hChkDBFreezeSpell) = $GUI_CHECKED)
			$g_abAttackUsePoisonSpell[$DB] = (GUICtrlRead($g_hChkDBPoisonSpell) = $GUI_CHECKED)
			$g_abAttackUseEarthquakeSpell[$DB] = (GUICtrlRead($g_hChkDBEarthquakeSpell) = $GUI_CHECKED)
			$g_abAttackUseHasteSpell[$DB] = (GUICtrlRead($g_hChkDBHasteSpell) = $GUI_CHECKED)
			$g_abAttackUseCloneSpell[$DB] = (GUICtrlRead($g_hChkDBCloneSpell) = $GUI_CHECKED)
			$g_abAttackUseSkeletonSpell[$DB] = (GUICtrlRead($g_hChkDBSkeletonSpell) = $GUI_CHECKED)
			$g_bTHSnipeBeforeEnable[$DB] = (GUICtrlRead($g_hChkTHSnipeBeforeDBEnable) = $GUI_CHECKED)
			$g_iTHSnipeBeforeTiles[$DB] = GUICtrlRead($g_hTxtTHSnipeBeforeDBTiles)
			$g_iTHSnipeBeforeScript[$DB] = GUICtrlRead($g_hCmbTHSnipeBeforeDBScript)

			$g_aiAttackUseSiege[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbDBSiege)
	EndSwitch

	ApplyConfig_600_29_DB_Standard($TypeReadSave)
	ApplyConfig_600_29_DB_Scripted($TypeReadSave)
	ApplyConfig_600_29_DB_Milking($TypeReadSave)
	ApplyConfig_600_29_DB_SmartFarm($TypeReadSave)
EndFunc   ;==>ApplyConfig_600_29_DB

Func ApplyConfig_600_29_DB_Standard($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack / Standard <><><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardDropOrderDB, $g_aiAttackStdDropOrder[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardDropSidesDB, $g_aiAttackStdDropSides[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardUnitDelayDB, $g_aiAttackStdUnitDelay[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardWaveDelayDB, $g_aiAttackStdWaveDelay[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardUnitDelayDB1, $g_aiAttackStdUnitDelay[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardWaveDelayDB1, $g_aiAttackStdWaveDelay[$DB])
			GUICtrlSetState($g_hChkRandomSpeedAtkDB, $g_abAttackStdRandomizeDelay[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkRandomSpeedAtkDB1, $g_abAttackStdRandomizeDelay[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkRandomSpeedAtkDB()
			GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $g_abAttackStdSmartAttack[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartAttackRedAreaDB()
			_GUICtrlComboBox_SetCurSel($g_hCmbSmartDeployDB, $g_aiAttackStdSmartDeploy[$DB])
			GUICtrlSetState($g_hChkAttackNearGoldMineDB, $g_abAttackStdSmartNearCollectors[$DB][0] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackNearElixirCollectorDB, $g_abAttackStdSmartNearCollectors[$DB][1] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackNearDarkElixirDrillDB, $g_abAttackStdSmartNearCollectors[$DB][2] ? $GUI_CHECKED : $GUI_UNCHECKED)
			; ================================================= Classic Foure Fingers - Added by Simple Mod ========================= ;
			cmbStandardDropSidesAB()
			Bridge()
			; ================================================== Multi Finger - Added by Simple Mod ======================================== ;

			_GUICtrlComboBox_SetCurSel($g_hCmbDBMultiFinger, $g_iMultiFingerStyle)

			; ================================================== Unit/Wave Factor  - Added by Simple Mod ======================================== ;

			GUICtrlSetState($g_hChkUnitFactor, $g_iChkUnitFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtUnitFactor, $g_iTxtUnitFactor)
			chkUnitFactor()
			GUICtrlSetState($g_hChkWaveFactor, $g_iChkWaveFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtWaveFactor, $g_iTxtWaveFactor)
			chkWaveFactor()

		Case "Save"
			$g_aiAttackStdDropOrder[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropOrderDB)
			$g_aiAttackStdDropSides[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesDB)
			$g_aiAttackStdUnitDelay[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardUnitDelayDB)
			$g_aiAttackStdWaveDelay[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardWaveDelayDB)
			$g_abAttackStdRandomizeDelay[$DB] = (GUICtrlRead($g_hChkRandomSpeedAtkDB) = $GUI_CHECKED)
			$g_abAttackStdSmartAttack[$DB] = (GUICtrlRead($g_hChkSmartAttackRedAreaDB) = $GUI_CHECKED)
			$g_aiAttackStdSmartDeploy[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbSmartDeployDB)
			$g_abAttackStdSmartNearCollectors[$DB][0] = (GUICtrlRead($g_hChkAttackNearGoldMineDB) = $GUI_CHECKED)
			$g_abAttackStdSmartNearCollectors[$DB][1] = (GUICtrlRead($g_hChkAttackNearElixirCollectorDB) = $GUI_CHECKED)
			$g_abAttackStdSmartNearCollectors[$DB][2] = (GUICtrlRead($g_hChkAttackNearDarkElixirDrillDB) = $GUI_CHECKED)

			; ================================================== Multi Finger - Added by Simple Mod =================================== ;
			$g_iMultiFingerStyle = _GUICtrlComboBox_GetCurSel($g_hCmbDBMultiFinger)

			; ================================================== Unit/Wave Factor - Added by Simple Mod =============================== ;
			$g_iChkUnitFactor = (GUICtrlRead($g_hChkUnitFactor) = $GUI_CHECKED)
			$g_iChkWaveFactor = (GUICtrlRead($g_hChkWaveFactor) = $GUI_CHECKED)
			$g_iTxtUnitFactor = GUICtrlRead($g_hTxtUnitFactor)
			$g_iTxtWaveFactor = GUICtrlRead($g_hTxtWaveFactor)

	EndSwitch
EndFunc   ;==>ApplyConfig_600_29_DB_Standard

Func ApplyConfig_600_29_DB_Scripted($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack / Scripted <><><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbScriptRedlineImplDB, $g_aiAttackScrRedlineRoutine[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbScriptDroplineDB, $g_aiAttackScrDroplineEdge[$DB])
			PopulateComboScriptsFilesDB()
			Local $tempindex = _GUICtrlComboBox_FindStringExact($g_hCmbScriptNameDB, $g_sAttackScrScriptName[$DB])
			If $tempindex = -1 Then
				$tempindex = 0
				SetLog("Previous saved Scripted Attack not found (deleted, renamed?)", $COLOR_ERROR)
				SetLog("Automatically setted a default script, please check your config", $COLOR_ERROR)
			EndIf
			_GUICtrlComboBox_SetCurSel($g_hCmbScriptNameDB, $tempindex)
			cmbScriptNameDB()
			cmbScriptRedlineImplDB()
		Case "Save"
			$g_aiAttackScrRedlineRoutine[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbScriptRedlineImplDB)
			$g_aiAttackScrDroplineEdge[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbScriptDroplineDB)
			Local $indexofscript = _GUICtrlComboBox_GetCurSel($g_hCmbScriptNameDB)
			Local $scriptname
			_GUICtrlComboBox_GetLBText($g_hCmbScriptNameDB, $indexofscript, $scriptname)
			$g_sAttackScrScriptName[$DB] = $scriptname
			IniWriteS($g_sProfileConfigPath, "attack", "ScriptDB", $g_sAttackScrScriptName[$DB])
	EndSwitch
EndFunc   ;==>ApplyConfig_600_29_DB_Scripted

Func ApplyConfig_600_29_DB_Milking($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack / Milking <><><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbMilkAttackType, $g_iMilkAttackType = 1 ? 1 : 0)
			; A. Structures
			For $i = 0 To 8
				_GUICtrlComboBox_SetCurSel($g_hCmbMilkLvl[$i + 4], $g_aiMilkFarmElixirParam[$i] + 1)
			Next
			; B. Conditions
			GUICtrlSetState($g_hChkAtkElixirExtractors, $g_bMilkFarmLocateElixir ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAtkGoldMines, $g_bMilkFarmLocateMine ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbAtkGoldMinesLevel, $g_iMilkFarmMineParam - 1)
			GUICtrlSetState($g_hChkAtkDarkDrills, $g_bMilkFarmLocateDrill ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbAtkDarkDrillsLevel, $g_iMilkFarmDrillParam - 1)
			_GUICtrlComboBox_SetCurSel($g_hCmbRedlineResDistance, $g_iMilkFarmResMaxTilesFromBorder)
			GUICtrlSetState($g_hChkAttackMinesIfGold, $g_bMilkFarmAttackGoldMines ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackMinesIfElixir, $g_bMilkFarmAttackElixirExtractors ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackMinesIfDarkElixir, $g_bMilkFarmAttackDarkDrills ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAttackMinesIfGold, $g_iMilkFarmLimitGold)
			GUICtrlSetData($g_hTxtAttackMinesIfElixir, $g_iMilkFarmLimitElixir)
			GUICtrlSetData($g_hTxtAttackMinesIfDarkElixir, $g_iMilkFarmLimitDark)
			chkAttackMinesifGold()
			chkAttackMinesifelixir()
			chkAttackMinesifdarkElixir()
			; C. Attack
			GUICtrlSetData($g_hTxtLowerXWave, $g_iMilkFarmTroopForWaveMin)
			GUICtrlSetData($g_hTxtUpperXWave, $g_iMilkFarmTroopForWaveMax)
			GUICtrlSetData($g_hTxtMaxWaves, $g_iMilkFarmTroopMaxWaves)
			GUICtrlSetData($g_hTxtLowerDelayWaves, $g_iMilkFarmDelayFromWavesMin)
			GUICtrlSetData($g_hTxtUpperDelayWaves, $g_iMilkFarmDelayFromWavesMax)
			_GUICtrlComboBox_SetCurSel($g_hCmbMilkingAttackDropGoblinAlgorithm, $g_iMilkingAttackDropGoblinAlgorithm = 1 ? 1 : 0)
			_GUICtrlComboBox_SetCurSel($g_hCmbStructureOrder, $g_iMilkingAttackStructureOrder)
			GUICtrlSetState($g_hChkStructureDestroyedBeforeAttack, $g_bMilkingAttackCheckStructureDestroyedBeforeAttack ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkStructureDestroyedAfterAttack, $g_bMilkingAttackCheckStructureDestroyedAfterAttack ? $GUI_CHECKED : $GUI_UNCHECKED)
			; D. After Milking
			GUICtrlSetState($g_hChkMilkAfterAttackTHSnipe, $g_bMilkAttackAfterTHSnipeEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkMilkAfterAttackTHSnipe()
			GUICtrlSetData($g_hTxtMaxTilesMilk, $g_iMilkFarmTHMaxTilesFromBorder)
			Local $FileSearch, $NewFile
			$FileSearch = FileFindFirstFile($g_sTHSnipeAttacksPath & "\*.csv")
			Local $output = ""
			While True
				$NewFile = FileFindNextFile($FileSearch)
				If @error Then ExitLoop
				$output = $output & StringLeft($NewFile, StringLen($NewFile) - 4) & "|"
			WEnd
			FileClose($FileSearch)
			$output = StringLeft($output, StringLen($output) - 1) ;remove last |
			GUICtrlSetData($g_hCmbMilkSnipeAlgorithm, $output)
			_GUICtrlComboBox_SetCurSel($g_hCmbMilkSnipeAlgorithm, _GUICtrlComboBox_FindStringExact($g_hCmbMilkSnipeAlgorithm, $g_sMilkFarmAlgorithmTh))
			GUICtrlSetState($g_hChkSnipeIfNoElixir, $g_bMilkFarmSnipeEvenIfNoExtractorsFound ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkMilkAfterAttackScripted, $g_bMilkAttackAfterScriptedAtkEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			PopulateComboMilkingCSVScriptsFiles()
			Local $tempindex = _GUICtrlComboBox_FindStringExact($g_hCmbMilkingCSVScriptName, $g_sMilkAttackCSVscript)
			If $tempindex = -1 Then
				$tempindex = 0
				SetLog("Previous saved Milking Scripted Attack not found (deleted, renamed?)", $COLOR_ERROR)
				SetLog("Automatically setted a default script, please check your config", $COLOR_ERROR)
			EndIf
			_GUICtrlComboBox_SetCurSel($g_hCmbMilkingCSVScriptName, $tempindex)
			; Advanced
			GUICtrlSetState($g_hChkMilkFarmForceTolerance, $g_bMilkFarmForceToleranceEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkMilkFarmForcetolerance()
			GUICtrlSetData($g_hTxtMilkFarmForceToleranceNormal, $g_iMilkFarmForceToleranceNormal)
			GUICtrlSetData($g_hTxtMilkFarmForceToleranceBoosted, $g_iMilkFarmForceToleranceBoosted)
			GUICtrlSetData($g_hTxtMilkFarmForceToleranceDestroyed, $g_iMilkFarmForceToleranceDestroyed)
			If $g_bDevMode = True Then
				GUICtrlSetState($g_hGrpMilkingDebug, $GUI_SHOW)
				GUICtrlSetState($g_hChkMilkingDebugIMG, $GUI_SHOW)
				GUICtrlSetState($g_hChkMilkingDebugVillage, $GUI_SHOW)
				GUICtrlSetState($g_hChkMilkingDebugFullSearch, $GUI_SHOW)
				GUICtrlSetState($g_hChkMilkingDebugIMG, $g_bDebugResourcesOffset ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetState($g_hChkMilkingDebugVillage, $g_bDebugMilkingIMGmake ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetState($g_hChkMilkingDebugFullSearch, $g_bDebugContinueSearchElixir ? $GUI_CHECKED : $GUI_UNCHECKED)
			EndIf
		Case "Save"
			$g_iMilkAttackType = _GUICtrlComboBox_GetCurSel($g_hCmbMilkAttackType)
			; A. Structures
			Local $TempMilkFarmElixirParam = ""
			For $i = 0 To 8
				$g_aiMilkFarmElixirParam[$i] = _GUICtrlComboBox_GetCurSel($g_hCmbMilkLvl[$i + 4]) - 1
			Next
			; B. Conditions
			$g_bMilkFarmLocateElixir = (GUICtrlRead($g_hChkAtkElixirExtractors) = $GUI_CHECKED)
			$g_bMilkFarmLocateMine = (GUICtrlRead($g_hChkAtkGoldMines) = $GUI_CHECKED)
			$g_iMilkFarmMineParam = _GUICtrlComboBox_GetCurSel($g_hCmbAtkGoldMinesLevel) + 1
			$g_bMilkFarmLocateDrill = (GUICtrlRead($g_hChkAtkDarkDrills) = $GUI_CHECKED)
			$g_iMilkFarmDrillParam = _GUICtrlComboBox_GetCurSel($g_hCmbAtkDarkDrillsLevel) + 1
			$g_iMilkFarmResMaxTilesFromBorder = _GUICtrlComboBox_GetCurSel($g_hCmbRedlineResDistance)
			$g_bMilkFarmAttackGoldMines = (GUICtrlRead($g_hChkAttackMinesIfGold) = $GUI_CHECKED)
			$g_bMilkFarmAttackElixirExtractors = (GUICtrlRead($g_hChkAttackMinesIfElixir) = $GUI_CHECKED)
			$g_bMilkFarmAttackDarkDrills = (GUICtrlRead($g_hChkAttackMinesIfDarkElixir) = $GUI_CHECKED)
			$g_iMilkFarmLimitGold = GUICtrlRead($g_hTxtAttackMinesIfGold)
			$g_iMilkFarmLimitElixir = GUICtrlRead($g_hTxtAttackMinesIfElixir)
			$g_iMilkFarmLimitDark = GUICtrlRead($g_hTxtAttackMinesIfDarkElixir)
			; C. Attack
			$g_iMilkFarmTroopForWaveMin = GUICtrlRead($g_hTxtLowerXWave)
			$g_iMilkFarmTroopForWaveMax = GUICtrlRead($g_hTxtUpperXWave)
			$g_iMilkFarmTroopMaxWaves = GUICtrlRead($g_hTxtMaxWaves)
			$g_iMilkFarmDelayFromWavesMin = GUICtrlRead($g_hTxtLowerDelayWaves)
			$g_iMilkFarmDelayFromWavesMax = GUICtrlRead($g_hTxtUpperDelayWaves)
			$g_iMilkingAttackDropGoblinAlgorithm = _GUICtrlComboBox_GetCurSel($g_hCmbMilkingAttackDropGoblinAlgorithm)
			$g_iMilkingAttackStructureOrder = _GUICtrlComboBox_GetCurSel($g_hCmbStructureOrder)
			$g_bMilkingAttackCheckStructureDestroyedBeforeAttack = (GUICtrlRead($g_hChkStructureDestroyedBeforeAttack) = $GUI_CHECKED)
			$g_bMilkingAttackCheckStructureDestroyedAfterAttack = (GUICtrlRead($g_hChkStructureDestroyedAfterAttack) = $GUI_CHECKED)
			; D. After Milking
			$g_bMilkAttackAfterTHSnipeEnable = (GUICtrlRead($g_hChkMilkAfterAttackTHSnipe) = $GUI_CHECKED)
			$g_iMilkFarmTHMaxTilesFromBorder = GUICtrlRead($g_hTxtMaxTilesMilk)
			$g_sMilkFarmAlgorithmTh = GUICtrlRead($g_hCmbMilkSnipeAlgorithm)
			$g_bMilkFarmSnipeEvenIfNoExtractorsFound = (GUICtrlRead($g_hChkSnipeIfNoElixir) = $GUI_CHECKED)
			$g_bMilkAttackAfterScriptedAtkEnable = (GUICtrlRead($g_hChkMilkAfterAttackScripted) = $GUI_CHECKED)
			Local $indexofscript = _GUICtrlComboBox_GetCurSel($g_hCmbMilkingCSVScriptName)
			Local $scriptname
			_GUICtrlComboBox_GetLBText($g_hCmbMilkingCSVScriptName, $indexofscript, $scriptname)
			$g_sMilkAttackCSVscript = $scriptname
			; Advanced
			$g_bMilkFarmForceToleranceEnable = (GUICtrlRead($g_hChkMilkFarmForceTolerance) = $GUI_CHECKED)
			$g_iMilkFarmForceToleranceNormal = GUICtrlRead($g_hTxtMilkFarmForceToleranceNormal)
			$g_iMilkFarmForceToleranceBoosted = GUICtrlRead($g_hTxtMilkFarmForceToleranceBoosted)
			$g_iMilkFarmForceToleranceDestroyed = GUICtrlRead($g_hTxtMilkFarmForceToleranceDestroyed)
			If $g_bDevMode Then
				$g_bDebugResourcesOffset = (GUICtrlRead($g_hChkMilkingDebugIMG) = $GUI_CHECKED)
				$g_bDebugMilkingIMGmake = (GUICtrlRead($g_hChkMilkingDebugVillage) = $GUI_CHECKED)
				$g_bDebugContinueSearchElixir = (GUICtrlRead($g_hChkMilkingDebugFullSearch) = $GUI_CHECKED)
			EndIf
	EndSwitch
EndFunc   ;==>ApplyConfig_600_29_DB_Milking

Func ApplyConfig_600_29_DB_SmartFarm($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Attack / SmartFarm <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetData($g_hTxtInsidePercentage, $g_iTxtInsidePercentage)
			GUICtrlSetData($g_hTxtOutsidePercentage, $g_iTxtOutsidePercentage)
			GUICtrlSetState($g_hChkDebugSmartFarm, $g_bDebugSmartFarm ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_iTxtInsidePercentage = GUICtrlRead($g_hTxtInsidePercentage)
			$g_iTxtOutsidePercentage = GUICtrlRead($g_hTxtOutsidePercentage)
			$g_bDebugSmartFarm = (GUICtrlRead($g_hChkDebugSmartFarm) = $GUI_CHECKED)
	EndSwitch
EndFunc

Func ApplyConfig_600_29_LB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack <><><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbABAlgorithm, $g_aiAttackAlgorithm[$LB])
			cmbABAlgorithm()
			_GUICtrlComboBox_SetCurSel($g_hCmbABSelectTroop, $g_aiAttackTroopSelection[$LB])
			GUICtrlSetState($g_hChkABKingAttack, BitAND($g_aiAttackUseHeroes[$LB], $eHeroKing) = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABQueenAttack, BitAND($g_aiAttackUseHeroes[$LB], $eHeroQueen) = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABWardenAttack, BitAND($g_aiAttackUseHeroes[$LB], $eHeroWarden) = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)
			Local $temp1, $temp2, $temp3
			$temp1 = GUICtrlRead($g_hChkABKingAttack) = $GUI_CHECKED ? $eHeroKing : $eHeroNone
			$temp2 = GUICtrlRead($g_hChkABQueenAttack) = $GUI_CHECKED ? $eHeroQueen : $eHeroNone
			$temp3 = GUICtrlRead($g_hChkABWardenAttack) = $GUI_CHECKED ? $eHeroWarden : $eHeroNone
			$g_aiAttackUseHeroes[$LB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
			GUICtrlSetState($g_hChkABDropCC, $g_abAttackDropCC[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABLightSpell, $g_abAttackUseLightSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABHealSpell, $g_abAttackUseHealSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABRageSpell, $g_abAttackUseRageSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABJumpSpell, $g_abAttackUseJumpSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABFreezeSpell, $g_abAttackUseFreezeSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABCloneSpell, $g_abAttackUseCloneSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABPoisonSpell, $g_abAttackUsePoisonSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABEarthquakeSpell, $g_abAttackUseEarthquakeSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABHasteSpell, $g_abAttackUseHasteSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABSkeletonSpell, $g_abAttackUseSkeletonSpell[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTHSnipeBeforeLBEnable, $g_bTHSnipeBeforeEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTHSnipeBeforeLBEnable()
			GUICtrlSetData($g_hTxtTHSnipeBeforeLBTiles, $g_iTHSnipeBeforeTiles[$LB])
			LoadABSnipeAttacks() ; recreate combo box values
			_GUICtrlComboBox_SetCurSel($g_hCmbTHSnipeBeforeLBScript, _GUICtrlComboBox_FindStringExact($g_hCmbTHSnipeBeforeLBScript, $g_iTHSnipeBeforeScript[$LB]))

			_GUICtrlComboBox_SetCurSel($g_hCmbABSiege, $g_aiAttackUseSiege[$LB])
		Case "Save"
			$g_aiAttackAlgorithm[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbABAlgorithm)
			$g_aiAttackTroopSelection[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbABSelectTroop)
			Local $temp1, $temp2, $temp3
			$temp1 = GUICtrlRead($g_hChkABKingAttack) = $GUI_CHECKED ? $eHeroKing : $eHeroNone
			$temp2 = GUICtrlRead($g_hChkABQueenAttack) = $GUI_CHECKED ? $eHeroQueen : $eHeroNone
			$temp3 = GUICtrlRead($g_hChkABWardenAttack) = $GUI_CHECKED ? $eHeroWarden : $eHeroNone
			$g_aiAttackUseHeroes[$LB] = BitOR(Int($temp1), Int($temp2), Int($temp3))
			$g_abAttackDropCC[$LB] = (GUICtrlRead($g_hChkABDropCC) = $GUI_CHECKED)
			$g_abAttackUseLightSpell[$LB] = (GUICtrlRead($g_hChkABLightSpell) = $GUI_CHECKED)
			$g_abAttackUseHealSpell[$LB] = (GUICtrlRead($g_hChkABHealSpell) = $GUI_CHECKED)
			$g_abAttackUseRageSpell[$LB] = (GUICtrlRead($g_hChkABRageSpell) = $GUI_CHECKED)
			$g_abAttackUseJumpSpell[$LB] = (GUICtrlRead($g_hChkABJumpSpell) = $GUI_CHECKED)
			$g_abAttackUseFreezeSpell[$LB] = (GUICtrlRead($g_hChkABFreezeSpell) = $GUI_CHECKED)
			$g_abAttackUseCloneSpell[$LB] = (GUICtrlRead($g_hChkABCloneSpell) = $GUI_CHECKED)
			$g_abAttackUsePoisonSpell[$LB] = (GUICtrlRead($g_hChkABPoisonSpell) = $GUI_CHECKED)
			$g_abAttackUseEarthquakeSpell[$LB] = (GUICtrlRead($g_hChkABEarthquakeSpell) = $GUI_CHECKED)
			$g_abAttackUseHasteSpell[$LB] = (GUICtrlRead($g_hChkABHasteSpell) = $GUI_CHECKED)
			$g_abAttackUseSkeletonSpell[$LB] = (GUICtrlRead($g_hChkABSkeletonSpell) = $GUI_CHECKED)
			$g_bTHSnipeBeforeEnable[$LB] = (GUICtrlRead($g_hChkTHSnipeBeforeLBEnable) = $GUI_CHECKED)
			$g_iTHSnipeBeforeTiles[$LB] = GUICtrlRead($g_hTxtTHSnipeBeforeLBTiles)
			$g_iTHSnipeBeforeScript[$LB] = GUICtrlRead($g_hCmbTHSnipeBeforeLBScript)

			$g_aiAttackUseSiege[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbABSiege)
	EndSwitch

	ApplyConfig_600_29_LB_Standard($TypeReadSave)
	ApplyConfig_600_29_LB_Scripted($TypeReadSave)
EndFunc   ;==>ApplyConfig_600_29_LB

Func ApplyConfig_600_29_LB_Standard($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack / Standard <><><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardDropOrderAB, $g_aiAttackStdDropOrder[$LB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardDropSidesAB, $g_aiAttackStdDropSides[$LB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardUnitDelayAB, $g_aiAttackStdUnitDelay[$LB])
			_GUICtrlComboBox_SetCurSel($g_hCmbStandardWaveDelayAB, $g_aiAttackStdWaveDelay[$LB])
			GUICtrlSetState($g_hChkRandomSpeedAtkAB, $g_abAttackStdRandomizeDelay[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkRandomSpeedAtkAB()
			GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $g_abAttackStdSmartAttack[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartAttackRedAreaAB()
			_GUICtrlComboBox_SetCurSel($g_hCmbSmartDeployAB, $g_aiAttackStdSmartDeploy[$LB])
			GUICtrlSetState($g_hChkAttackNearGoldMineAB, $g_abAttackStdSmartNearCollectors[$LB][0] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackNearElixirCollectorAB, $g_abAttackStdSmartNearCollectors[$LB][1] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAttackNearDarkElixirDrillAB, $g_abAttackStdSmartNearCollectors[$LB][2] ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_aiAttackStdDropOrder[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropOrderAB)
			$g_aiAttackStdDropSides[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesAB)
			$g_aiAttackStdUnitDelay[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardUnitDelayAB)
			$g_aiAttackStdWaveDelay[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbStandardWaveDelayAB)
			$g_abAttackStdRandomizeDelay[$LB] = (GUICtrlRead($g_hChkRandomSpeedAtkAB) = $GUI_CHECKED)
			$g_abAttackStdSmartAttack[$LB] = (GUICtrlRead($g_hChkSmartAttackRedAreaAB) = $GUI_CHECKED)
			$g_aiAttackStdSmartDeploy[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbSmartDeployAB)
			$g_abAttackStdSmartNearCollectors[$LB][0] = (GUICtrlRead($g_hChkAttackNearGoldMineAB) = $GUI_CHECKED)
			$g_abAttackStdSmartNearCollectors[$LB][1] = (GUICtrlRead($g_hChkAttackNearElixirCollectorAB) = $GUI_CHECKED)
			$g_abAttackStdSmartNearCollectors[$LB][2] = (GUICtrlRead($g_hChkAttackNearDarkElixirDrillAB) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_29_LB_Standard

Func ApplyConfig_600_29_LB_Scripted($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / Attack / Scripted <><><><>
	Switch $TypeReadSave
		Case "Read"
			_GUICtrlComboBox_SetCurSel($g_hCmbScriptRedlineImplAB, $g_aiAttackScrRedlineRoutine[$LB])
			_GUICtrlComboBox_SetCurSel($g_hCmbScriptDroplineAB, $g_aiAttackScrDroplineEdge[$LB])
			PopulateComboScriptsFilesAB()
			Local $tempindex = _GUICtrlComboBox_FindStringExact($g_hCmbScriptNameAB, $g_sAttackScrScriptName[$LB])
			If $tempindex = -1 Then
				$tempindex = 0
				SetLog("Previous saved Scripted Attack not found (deleted, renamed?)", $COLOR_ERROR)
				SetLog("Automatically setted a default script, please check your config", $COLOR_ERROR)
			EndIf
			_GUICtrlComboBox_SetCurSel($g_hCmbScriptNameAB, $tempindex)
			cmbScriptNameAB()
			cmbScriptRedlineImplAB()
		Case "Save"
			$g_aiAttackScrRedlineRoutine[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbScriptRedlineImplAB)
			$g_aiAttackScrDroplineEdge[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbScriptDroplineAB)
			Local $indexofscript = _GUICtrlComboBox_GetCurSel($g_hCmbScriptNameAB)
			Local $scriptname
			_GUICtrlComboBox_GetLBText($g_hCmbScriptNameAB, $indexofscript, $scriptname)
			$g_sAttackScrScriptName[$LB] = $scriptname
			IniWriteS($g_sProfileConfigPath, "attack", "ScriptAB", $g_sAttackScrScriptName[$LB])
	EndSwitch
EndFunc   ;==>ApplyConfig_600_29_LB_Scripted

Func ApplyConfig_600_29_TS($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / TH Snipe / Attack <><><><>
	Switch $TypeReadSave
		Case "Read"
			; Attack
			_GUICtrlComboBox_SetCurSel($g_hCmbTSSelectTroop, $g_aiAttackTroopSelection[$TS])
			GUICtrlSetState($g_hChkTSKingAttack, BitAND($g_aiAttackUseHeroes[$TS], $eHeroKing) = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSQueenAttack, BitAND($g_aiAttackUseHeroes[$TS], $eHeroQueen) = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSWardenAttack, BitAND($g_aiAttackUseHeroes[$TS], $eHeroWarden) = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)
			Local $temp1, $temp2, $temp3
			$temp1 = GUICtrlRead($g_hChkTSKingAttack) = $GUI_CHECKED ? $eHeroKing : $eHeroNone
			$temp2 = GUICtrlRead($g_hChkTSQueenAttack) = $GUI_CHECKED ? $eHeroQueen : $eHeroNone
			$temp3 = GUICtrlRead($g_hChkTSWardenAttack) = $GUI_CHECKED ? $eHeroWarden : $eHeroNone
			$g_aiAttackUseHeroes[$TS] = BitOR(Int($temp1), Int($temp2), Int($temp3))
			GUICtrlSetState($g_hChkTSDropCC, $g_abAttackDropCC[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSLightSpell, $g_abAttackUseLightSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSHealSpell, $g_abAttackUseHealSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSRageSpell, $g_abAttackUseRageSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSJumpSpell, $g_abAttackUseJumpSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSFreezeSpell, $g_abAttackUseFreezeSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSPoisonSpell, $g_abAttackUsePoisonSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSEarthquakeSpell, $g_abAttackUseEarthquakeSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkTSHasteSpell, $g_abAttackUseHasteSpell[$TS] ? $GUI_CHECKED : $GUI_UNCHECKED)
			LoadThSnipeAttacks() ; recreate combo box values
			_GUICtrlComboBox_SetCurSel($g_hCmbAttackTHType, _GUICtrlComboBox_FindStringExact($g_hCmbAttackTHType, $g_sAtkTSType))
		Case "Save"
			$g_aiAttackTroopSelection[$TS] = _GUICtrlComboBox_GetCurSel($g_hCmbTSSelectTroop)
			Local $temp1, $temp2, $temp3
			$temp1 = GUICtrlRead($g_hChkTSKingAttack) = $GUI_CHECKED ? $eHeroKing : $eHeroNone
			$temp2 = GUICtrlRead($g_hChkTSQueenAttack) = $GUI_CHECKED ? $eHeroQueen : $eHeroNone
			$temp3 = GUICtrlRead($g_hChkTSWardenAttack) = $GUI_CHECKED ? $eHeroWarden : $eHeroNone
			$g_aiAttackUseHeroes[$TS] = BitOR(Int($temp1), Int($temp2), Int($temp3))
			$g_abAttackDropCC[$TS] = (GUICtrlRead($g_hChkTSDropCC) = $GUI_CHECKED)
			$g_abAttackUseLightSpell[$TS] = (GUICtrlRead($g_hChkTSLightSpell) = $GUI_CHECKED)
			$g_abAttackUseHealSpell[$TS] = (GUICtrlRead($g_hChkTSHealSpell) = $GUI_CHECKED)
			$g_abAttackUseRageSpell[$TS] = (GUICtrlRead($g_hChkTSRageSpell) = $GUI_CHECKED)
			$g_abAttackUseJumpSpell[$TS] = (GUICtrlRead($g_hChkTSJumpSpell) = $GUI_CHECKED)
			$g_abAttackUseFreezeSpell[$TS] = (GUICtrlRead($g_hChkTSFreezeSpell) = $GUI_CHECKED)
			$g_abAttackUsePoisonSpell[$TS] = (GUICtrlRead($g_hChkTSPoisonSpell) = $GUI_CHECKED)
			$g_abAttackUseEarthquakeSpell[$TS] = (GUICtrlRead($g_hChkTSEarthquakeSpell) = $GUI_CHECKED)
			$g_abAttackUseHasteSpell[$TS] = (GUICtrlRead($g_hChkTSHasteSpell) = $GUI_CHECKED)
			$g_sAtkTSType = GUICtrlRead($g_hCmbAttackTHType)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_29_TS

Func ApplyConfig_600_30($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / End Battle <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkShareAttack, $g_bShareAttackEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtShareMinGold, $g_iShareMinGold)
			GUICtrlSetData($g_hTxtShareMinElixir, $g_iShareMinElixir)
			GUICtrlSetData($g_hTxtShareMinDark, $g_iShareMinDark)
			GUICtrlSetData($g_hTxtShareMessage, StringReplace($g_sShareMessage, "|", @CRLF))
			chkShareAttack()
			GUICtrlSetState($g_hChkTakeLootSS, $g_bTakeLootSnapShot ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkScreenshotLootInfo, $g_bScreenshotLootInfo ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTakeLootSS()
		Case "Save"
			$g_bShareAttackEnable = (GUICtrlRead($g_hChkShareAttack) = $GUI_CHECKED)
			$g_iShareMinGold = GUICtrlRead($g_hTxtShareMinGold)
			$g_iShareMinElixir = GUICtrlRead($g_hTxtShareMinElixir)
			$g_iShareMinDark = GUICtrlRead($g_hTxtShareMinDark)
			$g_sShareMessage = StringReplace(GUICtrlRead($g_hTxtShareMessage), @CRLF, "|")
			$g_bTakeLootSnapShot = (GUICtrlRead($g_hChkTakeLootSS) = $GUI_CHECKED)
			$g_bScreenshotLootInfo = (GUICtrlRead($g_hChkScreenshotLootInfo) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_30

Func ApplyConfig_600_30_DB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / End Battle <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkStopAtkDBNoLoot1, $g_abStopAtkNoLoot1Enable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtStopAtkDBNoLoot1, $g_aiStopAtkNoLoot1Time[$DB])
			chkStopAtkDBNoLoot1()
			GUICtrlSetState($g_hChkStopAtkDBNoLoot2, $g_abStopAtkNoLoot2Enable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtStopAtkDBNoLoot2, $g_aiStopAtkNoLoot2Time[$DB])
			chkStopAtkDBNoLoot2()
			GUICtrlSetData($g_hTxtDBMinGoldStopAtk2, $g_aiStopAtkNoLoot2MinGold[$DB])
			GUICtrlSetData($g_hTxtDBMinElixirStopAtk2, $g_aiStopAtkNoLoot2MinElixir[$DB])
			GUICtrlSetData($g_hTxtDBMinDarkElixirStopAtk2, $g_aiStopAtkNoLoot2MinDark[$DB])
			GUICtrlSetState($g_hChkDBEndNoResources, $g_abStopAtkNoResources[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBEndOneStar, $g_abStopAtkOneStar[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBEndTwoStars, $g_abStopAtkTwoStars[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBEndPercentHigher, $g_abStopAtkPctHigherEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBPercentHigher, $g_aiStopAtkPctHigherAmt[$DB])
			chkDBEndPercentHigher()
			GUICtrlSetState($g_hChkDBEndPercentChange, $g_abStopAtkPctNoChangeEnable[$DB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBPercentChange, $g_aiStopAtkPctNoChangeTime[$DB])
			chkDBEndPercentChange()
		Case "Save"
			$g_abStopAtkNoLoot1Enable[$DB] = (GUICtrlRead($g_hChkStopAtkDBNoLoot1) = $GUI_CHECKED)
			$g_aiStopAtkNoLoot1Time[$DB] = Int(GUICtrlRead($g_hTxtStopAtkDBNoLoot1))
			$g_abStopAtkNoLoot2Enable[$DB] = (GUICtrlRead($g_hChkStopAtkDBNoLoot2) = $GUI_CHECKED)
			$g_aiStopAtkNoLoot2Time[$DB] = Int(GUICtrlRead($g_hTxtStopAtkDBNoLoot2))
			$g_aiStopAtkNoLoot2MinGold[$DB] = Int(GUICtrlRead($g_hTxtDBMinGoldStopAtk2))
			$g_aiStopAtkNoLoot2MinElixir[$DB] = Int(GUICtrlRead($g_hTxtDBMinElixirStopAtk2))
			$g_aiStopAtkNoLoot2MinDark[$DB] = Int(GUICtrlRead($g_hTxtDBMinDarkElixirStopAtk2))
			$g_abStopAtkNoResources[$DB] = (GUICtrlRead($g_hChkDBEndNoResources) = $GUI_CHECKED)
			$g_abStopAtkOneStar[$DB] = (GUICtrlRead($g_hChkDBEndOneStar) = $GUI_CHECKED)
			$g_abStopAtkTwoStars[$DB] = (GUICtrlRead($g_hChkDBEndTwoStars) = $GUI_CHECKED)
			$g_abStopAtkPctHigherEnable[$DB] = (GUICtrlRead($g_hChkDBEndPercentHigher) = $GUI_CHECKED)
			$g_aiStopAtkPctHigherAmt[$DB] = GUICtrlRead($g_hTxtDBPercentHigher)
			$g_abStopAtkPctNoChangeEnable[$DB] = (GUICtrlRead($g_hChkDBEndPercentChange) = $GUI_CHECKED)
			$g_aiStopAtkPctNoChangeTime[$DB] = GUICtrlRead($g_hTxtDBPercentChange)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_30_DB

Func ApplyConfig_600_30_LB($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Activebase / End Battle <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkStopAtkABNoLoot1, $g_abStopAtkNoLoot1Enable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtStopAtkABNoLoot1, $g_aiStopAtkNoLoot1Time[$LB])
			chkStopAtkABNoLoot1()
			GUICtrlSetState($g_hChkStopAtkABNoLoot2, $g_abStopAtkNoLoot2Enable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtStopAtkABNoLoot2, $g_aiStopAtkNoLoot2Time[$LB])
			chkStopAtkABNoLoot2()
			GUICtrlSetData($g_hTxtABMinGoldStopAtk2, $g_aiStopAtkNoLoot2MinGold[$LB])
			GUICtrlSetData($g_hTxtABMinElixirStopAtk2, $g_aiStopAtkNoLoot2MinElixir[$LB])
			GUICtrlSetData($g_hTxtABMinDarkElixirStopAtk2, $g_aiStopAtkNoLoot2MinDark[$LB])
			GUICtrlSetState($g_hChkABEndNoResources, $g_abStopAtkNoResources[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABEndOneStar, $g_abStopAtkOneStar[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABEndTwoStars, $g_abStopAtkTwoStars[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDESideEB, $g_bDESideEndEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDESideEB()
			GUICtrlSetData($g_hTxtDELowEndMin, $g_iDESideEndMin)
			GUICtrlSetState($g_hChkDisableOtherEBO, $g_bDESideDisableOther ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDEEndBk, $g_bDESideEndBKWeak ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDEEndAq, $g_bDESideEndAQWeak ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDEEndOneStar, $g_bDESideEndOneStar ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkABEndPercentHigher, $g_abStopAtkPctHigherEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtABPercentHigher, $g_aiStopAtkPctHigherAmt[$LB])
			chkABEndPercentHigher()
			GUICtrlSetState($g_hChkABEndPercentChange, $g_abStopAtkPctNoChangeEnable[$LB] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtABPercentChange, $g_aiStopAtkPctNoChangeTime[$LB])
			chkABEndPercentChange()
		Case "Save"
			$g_abStopAtkNoLoot1Enable[$LB] = (GUICtrlRead($g_hChkStopAtkABNoLoot1) = $GUI_CHECKED)
			$g_aiStopAtkNoLoot1Time[$LB] = Int(GUICtrlRead($g_hTxtStopAtkABNoLoot1))
			$g_abStopAtkNoLoot2Enable[$LB] = (GUICtrlRead($g_hChkStopAtkABNoLoot2) = $GUI_CHECKED)
			$g_aiStopAtkNoLoot2Time[$LB] = (GUICtrlRead($g_hTxtStopAtkABNoLoot2))
			$g_aiStopAtkNoLoot2MinGold[$LB] = Int(GUICtrlRead($g_hTxtABMinGoldStopAtk2))
			$g_aiStopAtkNoLoot2MinElixir[$LB] = Int(GUICtrlRead($g_hTxtABMinElixirStopAtk2))
			$g_aiStopAtkNoLoot2MinDark[$LB] = Int(GUICtrlRead($g_hTxtABMinDarkElixirStopAtk2))
			$g_abStopAtkNoResources[$LB] = (GUICtrlRead($g_hChkABEndNoResources) = $GUI_CHECKED)
			$g_abStopAtkOneStar[$LB] = (GUICtrlRead($g_hChkABEndOneStar) = $GUI_CHECKED)
			$g_abStopAtkTwoStars[$LB] = (GUICtrlRead($g_hChkABEndTwoStars) = $GUI_CHECKED)
			$g_bDESideEndEnable = (GUICtrlRead($g_hChkDESideEB) = $GUI_CHECKED)
			$g_iDESideEndMin = GUICtrlRead($g_hTxtDELowEndMin)
			$g_bDESideDisableOther = (GUICtrlRead($g_hChkDisableOtherEBO) = $GUI_CHECKED)
			$g_bDESideEndAQWeak = (GUICtrlRead($g_hChkDEEndAq) = $GUI_CHECKED)
			$g_bDESideEndBKWeak = (GUICtrlRead($g_hChkDEEndBk) = $GUI_CHECKED)
			$g_bDESideEndOneStar = (GUICtrlRead($g_hChkDEEndOneStar) = $GUI_CHECKED)
			$g_abStopAtkPctHigherEnable[$LB] = (GUICtrlRead($g_hChkABEndPercentHigher) = $GUI_CHECKED)
			$g_aiStopAtkPctHigherAmt[$LB] = GUICtrlRead($g_hTxtABPercentHigher)
			$g_abStopAtkPctNoChangeEnable[$LB] = (GUICtrlRead($g_hChkABEndPercentChange) = $GUI_CHECKED)
			$g_aiStopAtkPctNoChangeTime[$LB] = GUICtrlRead($g_hTxtABPercentChange)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_30_LB

Func ApplyConfig_600_30_TS($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / TH Snipe / End Battle <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkTSActivateCamps2, $g_bEndTSCampsEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTSActivateCamps2()
			GUICtrlSetData($g_hTxtTSArmyCamps2, $g_iEndTSCampsPct)
		Case "Save"
			$g_bEndTSCampsEnable = (GUICtrlRead($g_hChkTSActivateCamps2) = $GUI_CHECKED)
			$g_iEndTSCampsPct = GUICtrlRead($g_hTxtTSArmyCamps2)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_30_TS

Func ApplyConfig_600_31($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Deadbase / Collectors <><><><>
	Switch $TypeReadSave
		Case "Read"
			For $i = 6 To 12
				GUICtrlSetState($g_ahChkDBCollectorLevel[$i], $g_abCollectorLevelEnabled[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetState($g_ahCmbDBCollectorLevel[$i], $g_abCollectorLevelEnabled[$i] ? $GUI_ENABLE : $GUI_DISABLE)
				_GUICtrlComboBox_SetCurSel($g_ahCmbDBCollectorLevel[$i], $g_aiCollectorLevelFill[$i])
			Next
			GUICtrlSetState($g_hChkDBDisableCollectorsFilter, $g_bCollectorFilterDisable ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbMinCollectorMatches, $g_iCollectorMatchesMin - 1)
			GUICtrlSetData($g_hSldCollectorTolerance, $g_iCollectorToleranceOffset)
			checkCollectors()

			; Check Collector Outside - Simple Mod
			GUICtrlSetState($g_hChkDBMeetCollOutside, $g_bDBMeetCollOutside = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinCollOutsidePercent, $g_iTxtDBMinCollOutsidePercent)
			GUICtrlSetState($g_hChkDBCollectorsNearRedline, $g_bDBCollectorsNearRedline = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbRedlineTiles, $g_iCmbRedlineTiles)
			GUICtrlSetState($g_hChkSkipCollectorCheck, $g_bSkipCollectorCheck = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSkipCollectorGold, $g_iTxtSkipCollectorGold)
			GUICtrlSetData($g_hTxtSkipCollectorElixir, $g_iTxtSkipCollectorElixir)
			GUICtrlSetData($g_hTxtSkipCollectorDark, $g_iTxtSkipCollectorDark)
			GUICtrlSetState($g_hChkSkipCollectorCheckTH, $g_bSkipCollectorCheckTH = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbSkipCollectorCheckTH, $g_iCmbSkipCollectorCheckTH)
			chkDBMeetCollOutside()

		Case "Save"
			For $i = 6 To 12
				$g_abCollectorLevelEnabled[$i] = (GUICtrlRead($g_ahChkDBCollectorLevel[$i]) = $GUI_CHECKED)
				$g_aiCollectorLevelFill[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbDBCollectorLevel[$i])
			Next
			$g_bCollectorFilterDisable = (GUICtrlRead($g_hChkDBDisableCollectorsFilter) = $GUI_CHECKED)
			$g_iCollectorMatchesMin = _GUICtrlComboBox_GetCurSel($g_hCmbMinCollectorMatches) + 1
			$g_iCollectorToleranceOffset = GUICtrlRead($g_hSldCollectorTolerance)

			; Check Collector Outside - Simple Mod
			$g_bDBMeetCollOutside = (GUICtrlRead($g_hChkDBMeetCollOutside) = $GUI_CHECKED)
			$g_iTxtDBMinCollOutsidePercent = GUICtrlRead($g_hTxtDBMinCollOutsidePercent)
			$g_bDBCollectorsNearRedline = GUICtrlRead($g_hChkDBCollectorsNearRedline) = $GUI_CHECKED ? 1 : 0
			$g_iCmbRedlineTiles = _GUICtrlComboBox_GetCurSel($g_hCmbRedlineTiles)
			$g_bSkipCollectorCheck = GUICtrlRead($g_hChkSkipCollectorCheck) = $GUI_CHECKED ? 1 : 0
			$g_iTxtSkipCollectorGold = GUICtrlRead($g_hTxtSkipCollectorGold)
			$g_iTxtSkipCollectorElixir = GUICtrlRead($g_hTxtSkipCollectorElixir)
			$g_iTxtSkipCollectorDark = GUICtrlRead($g_hTxtSkipCollectorDark)
			$g_bSkipCollectorCheckTH = GUICtrlRead($g_hChkSkipCollectorCheckTH) = $GUI_CHECKED ? 1 : 0
			$g_iCmbSkipCollectorCheckTH = _GUICtrlComboBox_GetCurSel($g_hCmbSkipCollectorCheckTH)

	EndSwitch
EndFunc   ;==>ApplyConfig_600_31

Func ApplyConfig_600_32($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / Trophy Settings <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkTrophyRange, $g_bDropTrophyEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtMaxTrophy, $g_iDropTrophyMax)
			GUICtrlSetData($g_hTxtDropTrophy, $g_iDropTrophyMin)
			GUICtrlSetState($g_hChkTrophyHeroes, $g_bDropTrophyUseHeroes ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTrophyHeroes()
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyHeroesPriority, $g_iDropTrophyHeroesPriority)
			GUICtrlSetState($g_hChkTrophyAtkDead, $g_bDropTrophyAtkDead ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDropTrophyArmyMin, $g_iDropTrophyArmyMinPct)
			chkTrophyRange()
			TxtDropTrophy()
			TxtMaxTrophy()
		Case "Save"
			$g_bDropTrophyEnable = (GUICtrlRead($g_hChkTrophyRange) = $GUI_CHECKED)
			$g_iDropTrophyMax = GUICtrlRead($g_hTxtMaxTrophy)
			$g_iDropTrophyMin = GUICtrlRead($g_hTxtDropTrophy)
			$g_bDropTrophyUseHeroes = (GUICtrlRead($g_hChkTrophyHeroes) = $GUI_CHECKED)
			$g_iDropTrophyHeroesPriority = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyHeroesPriority)
			$g_bDropTrophyAtkDead = (GUICtrlRead($g_hChkTrophyAtkDead) = $GUI_CHECKED)
			$g_iDropTrophyArmyMinPct = GUICtrlRead($g_hTxtDropTrophyArmyMin)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_32

Func ApplyConfig_600_33($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Drop Order Troops <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkCustomDropOrderEnable, $g_bCustomDropOrderEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDropOrder()
			For $p = 0 To UBound($g_ahCmbDropOrder) - 1
				_GUICtrlComboBox_SetCurSel($g_ahCmbDropOrder[$p], $g_aiCmbCustomDropOrder[$p])
				_GUICtrlSetImage($g_ahImgDropOrder[$p], $g_sLibIconPath, $g_aiDropOrderIcon[$g_aiCmbCustomDropOrder[$p] + 1])
			Next
			If $g_bCustomDropOrderEnable Then ; only update troop train order if enabled
				If Not ChangeDropOrder() Then ; process error
					SetDefaultDropOrderGroup()
					GUICtrlSetState($g_hChkCustomDropOrderEnable, $GUI_UNCHECKED)
					$g_bCustomDropOrderEnable = False
					GUICtrlSetState($g_hBtnDropOrderSet, $GUI_DISABLE) ; disable button
					GUICtrlSetState($g_hBtnRemoveDropOrder, $GUI_DISABLE)
					For $i = 0 To UBound($g_ahCmbDropOrder) - 1
						GUICtrlSetState($g_ahCmbDropOrder[$i], $GUI_DISABLE) ; disable combo boxes
					Next
				EndIf
			EndIf
		Case "Save"
			$g_bCustomDropOrderEnable = (GUICtrlRead($g_hChkCustomDropOrderEnable) = $GUI_CHECKED)
			For $p = 0 To UBound($g_ahCmbDropOrder) - 1
				$g_aiCmbCustomDropOrder[$p] = _GUICtrlComboBox_GetCurSel($g_ahCmbDropOrder[$p])
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_600_33

Func ApplyConfig_600_35_1($TypeReadSave)
	; <><><><> Bot / Options <><><><>
	Switch $TypeReadSave
		Case "Read"
			LoadLanguagesComboBox() ; recreate combo box values
			GUICtrlSetState($g_hChkDisableSplash, $g_bDisableSplash ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkForMBRUpdates, $g_bCheckVersion ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDeleteLogs, $g_bDeleteLogs ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDeleteLogsDays, $g_iDeleteLogsDays)
			chkDeleteLogs()
			GUICtrlSetState($g_hChkDeleteTemp, $g_bDeleteTemp ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDeleteTempDays, $g_iDeleteTempDays)
			chkDeleteTemp()
			GUICtrlSetState($g_hChkDeleteLoots, $g_bDeleteLoots ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDeleteLootsDays, $g_iDeleteLootsDays)
			chkDeleteLoots()
			GUICtrlSetState($g_hChkAutostart, $g_bAutoStart ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAutostartDelay, $g_iAutoStartDelay)
			chkAutoStart()
			GUICtrlSetState($g_hChkCheckGameLanguage, $g_bCheckGameLanguage ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAutoAlign, $g_bAutoAlignEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDisposeWindows()
			_GUICtrlComboBox_SetCurSel($g_hCmbAlignmentOptions, $g_iAutoAlignPosition)
			GUICtrlSetData($g_hTxtAlignOffsetX, $g_iAutoAlignOffsetX)
			GUICtrlSetData($g_hTxtAlignOffsetY, $g_iAutoAlignOffsetY)
			;GUICtrlSetState($g_hChkUpdatingWhenMinimized, $g_bUpdatingWhenMinimized ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkBotCustomTitleBarClick, ((BitAND($g_iBotDesignFlags, 1)) ? ($GUI_CHECKED) : ($GUI_UNCHECKED)))
			GUICtrlSetState($g_hChkBotAutoSlideClick, ((BitAND($g_iBotDesignFlags, 2)) ? ($GUI_CHECKED) : ($GUI_UNCHECKED)))
			GUICtrlSetState($g_hChkHideWhenMinimized, $g_bHideWhenMinimized ? $GUI_CHECKED : $GUI_UNCHECKED)
			TrayItemSetState($g_hTiHide, $g_bHideWhenMinimized ? $TRAY_CHECKED : $TRAY_UNCHECKED)
			GUICtrlSetState($g_hChkUseRandomClick, $g_bUseRandomClick ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkScreenshotType, $g_bScreenshotPNGFormat ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkScreenshotHideName, $g_bScreenshotHideName ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtTimeAnotherDevice, Int(Int($g_iAnotherDeviceWaitTime) / 60))
			GUICtrlSetState($g_hChkSinglePBTForced, $g_bForceSinglePBLogoff ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSinglePBTimeForced, $g_iSinglePBForcedLogoffTime)
			GUICtrlSetData($g_hTxtPBTimeForcedExit, $g_iSinglePBForcedEarlyExitTime)
			chkSinglePBTForced()
			GUICtrlSetState($g_hChkAutoResume, $g_bAutoResumeEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAutoResumeTime, $g_iAutoResumeTime)
			chkAutoResume()
			GUICtrlSetState($g_hChkDisableNotifications, $g_bDisableNotifications ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkFixClanCastle, $g_bForceClanCastleDetection ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSqlite, $g_bUseStatistics ? $GUI_CHECKED : $GUI_UNCHECKED)

			GUICtrlSetState($g_hChkOnlySCIDAccounts, $g_bOnlySCIDAccounts ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbWhatSCIDAccount2Use, $g_iWhatSCIDAccount2Use)

			GUICtrlSetState($g_hChkLabCheck, $g_iChkLabCheck = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
   		    chkLabCheck()
		Case "Save"
			$g_bDisableSplash = (GUICtrlRead($g_hChkDisableSplash) = $GUI_CHECKED)
			$g_bCheckVersion = (GUICtrlRead($g_hChkForMBRUpdates) = $GUI_CHECKED)
			$g_bDeleteLogs = (GUICtrlRead($g_hChkDeleteLogs) = $GUI_CHECKED)
			$g_iDeleteLogsDays = GUICtrlRead($g_hTxtDeleteLogsDays)
			$g_bDeleteTemp = (GUICtrlRead($g_hChkDeleteTemp) = $GUI_CHECKED)
			$g_iDeleteTempDays = GUICtrlRead($g_hTxtDeleteTempDays)
			$g_bDeleteLoots = (GUICtrlRead($g_hChkDeleteLoots) = $GUI_CHECKED)
			$g_iDeleteLootsDays = GUICtrlRead($g_hTxtDeleteLootsDays)
			$g_bAutoStart = (GUICtrlRead($g_hChkAutostart) = $GUI_CHECKED)
			$g_iAutoStartDelay = GUICtrlRead($g_hTxtAutostartDelay)
			$g_bCheckGameLanguage = (GUICtrlRead($g_hChkCheckGameLanguage) = $GUI_CHECKED)
			$g_bAutoAlignEnable = (GUICtrlRead($g_hChkAutoAlign) = $GUI_CHECKED)
			$g_iAutoAlignPosition = _GUICtrlComboBox_GetCurSel($g_hCmbAlignmentOptions)
			$g_iAutoAlignOffsetX = GUICtrlRead($g_hTxtAlignOffsetX)
			$g_iAutoAlignOffsetY = GUICtrlRead($g_hTxtAlignOffsetY)
			;$g_bUpdatingWhenMinimized = GUICtrlRead($g_hChkUpdatingWhenMinimized) = $GUI_CHECKED ? 1 : 0 ; disabled as is must be always on
			$g_iBotDesignFlags = BitOR(BitAND($g_iBotDesignFlags, BitNOT(1)), ((GUICtrlRead($g_hChkBotCustomTitleBarClick) = $GUI_CHECKED) ? (1) : (0)))
			$g_iBotDesignFlags = BitOR(BitAND($g_iBotDesignFlags, BitNOT(2)), ((GUICtrlRead($g_hChkBotAutoSlideClick) = $GUI_CHECKED) ? (2) : (0)))
			$g_bHideWhenMinimized = (GUICtrlRead($g_hChkHideWhenMinimized) = $GUI_CHECKED)

			$g_bUseRandomClick = (GUICtrlRead($g_hChkUseRandomClick) = $GUI_CHECKED)
			$g_bScreenshotPNGFormat = (GUICtrlRead($g_hChkScreenshotType) = $GUI_CHECKED)
			$g_bScreenshotHideName = (GUICtrlRead($g_hChkScreenshotHideName) = $GUI_CHECKED)
			$g_iAnotherDeviceWaitTime = Int(GUICtrlRead($g_hTxtTimeAnotherDevice)) * 60 ; Minutes are entered
			$g_bForceSinglePBLogoff = (GUICtrlRead($g_hChkSinglePBTForced) = $GUI_CHECKED)
			$g_iSinglePBForcedLogoffTime = GUICtrlRead($g_hTxtSinglePBTimeForced)
			$g_iSinglePBForcedEarlyExitTime = GUICtrlRead($g_hTxtPBTimeForcedExit)
			$g_bAutoResumeEnable = (GUICtrlRead($g_hChkAutoResume) = $GUI_CHECKED)
			$g_iAutoResumeTime = GUICtrlRead($g_hTxtAutoResumeTime)
			$g_bDisableNotifications = (GUICtrlRead($g_hChkDisableNotifications) = $GUI_CHECKED)
			$g_bForceClanCastleDetection = (GUICtrlRead($g_hChkFixClanCastle) = $GUI_CHECKED)
			$g_bUseStatistics = (GUICtrlRead($g_hChkSqlite) = $GUI_CHECKED)

			$g_bOnlySCIDAccounts = (GUICtrlRead($g_hChkOnlySCIDAccounts) = $GUI_CHECKED)
			$g_iWhatSCIDAccount2Use = _GUICtrlComboBox_GetCurSel($g_hCmbWhatSCIDAccount2Use)

			$g_iChkLabCheck = GUICtrlRead($g_hChkLabCheck) = $GUI_CHECKED ? 1 : 0
	EndSwitch
EndFunc   ;==>ApplyConfig_600_35_1

Func ApplyConfig_600_35_2($TypeReadSave)
	; <><><><> Bot / Profile / Switch Account <><><><>
	Switch $TypeReadSave
		Case "Read"
			;FarmSchedule
			For $i = 0 To 7
				GUICtrlSetState($g_ahChkSetFarm[$i], $g_abChkSetFarm[$i] = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

				_GUICtrlComboBox_SetCurSel($g_ahCmbAction1[$i], $g_aiCmbAction1[$i])
				_GUICtrlComboBox_SetCurSel($g_ahCmbCriteria1[$i], $g_aiCmbCriteria1[$i])
				GUICtrlSetData($g_ahTxtResource1[$i], $g_aiTxtResource1[$i])
				_GUICtrlComboBox_SetCurSel($g_ahCmbTime1[$i], $g_aiCmbTime1[$i])

				_GUICtrlComboBox_SetCurSel($g_ahCmbAction2[$i], $g_aiCmbAction2[$i])
				_GUICtrlComboBox_SetCurSel($g_ahCmbCriteria2[$i], $g_aiCmbCriteria2[$i])
				GUICtrlSetData($g_ahTxtResource2[$i], $g_aiTxtResource2[$i])
				_GUICtrlComboBox_SetCurSel($g_ahCmbTime2[$i], $g_aiCmbTime2[$i])
			Next

			_GUICtrlComboBox_SetCurSel($g_hCmbSwitchAcc, $g_iCmbSwitchAcc)
			GUICtrlSetState($g_hChkSwitchAcc, $g_bChkSwitchAcc ? $GUI_CHECKED : $GUI_UNCHECKED)
			If $g_bChkGooglePlay Then
				GUICtrlSetState($g_hRadSwitchGooglePlay, $GUI_CHECKED)
				GUICtrlSetState($g_hRadSwitchSuperCellID, $GUI_UNCHECKED)
				GUICtrlSetState($g_hRadSwitchSharedPrefs, $GUI_UNCHECKED)
			EndIf
			If $g_bChkSuperCellID Then
				GUICtrlSetState($g_hRadSwitchGooglePlay, $GUI_UNCHECKED)
				GUICtrlSetState($g_hRadSwitchSuperCellID, $GUI_CHECKED)
				GUICtrlSetState($g_hRadSwitchSharedPrefs, $GUI_UNCHECKED)
			EndIf
			If $g_bChkSharedPrefs Then
				GUICtrlSetState($g_hRadSwitchGooglePlay, $GUI_UNCHECKED)
				GUICtrlSetState($g_hRadSwitchSuperCellID, $GUI_UNCHECKED)
				GUICtrlSetState($g_hRadSwitchSharedPrefs, $GUI_CHECKED)
			EndIf
			GUICtrlSetState($g_hChkSmartSwitch, $g_bChkSmartSwitch ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDonateLikeCrazy, $g_bDonateLikeCrazy ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTotalAccount, $g_iTotalAcc - 1)
			For $i = 0 To 7
				GUICtrlSetState($g_ahChkAccount[$i], $g_abAccountNo[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
				_GUICtrlComboBox_SetCurSel($g_ahCmbProfile[$i], _GUICtrlComboBox_FindStringExact($g_ahCmbProfile[$i], $g_asProfileName[$i]))
				GUICtrlSetState($g_ahChkDonate[$i], $g_abDonateOnly[$i] ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			_GUICtrlComboBox_SetCurSel($g_hCmbTrainTimeToSkip, $g_iTrainTimeToSkip)
			_cmbSwitchAcc(False)

		Case "Save"
			;FarmSchedule
			For $i = 0 To 7
				$g_abChkSetFarm[$i] = (GUICtrlRead($g_ahChkSetFarm[$i]) = $GUI_CHECKED)

				$g_aiCmbAction1[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbAction1[$i])
				$g_aiCmbCriteria1[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbCriteria1[$i])
				$g_aiTxtResource1[$i] = GUICtrlRead($g_ahTxtResource1[$i])
				$g_aiCmbTime1[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbTime1[$i])

				$g_aiCmbAction2[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbAction2[$i])
				$g_aiCmbCriteria2[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbCriteria2[$i])
				$g_aiTxtResource2[$i] = GUICtrlRead($g_ahTxtResource2[$i])
				$g_aiCmbTime2[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbTime2[$i])
			Next

			$g_iCmbSwitchAcc = _GUICtrlComboBox_GetCurSel($g_hCmbSwitchAcc)
			$g_bChkSwitchAcc = (GUICtrlRead($g_hChkSwitchAcc) = $GUI_CHECKED)
			$g_bChkGooglePlay = (GUICtrlRead($g_hRadSwitchGooglePlay) = $GUI_CHECKED)
			$g_bChkSuperCellID = (GUICtrlRead($g_hRadSwitchSuperCellID) = $GUI_CHECKED)
			$g_bChkSharedPrefs = (GUICtrlRead($g_hRadSwitchSharedPrefs) = $GUI_CHECKED)
			$g_bChkSmartSwitch = (GUICtrlRead($g_hChkSmartSwitch) = $GUI_CHECKED)
			$g_bDonateLikeCrazy = (GUICtrlRead($g_hChkDonateLikeCrazy) = $GUI_CHECKED)
			$g_iTotalAcc = _GUICtrlComboBox_GetCurSel($g_hCmbTotalAccount) + 1 ; at least 2 accounts needed
			For $i = 0 To 7
				$g_abAccountNo[$i] = (GUICtrlRead($g_ahChkAccount[$i]) = $GUI_CHECKED)
				$g_asProfileName[$i] = GUICtrlRead($g_ahCmbProfile[$i])
				$g_abDonateOnly[$i] = (GUICtrlRead($g_ahChkDonate[$i]) = $GUI_CHECKED)
			Next
			$g_iTrainTimeToSkip = _GUICtrlComboBox_GetCurSel($g_hCmbTrainTimeToSkip)
	EndSwitch
EndFunc   ;==>ApplyConfig_600_35_2

Func ApplyConfig_600_52_1($TypeReadSave)
	; <><><> Attack Plan / Train Army / Troops/Spells <><><>
	; Quick train
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkUseQuickTrain, $g_bQuickTrainEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmy[0], $g_bQuickTrainArmy[0] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmy[1], $g_bQuickTrainArmy[1] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmy[2], $g_bQuickTrainArmy[2] ? $GUI_CHECKED : $GUI_UNCHECKED)
            		GUICtrlSetState($g_hChkMultiClick, $g_bChkMultiClick ? $GUI_CHECKED : $GUI_UNCHECKED) ; Multi-ClickArmy3 - Demen
		Case "Save"
			$g_bQuickTrainEnable = (GUICtrlRead($g_hChkUseQuickTrain) = $GUI_CHECKED)
			$g_bQuickTrainArmy[0] = (GUICtrlRead($g_ahChkArmy[0]) = $GUI_CHECKED)
			$g_bQuickTrainArmy[1] = (GUICtrlRead($g_ahChkArmy[1]) = $GUI_CHECKED)
			$g_bQuickTrainArmy[2] = (GUICtrlRead($g_ahChkArmy[2]) = $GUI_CHECKED)
           		 $g_bChkMultiClick = (GUICtrlRead($g_hChkMultiClick) = $GUI_CHECKED); Multi-ClickArmy3 - Demen
	EndSwitch
EndFunc   ;==>ApplyConfig_600_52_1

Func ApplyConfig_600_52_2($TypeReadSave)
	; troop/spell levels and counts
	Switch $TypeReadSave
		Case "Read"
			For $T = 0 To $eTroopCount - 1
				Local $iCurrLevel = $g_aiTrainArmyTroopLevel[$T]
				Local $iCurrCount = $g_aiArmyCompTroops[$T]
				Local $iMaxLevel = $g_aiTroopCostPerLevel[$T][0]
				Local $iColor = ($iCurrLevel = $iMaxLevel ? $COLOR_YELLOW : $COLOR_WHITE)
				GUICtrlSetData($g_ahTxtTrainArmyTroopCount[$T], ($iCurrCount <> 0 And $iCurrLevel <> 0) ? $iCurrCount : 0)
				GUICtrlSetState($g_ahTxtTrainArmyTroopCount[$T], $iCurrLevel <> 0 ? $GUI_SHOW : $GUI_HIDE)
				GUICtrlSetData($g_ahLblTrainArmyTroopLevel[$T], $iCurrLevel)
				If GUICtrlGetBkColor($g_ahLblTrainArmyTroopLevel[$T]) <> $iColor Then GUICtrlSetBkColor($g_ahLblTrainArmyTroopLevel[$T], $iColor)
			Next
			For $S = 0 To $eSpellCount - 1
				Local $iCurrLevel = $g_aiTrainArmySpellLevel[$S]
				Local $iCurrCount = $g_aiArmyCompSpells[$S]
				Local $iMaxLevel = $g_aiSpellCostPerLevel[$S][0]
				Local $iColor = ($iCurrLevel = $iMaxLevel ? $COLOR_YELLOW : $COLOR_WHITE)
				GUICtrlSetData($g_ahTxtTrainArmySpellCount[$S], ($iCurrCount <> 0 And $iCurrLevel <> 0) ? $iCurrCount : 0)
				GUICtrlSetState($g_ahTxtTrainArmySpellCount[$S], $iCurrLevel <> 0 ? $GUI_SHOW : $GUI_HIDE)
				GUICtrlSetData($g_ahLblTrainArmySpellLevel[$S], $iCurrLevel)
				If GUICtrlGetBkColor($g_ahLblTrainArmySpellLevel[$S]) <> $iColor Then GUICtrlSetBkColor($g_ahLblTrainArmySpellLevel[$S], $iColor)
			Next
			For $S = 0 To $eSiegeMachineCount - 1
				Local $iCurrLevel = $g_aiTrainArmySiegeMachineLevel[$S]
				Local $iCurrCount = $g_aiArmyCompSiegeMachine[$S]
				Local $iMaxLevel = $g_aiSiegeMachineCostPerLevel[$S][0]
				Local $iColor = ($iCurrLevel = $iMaxLevel ? $COLOR_YELLOW : $COLOR_WHITE)
				GUICtrlSetData($g_ahTxtTrainArmySiegeCount[$S], ($iCurrCount <> 0 And $iCurrLevel <> 0) ? $iCurrCount : 0)
				GUICtrlSetState($g_ahTxtTrainArmySiegeCount[$S], $iCurrLevel <> 0 ? $GUI_SHOW : $GUI_HIDE)
				GUICtrlSetData($g_ahLblTrainArmySiegeLevel[$S], $iCurrLevel)
				If GUICtrlGetBkColor($g_ahLblTrainArmySiegeLevel[$S]) <> $iColor Then GUICtrlSetBkColor($g_ahLblTrainArmySiegeLevel[$S], $iColor)
			Next
			; full & forced Total Camp values
			GUICtrlSetData($g_hTxtFullTroop, $g_iTrainArmyFullTroopPct)
			GUICtrlSetState($g_hChkTotalCampForced, $g_bTotalCampForced ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtTotalCampForced, $g_iTotalCampForcedValue)
			; spell capacity and forced flag
			GUICtrlSetData($g_hTxtTotalCountSpell, $g_iTotalSpellValue)
			GUICtrlSetState($g_hChkForceBrewBeforeAttack, $g_bForceBrewSpells ? $GUI_CHECKED : $GUI_UNCHECKED)
			; DoubleTrain - Demen
			GUICtrlSetState($g_hChkDoubleTrain, $g_bDoubleTrain ? $GUI_CHECKED : $GUI_UNCHECKED)
			;SmartTrain - Simple Mod (Demen)
			GUICtrlSetState($g_hChkSmartTrain, $g_bChkSmartTrain ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkPreciseArmyCamp, $g_bChkPreciseArmyCamp ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkFillArcher, $g_bChkFillArcher ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtFillArcher, $g_iTxtFillArcher)
			GUICtrlSetState($g_hChkFillEQ, $g_bChkFillEQ ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartTrain()
			; ================================================ AutoCamp - by Simple Mod (#ID135-) ========================================
			GUICtrlSetState($g_hChkAutoCamp, $g_bChkAutoCamp ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkAutoCamp()

		Case "Save"
			; troop/spell levels and counts
			For $T = 0 To $eTroopCount - 1
				$g_aiArmyCompTroops[$T] = GUICtrlRead($g_ahTxtTrainArmyTroopCount[$T])
				$g_aiTrainArmyTroopLevel[$T] = GUICtrlRead($g_ahLblTrainArmyTroopLevel[$T])
			Next
			For $S = 0 To $eSpellCount - 1
				$g_aiArmyCompSpells[$S] = GUICtrlRead($g_ahTxtTrainArmySpellCount[$S])
				$g_aiTrainArmySpellLevel[$S] = GUICtrlRead($g_ahLblTrainArmySpellLevel[$S])
			Next
			For $S = 0 To $eSiegeMachineCount - 1
				$g_aiArmyCompSiegeMachine[$S] = GUICtrlRead($g_ahTxtTrainArmySiegeCount[$S])
				$g_aiTrainArmySiegeMachineLevel[$S] = GUICtrlRead($g_ahLblTrainArmySiegeLevel[$S])
			Next
			; full & forced Total Camp values
			$g_iTrainArmyFullTroopPct = Int(GUICtrlRead($g_hTxtFullTroop))
			$g_bTotalCampForced = (GUICtrlRead($g_hChkTotalCampForced) = $GUI_CHECKED)
			$g_iTotalCampForcedValue = Int(GUICtrlRead($g_hTxtTotalCampForced))
			; spell capacity and forced flag
			$g_iTotalSpellValue = GUICtrlRead($g_hTxtTotalCountSpell)
			$g_bForceBrewSpells = (GUICtrlRead($g_hChkForceBrewBeforeAttack) = $GUI_CHECKED)
			; DoubleTrain - Demen
			$g_bDoubleTrain = (GUICtrlRead($g_hChkDoubleTrain) = $GUI_CHECKED)
			;SmartTrain - Simple Mod (Demen)
			$g_bChkSmartTrain = (GUICtrlRead($g_hChkSmartTrain) = $GUI_CHECKED)
			$g_bChkPreciseArmyCamp = (GUICtrlRead($g_hChkPreciseArmyCamp) = $GUI_CHECKED)
			$g_bChkFillArcher = (GUICtrlRead($g_hChkFillArcher) = $GUI_CHECKED)
			$g_iTxtFillArcher = GUICtrlRead($g_hTxtFillArcher)
			$g_bChkFillEQ = (GUICtrlRead($g_hChkFillEQ) = $GUI_CHECKED)
			; ================================================ AutoCamp - by Simple Mod (#ID135-) ========================================
			$g_bChkAutoCamp = (GUICtrlRead($g_hChkAutoCamp) = $GUI_CHECKED)

	EndSwitch
EndFunc   ;==>ApplyConfig_600_52_2

Func ApplyConfig_600_54($TypeReadSave)
	; <><><> Attack Plan / Train Army / Train Order <><><>
	Switch $TypeReadSave
		Case "Read"
			; Troops Order
			GUICtrlSetState($g_hChkCustomTrainOrderEnable, $g_bCustomTrainOrderEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTroopOrder()
			For $z = 0 To UBound($g_ahCmbTroopOrder) - 1
				_GUICtrlComboBox_SetCurSel($g_ahCmbTroopOrder[$z], $g_aiCmbCustomTrainOrder[$z])
				_GUICtrlSetImage($g_ahImgTroopOrder[$z], $g_sLibIconPath, $g_aiTroopOrderIcon[$g_aiCmbCustomTrainOrder[$z] + 1])
			Next
			If $g_bCustomTrainOrderEnable Then ; only update troop train order if enabled
				If Not ChangeTroopTrainOrder() Then ; process error
					SetDefaultTroopGroup()
					GUICtrlSetState($g_hChkCustomTrainOrderEnable, $GUI_UNCHECKED)
					$g_bCustomTrainOrderEnable = False
					GUICtrlSetState($g_hBtnTroopOrderSet, $GUI_DISABLE) ; disable button
					GUICtrlSetState($g_hBtnRemoveTroops, $GUI_DISABLE)
					For $i = 0 To UBound($g_ahCmbTroopOrder) - 1
						GUICtrlSetState($g_ahCmbTroopOrder[$i], $GUI_DISABLE) ; disable combo boxes
					Next
				EndIf
			EndIf
			; Spells Order
			GUICtrlSetState($g_hChkCustomBrewOrderEnable, $g_bCustomBrewOrderEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSpellsOrder()
			For $z = 0 To UBound($g_ahCmbSpellsOrder) - 1
				_GUICtrlComboBox_SetCurSel($g_ahCmbSpellsOrder[$z], $g_aiCmbCustomBrewOrder[$z])
				_GUICtrlSetImage($g_ahImgSpellsOrder[$z], $g_sLibIconPath, $g_aiSpellsOrderIcon[$g_aiCmbCustomBrewOrder[$z] + 1])
			Next
			If $g_bCustomBrewOrderEnable Then ; only update troop train order if enabled
				If Not ChangeSpellsBrewOrder() Then ; process error
					SetDefaultSpellsGroup()
					GUICtrlSetState($g_hChkCustomBrewOrderEnable, $GUI_UNCHECKED)
					$g_bCustomBrewOrderEnable = False
					GUICtrlSetState($g_hBtnRemoveSpells, $GUI_DISABLE) ; disable button
					GUICtrlSetState($g_hBtnSpellsOrderSet, $GUI_DISABLE)
					For $i = 0 To UBound($g_ahCmbSpellsOrder) - 1
						GUICtrlSetState($g_ahCmbSpellsOrder[$i], $GUI_DISABLE) ; disable combo boxes
					Next
				EndIf
			EndIf

			chkTotalCampForced()
			chkUseQTrain() ; this function also calls calls lblTotalCount and TotalSpellCountClick
			SetComboTroopComp() ; this function also calls lblTotalCount
		Case "Save"
			; Troops Order
			$g_bCustomTrainOrderEnable = (GUICtrlRead($g_hChkCustomTrainOrderEnable) = $GUI_CHECKED)
			For $z = 0 To UBound($g_ahCmbTroopOrder) - 1
				$g_aiCmbCustomTrainOrder[$z] = _GUICtrlComboBox_GetCurSel($g_ahCmbTroopOrder[$z])
			Next
			; Spells Order
			$g_bCustomBrewOrderEnable = (GUICtrlRead($g_hChkCustomBrewOrderEnable) = $GUI_CHECKED)
			For $z = 0 To UBound($g_ahCmbSpellsOrder) - 1
				$g_aiCmbCustomBrewOrder[$z] = _GUICtrlComboBox_GetCurSel($g_ahCmbSpellsOrder[$z])
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_600_54

Func ApplyConfig_600_56($TypeReadSave)
	; <><><><> Attack Plan / Search & Attack / Options / SmartZap <><><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkSmartLightSpell, $g_bSmartZapEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSmartEQSpell, $g_bEarthQuakeZap = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkNoobZap, $g_bNoobZap = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSmartZapDB, $g_bSmartZapDB = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSmartZapSaveHeroes, $g_bSmartZapSaveHeroes = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSmartZapFTW, $g_bSmartZapFTW = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSmartZapMinDE, $g_iSmartZapMinDE)
			GUICtrlSetData($g_hTxtSmartExpectedDE, $g_iSmartZapExpectedDE)
			chkSmartLightSpell()
			#CS
				GUICtrlSetState($g_hChkSmartZapDB, $g_bSmartZapEnable = True ? $GUI_ENABLE : $GUI_DISABLE)
				GUICtrlSetState($g_hTxtSmartZapMinDE, $g_bSmartZapEnable = True ? $GUI_ENABLE : $GUI_DISABLE)
				GUICtrlSetState($g_hChkNoobZap, $g_bSmartZapEnable = True ? $GUI_ENABLE : $GUI_DISABLE)
				GUICtrlSetState($g_hChkSmartZapSaveHeroes, $g_bSmartZapEnable = True ? $GUI_ENABLE : $GUI_DISABLE)
				GUICtrlSetState($g_hTxtSmartExpectedDE, $g_bNoobZap = True ? $GUI_ENABLE : $GUI_DISABLE)
			#CE
		Case "Save"
			$g_bSmartZapEnable = (GUICtrlRead($g_hChkSmartLightSpell) = $GUI_CHECKED)
			$g_bEarthQuakeZap = (GUICtrlRead($g_hChkSmartEQSpell) = $GUI_CHECKED)
			$g_bNoobZap = (GUICtrlRead($g_hChkNoobZap) = $GUI_CHECKED)
			$g_bSmartZapDB = (GUICtrlRead($g_hChkSmartZapDB) = $GUI_CHECKED)
			$g_bSmartZapSaveHeroes = (GUICtrlRead($g_hChkSmartZapSaveHeroes) = $GUI_CHECKED)
			$g_bSmartZapFTW = (GUICtrlRead($g_hChkSmartZapFTW) = $GUI_CHECKED)
			$g_iSmartZapMinDE = Int(GUICtrlRead($g_hTxtSmartZapMinDE))
			$g_iSmartZapExpectedDE = Int(GUICtrlRead($g_hTxtSmartExpectedDE))
	EndSwitch
EndFunc   ;==>ApplyConfig_600_56

Func ApplyConfig_641_1($TypeReadSave)
	; <><><> Attack Plan / Train Army / Options <><><>
	Switch $TypeReadSave
		Case "Read"
			; Training idle time
			If $g_bCloseWhileTrainingEnable = True Then
				GUICtrlSetState($g_hChkCloseWhileTraining, $GUI_CHECKED)
				_GUI_Value_STATE("ENABLE", $groupCloseWhileTraining)
				GUICtrlSetState($g_hLblCloseWaitingTroops, $GUI_ENABLE)
				GUICtrlSetState($g_hCmbMinimumTimeClose, $GUI_ENABLE)
				GUICtrlSetState($g_hLblSymbolWaiting, $GUI_ENABLE)
				GUICtrlSetState($g_hLblWaitingInMinutes, $GUI_ENABLE)
				; Max logout time - Simple Mod
				GUICtrlSetState($g_hChkTrainLogoutMaxTime, $GUI_ENABLE)
			Else
				GUICtrlSetState($g_hChkCloseWhileTraining, $GUI_UNCHECKED)
				_GUI_Value_STATE("DISABLE", $groupCloseWhileTraining)
				GUICtrlSetState($g_hLblCloseWaitingTroops, $GUI_DISABLE)
				GUICtrlSetState($g_hCmbMinimumTimeClose, $GUI_DISABLE)
				GUICtrlSetState($g_hLblSymbolWaiting, $GUI_DISABLE)
				GUICtrlSetState($g_hLblWaitingInMinutes, $GUI_DISABLE)
				; Max logout time - Simple Mod
				GUICtrlSetState($g_hChkTrainLogoutMaxTime, $GUI_DISABLE)
			EndIf
			GUICtrlSetState($g_hChkCloseWithoutShield, $g_bCloseWithoutShield ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCloseEmulator, $g_bCloseEmulator ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSuspendComputer, $g_bSuspendComputer ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkRandomClose, $g_bCloseRandom ? $GUI_CHECKED : $GUI_UNCHECKED)
			btnCloseWaitStopRandom()
			If $g_bCloseExactTime Then
				GUICtrlSetState($g_hRdoCloseWaitExact, $GUI_CHECKED)
				GUICtrlSetState($g_hRdoCloseWaitRandom, $GUI_UNCHECKED)
			EndIf
			If $g_bCloseRandomTime Then
				GUICtrlSetState($g_hRdoCloseWaitRandom, $GUI_CHECKED)
				GUICtrlSetState($g_hRdoCloseWaitExact, $GUI_UNCHECKED)
			EndIf
			_GUICtrlComboBox_SetCurSel($g_hCmbCloseWaitRdmPercent, $g_iCloseRandomTimePercent)
			btnCloseWaitRandom()
			GUICtrlSetData($g_hCmbMinimumTimeClose, $g_iCloseMinimumTime)
			; ================================================== Max logout time - by Simple Mod ======================================== ;

			GUICtrlSetState($g_hChkTrainLogoutMaxTime, $g_bTrainLogoutMaxTime = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtTrainLogoutMaxTime, $g_iTrainLogoutMaxTime)

			; Train click timing
			GUICtrlSetData($g_hSldTrainITDelay, $g_iTrainClickDelay)
			sldTrainITDelay()
			GUICtrlSetData($g_hLblTrainITDelayTime, $g_iTrainClickDelay & " ms")
			; Training add random delay
			GUICtrlSetState($g_hChkTrainAddRandomDelayEnable, $g_bTrainAddRandomDelayEnable ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAddRandomDelayMin, $g_iTrainAddRandomDelayMin)
			GUICtrlSetData($g_hTxtAddRandomDelayMax, $g_iTrainAddRandomDelayMax)
			chkAddDelayIdlePhaseEnable()
			; ================================================== Check Grand Warden Mode - Added by Simple Mod ======================================== ;

			GUICtrlSetState($g_hChkCheckWardenMode, $g_bCheckWardenMode ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkCheckWardenMode()
			_GUICtrlComboBox_SetCurSel($g_hCmbCheckWardenMode, $g_iCheckWardenMode)

		Case "Save"
			; Training idle time
			$g_bCloseWhileTrainingEnable = (GUICtrlRead($g_hChkCloseWhileTraining) = $GUI_CHECKED)
			$g_bCloseWithoutShield = (GUICtrlRead($g_hChkCloseWithoutShield) = $GUI_CHECKED)
			$g_bCloseEmulator = (GUICtrlRead($g_hChkCloseEmulator) = $GUI_CHECKED)
			$g_bSuspendComputer = (GUICtrlRead($g_hChkSuspendComputer) = $GUI_CHECKED)
			$g_bCloseRandom = (GUICtrlRead($g_hChkRandomClose) = $GUI_CHECKED)
			$g_bCloseExactTime = (GUICtrlRead($g_hRdoCloseWaitExact) = $GUI_CHECKED)
			$g_bCloseRandomTime = (GUICtrlRead($g_hRdoCloseWaitRandom) = $GUI_CHECKED)
			$g_iCloseRandomTimePercent = _GUICtrlComboBox_GetCurSel($g_hCmbCloseWaitRdmPercent)
			$g_iCloseMinimumTime = GUICtrlRead($g_hCmbMinimumTimeClose)
			; ================================================== Max logout time - by Simple Mod ======================================== ;
			$g_bTrainLogoutMaxTime = (GUICtrlRead($g_hChkTrainLogoutMaxTime) = $GUI_CHECKED)
			$g_iTrainLogoutMaxTime = GUICtrlRead($g_hTxtTrainLogoutMaxTime)

			; Train click timing
			$g_iTrainClickDelay = GUICtrlRead($g_hSldTrainITDelay)
			; Training add random delay
			$g_bTrainAddRandomDelayEnable = (GUICtrlRead($g_hChkTrainAddRandomDelayEnable) = $GUI_CHECKED)
			$g_iTrainAddRandomDelayMin = Int(GUICtrlRead($g_hTxtAddRandomDelayMin))
			$g_iTrainAddRandomDelayMax = Int(GUICtrlRead($g_hTxtAddRandomDelayMax))
			; ================================================== Check Grand Warden Mode - Added by Simple Mod ======================== ;

			$g_bCheckWardenMode = (GUICtrlRead($g_hChkCheckWardenMode) = $GUI_CHECKED)
			$g_iCheckWardenMode = _GUICtrlComboBox_GetCurSel($g_hCmbCheckWardenMode)

	EndSwitch
EndFunc   ;==>ApplyConfig_641_1

