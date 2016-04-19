;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLS_TIF_RedWavePlayerDebt03 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddToFaction(RedWaveWhore)
Game.GetPlayer().EquipItem(WhoreCollar)

RedWaveDebt.SetValue(Utility.RandomInt(10) * 100 + 500)

Debug.Notification("You now owe " + RedWaveDebt.GetValue() as Int + " gold.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property RedWaveWhore  Auto  

Armor Property WhoreCollar  Auto  

GlobalVariable Property RedWaveDebt  Auto  