---
name: cv-setup
description: Use when a user has just cloned or installed cv-kit and needs to create their profile, or when they type /cv-setup, or when another cv-kit skill reports that no profile was found. Also use for /cv-setup --voice to redo only the writing-voice file.
---

# cv-setup — One-time onboarding

## Overview

Creates the profile that every other cv-kit skill reads. Without it, `/jd` and `/proposal`
have no identity, no master CV, and no voice, and they stop rather than guess.

This skill writes four things:

- `profile/profile.yml` — name, contact details, links, paths
- `profile/voice.md` — the writing voice, derived from the user's own writing
- `profile/appendix.md` — company and project context, seeded empty
- a copy of the master CV, or a path pointing at where it already lives

## When to Use

- The user types `/cv-setup`, or `/cv-setup --voice` to redo only the voice file.
- The user just cloned cv-kit and asks how to start.
- Another cv-kit skill reported "no profile found".

## The Hard Rule

**Write only what the user tells you.** This skill collects facts. It does not improve them,
round them up, or fill a blank with something plausible. A missing field stays missing, and
the skill says so.

The one place inference is allowed is the voice derivation in Step 5, and even there the
output goes back to the user for confirmation before it is written.

---

## STEP 0 — Check prerequisites

Run both:

```bash
pandoc --version | head -1
weasyprint --version
```

If either is missing, print the install command for the user's platform and stop. Do not
continue and leave them to discover the failure at the first PDF conversion.

| Platform | Command |
|---|---|
| macOS | `brew install pandoc weasyprint poppler` |
| Debian / Ubuntu | `sudo apt install pandoc weasyprint poppler-utils` |
| Fedora | `sudo dnf install pandoc weasyprint poppler-utils` |
| Windows | Install WSL, then follow the Debian row |

Also run `bin/cv-pagecount` against any PDF on the machine to confirm a page counter exists.
If it fails, install poppler or `pip install pypdf` before continuing. The `/jd` skill cannot
verify a CV's page count without one.

If `--voice` was passed, skip to Step 5.

## STEP 1 — Decide where the profile goes

Default to `./profile/` in the current working directory. That is what `bin/cv-profile`
resolves to for anyone working inside a cv-kit clone.

Ask before writing anywhere else. Two cases come up:

- The user installed cv-kit as a plugin and works in many directories. Offer
  `~/.config/cv-kit/profile/`, which resolves from anywhere.
- The user already has a working folder full of applications and wants the profile to live
  there. Write `profile/` inside that folder, and tell them to run cv-kit skills from it.

If a profile already exists at the target, show what is in it and ask before overwriting.
Never overwrite a `voice.md` silently. That file is expensive to reproduce.

## STEP 2 — Interview for identity

Ask for these, one prompt at a time or as a short batch, whichever the user prefers:

| Field | Required | Notes |
|---|---|---|
| Name | yes | Exactly as it should appear at the top of a CV |
| Email | yes | The address on applications, not a work address they are leaving |
| Location | yes | City and country. This appears on the CV contact line. |
| Phone | no | Omit the key entirely if they decline |
| GitHub | no | As visible text, e.g. `github.com/janedoe` |
| LinkedIn | no | As visible text |
| Portfolio or other links | no | Any number, written in the order given |
| Work authorization | no | Free text, used only when a posting raises the topic |
| Sign-off | no | Defaults to "Best regards," |

Write `profile/profile.yml` using `templates/profile.example.yml` as the shape. Keep its
comments. They are the field reference a user reads six months later.

Do not invent a location because the user has a country-code phone number. Ask.

## STEP 3 — Locate the master CV

Ask for a path. PDF, Markdown, and DOCX all work.

Confirm the file exists and is readable before writing the path into `profile.yml`. Read the
first page and tell the user what you found, so a wrong file surfaces now rather than during
their first application.

If the user has no master CV at all, say so plainly and offer `/master-cv`, which interviews
them and builds one. Then stop. Do not write a `profile.yml` that points at a file which does
not exist.

Two paths are acceptable in `profile.yml`:

- A path inside the profile directory, if the user copied the file there.
- An absolute path to wherever it already lives.

Ask which they prefer. Copying keeps everything in one place. Pointing keeps one source of
truth when they update the CV elsewhere.

## STEP 4 — Seed the appendix

Copy `templates/appendix.example.md` to `profile/appendix.md`, keeping the headings, the rule
statement, and the table headers. Remove the example rows.

Tell the user what this file is for in one sentence: it stops a CV from describing a company
based on a guess at what its name implies.

## STEP 5 — Derive the writing voice

This is the step that makes output sound like the user instead of like a template.

Ask the user to point at two or three things they have written. Good sources:

- A blog post or a piece of long-form writing
- An old cover letter, even a bad one
- A long Slack or email message where they explained something
- A README or a design document they wrote

Read every file they name, in full. Then extract, and write down what you actually observed:

- Sentence length and rhythm. Do they vary it? Do they use fragments?
- What their first sentence does. Answer first, or a warm-up?
- How they handle a weakness. Named early, worked around, or absent?
- Punctuation habits. Em dashes, parentheses, colons, serial comma.
- Words they reach for, and words that never appear.
- Repeated structural moves. A caveat pattern, a named trade-off, a grounding specific.

Draft `voice.md` using `templates/voice.example.md` as the section structure. Fill every
section from what you observed. Quote real sentences from their samples in the Structural
Patterns section. A pattern with a quoted example is reproducible; a pattern described in the
abstract is not.

**Present the draft in the chat and wait for confirmation before writing the file.** Say which
samples you read and which traits you took from them. If you inferred something on thin
evidence, say which line it came from, so the user can correct it.

### If the user has no samples

Copy `templates/voice.neutral.md` to `profile/voice.md`. Say plainly that this is the neutral
default, that it carries no persona, and that `/cv-setup --voice` will upgrade it whenever they
have something written to point at.

Do not fake a personal voice from an interview alone. A voice guessed from three answers to
three questions produces cover letters that sound like a stranger imitating the user, which is
worse than a clean neutral register.

## STEP 6 — Report

Print:

- Every file written, with its full path.
- The resolved profile directory, and which of the three resolution rules found it.
- Anything the user declined to provide, listed explicitly.
- What to run next: `/jd` with a job posting, or `/proposal` with a client brief.

Then run `bin/cv-profile --check` and show its output. That proves the profile resolves the
same way a skill will resolve it, rather than assuming it does.
