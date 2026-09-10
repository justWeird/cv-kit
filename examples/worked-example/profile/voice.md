# Writing Voice — Neutral Default

This is the fallback voice. `/cv-setup` copies it to `profile/voice.md` when you have no
writing samples to derive a personal voice from. It works out of the box.

It carries the universal rules and no persona. Prose written from it reads as clear, direct,
and honest. It does not read as any particular person. If you want your own voice instead, run
`/cv-setup --voice` and point at two or three things you have written.

---

## Voice

Write as one professional talking to another. Not upward to a gatekeeper, not downward to a
reader who needs things simplified.

State what you did and what came of it. Let the facts carry the weight. A concrete outcome is
more persuasive than an adjective attached to yourself.

Name a limitation before the reader finds it. A caveat you raise yourself reads as
self-awareness. The same caveat discovered later reads as an omission.

## Sentence Rhythm

Vary sentence length. A long sentence that carries a full idea, followed by a short one that
lands the point, reads better than either alone.

Never stack three long sentences in a row. Break the third one.

Read the paragraph aloud in your head. If you run out of breath, the sentence is too long.

## Structure

### Application writing

Lead with the answer or with the most grounding fact. Do not warm up.

State the caveat in the second paragraph, not the last. Then show why it does not disqualify
you.

Close on something concrete. A specific thing about the company, a specific thing you would
work on. Not a statement of enthusiasm.

### Technical writing

Order: symptom, root cause, fix, trade-offs, verification.

Name the option you rejected and say why it lost.

Say what the fix covers and what it does not.

## Tone Calibration

| Situation | Tone |
|---|---|
| Describing your own work | Factual. The result is the claim. |
| Describing a gap | Direct, then immediately practical. No apology. |
| Describing a company you want to join | Specific about what they do. Never flattering in general terms. |
| Describing a failure | Own it in the first person. "I broke it", not "it was broken". |
| Describing a trade-off | Name both sides and say which one you picked. |

## Vocabulary

Prefer the plain word. "Use", not "utilise". "Build", not "architect" as a verb. "Fix", not
"remediate".

Use the same word for the same thing every time. Do not swap in a synonym for variety. A reader
who sees two words assumes two things.

Technical terms are fine when they are the accurate word. Jargon used to sound senior is not.

## Hard Constraints

### Never use

- Em dashes anywhere. Use commas, colons, or parentheses.
- "Delve into"
- "Nuanced"
- "Tapestry"
- "It's worth noting that"
- "It is important to note"
- "In conclusion"
- "To summarize"
- "Straightforward"
- "Let's explore"
- Any sentence that starts with "In today's world"
- "Results-driven", "passionate about", "proven track record", "team player", and every other
  phrase that describes a person without describing anything they did
- Passive voice used to avoid ownership. Say "I built it", not "it was built".

### Punctuation rules

- No em dashes, under any circumstances.
- Parentheses for asides and clarifications.
- Colons to introduce a list or to amplify the clause before them.
- Commas to carry a compound thought that would otherwise tempt an em dash.
- Serial comma throughout.

### Formatting rules

- No bullet points in a cover letter. It is narrative prose.
- Bullets are fine in a CV, a proposal, and technical documentation.
- No bold emphasis scattered through a paragraph.
- Headers only in documents long enough to need navigation.

## Structural Patterns to Replicate

### The honest caveat

State the limitation directly, then immediately show why it does not disqualify you.

> I have not worked in Go professionally. My production work is TypeScript and Python. What I
> can point at is the three-week window last March where I picked up Terraform from nothing and
> shipped the migration on schedule.

### The grounding specific

Anchor a claim to a concrete artifact instead of asserting it.

> The queue backed up twice a week before the change. It has not backed up since June.

### The named trade-off

State what you chose, what you rejected, and the principle behind the choice.

> I picked the allow-list. A block-list rots silently the moment somebody forgets an entry. At
> an auth boundary, failing closed matters more than reading cleanly.

### The scope boundary

Say what the work covers and what it does not.

> This fixes the duplicate writes. It does not touch the retry logic, which has a separate
> problem I have written up but not scheduled.

## Sample Transformations

### Too corporate

> I am a results-driven software engineer with a passion for building scalable solutions.

### Correct

> I pick up new stacks fast, and I take features from idea to release without needing to be
> chased.

---

### Too hedged

> I think I might have some experience that could potentially be relevant to this role.

### Correct

> My experience maps closely to what you are looking for, with one caveat I want to name up
> front.

---

### Too generic

> I am excited about the opportunity to contribute to your mission.

### Correct

> What pulls me toward this role is that the team is small enough that engineers sit close to
> the product decisions, and the posting says so plainly instead of implying it.

## Quick Reference Checklist

Verify before submitting any output:

- [ ] No em dashes anywhere
- [ ] No filler openers ("It's worth noting", "In today's world", "Straightforward")
- [ ] The caveat is named early, not buried
- [ ] At least one concrete specific: a name, a number, a project, an event
- [ ] Sentence rhythm varies, with no wall of long sentences
- [ ] Trade-offs named wherever a decision was made
- [ ] Ends on something grounded, not on a motivational flourish
- [ ] Parentheses used instead of em dashes for asides
- [ ] First person and active voice throughout
