settitlematchmode,2
CoordMode, Mouse, Window
Uncalibrated := ["Challenge", "Event", "Claim", "Friend", "Join", "Finish"]
IsXpGain := 0
PrePreStart:
	; Creates a GUI with a checkbox for whether the user is the XP Gainer or the Forfeiter
	Gui, New, 
	Gui, Add, Text, Center, I am the
	Gui, Add, Radio, vIsXpGain, XP Gainer
	Gui, Add, Radio,, Forfeiter
	Gui, Add, Button, Default w80 gPreStart, Submit
	Gui, Show
return	
	
PreStart:
	Gui, Submit
	Switch (IsXpGain) {
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
			Case "Friend":
				ToolTip, Hover over the the Forfeiter in your steam friends and Press (Ctrl+Alt+B), %ToolTipX%, %ToolTipY%
			Case "Join":
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
		Case "Friend":
			MouseGetPos, FriendX, FriendY
			Uncalibrated.RemoveAt(1)
			return
		Case "Join":
			MouseGetPos, JoinX, JoinY
			Uncalibrated.RemoveAt(1)
			return
		Case "Finish":
			ToolTip
			Goto, Start
			
		}
return

Start:
	x := 0
	y := 0
	Loop {		
		controlsend,,{Enter},Rocket League ; Jump to prevent AFK kick
		x++
		If (x = 20) { ; After 100 seconds (20 loops), Goes to the Xp Gainers Post-Game sequence @ Label PostGameX\
			x := 0
			Gosub, PostGame
		}
		Sleep, 5000
	}
return

PostGame:
	Switch IsXpGain {
		Case 1:
		Sleep, 4600
		Case 2:
		Gosub, Forfeit
	}
	Sleep, 20000
	; Waits for XP sequence to finish
	y++
	If (y = 10) {
		Switch IsXpGain {
			Case 1:
			Gosub, RewardClaim
			Case 2:
			Sleep, 26000
		}
		y := 0
	}
controlsend,,{Up},Rocket League
Sleep, 500
controlsend,,{Up},Rocket League
Sleep, 500
controlsend,,{Up},Rocket League
Sleep, 500
controlsend,,{Up},Rocket League
Sleep, 500
controlsend,,{Up},Rocket League
Sleep, 500
controlsend,,{Up},Rocket League
Sleep, 500
controlsend,,{Up},Rocket League
Sleep, 500
controlsend,,{Down},Rocket League
Sleep, 500
controlsend,,{Down},Rocket League
Sleep, 500
controlsend,,{Enter},Rocket League
Sleep, 25000
	; Readys up and then waits until in-game timer starts
return

Forfeit:
controlsend,,{Escape},Rocket League
Sleep,500
controlsend,,{Down},Rocket League
Sleep,500
controlsend,,{Down},Rocket League
Sleep,500
controlsend,,{Down},Rocket League
Sleep,500
controlsend,,{Down},Rocket League
Sleep,500
controlsend,,{Down},Rocket League
Sleep,500
controlsend,,{Down},Rocket League
Sleep,500
controlsend,,{Enter},Rocket League
Sleep,500
controlsend,,{Left},Rocket League
Sleep,500
controlsend,,{Enter},Rocket League
	; Forfeits
return

RewardClaim:
controlsend,,{Down},Rocket League
Sleep, 500
controlsend,,{Down},Rocket League
Sleep, 500
controlsend,,{Down},Rocket League
Sleep, 500
controlsend,,{Down},Rocket League
Sleep, 500
controlsend,,{Down},Rocket League
Sleep, 500
controlsend,,{Enter},Rocket League
Sleep, 500
controlsend,,{Left},Rocket League
Sleep, 500
controlsend,,{Enter},Rocket League
Sleep, 5000
WinGetActiveTitle, PrevTitle
WinActivate, Rocket League
click, %ChallengeX%, %ChallengeY%
click, %EventX%, %EventY%
click, %ClaimX%, %ClaimY%
WinActivate, %PrevTitle%
Sleep, 3250
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

WinActivate, Friends List
Sleep, 4750
Click, %FriendX%, %FriendY%, right
Sleep, 4750
MouseMove, %JoinX%, %JoinY%
Sleep, 500
Click, %JoinX%, %JoinY%
WinActivate, %PrevTitle%
Sleep, 3000
return
