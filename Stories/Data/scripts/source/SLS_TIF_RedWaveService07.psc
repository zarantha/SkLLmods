;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWaveService07 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
Actor akActor = _SLS_ShowDogRef as Actor
;BEGIN CODE

;		Debug.MessageBox( "The Sister quietly peels off your clothes to reveal your beauty to the world." )
;  		SexLab.ActorLib.StripActor(Game.GetPlayer(), DoAnimate= false)

	If  (SexLab.ValidateActor(akActor) > 0) &&  (SexLab.ValidateActor(akSpeaker) > 0) 
		
		Game.GetPlayer().RemoveItem(Gold001, 200)

		SexLab.QuickStart(akSpeaker, akActor)

	else
		Debug.Notification("Ask me again when both be found less occupied!")
	endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

ObjectReference Property _SLS_ShowDogRef  Auto  
 
