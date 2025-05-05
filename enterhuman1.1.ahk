; EnterHuman 1.1 - Chase V
; Realistic Human-Like typing with word-aware rhythm, long-word pauses, and backspace quirks
; General Formatting with ChatGPT 4.0
; 4-5-25
; 
; Run in AutoHotKey v2.x
; https://www.autohotkey.com/
;
; Run and Use [Ctrl]+[Alt]+V to type from clipboard or [Ctrl]+[Alt]+B to type from 'text' variable. 
; [Esc] to exit script.



; ----------------------------------------
; ------ TEXT TO TYPE - EDIT BELOW -------
; ----------------------------------------

text := "
(
This script simulates natural human typing patterns in AutoHotkey v2.

It includes randomized pauses, typos from adjacent keys, long word awareness, and more.
)"

; ----------------------------------------
; ----------- TYPING SETTINGS ------------
; ----------------------------------------

baseWPM := 140
typoChance := 30

commaPause := 250
commaPauseNoise := 75

sentencePause := 1000
sentencePauseNoise := 100

paragraphPause := 2000
paragraphPauseNoise := 700

thinkingPauseChance := 15
thinkingPauseTime := 800
thinkingPauseNoise := 150

enableTypingSounds := true
playEndChime := true


; ----------------------------------------
; ---------------- HOTKEYS ---------------
; ----------------------------------------

^!v:: {
    ; Ctrl + Alt + V — Type from clipboard
    if A_Clipboard = ""
    {
        MsgBox "Clipboard is empty!"
        return
    }
    SendHuman(A_Clipboard)
}

^!b:: {
    ; Ctrl + Alt + B — Type from built-in text variable
    SendHuman(text)
}

Esc::ExitApp()


; ----------------------------------------
; ---- ADJACENT KEY TYPO MAP (GLOBAL) ----
; ----------------------------------------

adjacentKeyMap := Map(
    "a", ["s", "q", "z"], 
    "b", ["v", "g", "n"], 
    "c", ["x", "d", "v"], 
    "d", ["s", "e", "f", "c"], 
    "e", ["w", "r", "d"], 
    "f", ["d", "r", "g", "v"], 
    "g", ["f", "t", "h", "b"], 
    "h", ["g", "y", "j", "n"], 
    "i", ["u", "o", "k"], 
    "j", ["h", "u", "k", "m"], 
    "k", ["j", "i", "l", ";"], 
    "l", ["k", "o", ";"], 
    "m", ["n", "j", ",", "k"], 
    "n", ["b", "h", "m", ","], 
    "o", ["i", "p", "l", ";", "["], 
    "p", ["o", ";", "[", "]"], 
    "q", ["w", "a"], 
    "r", ["e", "t", "f"], 
    "s", ["a", "w", "d", "x"], 
    "t", ["r", "y", "g"], 
    "u", ["y", "i", "j"], 
    "v", ["c", "f", "b"], 
    "w", ["q", "e", "s"], 
    "x", ["z", "s", "d"], 
    "y", ["t", "u", "h"], 
    "z", ["x", "a"],

    ";", ["l", "p", "'", ":"],
    "'", [";", "[", "]"],
    "[", ["p", "]", "\\"],
    "]", ["[", "\\", "'"],
    "\\", ["]", "[", "'"],
    ",", ["m", ".", "k"],
    ".", [",", "/", "l"],
    "/", [".", ";", "'"]
)


; ----------------------------------------
; ---------- CORE FUNCTIONS --------------
; ----------------------------------------

SendHuman(str) {
    global baseWPM, typoChance, commaPause, sentencePause, paragraphPause
    global commaPauseNoise, sentencePauseNoise, paragraphPauseNoise
    global thinkingPauseChance, thinkingPauseTime, thinkingPauseNoise
    global enableTypingSounds, playEndChime

    Loop Parse str
    {
        char := A_LoopField

        if (char = "`n") {
            nextChar := SubStr(str, A_Index + 1, 1)
            if (nextChar = "`n") {
                Send("`n")
                Sleep(Noise(paragraphPause, paragraphPauseNoise))
                continue
            }
        }

        if char = "," || char = "—" {
            Send(char)
            Sleep(Noise(commaPause, commaPauseNoise))
            continue
        }
        if char = "." || char = "!" || char = "?" {
            Send(char)
            Sleep(Noise(sentencePause, sentencePauseNoise))
            continue
        }

        if char = " " {
            prevWord := GetPreviousWord(str, A_Index)
            if StrLen(prevWord) >= 8 {
                Sleep(Random(100, 250))
            }

            if Random(1, 100) = 1 {
                Send(" ")
                Sleep(40)
                Send("{BS}")
            }

            if Random(1, thinkingPauseChance) = 1 {
                Sleep(Noise(thinkingPauseTime, thinkingPauseNoise))
            }
        }

        if (Random(1, typoChance) = 1 && char != "`n" && char != "`r" && char != " ") {
            typoChar := GetAdjacentKey(char)
            if typoChar != "" {
                Send(typoChar)
                Sleep(80)
                Send("{BS}")
                Sleep(40)
            }
        }

        currentWPM := baseWPM + Random(-10, 10)
        charDelay := Round(60000 / (currentWPM * 5))
        Sleep(Random(charDelay - 5, charDelay + 5))

        if enableTypingSounds {
            SoundBeep(750, 10)
        }

        Send(char)
    }

    if playEndChime {
        SoundBeep(1200, 200)
        Sleep(100)
        SoundBeep(1500, 200)
        Sleep(100)
        SoundBeep(1800, 200)
    }
}

GetAdjacentKey(char) {
    global adjacentKeyMap

    char := SubStr(char, 1, 1)
    lowerChar := StrLower(char)

    if !adjacentKeyMap.Has(lowerChar)
        return ""

    keys := adjacentKeyMap[lowerChar]
    idx := Random(1, keys.Length)
    typo := keys[idx]

    return (char ~= "[A-Z]") ? StrUpper(typo) : typo
}

GetPreviousWord(str, idx) {
    segment := SubStr(str, 1, idx - 1)
    match := ""
    if RegExMatch(segment, "([\w'-]+)\s*$", &m) && m[1] != ""
        match := m[1]
    return match
}

Noise(base, range := 50) {
    return Random(base - range, base + range)
}
