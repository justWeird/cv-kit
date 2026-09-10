# cv-kit

Turn one job posting into a tailored CV, a cover letter, and interview-prep notes. Turn one
client brief into a costed proposal. Everything is grounded in a master CV you supply.

**It will not invent anything about you.** If a posting asks for Kubernetes and your master CV
has no Kubernetes, the output has no Kubernetes. It goes in the gap list instead, with a note on
how to answer the question in the interview. That rule overrides keyword coverage, formatting,
and every other instruction in the toolkit.

Built as skills for [Claude Code](https://claude.com/claude-code). Output is Markdown, converted
to PDF with pandoc and weasyprint.

## Why this exists

Most AI CV tools optimise for the screener. They pad keywords, inflate scope, and attach numbers
to bullets that never had numbers. That works until somebody asks you about it in a room.

cv-kit does the opposite. It cuts hard, keeps every claim traceable to your master CV, and gives
you an honest gap list to prepare from. The gap list is the product as much as the CV is.

## Quickstart

```bash
# 1. Prerequisites
brew install pandoc weasyprint poppler        # macOS
# sudo apt install pandoc weasyprint poppler-utils   # Debian/Ubuntu

# 2. Clone
git clone https://github.com/justWeird/cv-kit.git
cd cv-kit

# 3. Set up your profile (one time, 10 minutes)
claude
> /cv-setup

# 4. Apply for something
> /jd  <paste the job posting, or give it a file path or URL>
```

Output lands in `applications/<Company>/`: `CV.md`, `CV.pdf`, `Cover-Letter.md`,
`Cover-Letter.pdf`, and `Notes.md`.

Full instructions, including the plugin install and every profile field, are in
[SETUP.md](SETUP.md).

## The skills

| Skill | What it does |
|---|---|
| `/cv-setup` | One-time onboarding. Interviews you, reads two or three things you have written, and builds your profile and writing voice from them. |
| `/master-cv` | For people with no master CV. Interviews you role by role and writes one. Flags every bullet that needs a number instead of inventing one. |
| `/jd` | Job posting in. Tailored CV, cover letter, and interview prep out. Five steps: decode the role, fit-gap analysis, CV, letter, prep list. |
| `/proposal` | Client brief in. A costed proposal out: phases, prices, exclusions, terms, and the decisions the client still owes you. |

`/proposal` is newer than the rest. It was written from finished proposals rather than from a
directive run many times, so read its first few outputs more carefully.

## A worked example

[`examples/worked-example/`](examples/worked-example/) holds a complete run: a fictional
applicant, a fictional posting, and the real files the workflow produced.

The input is a backend role at a freight company that needs a 40-second replan made fast. The
applicant has six years of Python and PostgreSQL performance work, no Kubernetes, and no routing
experience.

**What came out of it:**

- [CV.md](examples/worked-example/output/Meridian-Logistics/CV.md), 446 words, one page.
  Every number in it appears in
  [master-cv.md](examples/worked-example/profile/master-cv.md).
- [Cover-Letter.md](examples/worked-example/output/Meridian-Logistics/Cover-Letter.md),
  478 words. It names the Kubernetes gap in paragraph three, before the "why this company"
  paragraph.
- [Notes.md](examples/worked-example/output/Meridian-Logistics/Notes.md), which carries the
  fit-gap table and six interview questions the applicant should expect, each with an angle.

Here is the honest-caveat paragraph the workflow produced, which is the part most CV tools will
not write for you:

> Here is my honest caveat. I have never worked on routing or optimisation problems, and I have
> not run Kubernetes in production. I am not going to arrive with an opinion about vehicle
> routing heuristics. What I would arrive with is the ability to read your query plans in week
> one and tell you where the 40 seconds actually goes, which in my experience is rarely where
> the team assumed it was.

The example's `Notes.md` also records what the render check caught and what got cut to fit,
because those decisions are part of the workflow rather than a tidy afterthought.

## How it works

You supply a **profile**: your identity, your master CV, a writing-voice file, and an appendix
of what each company you have worked for actually does.

```
profile/
  profile.yml      name, email, links, location, paths
  master-cv.md     everything you have done, deliberately too long
  voice.md         your writing voice, derived from your own writing
  appendix.md      what each company and project actually does
```

`/jd` reads all four, then cuts the master CV down for one specific posting.

The **appendix** is the part people skip and should not. It is what stops a CV from describing
your employer based on a guess at what its name implies. If a company is not in it, the skill
stops and asks you rather than filling the gap with something plausible.

Your profile never enters git. `.gitignore` excludes `profile/` and `applications/` before the
first commit.

## Writing voice

`/cv-setup` asks for two or three things you have written: a blog post, an old cover letter, a
long message where you explained something. It reads them and builds `voice.md` from what it
observes, then shows you the draft before writing it.

If you have nothing to point at, it uses [a neutral
default](templates/voice.neutral.md): plain, direct, no persona. You can upgrade later with
`/cv-setup --voice`.

The CV and the cover letter use that file differently. The letter uses the full voice, persona
included. The CV uses only the hard constraints (no em dashes, no filler, active voice) layered
under stricter rules: one idea per bullet, 30 words maximum, verb first. Dense clause-stacked
bullets read as clunky, and a CV is not the place for narrative voice.

## What this is not

- **Not a CV generator.** It cannot write a CV without a master CV to cut down.
- **Not a keyword stuffer.** Keywords that do not apply to you are logged as gaps, not inserted.
- **Not a submission button.** Every document stops and waits for you to edit the prose before
  it becomes a PDF. You are the one who has to defend it in an interview.
- **Not a Word pipeline.** Output is Markdown to PDF. If an employer demands `.docx`, convert it
  yourself and check the result.

## Requirements

- [Claude Code](https://claude.com/claude-code)
- pandoc
- weasyprint
- A page counter: poppler's `pdfinfo`, or `pip install pypdf`. `bin/cv-pagecount` also falls back
  to parsing the PDF directly with Python's standard library, so this is usually already covered.

## Tests

```bash
./tests/test-pagecount.sh
```

## License

MIT. See [LICENSE](LICENSE).
