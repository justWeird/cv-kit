---
name: proposal
description: Use when the user shares a client brief, requirements document, or project description and wants a written development proposal with phases, pricing, and terms. Also use when they type /proposal.
---

# proposal — Client development proposal

## Overview

Turns one client brief into a written proposal: what you understood, what you would build, what
it costs, what it excludes, and what the client still owes you a decision on.

The proposal's job is not to win the work by sounding confident. It is to make the engagement
survivable for both sides by putting the uncomfortable parts in writing before anyone signs.
A proposal that hides the hard problem sells a project that fails in month three.

> **This skill is newer than the rest of cv-kit.** It was written from finished proposals rather
> than from a directive that had been run many times. Read its output more carefully than you
> read `/jd` output, at least for the first few clients.

## When to Use

- The user shares a client brief, a features document, or a requirements list and wants a
  proposal.
- The user types `/proposal`, or `/proposal <client>`.
- The user wants to revise an existing proposal after client feedback.

If there is no brief, ask for one. A proposal written from a two-sentence description will
either be vague enough to be useless or specific enough to be wrong.

## STEP 0 — Resolve the profile

Run `bin/cv-profile --check`. Read `profile.yml`. You need `profile.name`, `profile.email`, and
`profile.voice` at minimum.

If it fails, stop and tell the user to run `/cv-setup`.

Resolve the output directory the same way `/jd` does: `$CV_APPLICATIONS`, then
`profile.applications_dir`, then `./applications/`, then the current directory.

## The Hard Rule

**Never promise capability, experience, or a timeline the user has not confirmed.**

The same rule that governs `/jd` governs this skill, with three additions specific to selling
work rather than applying for it:

- **Never invent a price.** Ask. A number you produced is a number the user has to honour.
- **Never invent a duration.** Ask. If the user does not know, propose a range and mark it as
  yours to confirm, in the chat, not in the document.
- **Never cite past work the master CV does not carry.** "I have built versions of that before"
  is a claim, and it needs a real project behind it.

Everything else about scope, risk, and exclusions is yours to draft, because those come from
reading the brief, not from claiming anything.

## What to collect before writing

Ask for anything missing. Do not write around a gap.

| Input | Why it matters |
|---|---|
| The brief itself | The whole basis of Sections 2 through 5 |
| Client and contact name | The "Prepared for" line, and the acceptance block |
| Total budget, or a budget range | Section 10 cannot be written without it |
| How the user wants to split payment | Deposit and delivery percentages |
| Availability and preferred timeline | Phase durations |
| Support window the user offers | Usually 14 to 30 days after handover |
| Whether the user wants portfolio rights | Goes in the ownership clause |

## The structure

Write `<Client>/proposal.md` with these sections. Both source proposals used this shape, and
the numbering is part of it: later sections reference earlier ones by number, and the client
reads it as a contract, not an essay.

**Title block.** Project title as `#`, then a paragraph with hard line breaks (trailing
backslashes) carrying "Prepared for", "Prepared by" (name and email from the profile), and the
date.

**1. Where I am starting from.** Read the brief back to the client, and say something true
about its quality. Then spend the honest caveat: name the hardest real problem in the project,
and in most software work it is not the software. Adoption, data discipline, an unowned
decision, a dependency on a third party. Say that everything in the proposal is shaped around
that problem, and name the later section that returns to it.

**2. The approach, and the option you rejected.** State the technical choice. Name the
alternative. Give the reasons it lost, as a short list. Then own the trade-offs the winner
carries, explicitly, in the same section. A choice presented without its costs reads as a
default, not a decision.

**3. What I understood it to be.** Roles, pipeline, modules, in the client's own vocabulary.
Concrete enough that a wrong reading is visible to them on first read. This section exists to
be corrected.

**4. What the brief does not say yet.** The section that earns the specification phase. List
every contradiction, undefined threshold, and unmade decision, each one specific:

- A feature described but never defined, with no finish line
- Two requirements in the same document that cannot both hold
- A decision with regulatory or architectural weight, presented as a detail
- A feature that is a different product sharing a login
- A document revised more than once with no authoritative version

Number these. Section 11 asks the client to answer them.

**5. The phases.** Each phase gets a name, a duration range, a price, and a deliverable list.
Phase 1 is a specification phase whenever Section 4 has real content in it, and say why: it is
the cheapest phase and it protects the other two.

**6. What the price does not cover.** Start with one line: the figure is labour, nothing else.
Then a table of third-party running costs (hosting, storage, domain, email, backups) with
indicative monthly figures and which phase first needs each. State that the client registers and
pays for those in their own name and adds the user as a collaborator, and give the reason:
every account is theirs from day one, and nobody untangles ownership later.

Then the exclusions list. Be specific and unembarrassed. Data entry, hardware, connectivity,
legal advice, maintenance past the support window, and training past what Phase 3 includes.

**7. What I am leaving out on purpose.** Deferred scope, one entry each, with the reason.
Distinguish "not in this budget" from "cannot be built yet". A feature that needs six months of
production data cannot be bought early at any price, and saying so protects the user later.

**8. What will actually decide whether this works.** Return to Section 1. List the real risks,
and be honest about how many of them are the client's rather than the user's. Adoption,
discipline, connectivity, and a single decision-maker are the recurring four.

**9. Revisions, changes, and what "done" means.** The section that prevents the argument in
month three. Cover, one bullet each: revisions per phase, how a change request is handled,
what acceptance is checked against, review cadence and staging access, the support window,
ownership and portfolio rights, and what the timeline assumes about client response time.

**10. Payment terms.** Total, then a table with one row per phase and columns for the
commencement share, the delivery share, and the phase total, with a totals row. State when work
starts (after the deposit clears) and when IP transfers (after the balance clears).

**11. What I need from you.** A checklist. Sign-off and deposit, access to the people who
actually do the work today, existing data in any form, answers to the numbered questions in
Section 4 from one named decision-maker, and accounts from Section 6.

**12. Acceptance.** Signature block for both sides: name, signature, date, with hard line
breaks so the lines do not collapse.

**Closing paragraph.** One short paragraph after the signature block. State what the proposal
covers, what gets quoted separately, and tell the client to raise anything in the risk and
exclusion sections before signing rather than after.

## Voice

Write in the full voice from `profile.voice`, persona included, the same register as a cover
letter. This is a document that argues, not a spec sheet.

Three moves carry most of the weight, and all three come from the voice file's structural
patterns:

- **The honest caveat.** Name the limitation, then show why it does not sink the project.
- **The named trade-off.** What you chose, what you rejected, and the principle behind it.
- **The scope boundary.** What the work covers and what it does not, said plainly.

Two register notes specific to proposals. Bullets are allowed here, unlike in a cover letter,
because the client reads this document to find clauses rather than to follow an argument. And
address the client as "you" throughout, the user as "I".

## Length

There is no word cap. Both source proposals ran 8 pages. A proposal is long because the
exclusions and terms sections are long, and those are the sections that earn their space.

What does not earn space: restating the brief at length in Section 3, or padding phase
deliverables to look substantial. If a phase has three deliverables, list three.

## Stop and wait for approval

Present `proposal.md` in the chat and wait for explicit approval before treating any PDF as
final. The user edits prices, dates, and terms themselves. This gate matters more here than in
`/jd`, because a proposal is an offer: a stale PDF sent to a client is a number the user did
not mean to quote.

Converting once, quietly, to run the visual-render check below is fine. Say so when you do it.

## Convert to PDF

```bash
pandoc <Client>/proposal.md -o <Client>/proposal.pdf \
  --pdf-engine=weasyprint --css=styles/proposal.css --metadata title="Proposal"
```

`styles/proposal.css` carries two things the CV and letter stylesheets do not: table rules and
a page-number footer. Both matter in a multi-page client document.

Check the page count, then read the rendered PDF and confirm four things by eye:

```bash
bin/cv-pagecount <Client>/proposal.pdf
```

- Every table renders with visible rules and a shaded header row. A cost table that renders as
  a run of pipe characters is the most common failure.
- Page numbers appear in the footer as `n / total`.
- No section heading sits orphaned at the bottom of a page. The stylesheet sets
  `break-after: avoid` on headings, so an orphan means the markdown structure is wrong.
- Right-aligned money columns actually right-align. That needs the `---:` separator in the
  markdown table, not just intent.

`proposal.pdf` ships alongside `proposal.md` only after this check passes.

## Close-out

End the chat response with:

- The path to the folder written.
- The total quoted, and the phase split.
- Every number in the document the user supplied, listed back to them for confirmation.
- Every question from Section 4, so the user can decide whether any of them should have been
  asked before sending rather than inside the proposal.
