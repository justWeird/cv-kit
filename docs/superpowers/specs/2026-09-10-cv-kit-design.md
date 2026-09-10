# cv-kit — Design Spec

Date: 2026-09-10
Status: approved, ready to build

## 1. Problem

A working job-application workflow exists in `~/Downloads/DEV/jd/`. It produces a tailored CV,
a cover letter, and interview-prep notes from one job posting. It works well. It is also
unusable by anyone else, for four reasons.

1. The directive names one person. "Joseph", his email, his GitHub, and his LinkedIn sit
   inside the skill text, not in a data file.
2. The directive hardcodes one absolute path: `~/Downloads/DEV/jd/`.
3. The tooling and the personal data share a directory. That directory holds a Master CV, a
   context appendix, a personal voice guide, and 40+ real job applications.
4. Two more utilities exist only as outputs, not as tools. A proposal stylesheet and two
   finished proposals exist. No proposal directive does.

`cv-kit` is a separate public repository that solves all four. It carries the tooling. It
carries no personal data.

## 2. Goal

A person clones the repository, runs one setup command, and gets three working utilities: a
tailored CV, a cover letter, and a client proposal. The person supplies their own identity,
their own master CV, and their own writing voice.

### Non-goals

- Migrating the 40+ existing company folders in `DEV/jd/`. They stay where they are.
- A web interface, a hosted service, or any runtime beyond Claude Code plus pandoc.
- Replacing the user's judgment. Every document stops for human approval before it becomes a
  PDF.

## 3. Distribution and profile resolution

The repository ships two ways at once.

**As a workspace.** The user clones it, runs `claude` inside it, and works there. Claude Code
loads `.claude/skills/` as project skills automatically. Output lands in `applications/`.

**As a plugin.** The user runs `/plugin marketplace add <owner>/cv-kit` and installs it. The
skills then work in any directory.

Both paths need the same answer to one question: where is the profile? The skills resolve it
in this order, and stop at the first hit.

1. `$CV_PROFILE`, if the environment variable is set and the directory exists.
2. `./profile/` in the current working directory.
3. `~/.config/cv-kit/profile/`.

If no profile resolves, every skill stops and tells the user to run `/cv-setup`. No skill
guesses at identity.

This rule serves the existing user without moving anything. `DEV/jd/` gains a `profile/`
subdirectory holding the Master CV, the appendix, and the voice file. The 40+ company folders
do not move. Running `/jd` from `DEV/jd/` finds the local profile through rule 2.

## 4. Repository layout

```
cv-kit/
  .claude/skills/
    cv-setup/SKILL.md
    master-cv/SKILL.md
    jd/SKILL.md
    proposal/SKILL.md
  .claude-plugin/
    plugin.json
    marketplace.json
  styles/
    cv.css
    letter.css
    proposal.css
  templates/
    profile.example.yml
    appendix.example.md
    voice.example.md
    voice.neutral.md
    proposal.example.md
  examples/
    worked-example/          # fictional persona, full input and output
  docs/superpowers/specs/
  profile/                   # gitignored, created by /cv-setup
  applications/              # gitignored, output lands here
  README.md
  SETUP.md
  LICENSE                    # MIT
  .gitignore
```

`.gitignore` excludes `profile/` and `applications/` from the first commit. It also excludes
`.DS_Store`, `*.pdf` outside `examples/`, and `CLAUDE.local.md`.

The three stylesheets are copied from `DEV/jd/` unchanged, then renamed. `cv-style.css`
becomes `styles/cv.css`. `letter-style.css` becomes `styles/letter.css`. `proposal-style.css`
becomes `styles/proposal.css`. The CSS content itself does not change.

## 5. The profile

`profile/profile.yml` holds every fact the current skill hardcodes.

```yaml
name: Jane Doe
email: jane@example.com
phone: "+31 6 12345678"        # optional, omit the key to leave it off the CV
location: Amsterdam, Netherlands
links:
  github: github.com/janedoe
  linkedin: linkedin.com/in/janedoe
  portfolio: janedoe.dev        # optional
master_cv: profile/Master_CV.pdf
voice: profile/voice.md
appendix: profile/appendix.md
work_authorization: "EU citizen"   # optional, free text, used in cover letters
sign_off: "Best regards,"          # optional, defaults to "Best regards,"
```

Three companion files sit beside it.

- `profile/voice.md` governs prose voice. `/jd` reads it in full before writing a cover
  letter. Its section structure copies the existing style guide: voice, sentence rhythm,
  structure, tone calibration, vocabulary, hard constraints, structural patterns, and a quick
  reference checklist.
- `profile/appendix.md` grounds every Context line. It holds one row per company and per
  project, with a "what it does" column and a source column. The rule stays: if a name is not
  in this file, ask the user, never infer from the name.
- The master CV lives at whatever path `master_cv` names. PDF and Markdown both work.

Field resolution has one hard rule. A skill that needs a field missing from `profile.yml`
stops and asks. It does not substitute a placeholder and it does not invent a value.

## 6. Skills

### 6.1 /cv-setup

One-time onboarding. It runs in this order.

1. Check prerequisites. Run `pandoc --version` and `weasyprint --version`. If either is
   missing, print the install command for the user's platform and stop.
2. Resolve where the profile should go. Default to `./profile/` in the current directory.
   Ask before writing outside it.
3. Interview for identity: name, email, phone, location, GitHub, LinkedIn, portfolio, and
   work authorization. Write `profile.yml`.
4. Locate the master CV. Ask for a path. Accept PDF, Markdown, or DOCX. If the user has none,
   offer to run `/master-cv` instead and stop.
5. Derive the voice. Ask the user to point at two or three things they have written: a blog
   post, an old cover letter, a long message. Read them. Draft `profile/voice.md` in that
   person's voice. Present the draft and wait for confirmation before writing it.
6. If the user has no writing samples, copy `templates/voice.neutral.md` to
   `profile/voice.md`, say so plainly, and tell them they can rerun `/cv-setup --voice`
   later.
7. Seed `profile/appendix.md` from `templates/appendix.example.md`, with the table headers
   and no rows.
8. Print what it wrote and what to run next.

The voice-derivation step never claims more than it did. It says which samples it read and
which traits it extracted.

### 6.2 /master-cv

For a user with no master CV. It interviews them and writes `profile/master-cv.md`.

The interview walks roles from most recent backwards. For each role it asks for the title,
the company, the dates, what they actually shipped, and any numbers attached to it. It then
asks for education, projects, and skills.

Two rules govern it.

- It writes only what the user said. It does not sharpen a claim into something stronger.
- It flags every bullet with no number, so the user can go find one. It does not add one.

Output uses the same Markdown structure the ATS-safety rules require: `#` for the name, `##`
for section headings, bold for role lines, a blank line before every bullet list.

### 6.3 /jd

The existing directive, ported. The port makes exactly these changes and no others.

| What changes | From | To |
|---|---|---|
| Applicant name | Literal "Joseph" throughout | `profile.name` |
| Contact block | Three hardcoded lines | `profile.email`, `profile.links.*`, `profile.phone` |
| Master CV path | `/Users/.../DEV/jd/Master_CV.pdf` | `profile.master_cv` |
| Voice file | `jfadiji_writing_style.md` | `profile.voice` |
| Appendix path | `/Users/.../DEV/jd/appendix.md` | `profile.appendix` |
| Stylesheet paths | `cv-style.css`, `letter-style.css` | `styles/cv.css`, `styles/letter.css` |
| Output folder | `/Users/.../DEV/jd/<Company>/` | `<applications-dir>/<Company>/` |
| Page-count check | `mdls` only, with a fallback aside | Platform check first, then `mdls` on macOS, `pdfinfo` or `pypdf` elsewhere |

Everything else survives verbatim. That includes the Hard Rule, the Common Mistakes table,
the STE rules for CV prose, the Context lines rule, the ATS-safety rules, the length budget
with its empirical 939-word ceiling, both stop-and-wait-for-approval gates, the visual render
check, the sign-off backslash note, and the Quick Reference table.

Two notes get an added caveat rather than a rewrite.

- The 939-word ceiling was measured against one specific stylesheet on 2026-09-02. The ported
  skill keeps the number and states that it was measured for this stylesheet and this
  structure. A user who edits `styles/cv.css` has to reverify it.
- The `mdls` page check is macOS-only. The ported skill detects the platform and picks a
  checker. It never skips the check.

The output folder resolves like the profile: `$CV_APPLICATIONS`, then `./applications/`, then
the current directory.

### 6.4 /proposal

New. No directive exists to port, so this one is derived from two finished proposals:
`DEV/jd/AlfaCables/AlphaCables_proposal.md` and `DEV/jd/Trove/Trove_proposal.md`.

Input is a client brief: a document, a pasted block, or a conversation. Output is
`<Client>/proposal.md` and `<Client>/proposal.pdf`.

The shared skeleton from both examples, generalised:

1. Title, plus a "Prepared for / Prepared by / Date" block.
2. **Where I am starting from.** Read the brief back. Then spend the honest caveat: name the
   hardest real problem in the project, and say it is not the software.
3. **The approach, and the option rejected.** State the technical choice. Name the
   alternative. Give the reasons it lost, and own the trade-offs the winner carries.
4. **What I understood it to be.** Roles, pipeline, modules. Concrete, in the client's words.
5. **What the brief does not say yet.** A list of contradictions, undefined thresholds, and
   decisions the client still owes. This section justifies a specification phase.
6. **The phases.** Each phase gets a duration range, a price, and a deliverable list.
7. **What the price does not cover.** Explicit exclusions.
8. **What I am leaving out on purpose.** Deferred scope, with the reason.
9. **Revisions, changes, and what "done" means.**
10. **Payment terms.**
11. **What I need from you.**
12. **Acceptance.**

Rules that carry over from `/jd`:

- The Hard Rule applies. No invented capability, no invented past project, no invented
  timeline the user has not agreed to.
- Prose follows `profile.voice`, persona included, the same as the cover letter.
- Stop after `proposal.md` and wait for approval before treating any PDF as final.
- Convert with `pandoc --pdf-engine=weasyprint --css=styles/proposal.css`.
- Verify the render visually: tables have rules, page numbers appear in the footer, no
  heading sits orphaned at a page break.

One thing this skill must ask rather than assume: price and duration. It never proposes a
number the user has not given it.

## 7. Documentation

### README.md

Answers "what is this and should I use it".

- One-paragraph problem statement.
- A 60-second quickstart: clone, install prerequisites, run `/cv-setup`, run `/jd`.
- One worked example with real before-and-after output, from `examples/`.
- The skill list, one line each.
- The honesty rule, stated plainly and early. This is the repository's actual selling point.
- A short section on what this is not: not an AI CV generator, not a fabrication tool.

### SETUP.md

Answers "how do I get it running".

- Prerequisites with install commands per platform: Claude Code, pandoc, weasyprint. macOS
  via Homebrew, Debian and Ubuntu via apt, Windows via WSL.
- Two install paths: clone as a workspace, or add as a plugin.
- Running `/cv-setup`, field by field.
- The full `profile.yml` field reference, with which fields are required.
- Bringing your own master CV, in PDF or Markdown.
- Troubleshooting, drawn from failure modes already recorded in the existing directive:
  the CV renders to 3 pages, `mdls` returns `(null)`, bullets render as literal hyphens,
  the sign-off collapses onto one line, weasyprint fails on a missing font.

## 8. The worked example

README needs one example. It uses a fictional persona, not a redacted real application. A
fictional persona carries no risk of leaking a real employer's job description, and it can be
built to show every feature.

`examples/worked-example/` holds the input job posting, the profile used, and the three
output files. It is the only directory where committed PDFs are allowed.

## 9. Risks

| Risk | Mitigation |
|---|---|
| Personal data reaches the public remote | `.gitignore` excludes `profile/` and `applications/` before the first commit. Verify with `git status --ignored` before pushing. |
| `/proposal` has never been run | Ship it, and say in README that it is newer than the other three. Test it against one real brief before relying on it. |
| Voice derivation produces a bad voice file | `/cv-setup` presents the draft and waits for confirmation. It never writes the voice file silently. |
| The 939-word ceiling misleads a user who edited the CSS | State the measurement conditions next to the number, and say who has to reverify it. |
| The port drops a hard-won rule from the existing skill | Section 6.3 lists exactly what changes. Everything absent from that table survives verbatim. Diff the ported skill against the original before committing. |

## 10. Build order

1. Repository skeleton, `.gitignore`, LICENSE.
2. Copy and rename the three stylesheets.
3. Templates: `profile.example.yml`, `appendix.example.md`, `voice.example.md`,
   `voice.neutral.md`.
4. `/cv-setup`.
5. `/jd`, ported. Diff against the original.
6. `/master-cv`.
7. `/proposal`.
8. Plugin manifests.
9. The worked example.
10. README.md and SETUP.md.
11. `git init`, first commit, then push once the user approves.

Steps 9 and 10 come last on purpose. Both document what the other steps actually built, not
what this spec predicted they would build.
