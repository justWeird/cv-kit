# Meridian Logistics BV — Backend Engineer (Python)

Worked example for cv-kit. The company, the posting, and the applicant are all fictional.

## STEP 1 — Decode the job

This role is hired to fix one number: 40 seconds to replan a large carrier's day. Everything
else in the posting serves that.

| Skill demanded | Why it matters to this employer | ATS keywords (verbatim) |
|---|---|---|
| Python performance work | The routing service is the product bottleneck, and their biggest customers hit it five times a morning | "Strong Python", "FastAPI", "async framework" |
| PostgreSQL query optimisation | They named query plans explicitly, which means they suspect the database, not the algorithm | "read a query plan", "fixed a slow one", "PostgreSQL" |
| Background job processing | They already know the fix: replace the synchronous replan with an async pipeline | "async job pipeline", "Celery, RQ, or similar", "background job processing" |
| Docker and CI/CD | A 6-engineer platform team has no dedicated ops | "Docker", "CI/CD pipelines" |
| Performance as a product requirement | They want somebody who has been held to a latency number, not someone who finds profiling interesting | "performance was a product requirement, not an afterthought" |

## STEP 2 — Fit-gap analysis

| Role requires | What I have (from master CV) | Overlap | Gap to address |
|---|---|---|---|
| Strong Python, FastAPI or similar async | Rewrote the Northwind pricing API on FastAPI, 1.9s to 210ms p95 | Direct | None |
| PostgreSQL, can read a query plan | Kestrel index fix, 4.1s to 90ms. Northwind settlement CTE rewrite, 6h to 38min. Built Slowquery, a query plan visualiser. | Direct, and unusually strong | None |
| Background job processing | Moved four endpoints to Celery at Northwind, timeouts 300/week to under 10 | Direct | None |
| Docker and CI/CD | EC2 to ECS migration at Kestrel, release 40min to 6min. GitHub Actions. | Direct | No Kubernetes at all |
| Performance as a product requirement | Every headline achievement is a latency or throughput number | Direct | None |
| Own a service end to end | Owned billing on-call for 18 months. Never owned a service's full roadmap. | Partial | Ownership has been operational, not directional |
| Work directly with operations teams | Agency client work at Bramble. No direct operations-team contact since 2021. | Weak | Four years since regular non-technical stakeholder contact |
| AWS (nice to have) | ECS, RDS, S3 at Kestrel | Direct | Nothing recent. AWS work is three years old. |
| Logistics or routing (nice to have) | Northwind Freight is freight brokerage, so the domain is adjacent | Partial | Never worked on routing or optimisation algorithms |
| Kubernetes (nice to have) | None | None | Genuine gap. Not claimed anywhere. |
| Dutch (welcome, not required) | B1, conversational | Partial | Fine for this posting, would not be fine for a Dutch-required role |

## STEP 5 — Interview prep

Every gap above, with the angle to take.

- **No Kubernetes.** Do not oversell the ECS experience as equivalent. The honest line: I have run
  containers in production for three years, on ECS rather than Kubernetes, and the operational
  concepts transfer even though the tooling does not. Ask them whether they are on Kubernetes
  today or planning to move.
- **No routing or optimisation background.** Lead with what transfers: the ability to find where
  40 seconds actually goes. Ask what they have already profiled, because the answer tells you
  whether this is a database problem or an algorithm problem, and those are different jobs.
- **AWS experience is three years stale.** Name the date rather than letting them find it. ECS,
  RDS, and S3 in 2022 are not the same products they are now.
- **Ownership has been operational, not directional.** The posting says "own the routing service
  end to end". Eighteen months of billing on-call is real ownership of uptime, not of roadmap. Be
  ready to say which one they mean and which one you have done.
- **Four years since regular operations-team contact.** The posting puts this in the
  responsibilities, so treat it as a real requirement. The Bramble agency work is the closest
  example: six clients, all non-technical, all with opinions.
- **Dutch is B1.** Fine here. Say the level plainly rather than "conversational", because levels
  are checkable and adjectives are not.

## Notes on this example

Three things worth pointing at, because they are what cv-kit does differently.

1. **The Kubernetes row says "None".** The master CV has no Kubernetes, so the CV has no
   Kubernetes, even though the posting asks for it. It is logged as a gap instead.
2. **Every number in the CV appears in the master CV.** Nothing was rounded, scaled, or added.
3. **The cover letter names the biggest gap in paragraph three**, before the "why this company"
   paragraph, rather than hoping nobody asks.

## What the render check caught

The word count and the page count both passed before these were found. Only reading the
rendered PDF surfaced them, which is why that check is in the skill.

- **Education and Skills rendered as run-on paragraphs.** "2016 – 2018 Specialization:
  distributed systems" ran together on one line. Markdown folds a single newline into a space,
  so every line of a multi-line block needs a trailing backslash. Same root cause as the
  sign-off bug already documented in the skill.
- **The Achievements section orphaned onto a near-empty page 2.** Fixed by cutting, not by
  shrinking the font.

## Cuts made, and why

- **Dropped the Achievements section.** Its one item, a PyGrunn talk about the settlement job
  rewrite, is relevant to this role. It was the last thing on the page and it pushed the CV to a
  second page holding nothing else. The talk moved into the cover letter's closing paragraph
  instead, where a narrative detail belongs.
- **Kept every professional role**, including the 2018 freelance work, which is the least
  relevant material here. Dropping the Achievements section freed enough room that no role had
  to go.

## Measured, not assumed

Measured on 2026-09-10 against `styles/cv.css`, by adding one bullet at a time and rendering at
each step:

| Content | Words | Pages |
|---|---:|---:|
| Full CV, no Achievements section | 446 | 1 |
| Same, plus an Achievements heading and one bullet | 461 | 2 |

Page one holds this structure at 446 words and breaks on the next section heading. That is
consistent with the 939-word two-page ceiling recorded in the skill, and it shows how much of
the budget a section heading costs on its own.
