settitlematchmode,2
CoordMode, Mouse, Screen
IniRead, IniReset, RocketXP.ini, ResetConfig, ResetConfig, 0
If (IniReset = 1) {
	gosub, IniMake
}
IniRead, dMode, RocketXP.ini, Settings, Mode, 0
IniRead, dClaimAmount, RocketXP.ini, Settings, ClaimAmount, 10
IniRead, dStartLength, RocketXP.ini, Settings, StartLength, 20
IniRead, dEndLength, RocketXP.ini, Settings, EndLength, 20
IniRead, dJoinLength, RocketXP.ini, Settings, JoinLength, 20
IniRead, dLeaveLength, RocketXP.ini, Settings, LeaveLength, 10
IniRead, dDelay, RocketXP.ini, Delay, Delay, 0
IniRead, dMatchDelay, RocketXP.ini, Delay, MatchDelay, 0
Uncalibrated := ["Challenge", "Event", "Claim", "Friend", "Join", "Finish"]
Games := 0

NormalStart:
	; Creates a GUI with a checkbox for whether the user is the XP Gainer or the Forfeiter
	Gui, New, 
	Gui, Add, Checkbox, vAddHotkeys, Testing Mode
	Gui, Add, Text, Center, I am the
	Gui, Add, Radio, vMode, XP Gainer
	Gui, Add, Radio,, Forfeiter
	Gui, Add, Text, Center, How many Games are required for the challenge?
	Gui, Add, Edit
	Gui, Add, UpDown, vClaimAmount Range1-100, %dClaimAmount%
	Gui, Add, Text, Center, Time Between Ready and Timer Start (in Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vStartLength Range1-100, %dStartLength%
	Gui, Add, Text, Center, Time Between End Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vEndLength Range1-100, %dEndLength%
	Gui, Add, Text, Center, How long between Join Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vJoinLength Range1-100, %dJoinLength%
	Gui, Add, Text, Center, How long to leave match (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vLeaveLength Range1-100, %dLeaveLength%
	Gui, Add, Text, Center, Jump Frequency Adjustment (In Milliseconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vDelay Range-1000-1000, %dDelay%
	Gui, Add, Text, Center, Match Time Adjustment (In Milliseconds)
	Gui, Add, Edit
	gui, Add, UpDown, vMatchDelay Range-1000-1000, %dMatchDelay%
	Gui, Add, Button, Default w80 gPreStart, Submit
	Gui, Add, Button, w80 gWarn, Set Default
	Gui, Add, Button, w80 gPreIniMake, Create INI File
	Gui, Show
	return	

GuiClose:
	ExitApp
	return

PreIniMake:
	Gui, New
	Gui, Add, Text, Center, This will replace all default values. Are you sure you want to do this?
	Gui, Add, Button, w80 gIniMake, Yes
	Gui, Add, Button, w80 y+0 gClose, No
	Gui, Show
	return

Close:
	Gui, Submit
	return

IniMake:
	Gui, Submit
	IniWrite, 0, RocketXP.ini, ResetConfig, ResetConfig
	IniWrite, 0, RocketXP.ini, Settings, Mode
	IniWrite, 10, RocketXP.ini, Settings, ClaimAmount
	IniWrite, 20, RocketXP.ini, Settings, StartLength
	IniWrite, 20, RocketXP.ini, Settings, EndLength
	IniWrite, 20, RocketXP.ini, Settings, JoinLength
	IniWrite, 10, RocketXP.ini, Settings, LeaveLength
	IniWrite, 0, RocketXP.ini, Delay, Delay
	IniWrite, 0, RocketXP.ini, Delay, MatchDelayss
return

Warn:
	Gui, New
	Gui, Add, Text, Center, This will replace all default values. Are you sure you want to do this?
	Gui, Add, Button, w80 gCommit, Yes
	Gui, Add, Button, w80 y+0 gCancel, No
	Gui, Show
return

Commit:
	Gui, Submit
	Gui, Submit
	IniWrite, %Mode%, RocketXP.ini, Settings, Mode
	IniWrite, %ClaimAmount%, RocketXP.ini, Settings, ClaimAmount
	IniWrite, %StartLength%, RocketXP.ini, Settings, StartLength
	IniWrite, %EndLength%, RocketXP.ini, Settings, EndLength
	IniWrite, %JoinLength%, RocketXP.ini, Settings, JoinLength
	IniWrite, %LeaveLength%, RocketXP.ini, Settings, LeaveLength
	IniWrite, %Delay%, RocketXP.ini, Settings, Delay
	IniWrite, %MatchDelay%, RocketXP.ini, Settings, MatchDelay
return

^!a::
	GuiSubmit := 0
	Gui, New, 
	Gui, Add, Checkbox, vAddHotkeys, Testing Mode
	Gui, Add, Text, Center, I am the
	Gui, Add, Radio, vMode, XP Gainer
	Gui, Add, Radio,, Forfeiter
	Gui, Add, Text, Center, How many Games are required for the challenge?
	Gui, Add, Edit
	Gui, Add, UpDown, vClaimAmount Range1-100, %dClaimAmount%
	Gui, Add, Text, Center, Time Between Ready and Timer Start (in Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vStartLength Range1-100, %dStartLength%
	Gui, Add, Text, Center, Time Between End Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vEndLength Range1-100, %dEndLength%
	Gui, Add, Text, Center, How long between Join Game and Ready Available (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vJoinLength Range1-100, %dJoinLength%
	Gui, Add, Text, Center, How long to leave match (In Seconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vLeaveLength Range1-100, %dLeaveLength%
	Gui, Add, Text, Center, Jump Frequency Adjustment (In Milliseconds)
	Gui, Add, Edit
	Gui, Add, UpDown, vDelay Range-1000-1000, %dDelay%
	Gui, Add, Text, Center, Match Time Adjustment (In Milliseconds)
	Gui, Add, Edit
	gui, Add, UpDown, vMatchDelay Range-1000-1000, %dMatchDelay%
	Gui, Add, Button, Default w80 gSubmit, Submit
	Gui, Add, Button, w80 gWarn, Set Default
	Gui, Show
	While (GuiSubmit = 0) {
	
	}
return

Submit:
	Gui, Submit
	SleepLength := 5000 + Delay
	StartLength *= 1000
	EndLength *= 1000
	JoinLength *= 1000
	LeaveLength *= 1000
	GuiSubmit := 1
	StartSleep := StartLength + MatchDelay
	Switch AddHotkeys {
		Case 1: 
		Hotkey, ^+p, Prestart
		Hotkey, ^+c, Calibration
		Hotkey, ^+g, Game
		Hotkey, ^+q, PostGame
		Hotkey, ^+f, Forfeit
		Hotkey, ^+r, RewardClaim
		Hotkey, ^+l, Leave
		Default:
		Hotkey, ^+p, Terminate
		Hotkey, ^+g, Terminate
		Hotkey, ^+q, Terminate
		Hotkey, ^+f, Terminate
		Hotkey, ^+r, Terminate
		Hotkey, ^+l, Terminate
	}
	return

Terminate:
	return

PreStart:
Gosub, Submit
	Switch (Mode) {
	Case 1:
		Gosub, Calibration
	Case 2: 
		CurrentCalibration := "Finish"
		Loop {
			MouseGetPos, ToolTipX, ToolTipY
			ToolTipY += 20
			ToolTip, Press (Ctrl+Shift+B) To start the script, %ToolTipX%, %ToolTipY%
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
				ToolTip, Hover over the "View Challenges" Button and Press (Ctrl+Shift+B), %ToolTipX%, %ToolTipY%
			Case "Event":
				ToolTip, Hover over the Event Panel in the Challenge Menu and Press (Ctrl+Shift+B), %ToolTipX%, %ToolTipY%
			Case "Claim":
				ToolTip, Hover over the Claim Button (or where it would be) for the reward you want to farm and Press (Ctrl+Shift+B), %ToolTipX%, %ToolTipY%
			Case "Friend":
				ToolTip, Hover over the the Forfeiter in your steam friends and Press (Ctrl+Shift+B), %ToolTipX%, %ToolTipY%
			Case "Join":
				ToolTip, Hover over the "Join Game" (or "Launch Game" if join game isn't visible) Button and Press (Ctrl+Shift+B), %ToolTipX%, %ToolTipY%
			Case "Finish":
				ToolTip, Press (Ctrl+Shift+B) To start the script, %ToolTipX%, %ToolTipY%
		}
	}
	return
	
^+b::
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
			Goto, Game
		}
	return

; Main Script Begin

Game:
	;SetTimer, PostGame, 90000
	Loop {
		Loop 20 {		
			controlsend,,{Enter},Rocket League ; Jump to prevent AFK kick
			Sleep, %SleepLength%
		}
		Gosub, PostGame
	}	
PostGame:
	; End the Game
	Switch Mode {
		Case 1:
			Sleep, 900
		Case 2:
			Gosub, Forfeit
	}
	Sleep, %EndLength%
	
	; Claim Rewards
	Games++
	If (Games = %ClaimAmount%) {
		Games := 0
		Switch Mode {
			Case 1:
				Gosub, RewardClaim
			Case 2:
				Sleep, %LeaveLength%
				Sleep, 10100
		}
		Sleep, %JoinLength%
	}
	
	; Ready Up
	ControlFocus,,Rocket League
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Escape},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Escape},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Escape},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Escape},Rocket League
	Sleep,100
	controlsend,,{Up},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Escape},Rocket League
	Sleep,100
	controlsend,,{Up},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Escape},Rocket League
	Sleep,100
	controlsend,,{Up},Rocket League
	Sleep,100
	controlsend,,{Enter},Rocket League
	Sleep,100
	controlsend,,{Escape},Rocket League
	Sleep, %StartSleep%
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
	WinActivate,Friends List
	MouseMove, %FriendX%, %FriendY%
	Sleep, 2500
	Click, %FriendX%, %FriendY%, RIGHT
	MouseMove, %JoinX%, %JoinY%
	Sleep, 2750
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
	controlsend,,{Down},Rocket League
	Sleep, 100
	controlsend,,{Enter},Rocket League
	Sleep, 100
	controlsend,,{Left},Rocket League
	Sleep, 100
	controlsend,,{Enter},Rocket League
	Sleep, %LeaveLength%
	return