# EnterHuman for Windows

This folder contains the original Windows version of EnterHuman, written for **AutoHotkey v2**.

It simulates irregular keyboard input by typing text one character at a time and adding randomized delays, punctuation pauses, occasional hesitation, nearby-key mistakes, and backspace corrections.

For project-wide purpose, AI-assistance, responsible-use, and misuse information, see the [main README](../README.md).

## Files

```text
Windows/
├── enterhuman1.1.ahk
└── README.md
```

- `enterhuman1.1.ahk` - main AutoHotkey v2 script
- `README.md` - Windows-specific setup and usage instructions

## Requirements

- Windows
- [AutoHotkey v2](https://www.autohotkey.com/)

The script is written for AutoHotkey **v2.x** and is not intended for AutoHotkey v1.

## Setup

1. Install AutoHotkey v2.
2. Open the `Windows` folder.
3. Double-click `enterhuman1.1.ahk`.
4. AutoHotkey should place its icon in the Windows system tray while the script is running.

## Using clipboard text

1. Copy the text you want EnterHuman to type.
2. Click in the target text field.
3. Press:

```text
Ctrl + Alt + V
```

EnterHuman will type the current clipboard contents as simulated keystrokes.

If the clipboard is empty, the script displays a message instead.

## Using built-in text

The script also contains a built-in `text` variable near the top of the file.

Press:

```text
Ctrl + Alt + B
```

to type that built-in text.

To change it, edit this section of `enterhuman1.1.ahk`:

```ahk
text := "
(
Your text here.
)"
```

## Hotkeys

| Hotkey | Action |
| --- | --- |
| `Ctrl + Alt + V` | Type the current clipboard contents |
| `Ctrl + Alt + B` | Type the built-in `text` value |
| `Esc` | Exit EnterHuman |

Because `Esc` exits the script globally while EnterHuman is running, close the script when you are finished if you need Escape for another application.

## Typing settings

The main behavior settings are near the top of `enterhuman1.1.ahk`.

### Typing speed

```ahk
baseWPM := 140
```

Approximate base words per minute. The script adds a small amount of random variation while typing.

### Typo frequency

```ahk
typoChance := 30
```

This represents approximately a **1 in 30** chance of attempting a typo on an eligible character. Typos are chosen from a map of nearby keyboard keys, then corrected with Backspace.

### Punctuation pauses

```ahk
commaPause := 250
commaPauseNoise := 75

sentencePause := 1000
sentencePauseNoise := 100

paragraphPause := 2000
paragraphPauseNoise := 700
```

These values are in **milliseconds**.

- commas and em dashes receive a shorter pause
- periods, exclamation marks, and question marks receive a longer pause
- blank-line paragraph breaks receive the longest pause
- the matching `Noise` settings add random variation around each base delay

### Thinking pauses

```ahk
thinkingPauseChance := 15
thinkingPauseTime := 800
thinkingPauseNoise := 150
```

After spaces, the script occasionally pauses as if the typist is thinking. With the default setting, the pause has roughly a **1 in 15** chance of occurring.

The script also adds a brief delay after words eight or more characters long.

### Sounds

```ahk
enableTypingSounds := true
playEndChime := true
```

- `enableTypingSounds` plays a short beep while typing
- `playEndChime` plays a short three-tone sequence after completion

Set either value to `false` to disable it.

## How the typo behavior works

The script contains an `adjacentKeyMap` that associates characters with nearby keys. For example, an intended `a` may briefly produce `s`, `q`, or `z` before the script presses Backspace and continues with the correct character.

This creates visible correction behavior instead of merely slowing down text entry.

## Limitations

- EnterHuman sends input to the currently active application, so make sure the intended text field has focus before starting.
- Some applications and secure fields intentionally reject or handle synthetic keystrokes differently.
- Keyboard layout differences may affect adjacent-key assumptions or certain punctuation characters.
- Hotkeys can conflict with shortcuts used by other software.
- Very high WPM values may behave inconsistently depending on the target application.
- AutoHotkey automation should only be used where simulated input is permitted.

## Stopping the script

Press `Esc`, or right-click the AutoHotkey tray icon and exit the script.

## Responsible use

This program should not be used to conceal prohibited automation, evade anti-bot or rate-limit controls, misrepresent automated activity as human activity, or violate platform, workplace, academic, or organizational rules.

See the [main README](../README.md#responsible-use-and-misuse) for the full project misuse statement.
