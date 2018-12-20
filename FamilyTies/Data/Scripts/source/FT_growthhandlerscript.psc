Scriptname FT_growthhandlerscript extends ReferenceAlias  

FormList Property VanillaHairRaceList  Auto  
FormList Property CustomHairRaceList  Auto  
FormList Property CustomEyesRaceList  Auto  

Race Property bteen  Auto  
Race Property brace  Auto  

Race Property iteen  Auto  
Race Property irace  Auto  

Race Property nteen  Auto  
Race Property nrace  Auto  

Race Property rteen  Auto  
Race Property rrace  Auto  

Race Property erace  Auto  

Message Property adultmsg  Auto  
Message Property eldermsg  Auto  


Race rPlayerRealRace 
Race rPlayerCurrentRace 

int age
int	baseAge 
int	anniversaryFrequency 

int daysPassed = 0
int yearsCount  = 0
int daysCount = 0
int iGameDateLastCheck = -1
Int iDaysSinceLastCheck = -1
int iDaysSinceLastAnniversary = 0
int iDaysSinceLastBirthday = 0

Bool bGrantStartPerks = False

Event OnInit()
	Actor PlayerActor 

	PlayerActor = Game.getPlayer() as Actor
	rPlayerRealRace = PlayerActor.getrace()
	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerRealRace", rPlayerRealRace as Form)

	StorageUtil.SetFloatValue(PlayerActor, "_FT_baseAge", 18.0 )
	StorageUtil.SetFloatValue(PlayerActor, "_FT_anniversaryFrequency", 364.0 ) 

	StorageUtil.SetIntValue(none, "_FT_startAging", 0 )
 	StorageUtil.SetIntValue(none, "_FT_pauseAging", 0 )

	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerAge", 18)

	; Debug.Messagebox("Birthday initialization\nPlayer Level: "+ PlayerActor.getlevel() +"\nPlayer Age Level: " + StorageUtil.GetIntValue(PlayerActor, "_FT_iPlayerAgeLevel")  +"\nPlayer Age: " + start_age.GetValue() as Int)

	_maintenance()

EndEvent

Event OnPlayerLoadGame()

	_maintenance()

EndEvent

Function _maintenance()
 	Actor PlayerActor= Game.GetPlayer() as Actor
 	ActorBase pActorBase = PlayerActor.GetActorBase()

	If (!StorageUtil.HasIntValue(none, "_FT_iFamilyTies"))
		StorageUtil.SetIntValue(none, "_FT_iFamilyTies", 1)
	EndIf

	rPlayerCurrentRace = PlayerActor.getrace()
	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerCurrentRace", rPlayerCurrentRace as Form)
	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerYearsCount", yearsCount)

	if ((StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race) != None )
		rPlayerRealRace = StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race
	else
		rPlayerRealRace = None
	endif

	_registerNewRacesForHeadparts( VanillaHairRaceList  )
	_registerNewRacesForHeadparts( CustomHairRaceList  )
	_registerNewRacesForHeadparts( CustomEyesRaceList  )

	UnregisterForAllModEvents()
	Debug.Trace("Family ties: Reset events")

	RegisterForSleep()

	; RegisterForSingleUpdate(10)
EndFunction

 
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Actor PlayerActor = Game.GetPlayer() as Actor
	; Location kLocation = PlayerActor.GetCurrentLocation()
	; Bool bLocationAllowed = False


 		
	If (StorageUtil.GetIntValue(none, "_FT_startAging" ) == 0)
		Debug.Trace("[FT] Family Ties aging stopped" )
		bGrantStartPerks = false
		Return
	Endif


	If (StorageUtil.GetIntValue(none, "_FT_pauseAging" ) == 1)
		Debug.Trace("[FT] Family Ties aging disabled" )
		Return
	Endif

	baseAge = StorageUtil.GetFloatValue(PlayerActor, "_FT_baseAge" ) as Int
	anniversaryFrequency = StorageUtil.GetFloatValue(PlayerActor, "_FT_anniversaryFrequency" ) as Int
 	daysPassed = Game.QueryStat("Days Passed")

 	; Initial values
 	if (iGameDateLastCheck == -1)
 		iGameDateLastCheck = daysPassed
		iDaysSinceLastAnniversary = 0
		iDaysSinceLastBirthday = 0
 		daysCount = 0
		yearsCount = 0
 	endIf

 	If (!bGrantStartPerks) && (baseAge>16)
 		bGrantStartPerks = true
 		Game.AddPerkPoints((baseAge as Int) - 16)
 	endif
 
	iDaysSinceLastCheck = (daysPassed - iGameDateLastCheck ) as Int

	daysCount = daysCount + iDaysSinceLastCheck
	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerDaysCount", daysCount)
	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerYearsCount", yearsCount)
	age = baseAge + yearsCount
 
	Debug.Trace("[FT] age = " + age)
	Debug.Trace("[FT] yearsCount = " + yearsCount) 
	Debug.Trace("[FT] daysCount = " + daysCount)
	Debug.Trace("[FT] anniversaryFrequency = " + anniversaryFrequency)


	If (daysCount > anniversaryFrequency)

		if (daysCount>=364)
			yearsCount = yearsCount + 1
	 		age = baseAge + yearsCount
	 		daysCount = daysCount - 364
			celebrateBirthday()
		Else
			celebrateAnniversary()
		Endif

	EndIf

	iGameDateLastCheck = daysPassed  

	StorageUtil.SetIntValue(PlayerActor, "_FT_iPlayerAge", age)
EndEvent


Function celebrateAnniversary()
	Actor PlayerActor
	Form fPlayerRealRace 
	Form fPlayerCurrentRace 

	PlayerActor = Game.GetPlayer() as Actor
	rPlayerCurrentRace = PlayerActor.getrace()

	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerCurrentRace", rPlayerCurrentRace as Form)

	if ((StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race) != None )
		rPlayerRealRace = StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race
	else
		rPlayerRealRace = None
	endif
 
	fPlayerRealRace = rPlayerRealRace as Form
	fPlayerCurrentRace  = rPlayerCurrentRace as Form

	If (rPlayerRealRace != None) && (rPlayerRealRace != rPlayerCurrentRace)
		Debug.Messagebox("[Anniversary perks skipped because current race "+ rPlayerCurrentRace +" is not player real race " + rPlayerRealRace+"\nPlayer Real Race: " + fPlayerRealRace.GetName()+"\nPlayer Current Race: " + fPlayerCurrentRace.GetName() + " ]")

	ElseIf (rPlayerRealRace != None) && (rPlayerRealRace == rPlayerCurrentRace)

		Debug.Messagebox("Anniversary update\nPlayer Level: "+ PlayerActor.getlevel() +"\nPlayer Age : " + age )

		if (Utility.RandomInt(1,364)<=anniversaryFrequency)
			Game.AddPerkPoints(1)
		endif

     endif


EndFunction


Function celebrateBirthday()
	Actor PlayerActor
	Form fPlayerRealRace 
	Form fPlayerCurrentRace 

	PlayerActor = Game.GetPlayer() as Actor
	rPlayerCurrentRace = PlayerActor.getrace()

	StorageUtil.SetFormValue(PlayerActor, "_FT_fPlayerCurrentRace", rPlayerCurrentRace as Form)

	if ((StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race) != None )
		rPlayerRealRace = StorageUtil.GetFormValue(PlayerActor, "_FT_fPlayerRealRace") as Race
	else
		rPlayerRealRace = None
	endif
 
	fPlayerRealRace = rPlayerRealRace as Form
	fPlayerCurrentRace  = rPlayerCurrentRace as Form

	If (rPlayerRealRace != None) && (rPlayerRealRace != rPlayerCurrentRace)
		Debug.Messagebox("[Birthday perks skipped because current race "+ rPlayerCurrentRace +" is not player real race " + rPlayerRealRace+"\nPlayer Real Race: " + fPlayerRealRace.GetName()+"\nPlayer Current Race: " + fPlayerCurrentRace.GetName() + " ]")

	ElseIf (rPlayerRealRace != None) && (rPlayerRealRace == rPlayerCurrentRace)

		Debug.Messagebox("Birthday update\nPlayer Level: "+ PlayerActor.getlevel() +"\nPlayer Age : " + age )

		If (age <= 20) 
			if ( rPlayerRealRace == bteen) ||  ( rPlayerRealRace == iteen) ||  ( rPlayerRealRace == nteen) ||  ( rPlayerRealRace == rteen) 
				Debug.Messagebox("Happy birthday!\n At " + age + ", you are no longer a sheltered child. As a teenager, you are discovering the harsh environment of Skyrim. Life is short.. make the most of it.")

				PlayerActor.SetScale(0.96 + ((age - baseAge) * 0.01 ) )
 			Else
				Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Endif
			Game.AddPerkPoints(2)
			
		elseif (age == 21)  
			if ( rPlayerRealRace == bteen) ||  ( rPlayerRealRace == iteen) ||  ( rPlayerRealRace == nteen) ||  ( rPlayerRealRace == rteen) 
				Debug.Messagebox("Happy birthday!\n At " + age + ", you are a fully grown adult now. Surviving was not easy and will not get any easier from now on. ")

				if rPlayerRealRace == bteen
					PlayerActor.setrace(brace)

				elseif rPlayerRealRace == iteen
					PlayerActor.setrace(irace)

				elseif rPlayerRealRace == nteen
					PlayerActor.setrace(nrace)

				elseif rPlayerRealRace == rteen
					PlayerActor.setrace(rrace)
			 	endif
					
				PlayerActor.SetScale(1.0)

			 	Utility.Wait(10.0)
				int iopt2 = adultmsg.show()
			 	if iopt2 == 0
					game.showracemenu()
				endif
			Else
				Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Endif
			Game.AddPerkPoints(3)

		elseif (age < 70)
			Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Game.AddPerkPoints(3)

		elseif (age == 70)
			if ( rPlayerRealRace == brace) ||  ( rPlayerRealRace == irace) ||  ( rPlayerRealRace == nrace) ||  ( rPlayerRealRace == rrace) 
				Debug.Messagebox("Happy birthday!\n After years of adventuring, with old age comes power and wisdom. Happly both carefully.")

				PlayerActor.setrace(erace)
				PlayerActor.SetScale(1.0)
				Utility.Wait(10.0)
				int iopt3 = eldermsg.show()
	 			if iopt3 == 0
					game.showlimitedracemenu()
				endif
			Else
				Debug.Messagebox("Happy birthday!\n You are " + age + ". ")
			Endif

			Game.AddPerkPoints(5)

		endif

     endif


EndFunction



Function _registerNewRacesForHeadparts(FormList HairRaceList)
 
    If (!HairRaceList.HasForm( bteen  as Form) )
		HairRaceList.AddForm( bteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( rteen  as Form) )
		HairRaceList.AddForm( rteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( nteen  as Form) )
		HairRaceList.AddForm( nteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( iteen  as Form) )
		HairRaceList.AddForm( iteen  as Form) 
	Endif

    If (!HairRaceList.HasForm( erace  as Form) )
		HairRaceList.AddForm( erace  as Form) 
	Endif
 
EndFunction

