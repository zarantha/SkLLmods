Scriptname SLP_ChaurusQueenSkinScript extends zadPlugScript  


SLP_fcts_parasites Property fctParasites  Auto

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		if akActor == libs.PlayerRef
			libs.NotifyActor("The parasite is spreading through your skin and invading your breasts. New glands appear on your chest and start exuding a sweet and sticky liquid.", akActor, true)
			
		EndIf
	EndIf
EndFunction

int Function OnEquippedFilter(actor akActor, bool silent=false)
	ActorBase 	pActorBase  
	if akActor == none
		akActor == libs.PlayerRef
	EndIf
	pActorBase = akActor.GetActorBase()

	if ! akActor.IsEquipped(deviceRendered)
		if akActor!=libs.PlayerRef && ShouldEquipSilently(akActor)
			libs.Log("Avoiding FTM duplication bug (Harness).")
			return 0
		EndIf
		if akActor.WornHasKeyword(libs.zad_DeviousCorset)
			MultipleItemFailMessage("Corset")
			return 2
		Endif
		if (pActorBase.GetSex()==0)
			; libs.NotifyActor("The spores refuse to attach themselves around a male.", akActor, true)
			return 2
		Endif
	Endif
	return 0
EndFunction


Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost BodyHarness")

	fctParasites.applyChaurusQueenSkin(akActor )

EndFunction