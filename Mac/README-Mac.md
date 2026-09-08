# EnterHuman for macOS

This folder contains the macOS version of EnterHuman, implemented in **AppleScript** and using macOS **System Events** to send simulated keystrokes.

It follows the same basic idea as the Windows AutoHotkey version: text is entered one character at a time with randomized delays, punctuation pauses, occasional hesitation, nearby-key mistakes, and backspace corrections.

For project-wide purpose, AI-assistance, responsible-use, and misuse information, see the [main README](../README.md).

## Files

```text
Mac/
├── EnterHuman.applescript
└── README.md
```

- `EnterHuman.applescript` - AppleScript source file
- `README.md` - macOS-specific setup and usage instructions

## Requirements

- macOS
- Script Editor, included with macOS
- Accessibility permission for whichever application runs the script

## Run it in Script Editor

1. Open **Script Editor**. It is normally located in `Applications > Utilities > Script Editor`.
2. Open `EnterHuman.applescript`.
3. Compile the script using the hammer button.
4. Copy the text you want typed, or edit the `builtInText` property near the top of the script.
5. Click **Run**.
6. Choose **Type Clipboard** or **Type Built-in Text**.
7. After making your selection, you have about **1.5 seconds** to click into the target text field.

## Accessibility permission

macOS normally prevents scripts from controlling the keyboard until Accessibility permission is granted.

1. Open **System Settings**.
2. Go to **Privacy & Security > Accessibility**.
3. Enable permission for **Script Editor**.

If you later run EnterHuman another way, grant Accessibility permission to the application actually sending the events. For example:

- a saved `EnterHuman.app`
- Automator
- Shortcuts

macOS may prompt for the permission automatically the first time the automation runs.

## Save EnterHuman as an app

You can export the AppleScript as a double-clickable macOS application:

1. Open `EnterHuman.applescript` in Script Editor.
2. Choose **File > Export**.
3. Set **File Format** to **Application**.
4. Name it `EnterHuman.app` or another name of your choice.
5. Save it.
6. Grant the exported application Accessibility permission if macOS requests it.

## Use a keyboard shortcut with Automator

AppleScript does not provide a global hotkey system by itself. One option is to wrap the script in an Automator Quick Action.

1. Open **Automator**.
2. Create a new **Quick Action**.
3. Set the workflow to receive **no input** in **any application**.
4. Add **Run AppleScript**.
5. Paste the contents of `EnterHuman.applescript` into the action.
6. Save it as `EnterHuman`.
7. Open **System Settings > Keyboard > Keyboard Shortcuts > Services**.
8. Find the new service and assign a keyboard shortcut.

Choose a shortcut that does not conflict with existing application or system shortcuts.

## Typing settings

The main settings are defined near the top of `EnterHuman.applescript`.

### Built-in text

```applescript
property builtInText : "This script simulates natural human typing patterns on macOS."
```

Change this value if you want the **Type Built-in Text** option to enter different content.

### Typing speed

```applescript
property baseWPM : 140
```

Approximate base words per minute. The script varies the value slightly while typing.

### Typo frequency

```applescript
property typoChance : 30
```

This represents approximately a **1 in 30** chance of attempting a typo on an eligible character. Set it to `0` to disable typo attempts.

### Punctuation pauses

```applescript
property commaPause : 0.25
property commaPauseNoise : 0.075

property sentencePause : 1.0
property sentencePauseNoise : 0.10

property paragraphPause : 2.0
property paragraphPauseNoise : 0.70
```

Unlike the Windows script, AppleScript delay values are expressed in **seconds**.

- commas and em dashes receive a shorter pause
- periods, exclamation marks, and question marks receive a longer pause
- blank-line paragraph breaks receive the longest pause
- the matching noise value adds random variation to the delay

### Thinking pauses

```applescript
property thinkingPauseChance : 15
property thinkingPauseTime : 0.80
property thinkingPauseNoise : 0.15
```

After spaces, the script occasionally pauses before continuing. With the default setting, the thinking pause has roughly a **1 in 15** chance of occurring.

The script also adds a brief delay after words eight or more characters long.

### Sounds

```applescript
property enableTypingSounds : false
property playEndChime : true
```

AppleScript's normal `beep` command does not provide the same frequency control used by AutoHotkey, so typing sounds are disabled by default. The completion chime uses generic system beeps.

## How the typo behavior works

The script contains a list of nearby keyboard keys for common characters. When a typo is triggered, EnterHuman sends one nearby character, waits briefly, presses Backspace, and then continues with the intended text.

Keyboard layout differences may affect how closely these mappings correspond to physical neighboring keys.

## macOS-specific limitations

- AppleScript does not provide global hotkeys by itself.
- `System Events` sends input to the currently active application, so the correct field must have focus.
- The script requires Accessibility permission.
- Some secure fields and applications intentionally block synthetic keystrokes.
- `keystroke` behavior can vary with keyboard layout and the active application.
- macOS system beeps cannot reproduce the frequency-based typing sounds used in the AutoHotkey version.
- Automation should only be used where simulated input is permitted.

## Responsible use

This program should not be used to conceal prohibited automation, evade anti-bot or rate-limit controls, misrepresent automated activity as human activity, or violate platform, workplace, academic, or organizational rules.

See the [main README](../README.md#responsible-use-and-misuse) for the full project misuse statement.
