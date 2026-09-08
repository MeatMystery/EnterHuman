# EnterHuman 1.1

EnterHuman is a small cross-platform keyboard automation project that sends text as individual keystrokes with randomized timing, pauses, occasional nearby-key typos, and backspace corrections. The result approximates the irregular rhythm of normal typing instead of inserting an entire block of text at once.

The project includes separate implementations for Windows and macOS:

- **Windows:** AutoHotkey v2
- **macOS:** AppleScript using System Events

## Repository layout

```text
EnterHuman/
├── README.md
├── Mac/
│   ├── EnterHuman.applescript
│   └── README.md
└── Windows/
    ├── enterhuman1.1.ahk
    └── README.md
```

For installation and usage instructions, see the README for your platform:

- [Windows instructions](Windows/README.md)
- [macOS instructions](Mac/README.md)

## Features

Both versions are built around the same general behavior:

- configurable base typing speed
- small randomized timing differences between keystrokes
- longer pauses around punctuation and paragraph breaks
- occasional pauses between words
- added hesitation after longer words
- optional nearby-key typing mistakes followed by backspace correction
- clipboard-based text entry
- customizable built-in text
- optional typing or completion sounds where supported

The implementations are not identical because AutoHotkey and AppleScript expose different automation and sound capabilities.

## Purpose

EnterHuman began as a keyboard-automation experiment and a way to practice building more natural-looking simulated input. It can be useful for legitimate purposes such as:

- UI and text-field testing
- testing software behavior with delayed or imperfect keyboard input
- demonstrations and tutorials
- personal automation where simulated keystrokes are permitted
- accessibility-related workflows where appropriate and authorized
- learning AutoHotkey, AppleScript, and desktop automation concepts

Early personal experiments included entering text in situations where normal paste behavior was inconvenient or restricted and testing a friend's bot in a rate-limited Discord channel. Those origins are included only as project history and should not be interpreted as authorization or encouragement to bypass restrictions or safeguards.

## Responsible use and misuse

EnterHuman can make automated keyboard input resemble ordinary manual typing. That capability is intended for testing and permitted automation, **not** for misleading people or systems about whether a human is performing an action.

Do **not** use EnterHuman to:

- bypass CAPTCHAs, anti-bot systems, rate limits, paste restrictions, or similar safeguards when doing so is prohibited
- evade moderation systems, spam controls, platform limits, account restrictions, or abuse-prevention measures
- disguise automated activity as manual human activity when that distinction affects access, trust, eligibility, evaluation, or enforcement
- gain privileges, rewards, rankings, participation credit, access, or other advantages that would not be available if the automation were disclosed
- impersonate another person or falsely represent who entered, submitted, or authored content
- automate exams, assignments, attendance, academic submissions, or other work in violation of academic-integrity requirements
- deceptively submit forms, votes, reviews, registrations, applications, messages, or other content
- automate interactions at unauthorized scale or in violation of a service's terms or acceptable-use policies
- facilitate harassment, spam, fraud, unauthorized access, abuse, or other harmful activity

Sending text one character at a time instead of pasting it does **not** make an otherwise prohibited action acceptable. Likewise, making automation appear more human does not make the automated action itself human.

Users are responsible for determining whether automation is allowed in the environment where they use EnterHuman. If a website, application, instructor, employer, organization, or system administrator requires manual input or prohibits automation, those requirements should be followed.

## AI assistance note

AI tools were used as **development aids** during parts of this project, including brainstorming, troubleshooting, code review, documentation cleanup, and assistance adapting the original Windows concept to macOS.

The project was not produced by AI without human involvement. Its purpose, behavior, testing, revisions, configuration choices, organization, and final implementation decisions were directed and reviewed by the project author. AI-generated or AI-assisted suggestions were treated as drafts to be evaluated, modified, tested, or rejected rather than automatically accepted.

As with any AI-assisted code, mistakes or unexpected behavior may remain. Review and test the scripts before relying on them, especially after making modifications.

## Disclaimer

This software is provided for educational, testing, accessibility, and otherwise permitted automation purposes. The author does not authorize or encourage misuse of the project and is not responsible for actions taken by users with it.

You are responsible for complying with applicable laws, organizational policies, academic rules, platform terms, and the permissions of any system you interact with. Use EnterHuman only where you are authorized to automate keyboard input.
