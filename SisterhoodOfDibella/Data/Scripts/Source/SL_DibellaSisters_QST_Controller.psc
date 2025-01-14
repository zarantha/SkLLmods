Scriptname SL_DibellaSisters_QST_Controller extends ReferenceAlias  

ReferenceAlias Property PlayerAlias  Auto  


Event OnPlayerLoadGame()
	_maintenance()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	; Only runs going in or out of Markarth Temple
	If ((akNewLoc != TempleLocation) && (akOldLoc == TempleLocation))
		Return
	Endif



	ObjectReference akActorREF= Game.GetPlayer() as ObjectReference
	Actor akActor= Game.GetPlayer()
	Int iTempleCorruption = StorageUtil.GetIntValue( akActor, "_SLSD_iDibellaTempleCorruption")
	Int iSybilLevel = StorageUtil.GetIntValue( akActor, "_SLSD_iDibellaSybilLevel" )

	; Check if new location is Temple or Inner Sanctum
	; Check value of temple corruption from StorageUtil
	; Set outfits accordingly

	If ((akNewLoc == TempleLocation) || (akOldLoc == TempleLocation))  && (iSybilLevel < 5)
		Debug.Trace("[SLSD] Temple corruption: " + iTempleCorruption )
		; Debug.Notification("[SLSD] Temple corruption: " + iTempleCorruption )
		Debug.Trace("[SLSD] Sybil Level: " + iSybilLevel )
		; Debug.Notification("[SLSD] SennaRef: " + SennaRef)
		; Debug.Notification("[SLSD] OrlaRef: " + OrlaRef)
		; Debug.Notification("[SLSD] AnwenRef: " + AnwenRef)
		; Debug.Notification("[SLSD] HamalRef: " + HamalRef)
		; Debug.Notification("[SLSD] SybilRef: " + SybilRef)

		If (iTempleCorruption == 0)
			(SennaRef as Actor).SetOutfit(SisterPureOutfit)
			(OrlaRef as Actor).SetOutfit(SisterPureOutfit)
			(AnwenRef as Actor).SetOutfit(SisterPureOutfit)
			(HamalRef as Actor).SetOutfit(HamalPureOutfit)
			(SybilRef as Actor).SetOutfit(FjotraPureOutfit)

		ElseIf (iTempleCorruption >= 1) && (iTempleCorruption <= 4)
			(SennaRef as Actor).SetOutfit(SisterPureOutfit)
			(OrlaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(AnwenRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(HamalRef as Actor).SetOutfit(HamalCorruptedOutfit)

			If (SybilRef != None) 
				If (iSybilLevel == 1) 
					(SybilRef as Actor).SetOutfit(FjotraNoviceOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Novice")

				ElseIf (iSybilLevel == 2)
					(SybilRef as Actor).SetOutfit(FjotraAccolyteOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Accolyte")
					
				ElseIf (iSybilLevel == 3)
					(SybilRef as Actor).SetOutfit(FjotraInitiateOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Initiate")
					
				ElseIf (iSybilLevel >= 4)
					(SybilRef as Actor).SetOutfit(FjotraCorruptedOutfit)
					; Debug.Notification("[SLSD] Fjotra is a Mother")
					
				EndIf
			EndIf

		ElseIf (iTempleCorruption > 4)
			(SennaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(OrlaRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(AnwenRef as Actor).SetOutfit(SisterCorruptedOutfit)
			(HamalRef as Actor).SetOutfit(HamalCorruptedOutfit)
			(SybilRef as Actor).SetOutfit(FjotraCorruptedOutfit)
		EndIf
	EndIf

EndEvent

Function _Maintenance()
;
	Int iTempleCorruption = StorageUtil.GetIntValue( Game.GetPlayer(), "_SLSD_iDibellaTempleCorruption")

	RegisterForModEvent("SLSDEquipOutfit",   "OnSLSDEquipOutfit")

	If (iTempleCorruption <= 2)
 		_SLS_SisterClothingDresserPurified.Enable()
 		_SLS_SisterClothingDresserCorrupted.Disable()

	ElseIf  (iTempleCorruption >=3)
 		_SLS_SisterClothingDresserPurified.Disable()
 		_SLS_SisterClothingDresserCorrupted.Enable()
	Endif
EndFunction



Event OnSLSDEquipOutfit(String _eventName, String _args, Float _argc = -1.0, Form _sender)
 	Actor kActor = _sender as Actor
	String sOutfit = _args

	Debug.Trace("[SL_DibellaSisters_QST_controller] Receiving equip outfit story event [" + _args  + "] [" + _argc as Int + "]")

	if (sOutfit == "SisterPure")
		kActor.SetOutfit(SisterPureOutfit)

	elseif (sOutfit == "SisterCorrupted")
		kActor.SetOutfit(SisterCorruptedOutfit)

	elseif (sOutfit == "HamalPure")
		kActor.SetOutfit(HamalPureOutfit)

	elseif (sOutfit == "HamalCorrupted")
		kActor.SetOutfit(HamalCorruptedOutfit)

	elseif (sOutfit == "FjotraPure")
		kActor.SetOutfit(FjotraPureOutfit)

	elseif (sOutfit == "FjotraNovice")
		kActor.SetOutfit(FjotraNoviceOutfit )

	elseif (sOutfit == "FjotraAccolyte")
		kActor.SetOutfit(FjotraAccolyteOutfit)

	elseif (sOutfit == "FjotraInitiate")
		kActor.SetOutfit(FjotraInitiateOutfit)

	elseif (sOutfit == "FjotraCorrupted")
		kActor.SetOutfit(FjotraCorruptedOutfit)
		
	elseif (sOutfit == "TravelingSister")
		kActor.SetOutfit(TravelingSisterOutfit  )
		
	else
		Debug.Trace("[SL_DibellaSisters_QST_controller] Unknow outfit [" + sOutfit  + "]")
	Endif
EndEvent

ObjectReference Property SennaRef Auto
ObjectReference Property OrlaRef Auto
ObjectReference Property AnwenRef Auto
ObjectReference Property HamalRef Auto
; ObjectReference Property FjotraRef Auto
ObjectReference Property SybilRef Auto

Outfit Property SisterPureOutfit Auto
Outfit Property SisterCorruptedOutfit Auto
Outfit Property HamalPureOutfit Auto
Outfit Property HamalCorruptedOutfit Auto
Outfit Property FjotraPureOutfit Auto
Outfit Property FjotraCorruptedOutfit Auto

Outfit Property FjotraNoviceOutfit Auto
Outfit Property FjotraAccolyteOutfit Auto
Outfit Property FjotraInitiateOutfit Auto

Location Property TempleLocation Auto



Outfit Property TravelingSisterOutfit  Auto  

ObjectReference Property _SLS_SisterClothingDresserPurified  Auto  

ObjectReference Property _SLS_SisterClothingDresserCorrupted  Auto  
