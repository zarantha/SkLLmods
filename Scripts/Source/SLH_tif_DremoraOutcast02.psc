;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLH_tif_DremoraOutcast02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor kVictim  = Game.GetPlayer() as Actor

kVictim.resethealthandlimbs()

If (Utility.RandomInt(0,10)>6)

Int IButton = _SLH_warning.Show()

If IButton == 0 ; Show the thing.

	If  (SexLab.ValidateActor( SexLab.PlayerREF) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 

		SexLab.QuickStart(SexLab.PlayerRef, akSpeaker , Victim = SexLab.PlayerRef, AnimationTags = "Sex")
	EndIf

EndIf

EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

Message Property _SLH_warning  Auto  