---
name: master-cv
description: Use when a user has no master CV to point cv-kit at, or types /master-cv, or when /cv-setup reports that no master CV exists. Interviews the user about their roles and writes profile/master-cv.md.
---

# master-cv — Build a master CV from nothing

## Overview

Every other cv-kit skill reads a master CV and tailors it. This skill produces one, for a user
who has none, or whose only CV is a decade-old Word file they would rather rebuild.

The output is `profile/master-cv.md`: a long, complete, untailored record of everything the
user has done. It is not a submission document. It is the source of truth that `/jd` cuts down
for each application.

**A master CV is deliberately too long.** Do not trim it. `/jd` handles trimming, and it can
only cut material that exists here.

## When to Use

- The user types `/master-cv`.
- `/cv-setup` reached Step 3 and the user had no CV to point at.
- The user wants to rebuild a master CV from scratch rather than edit an old one.

## The Hard Rule

**Write only what the user said.**

This skill is an interviewer and a transcriber. It is not a ghostwriter.

- Do not sharpen "I helped with the migration" into "Led the migration".
- Do not attach a number the user did not give. If they say "it got a lot faster", write "it got
  faster" and flag the bullet as needing a number.
- Do not add a technology to the skills list because it usually accompanies one they named.
- Do not infer a date range from a gap between two other roles. Ask.

When a user reaches for a stronger word than their own story supports, say so once, plainly, and
write what they confirm. They are the one who has to defend it in an interview.

---

## STEP 1 — Set expectations

Tell the user three things before starting:

1. This takes 20 to 40 minutes. It is the longest thing cv-kit asks of them, and it happens
   once.
2. The output is long on purpose. It is not the CV they send anyone.
3. Every number they can find now saves an application later. Suggest they open old commit
   histories, performance reviews, dashboards, or invoices before starting.

Ask whether they want to do it all now or in sections. Working role by role across several
sessions is fine; append to the file each time.

## STEP 2 — Interview, most recent first

Work backwards through their career. For each role, collect:

| Field | Prompt |
|---|---|
| Title | What was your title? Use the one on the contract, not an aspirational one. |
| Company | And what does the company actually do? One or two plain sentences. |
| Dates | Month and year, start and end. "Present" for the current role. |
| Scope | How big was the team? What did you own end to end? |
| Achievements | What did you ship? Ask for four to six per role at this stage. |
| Numbers | For each achievement: is there a number attached? Users, latency, revenue, hours saved, error rate, team size. |
| Stack | What did you actually write, not what was in the job ad. |

Two follow-ups matter more than the rest.

**"What broke, and what did you do about it?"** Incident stories carry specifics that
achievement lists lose. They also make good interview material later.

**"What would not have happened if you had not been there?"** This surfaces ownership without
inviting inflation, because it asks for a counterfactual the user can actually check.

Record the company description straight into `profile/appendix.md` as you go. That is the same
file `/jd` reads before writing a Context line, and filling it now avoids being asked again
during the first application.

## STEP 3 — Education, projects, and the rest

- **Education**: institution, degree, field, dates, and any specialization worth naming.
  Thesis title if it is relevant to the work they want.
- **Projects**: personal or open-source work. For each, what it is in one line, what they built,
  the stack, and a link if it is public.
- **Certifications**: name, issuer, date, and expiry if it has one.
- **Languages**: language and level. Use a scale the user names, and record which scale it is.
- **Achievements**: awards, talks, publications. Skip the section if there are none rather than
  padding it.

## STEP 4 — Write the file

Write `profile/master-cv.md` in the structure `/jd` expects, so the tailoring step has real
Markdown to work from:

- The name is a level-1 header: `# <name>`.
- Contact details on the line below it, plain text.
- Section headings are level-2: `## Summary`, `## Experience`, `## Education`, `## Projects`,
  `## Skills`, and any others that apply.
- Every role line is bold: `**Title** · Company · Dates`.
- A blank line always sits before a bullet list. Without it, pandoc folds the `-` lines into the
  paragraph above as literal hyphens.
- Bullets are `action → result`, one idea each.

Two things this file carries that a tailored CV does not:

- **Every role and every achievement**, including ones no current application needs.
- **A `<!-- needs a number -->` comment** on every bullet where the user could not supply one.
  These are invisible in a render and visible in the source, which is exactly where a user goes
  looking when they want to strengthen the CV later.

## STEP 5 — Report and hand off

Print:

- The path written, and the word count.
- How many bullets carry a `needs a number` marker, and which roles they sit in.
- Any role where the user gave dates they were unsure about.
- What to do next: update `profile.yml` so `master_cv` points at this file, then run `/jd` with
  a job posting.

If `profile.yml` already exists, offer to update the `master_cv` field directly. If it does not,
tell the user to run `/cv-setup`, which will find this file.
