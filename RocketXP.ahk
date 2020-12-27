settitlematchmode,2
CoordMode, Mouse, Screen
Uncalibrated := ["Challenge", "Event", "Claim", "Join", "Join2", "Finish"]
Mode := 0
ClaimAmount := 10

NormalStart:
	; Creates a GUI with a checkbox for whether the user is the XP Gainer or the Forfeiter
	Gui, New, 
	Gui, Add, Checkbox, vAddHotkeys, Testing Mode
	Gui, Add, Text, Center, I am the
	Gui, Add, Radio, vMode, XP Gainer
	Gui, Add, Radio,, Forfeiter
	Gui, Add, Text, Center, How many Games are required for the challenge?
	Gui, Add, Edit
	Gui, Add, UpDown, vClaimAmount Range1-100, 10
	Gui, Add, Text, Center, Time Between Ready and Timer Start (in Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vStartLength Range1-100, 25
	Gui, Add, Text, Center, Time Between End Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vEndLength Range1-100, 20
	Gui, Add, Text, Center, How long between Join Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vJoinLength Range1-100, 20
	Gui, Add, Text, Center, How long to leave match (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vLeaveLength Range1-100, 10
	Gui, Add, Button, Default w80 gPreStart, Submit
	Gui, Show
return	

^!a::
	GuiSubmit := 0
	Gui, New,
	Gui, Add, Checkbox, vAddHotkeys, Testing Mode
	Gui, Add, Text, Center, How many Games are required for the challenge?
	Gui, Add, Edit
	Gui, Add, UpDown, vClaimAmount Range1-100, 10
	Gui, Add, Text, Center, Time Between Ready and Timer Start (in Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vStartLength Range1-100, 25
	Gui, Add, Text, Center, Time Between End Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vEndLength Range1-100, 20
	Gui, Add, Text, Center, How long between Join Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vJoinLength Range1-100, 20
	Gui, Add, Text, Center, How long to leave match (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vLeaveLength Range1-100, 10
	Gui, Add, Button, Default w80 gSubmit, Submit
	Gui, Show
	While (GuiSubmit = 0) {
	
	}
return

Submit:
	Clipboard = %AddHotkeys%
	Gui, Submit
	StartLength *= 1000
	EndLength *= 1000
	JoinLength *= 1000
	LeaveLength *= 1000
	GuiSubmit := 1
return

PreStart:
	Clipboard = %AddHotkeys%
	Gui, Submit
	StartLength *= 1000
	EndLength *= 1000
	JoinLength *= 1000
	LeaveLength *= 1000
	Switch (Mode) {
	Case 1:
		Gosub, Calibration
	Case 2: 
		CurrentCalibration := "Finish"
		Loop {
			MouseGetPos, ToolTipX, ToolTipY
			ToolTipY += 20
			ToolTip, Press (Ctrl+Alt+B) To start the script, %ToolTipX%, %ToolTipY%
		}
	}
return

Calibration:
	UncalibratedCount := Uncalibrated.Count()
	While (UncalibratedCount != 0) {
		MouseGetPos, ToolTipX, ToolTipY
		ToolTipY += 20
		CurrentCalibration := Uncalibrated[1]
		Switch (CurrentCalibration) {
			Case "Challenge":
				ToolTip, Hover over the "View Challenges" Button and Press (Ctrl+Alt+B), %ToolTipX%, %ToolTipY%
			Case "Event":
				ToolTip, Hover over the Event Panel in the Challenge Menu and Press (Ctrl+Alt+B), %ToolTipX%, %ToolTipY%
			Case "Claim":
				ToolTip, Hover over the Claim Button (or where it would be) for the reward you want to farm and Press (Ctrl+Alt+B), %ToolTipX%, %ToolTipY%
			;Case "Friend":
			;	ToolTip, Hover over the the Forfeiter in your steam friends and Press (Ctrl+Alt+B), %ToolTipX%, %ToolTipY%
			Case "Join":
				ToolTip, Hover over the "Join Game" (or "Launch Game" if join game isn't visible) Button and Press (Ctrl+Alt+B), %ToolTipX%, %ToolTipY%
			Case "Join2":
				ToolTip, Hover over the "Join Game" (or "Launch Game" if join game isn't visible) Button and Press (Ctrl+Alt+B), %ToolTipX%, %ToolTipY%
			Case "Finish":
				ToolTip, Press (Ctrl+Alt+B) To start the script, %ToolTipX%, %ToolTipY%
		}
	}
return
	
^!b::
	Switch (CurrentCalibration) {
		Case "Challenge":
			MouseGetPos, ChallengeX, ChallengeY
			Uncalibrated.RemoveAt(1)
			return
		Case "Event":
			MouseGetPos, EventX, EventY
			Uncalibrated.RemoveAt(1)
			return
		Case "Claim":
			MouseGetPos, ClaimX, ClaimY
			Uncalibrated.RemoveAt(1)
			return
	;	Case "Friend":
	;		MouseGetPos, FriendX, FriendY
	;		Uncalibrated.RemoveAt(1)
	;		return
		Case "Join":
			ControlClick,,Friends List,,RIGHT
			Uncalibrated.RemoveAt(1)
			return
		Case "Join2":
			MouseGetPos, JoinX, JoinY
			Uncalibrated.RemoveAt(1)
			return
		Case "Finish":
			ToolTip
			Goto, Game
		}
return

^!c::
	ControlClick,,Friends List,,RIGHT
return

; Main Script Begin

Game:
	SetTimer, PostGame, 90000
	Loop {		
		controlsend,,{Enter},Rocket League ; Jump to prevent AFK kick
		Sleep, 5000
	}
		
PostGame:
	; End the Game
	Switch Mode {
		Case 1:
			Sleep, 700
		Case 2:
			Gosub, Forfeit
	}
	Sleep, %EndLength%
	
	; Claim Rewards
	Games++
	If (Games = %ClaimAmount%) {
		Switch Mode {
			Case 1:
				Gosub, RewardClaim
			Case 2:
				Sleep, %LeaveLength%
				Sleep, 5000
		}
		Sleep, %JoinLength%
	}
	
	; Ready Up
	ControlFocus,,Rocket League
	controlsend,,{Enter},Rocket League
	Sleep, %StartLength%
return

; Various Subroutines Below

Forfeit:
	ControlFocus,,Rocket League
	controlsend,,{Escape},Rocket League
	Sleep,100
	controlsend,,{Down},Rocket League
	Sleep,100
	controlsend,,{Down},Rocket League
	Sleep,100
	controlsend,,{Down},Rocket League
	Sleep,100
	controlsend,,{Down},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Left},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
return

RewardClaim:
	Gosub, Leave
	BlockInput, On
	ControlFocus,,Rocket League
	MouseMove, %ChallengeX%, %ChallengeY%
	ControlClick,,Rocket League
	MouseMove, %EventX%, %EventY%
	ControlClick,,Rocket League
	MouseMove, %ClaimX%, %ClaimY%
	ControlClick,,Rocket League
	BlockInput, Off
	Sleep, 2000
	controlsend,,{Right},Rocket League
	Sleep, 250
	controlsend,,{Enter},Rocket League
	Sleep, 250
	controlsend,,{Right},Rocket League
	Sleep, 250
	controlsend,,{Enter},Rocket League
	Sleep, 250
	controlsend,,{Right},Rocket League
	Sleep, 250
	controlsend,,{Enter},Rocket League
	Sleep, 250
	controlsend,,{Right},Rocket League
	Sleep, 250
	controlsend,,{Enter},Rocket League
	Sleep, 250
	controlsend,,{Esc},Rocket League
	Sleep, 250
	controlsend,,{Esc},Rocket League
	BlockInput, On
	WinGetActiveTitle, PrevTitle
	ControlClick,,Friends List,,RIGHT
	MouseMove, %JoinX%, %JoinY%
	Sleep, 250
	Click, %JoinX%, %JoinY%
	WinActivate, %PrevTitle%
	BlockInput, Off
return

Leave:
	ControlFocus,,Rocket League
	controlsend,,{Down},Rocket League
	Sleep, 100
	controlsend,,{Down},Rocket League
	Sleep, 100
	controlsend,,{Down},Rocket League
	Sleep, 100
	controlsend,,{Enter},Rocket League
	Sleep, 100
	controlsend,,{Left},Rocket League
	Sleep, 100
	controlsend,,{Enter},Rocket League
	Sleep, %LeaveLength%
return
