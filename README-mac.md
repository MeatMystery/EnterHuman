# EnterHuman for macOS

This is an AppleScript conversion of the original AutoHotkey EnterHuman script. It simulates human-like typing by sending keystrokes through macOS **System Events**.

Use it only for permitted UI testing, demos, accessibility workflows, or personal automation. Do not use it to bypass site/game limits, CAPTCHAs, academic rules, or terms of service.

## Files

- `EnterHuman.applescript` - AppleScript source file to open in Apple's built-in Script Editor.

## Run it in Script Editor

1. Open **Script Editor**. It is built into macOS and is usually in `Applications > Utilities > Script Editor`.
2. Open `EnterHuman.applescript`.
3. Click the hammer/compile button. If Script Editor flags a line, check that the file was saved as plain text with UTF-8 encoding.
4. Copy the text you want typed, or edit the `builtInText` property near the top of the script.
5. Click Run.
6. Choose **Type Clipboard** or **Type Built-in Text**.
7. You have about 1.5 seconds to click into the text field where the script should type.

## Give Accessibility permission

macOS blocks scripts from controlling the keyboard until you grant permission.

1. Open **System Settings**.
2. Go to **Privacy & Security > Accessibility**.
3. Enable permission for **Script Editor**.
4. If you save this as an app, also enable permission for that app.
5. If you run it through Automator or Shortcuts, enable permission for **Automator** or **Shortcuts** too.

## Save it as a double-click app

1. Open the script in **Script Editor**.
2. Choose **File > Export**.
3. Set **File Format** to **Application**.
4. Name it something like `EnterHuman.app`.
5. Save it.
6. The first time it runs, macOS may ask for Accessibility permission.

## Use it with a keyboard shortcut using Automator

1. Open **Automator**.
2. Create a new **Quick Action**.
3. Set “Workflow receives” to **no input** in **any application**.
4. Add the action **Run AppleScript**.
5. Paste the contents of `EnterHuman.applescript` into the action.
6. Save it as `EnterHuman`.
7. Open **System Settings > Keyboard > Keyboard Shortcuts > Services**.
8. Find `EnterHuman` and assign a shortcut.

Note: macOS keyboard shortcuts can conflict with app shortcuts. Try something uncommon, such as Control-Option-Command-V.

## Settings to edit

At the top of `EnterHuman.applescript`, you can change:

- `builtInText` - the built-in message.
- `baseWPM` - approximate typing speed.
- `typoChance` - lower means more typos; `30` means about 1 typo attempt per 30 eligible characters. Set to `0` to disable.
- `enableTypingSounds` - AppleScript only supports generic beeps, not custom-frequency key sounds, so this is off by default.
- `playEndChime` - generic beeps when typing finishes.

## Limitations vs. AutoHotkey

- AppleScript does not support global hotkeys by itself. Use Automator Quick Actions, Shortcuts, or a third-party launcher if you need hotkeys.
- AppleScript’s `keystroke` command depends on the active app and keyboard layout.
- macOS beeps cannot match the AutoHotkey frequency-based sound effects.
- Some secure fields and apps intentionally block synthetic keystrokes.
