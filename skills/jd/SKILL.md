---
name: jd
description: Use when the user shares a job posting (pasted text, an attachment, a file path, or a URL) and wants a tailored CV, cover letter, and interview prep built from it, or when they invoke "jd" or type /jd.
---

# JD — Job Application Directive

## Overview

Turns one job posting into a tailored CV, a cover letter, and interview-prep notes, grounded
strictly in the user's master CV. The core principle: **never invent, exaggerate, or imply
anything the applicant has not actually done.** Everything else in this skill is secondary to
that rule.

Identity, paths, and voice come from the profile. Nothing about a particular person is
hardcoded here.

## When to Use

- The user pastes, attaches, or links a job posting and asks for a CV, cover letter, or
  application materials.
- The user types `/jd`, `jd <company>`, or `jd <path-to-jd-file>`.
- The user asks to redo, refresh, or fix an existing company folder's application materials.

If the job description is missing or ambiguous, ask for it before doing anything else. Do not
proceed on a guess.

## STEP 0 — Resolve the profile

Run this before anything else:

```bash
bin/cv-profile --check
```

It prints the profile directory, or it fails with an actionable message. Resolution order is
`$CV_PROFILE`, then `./profile/`, then `~/.config/cv-kit/profile/`.

If it fails, stop and tell the user to run `/cv-setup`. Do not continue with a placeholder
name, a guessed email, or an assumed master CV path.

Read `profile.yml` in full. Every `profile.*` reference below means a field from that file. A
required field that is missing stops the skill; ask the user for it rather than substituting a
value.

Resolve the output directory the same way: `$CV_APPLICATIONS`, then `profile.applications_dir`,
then `./applications/`, then the current directory.

## Inputs

| Input | Where to find it |
|---|---|
| Master CV | The path in `profile.master_cv`. **Read it in full before anything else.** Every fact in the output traces back to this file, not to another company's folder, not to memory. |
| Job description | Attached, pasted, a file passed as an argument, or a URL to fetch. |
| Writing style | The path in `profile.voice`. Read it in full before writing any prose. It governs the cover letter's full narrative voice, persona included (Step 4). The CV (Step 3) uses only its Hard Constraints (no em dashes, no filler phrases, active voice, precise word choice), layered under the CV's own Simplified Technical English rules; it does not use the persona. |
| Company/project context | The path in `profile.appendix`. Read it before writing any Context line (Step 3). If a company or project is missing, **ask the user what it does. Never assume or infer it from the name.** Add the answer to the appendix once you have it, so the next application does not need to ask again. |

## Common Mistakes

These happened in real use, not hypothetically. Watch for them specifically:

| Mistake | What it looks like | Fix |
|---|---|---|
| Skipping the master CV | Copying bullets from an existing company folder as a template instead of reading `profile.master_cv` fresh | Read the master CV in full before touching any existing folder. Other folders may have drifted or contain stale data. |
| Guessing the word budget | Inferring a word count from a comment in `styles/cv.css` ("~600 words") instead of the actual target below | Use the Length Budget section below. It is the authority, not a stylesheet comment. |
| Skipping Notes.md | Producing only CV.md and Cover-Letter.md | Steps 1, 2, and 5 always go in `<Company>/Notes.md`, and get printed in the chat response too. |
| Skipping PDF conversion and the visual check | Treating the `.md` files as the finished deliverable | Both files must be converted to PDF and visually confirmed before being called done. See Convert to PDF under Steps 3 and 4. |
| Converting to PDF before approval | Running pandoc the moment CV.md or Cover-Letter.md is written, without asking | Stop after each `.md` file and wait for explicit approval before treating a PDF as final. Converting once, quietly, to run the visual-render check is fine; converting again after that as if it were done is not. See Stop and wait for approval under Steps 3 and 4. |
| Clunky, clause-stacked CV bullets | A bullet chains two or three actions with semicolons and "and" (e.g. "Diagnosed X...; cut Y and added Z...") because the master CV's own bullet does that | Split into separate bullets or cut the weaker action. See the STE rules under Step 3; the CV is not written in the cover letter's narrative voice. |
| No context for what a role or project is | A reader cannot tell what a company or project actually does, only what was done there, because the bullets jump straight to actions | Add a context line (Experience) or header parenthetical (Projects) whenever the name alone does not convey what it is. See Context lines under Step 3. |
| Sign-off collapses onto one line | "Best regards,\" gets its own line in the rendered PDF, but the name, email, and link lines below it run together into one paragraph | Every line of the sign-off needs its own trailing backslash, not just the closing line. See the formatting note under Step 4's Convert to PDF. |
| ATS checker flags "name not detected" or curly quotes | The PDF text layer is fine, but its `/Title` metadata reads "CV" and pandoc has converted straight quotes to curly ones (found by an online checker, 2026-09-14) | Always pass `-f markdown-smart` and `--metadata title="<Full Name>"` to pandoc. See Convert to PDF under Steps 3 and 4. |
| Skipping the page-count check because `mdls` returned `(null)` | Assuming 2 pages without verifying | Use `bin/cv-pagecount`. It tries pdfinfo, mdls, pypdf, and a raw object count in that order, and fails loudly rather than returning nothing. |

## Output

Create a folder named after the company (e.g. `Stripe/`) inside the resolved applications
directory. Write:

- `Stripe/CV.md` — the tailored CV
- `Stripe/CV.pdf` — the converted, submission-ready PDF (see Convert to PDF under Step 3)
- `Stripe/Cover-Letter.md` — the cover letter
- `Stripe/Cover-Letter.pdf` — the converted PDF (see Convert to PDF under Step 4)
- `Stripe/Notes.md` — Steps 1, 2, and 5 (decode, fit-gap, interview prep)

Also print Steps 1 to 5 in the chat response, each section clearly labelled.

If the company folder already exists, ask before overwriting.

## The Hard Rule

**Never invent, exaggerate, or imply anything the applicant has not actually done.**

This overrides every other instruction here, including keyword coverage and bullet formatting.
Concretely:

- No invented metrics. If a bullet has no number in the master CV, do not add one.
- No inflated scope: "led" only if they led, "owned" only if they owned.
- No tools, certifications, or years of experience that are not already in the master CV.
- If a bullet lacks a quantifiable result, sharpen the verb and clarify the outcome, but leave
  the facts untouched.
- If a required keyword genuinely does not apply, leave it out and log it as a gap in Step 2. A
  missing keyword is a gap to address in interview, not a licence to fabricate.
- This also covers the companies and projects around the applicant, not just the applicant's own
  actions. A Context line (Step 3) describing what a company or project does must come from the
  master CV, the appendix, or the user directly, never from a guess at what the name implies.

## STEP 1 — Decode the job

Read the job description as a recruiter would: what is this role actually being hired to fix?

Output a table: the top 5 skills the role demands, why each matters to this employer, and the
exact ATS keywords (verbatim from the JD) that must appear in the CV.

## STEP 2 — Fit-gap analysis

A four-column table:

| Role requires | What I have (from master CV) | Overlap | Gap to address |

Be honest in the gap column. An accurate gap list is more useful than a flattering one.

## STEP 3 — Tailor the CV

Rewrite the master CV for this role:

- Sharpen the summary, experience, and skills sections against Step 1.
- Weave in the ATS keywords naturally, in context, never as a keyword dump.
- Rewrite every bullet as **action → result**: what the applicant did, with what measurable
  outcome. Keep bullets specific and concrete.
- Reorder and trim to foreground what this employer cares about. Cutting irrelevant material is
  allowed; inventing relevant material is not.

**CV prose (Summary and bullets) follows Simplified Technical English form, not the cover
letter's narrative voice.** This is a stricter, plainer register than Step 4's cover letter, and
it is deliberate: dense, clause-stacked bullets read as clunky, and STE's whole point is that
they should not. These rules apply to the Summary line and every Experience/Projects bullet:

- One idea per bullet or sentence. If a master-CV bullet chains two distinct actions with a
  semicolon (e.g. "Diagnosed X; cut Y and added Z"), split it into two bullets, or cut the
  weaker action. Never keep the semicolon splice.
- Maximum 30 words per bullet where the content allows it. A bullet that only clears 30 words by
  stacking clauses needs to be split or cut, not left as one long sentence.
- Active voice, verb-first, applicant as the implied actor ("Built...", "Diagnosed...",
  "Closed..."). Never use a passive construction to describe the applicant's own work ("was
  diagnosed", "was designed").
- No noun stack longer than three words (e.g. "the production data-loss incident", not "the
  production-staging S3 bucket misconfiguration incident").
- Past tense throughout, except a genuinely still-ongoing bullet at the current role, which may
  use present tense, applied consistently.
- Precise, plain word choice over impressive-sounding filler: "I pick up new stacks fast", not
  "results-driven engineer". No em dashes.
- If splitting a crammed bullet pushes a role over its bullet ceiling (see Length budget below),
  cut a whole achievement. Do not re-merge two actions back into one bullet to make room.

This STE rule governs the CV only. The cover letter in Step 4 keeps the full narrative voice and
persona from `profile.voice`; do not apply these sentence limits there, and do not apply the
cover letter's persona here.

**Context lines**: add one short grounding sentence before the bullet list whenever a role's
company, or a project's name, does not obviously convey what the thing is or does. A recruiter
scanning top-to-bottom, left-margin first, hits this line right where the eye already lands (see
the F-pattern research cited in Length budget below), and it answers "what is this, how big is
it, why should I care" before the bullets, which otherwise read as actions with no subject.

- Pull the description from the appendix at `profile.appendix`. If the company or project is not
  listed there, ask the user what it does before writing a Context line for it. Do not infer it
  from the name. Once you have the answer, add it to the appendix so the next application does
  not need to ask again.
- **Experience**: one plain-text sentence on its own line, right after the bold role/company/dates
  line, with a blank line before the bullets that follow (see the blank-line rule under
  ATS-safety rules). Example: "Example Corp builds warehouse routing software for mid-size
  logistics firms in the Benelux."
- **Projects**: fold it into the project's own header line as a short parenthetical instead, since
  a project header does not already carry a competing company/location/dates line. Example:
  "Example App (cross-platform transit-tracking app)".
- Skip it when the name is already self-evident: a well-known university, a well-known freelance
  platform, or a project whose own first bullet already states what it is.
- Same STE discipline as every bullet: one or two sentences, one idea each, at most 30 words per
  sentence, active voice, no em dashes.
- Context lines count toward the word budget below. A CV covering more roles pays this cost more
  than once, so budget for it up front instead of discovering the overrun at the page-count check.

**ATS-safety rules** (CV.md will be converted to PDF and machine-parsed):

- No Markdown tables anywhere in CV.md. Bullets and plain lines only. Table cells scramble in
  older ATS parsers.
- Standard section headings only: `Summary`, `Experience`, `Education`, `Skills` (plus
  `Projects` or `Certifications` if needed). No creative heading names.
- Write real Markdown, not plain text that merely looks like a CV. `styles/cv.css` styles actual
  HTML elements, so the source must produce them:
  - The name is a level-1 header: `# <profile.name>`.
  - Every section heading is a level-2 header: `## Summary`, `## Experience`, and so on.
  - Every role or degree line is bold: `**Full Stack Software Engineer** · Company · Dates`.
  - A blank line always sits before a bullet list. Pandoc's default Markdown will not start a
    new list right after a paragraph with no blank line between them; it folds the `-` lines
    into that paragraph as literal hyphens instead of rendering a list.
  - Copy the exact pattern from an existing company folder's CV.md (any one) for formatting
    conventions, but pull the actual content from the master CV, not from that folder. If no
    company folder exists yet, use `examples/worked-example/CV.md`.
- Contact info as plain text at the top of the body, never implied to belong in a header or
  footer. Build the contact block from the profile, in this order, skipping any field the
  profile does not carry:
  - `profile.email`
  - `profile.phone`
  - `profile.location`
  - every entry under `profile.links`, in the order they appear in the file
  - Write the URLs as visible text (ATS parsers read the text layer, and a printed or parsed CV
    keeps the address either way). Linking them is fine as long as the visible text is the URL
    itself, e.g. `[github.com/janedoe](https://github.com/janedoe)`.
- Single column, linear order, no images or icons. Dates in a consistent format (e.g.
  `Jan 2024 – Present`) on the same line as the role.

**Length budget** (CV.md must convert to a PDF of at most 2 pages; Markdown converters add
generous heading and list spacing, so budget tighter than the master PDF):

- Target **650 to 750 words** for the whole file. This is a working target, not a hard cap: it
  leaves real margin below where this template actually breaks, so verify with `wc -w` as a
  pre-check, but treat the page-count render in Convert to PDF below as the actual authority,
  not the word count alone.
- Empirical ceiling for the stylesheet shipped as `styles/cv.css`, measured on 2026-09-02
  against a CV with 5 experience roles and 5 projects, built up incrementally from real content
  and rendered at each step: 2 pages held up to 939 words, and broke to 3 pages at 947 words. A
  leaner CV (fewer roles or projects) has more headroom than that; a denser one has less.
  **That number belongs to that stylesheet and that structure.** Reverify it with the same
  build-up-and-render method whenever `styles/cv.css` changes or a CV's section count changes
  materially, since the number moves with structure, not just word count. The 939-word figure
  also predates the Context lines rule above; a CV that adds a context line to most roles and
  projects will likely hit 3 pages below 939 words. Treat it as a rough upper bound, not a
  precise one, until it is reverified with context lines included.
- Do not spend the budget evenly across sections. Eye-tracking research on recruiter screening
  (TheLadders, ResumeGo) shows an initial scan of well under 15 seconds that follows an
  F-pattern: the top third of page one, then the left margin for job titles, companies, and
  dates. Put the strongest, most JD-relevant material there: the summary's opening sentence, and
  the current role's first one or two bullets. A CV packed close to the 940-word ceiling does not
  scan faster than a leaner one, it just fits more onto the page.
- At most 4 bullets for the current role, 3 for every other role, 1 for older or less relevant
  roles. These are ceilings, not quotas: use only as much of each as the JD's relevance and the
  word target justify. Every professional role in the master CV gets at least the 1-bullet
  floor; do not drop a role to zero bullets by default. If space genuinely forces dropping a
  role entirely, state that decision explicitly in the chat response (which role, and why)
  instead of cutting it silently.
- At most 3 projects, chosen for relevance to this JD, max 2 bullets each. Cutting a project
  entirely beats shortening all of them.
- One line per education entry plus one for specializations. Drop the Achievements section
  unless an item is directly relevant to the JD.

### Stop and wait for approval

Once CV.md is within the target range, stop. Present CV.md in the chat response and wait for
explicit approval before converting to PDF. The user edits the prose themselves before it
becomes a submission-ready artifact; converting early produces a PDF that goes stale the moment
they edit the markdown, which forces a rerun. This overrides the auto-convert instinct the rest
of this step implies.

The one exception: converting to PDF for the visual-render check below (page count, whether
Markdown actually produced real headers and lists) is fine to run without asking, since that is
verification of the file you already wrote, not a submission artifact. Say so explicitly when
you do it, and do not treat that PDF as final until the user approves the markdown.

### Convert to PDF

Once CV.md is approved, convert it. Run pandoc from the cv-kit root so the relative CSS path
resolves, or pass an absolute path to the stylesheet:

```bash
pandoc <Company>/CV.md -f markdown-smart -o <Company>/CV.pdf \
  --pdf-engine=weasyprint --css=styles/cv.css --metadata title="<Full Name>"
```

Two flags matter for ATS parsing. `-f markdown-smart` turns off pandoc's smart-quote
extension, which otherwise converts every straight quote in the markdown into a curly one in the
PDF text layer; some keyword matchers treat `master's` and `master’s` as different strings.
`--metadata title="<Full Name>"` sets the PDF's `/Title` field to the candidate's name (the exact name from `Master_CV.pdf`); some parsers read
that field first as the candidate name, and a title of "CV" fails their name check. The CSS
hides pandoc's injected title block, so the name still renders once on the page.

Then verify the page count and fail loudly if it exceeds 2:

```bash
bin/cv-pagecount <Company>/CV.pdf
```

That script tries pdfinfo, then `mdls`, then pypdf, then a raw object count, and exits non-zero
with install instructions if none is available. Never skip the check because one counter is
missing.

If it comes out at 3 pages, cut content first (drop a project, trim bullets); only touch
`styles/cv.css` sizing as a last resort, and never below 10pt body text.

Page count is not the only check. Read the rendered `CV.pdf` directly (the Read tool renders
PDFs) and visually confirm: the name renders as a real heading, not an inline run of contact
text; section titles are visually distinct (uppercase, underlined, per `styles/cv.css`); every
bullet renders as an actual bulleted list item, not a paragraph with a literal `-` or `•`
character sitting in the wrong place; and no section got orphaned onto a near-empty trailing
page. A file can pass the word-count and page-count checks while still being broken this way,
since both checks are blind to whether the Markdown actually produced headers and lists.
`CV.pdf` ships alongside `CV.md` in the company folder only after this visual check passes.

## STEP 4 — Cover letter

Using the Step 3 CV and the job description:

- **Para 1** — open with a problem this company likely faces, and how the applicant solves
  problems like that today.
- **Para 2** — matching skills and experience, drawn from the strongest overlaps in Step 2.
  This is where the honest-caveat pattern belongs: name the biggest gap from Step 2 directly,
  then show why it does not disqualify.
- **Para 3** — a specific reason to want this role at this company. Reference something real
  about them (something they said, shipped, or do differently). End grounded, not on
  aspirational rhetoric.

**Always under 500 words.** Write it in the full voice defined by `profile.voice`, persona
included: treat the reader as an equal, name practical realities without apology, anchor claims
in concrete specifics. No bullet points in the letter (narrative writing rule). This is the one
place in this skill's output that writes as the user; the CV in Step 3 does not.

If the posting raises work authorization, visas, or sponsorship, use
`profile.work_authorization` verbatim. Do not paraphrase a permit's name, and do not raise the
topic when the posting does not.

Before finalising, run the letter through the voice file's Quick Reference Checklist. In
particular:

- No em dashes anywhere (parentheses, commas, or colons instead)
- No banned phrases from the voice file's "Never use" list
- At least one concrete specific (name, number, project, event)
- Varied sentence rhythm, first person, active voice throughout

### Stop and wait for approval

Same rule as the CV: present Cover-Letter.md in the chat response and wait for explicit
approval before converting to PDF, for the same reason (the user edits the prose themselves
first). Converting for the visual-render check only, without treating that PDF as final, is fine
without asking; say so explicitly when you do it.

### Convert to PDF

Once Cover-Letter.md is approved and passes the checklist, convert it:

```bash
pandoc <Company>/Cover-Letter.md -f markdown-smart -o <Company>/Cover-Letter.pdf \
  --pdf-engine=weasyprint --css=styles/letter.css --metadata title="<Full Name>"
```

Verify it is exactly 1 page:

```bash
bin/cv-pagecount <Company>/Cover-Letter.pdf
```

A sub-500-word letter that spills to 2 pages means the words need cutting, not the font.

Read the rendered `Cover-Letter.pdf` directly and visually confirm the paragraphs render as
normal flowing text and the sign-off lands on its own line. `Cover-Letter.pdf` ships alongside
`Cover-Letter.md` in the company folder only after this check passes.

Formatting note: Markdown folds single newlines into spaces, so the sign-off needs a hard line
break after *every* line, not just after the closing phrase. A backslash only on the first line
still lets the name, email, and link lines below it collapse into one run of text. End every
line of the sign-off block with a backslash, except the last, which needs none because nothing
follows it. Build the block from the profile:

```
<profile.sign_off>\
<profile.name>\
<profile.email>\
<first link>\
<last link>
```

## STEP 5 — Final check

A short bullet list: every item from the Step 2 gap column the applicant should be ready to
address in an interview, with a one-line angle for each.

## Close-out

End the chat response with the word count of the cover letter and the path to the folder you
created.

## Quick Reference

| Item | Target |
|---|---|
| CV word count | 650 to 750 words (empirical ceiling ~939 words for the shipped `styles/cv.css`, before it breaks to 3 pages) |
| CV page count | At most 2, verified with `bin/cv-pagecount`, not assumed |
| Cover letter word count | Under 500 words |
| Cover letter page count | Exactly 1, verified with `bin/cv-pagecount` |
| CV bullets per role | 4 current / 3 other / 1 older, floor of 1 per role |
| Projects | At most 3, at most 2 bullets each |
| Source of truth for content | `profile.master_cv`, always, never another company's folder |
| Source of truth for identity | `profile.yml`, never a name or address remembered from an earlier run |
| Source of truth for voice | `profile.voice`, in full, before writing prose |
| CV prose register (Summary, bullets) | STE: one idea per bullet, at most 30 words, active voice, no persona |
| CV context lines | One grounding line per role or project whose name is not self-evident; parenthetical for Projects, separate sentence for Experience |
| Cover letter prose register | Full narrative voice and persona from `profile.voice` |
