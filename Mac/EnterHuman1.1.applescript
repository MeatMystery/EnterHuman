-- EnterHuman for macOS - AppleScript version
-- Converted from an AutoHotkey human-like typing script.
-- Use only for permitted UI testing, demos, accessibility workflows, or personal automation.
-- Requires macOS Accessibility permission for Script Editor, Automator, Shortcuts, or the saved app.

-- -------------------------------
-- Text to type when choosing Built-in Text
-- -------------------------------
property builtInText : "This script simulates natural human typing patterns on macOS." & return & return & "It includes randomized pauses, typo corrections, long-word awareness, and more."

-- -------------------------------
-- Typing settings
-- -------------------------------
property baseWPM : 140
property typoChance : 30 -- 1 in N chance per eligible character. Use 0 to disable typos.

property commaPause : 0.25
property commaPauseNoise : 0.075

property sentencePause : 1.0
property sentencePauseNoise : 0.10

property paragraphPause : 2.0
property paragraphPauseNoise : 0.70

property thinkingPauseChance : 15 -- 1 in N chance after spaces. Use 0 to disable.
property thinkingPauseTime : 0.80
property thinkingPauseNoise : 0.15

property enableTypingSounds : false -- macOS beep has no frequency control, so this is off by default.
property playEndChime : true

-- -------------------------------
-- Main menu
-- -------------------------------
on run
	set choiceList to {"Type Clipboard", "Type Built-in Text", "Cancel"}
	set chosen to button returned of (display dialog "Choose what EnterHuman should type. After you click OK, quickly place your cursor in the target text field." buttons choiceList default button "Type Clipboard" cancel button "Cancel" with title "EnterHuman for macOS")
	
	if chosen is "Type Clipboard" then
		set textToType to the clipboard as text
		if textToType is "" then
			display dialog "Clipboard is empty." buttons {"OK"} default button "OK" with icon caution
			return
		end if
	else if chosen is "Type Built-in Text" then
		set textToType to builtInText
	else
		return
	end if
	
	delay 1.5
	my sendHuman(textToType)
end run

-- -------------------------------
-- Core typing routine
-- -------------------------------
on sendHuman(str)
	set charCount to count characters of str
	repeat with i from 1 to charCount
		set char to character i of str
		
		-- Paragraph pause for blank lines
		if char is return or char is linefeed then
			if i < charCount then
				set nextChar to character (i + 1) of str
				if nextChar is return or nextChar is linefeed then
					my typeCharacter(return)
					delay (my noise(paragraphPause, paragraphPauseNoise))
					-- Let the next newline be processed normally; this intentionally creates a blank line.
				else
					my typeCharacter(return)
				end if
			else
				my typeCharacter(return)
			end if
		else if char is "," or char is "—" then
			my typeCharacter(char)
			delay (my noise(commaPause, commaPauseNoise))
		else if char is "." or char is "!" or char is "?" then
			my typeCharacter(char)
			delay (my noise(sentencePause, sentencePauseNoise))
		else
			if char is " " then
				set prevWord to my getPreviousWord(str, i)
				if (length of prevWord) ≥ 8 then delay (my randomReal(0.10, 0.25))
				
				if (random number from 1 to 100) is 1 then
					my typeCharacter(" ")
					delay 0.04
					my backspaceOnce()
				end if
				
				if thinkingPauseChance > 0 then
					if (random number from 1 to thinkingPauseChance) is 1 then delay (my noise(thinkingPauseTime, thinkingPauseNoise))
				end if
			end if
			
			if typoChance > 0 and char is not return and char is not linefeed and char is not " " then
				if (random number from 1 to typoChance) is 1 then
					set typoChar to my getAdjacentKey(char)
					if typoChar is not "" then
						my typeCharacter(typoChar)
						delay 0.08
						my backspaceOnce()
						delay 0.04
					end if
				end if
			end if
			
			set currentWPM to baseWPM + (random number from -10 to 10)
			set charDelay to 60 / (currentWPM * 5)
			delay (my randomReal(charDelay - 0.005, charDelay + 0.005))
			
			if enableTypingSounds then beep 1
			my typeCharacter(char)
		end if
	end repeat
	
	if playEndChime then
		beep 1
		delay 0.10
		beep 1
		delay 0.10
		beep 1
	end if
end sendHuman

on typeCharacter(char)
	tell application "System Events"
		if char is return or char is linefeed then
			key code 36
		else
			keystroke char
		end if
	end tell
end typeCharacter

on backspaceOnce()
	tell application "System Events" to key code 51
end backspaceOnce

-- -------------------------------
-- Helpers
-- -------------------------------
on getAdjacentKey(char)
	set lowerChar to my lowercaseChar(char)
	set candidates to {}
	
	if lowerChar is "a" then set candidates to {"s", "q", "z"}
	if lowerChar is "b" then set candidates to {"v", "g", "n"}
	if lowerChar is "c" then set candidates to {"x", "d", "v"}
	if lowerChar is "d" then set candidates to {"s", "e", "f", "c"}
	if lowerChar is "e" then set candidates to {"w", "r", "d"}
	if lowerChar is "f" then set candidates to {"d", "r", "g", "v"}
	if lowerChar is "g" then set candidates to {"f", "t", "h", "b"}
	if lowerChar is "h" then set candidates to {"g", "y", "j", "n"}
	if lowerChar is "i" then set candidates to {"u", "o", "k"}
	if lowerChar is "j" then set candidates to {"h", "u", "k", "m"}
	if lowerChar is "k" then set candidates to {"j", "i", "l", ";"}
	if lowerChar is "l" then set candidates to {"k", "o", ";"}
	if lowerChar is "m" then set candidates to {"n", "j", ",", "k"}
	if lowerChar is "n" then set candidates to {"b", "h", "m", ","}
	if lowerChar is "o" then set candidates to {"i", "p", "l", ";", "["}
	if lowerChar is "p" then set candidates to {"o", ";", "[", "]"}
	if lowerChar is "q" then set candidates to {"w", "a"}
	if lowerChar is "r" then set candidates to {"e", "t", "f"}
	if lowerChar is "s" then set candidates to {"a", "w", "d", "x"}
	if lowerChar is "t" then set candidates to {"r", "y", "g"}
	if lowerChar is "u" then set candidates to {"y", "i", "j"}
	if lowerChar is "v" then set candidates to {"c", "f", "b"}
	if lowerChar is "w" then set candidates to {"q", "e", "s"}
	if lowerChar is "x" then set candidates to {"z", "s", "d"}
	if lowerChar is "y" then set candidates to {"t", "u", "h"}
	if lowerChar is "z" then set candidates to {"x", "a"}
	if lowerChar is ";" then set candidates to {"l", "p", "'", ":"}
	if lowerChar is "'" then set candidates to {";", "[", "]"}
	if lowerChar is "[" then set candidates to {"p", "]", "\\"}
	if lowerChar is "]" then set candidates to {"[", "\\", "'"}
	if lowerChar is "\\" then set candidates to {"]", "[", "'"}
	if lowerChar is "," then set candidates to {"m", ".", "k"}
	if lowerChar is "." then set candidates to {",", "/", "l"}
	if lowerChar is "/" then set candidates to {".", ";", "'"}
	
	if candidates is {} then return ""
	set picked to item (random number from 1 to (count of candidates)) of candidates
	if my isUppercaseLetter(char) then return my uppercaseChar(picked)
	return picked
end getAdjacentKey

on getPreviousWord(str, idx)
	set segment to text 1 thru (idx - 1) of str
	set AppleScript's text item delimiters to {" ", return, linefeed, tab, ".", ",", "!", "?", ";", ":", "(", ")", "[", "]", "{", "}", quote}
	set bits to text items of segment
	set AppleScript's text item delimiters to ""
	repeat with j from (count of bits) to 1 by -1
		set candidate to item j of bits as text
		if candidate is not "" then return candidate
	end repeat
	return ""
end getPreviousWord

on noise(baseValue, noiseRange)
	return my randomReal(baseValue - noiseRange, baseValue + noiseRange)
end noise

on randomReal(minValue, maxValue)
	if minValue < 0 then set minValue to 0
	return minValue + ((random number from 0 to 1000000) / 1000000) * (maxValue - minValue)
end randomReal

on lowercaseChar(char)
	set lowers to "abcdefghijklmnopqrstuvwxyz"
	set uppers to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	repeat with i from 1 to 26
		if char is character i of uppers then return character i of lowers
	end repeat
	return char
end lowercaseChar

on uppercaseChar(char)
	set lowers to "abcdefghijklmnopqrstuvwxyz"
	set uppers to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	repeat with i from 1 to 26
		if char is character i of lowers then return character i of uppers
	end repeat
	return char
end uppercaseChar

on isUppercaseLetter(char)
	set uppers to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	repeat with i from 1 to 26
		if char is character i of uppers then return true
	end repeat
	return false
end isUppercaseLetter
