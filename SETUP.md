# Setup

Everything you need to get cv-kit running, plus the failure modes that have actually happened.

## 1. Prerequisites

Three things: Claude Code, pandoc, and weasyprint. A PDF page counter is strongly recommended.

### macOS

```bash
brew install pandoc weasyprint poppler
```

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install pandoc weasyprint poppler-utils
```

### Fedora

```bash
sudo dnf install pandoc weasyprint poppler-utils
```

### Windows

Use WSL, then follow the Debian instructions inside it. weasyprint's native Windows install
needs GTK libraries and is not worth the time.

### Verify

```bash
pandoc --version | head -1
weasyprint --version
```

Both must print a version. If weasyprint prints a font warning, that is normal and harmless.

## 2. Install cv-kit

Two ways. Pick one.

### As a workspace (recommended for a first run)

```bash
git clone https://github.com/justWeird/cv-kit.git
cd cv-kit
claude
```

Claude Code loads the skills from `.claude/skills/`, which is a symlink to `skills/`. Your
profile and your applications live inside this clone, and both are gitignored.

Run cv-kit skills from this directory.

### As a plugin (works in any directory)

```
/plugin marketplace add justWeird/cv-kit
/plugin install cv-kit
```

The skills are then available everywhere. Put your profile at `~/.config/cv-kit/profile/` so it
resolves from any working directory. `/cv-setup` will offer that location.

> If `/jd` reports "no profile found" after a plugin install, your profile is not in one of the
> three resolved locations. See "Where the profile lives" below.

## 3. Run /cv-setup

```
/cv-setup
```

It takes about 10 minutes and does six things:

1. Checks that pandoc, weasyprint, and a page counter are installed.
2. Asks where the profile should go.
3. Interviews you for name, email, location, links, and work authorization.
4. Asks for your master CV. PDF, Markdown, or DOCX.
5. Asks for two or three things you have written, reads them, and drafts your writing voice.
6. Seeds the appendix.

**If you have no master CV**, `/cv-setup` will stop at step 4 and point you at `/master-cv`,
which interviews you and builds one. Run that first, then come back.

**If you have no writing samples**, step 5 falls back to a neutral voice with no persona. That
works fine. Run `/cv-setup --voice` later when you have something to point at.

## 4. Where the profile lives

Skills resolve the profile in this order and stop at the first hit:

1. `$CV_PROFILE`, if set and it is a directory
2. `./profile/` in the current working directory
3. `~/.config/cv-kit/profile/`

Check what resolves:

```bash
bin/cv-profile --check
```

That prints the directory, or fails with a message telling you what it looked for.

To keep a profile somewhere else:

```bash
export CV_PROFILE=~/Documents/job-search/profile
```

Add that line to your shell profile to make it stick.

## 5. Profile field reference

`profile/profile.yml`. The annotated version is at
[`templates/profile.example.yml`](templates/profile.example.yml).

| Field | Required | Notes |
|---|---|---|
| `name` | yes | Exactly as it should appear at the top of your CV |
| `email` | yes | Goes in the CV contact block and the letter sign-off |
| `location` | yes | City and country |
| `master_cv` | yes | Path to your master CV. PDF, Markdown, or DOCX. |
| `voice` | yes | Path to your writing-voice file |
| `appendix` | yes | Path to your company and project appendix |
| `phone` | no | Omit the key entirely to keep it off the CV |
| `links.github` | no | Written as visible text, e.g. `github.com/janedoe` |
| `links.linkedin` | no | Same |
| `links.<anything>` | no | Any number of extra links, written in the order listed |
| `work_authorization` | no | Free text. Used only when a posting raises the topic. |
| `sign_off` | no | Defaults to "Best regards," |
| `applications_dir` | no | Where output folders go. Defaults to `./applications/`. |

A skill that needs a missing required field stops and asks you. It never substitutes a
placeholder.

## 6. Bringing your own master CV

Anything readable works: PDF, Markdown, DOCX.

Two things make a master CV work well with `/jd`:

- **Length.** A master CV should be too long. It holds every role, every project, and every
  achievement, including ones no current application needs. `/jd` cuts; it cannot restore.
- **Numbers.** Every bullet that carries a real number is a bullet `/jd` can lead with. Every
  bullet without one stays vague, because the skill will not invent one for you. Go find the
  numbers once, and every future application benefits.

If you write it in Markdown, follow the structure in
[the example](examples/worked-example/profile/master-cv.md): `#` for your name, `##` for section
headings, bold role lines, and a blank line before every bullet list.

## 7. Fill in the appendix as you go

`profile/appendix.md` records what each company and project actually does.

`/jd` reads it before writing a Context line, the one-sentence description that sits under a
role and tells a recruiter what the company is. If a name is missing from the appendix, the
skill stops and asks you rather than guessing from the name.

Answer once, and it is recorded for every future application.

## Troubleshooting

### The CV renders to 3 pages

Cut content first. Drop a project, trim a bullet, drop the Achievements section. Only touch
`styles/cv.css` as a last resort, and never set body text below 10pt.

A section heading alone costs real space. In the worked example, a CV that fit on one page at
446 words broke to two pages when a single heading and one bullet were added.

### Bullets render as literal hyphens in the middle of a paragraph

Markdown needs a blank line before a list. Without it, pandoc folds the `-` lines into the
paragraph above.

```markdown
Northwind Freight runs freight brokerage software.
- This breaks.

Northwind Freight runs freight brokerage software.

- This works.
```

### Two lines run together into one

Markdown folds a single newline into a space. Any multi-line block that must stay on separate
lines needs a trailing backslash on every line except the last.

```markdown
**MSc Computer Science** · Delft · 2016 – 2018\
Specialization: distributed systems.
```

This bites in three places: the sign-off block, the Education entries, and the Skills block.

### The sign-off collapses into one line

Same cause. A backslash only after "Best regards," is not enough. Every line needs one:

```markdown
Best regards,\
Jane Doe\
jane@example.com\
github.com/janedoe\
linkedin.com/in/janedoe
```

The last line takes no backslash because nothing follows it.

### `mdls` returns `(null)`

Expected, and already handled. `mdls` reads the Spotlight index, and a PDF written seconds ago
is not indexed yet. `bin/cv-pagecount` tries `pdfinfo` first, then a Python parser, and only
falls back to `mdls` last.

If `bin/cv-pagecount` itself fails, install a counter:

```bash
brew install poppler       # macOS
pip install pypdf          # any platform
```

Do not skip the page-count check. A 3-page CV fails silently otherwise.

### weasyprint prints font or CSS warnings

Warnings like `Ignored 'overflow-x: auto', unknown property` come from pandoc's default HTML
template, not from the cv-kit stylesheets. They do not affect the output.

### `/jd` says no profile was found

Run `bin/cv-profile --check` to see where it looked. Either move your profile into one of the
three resolved locations, or set `$CV_PROFILE` to point at it.

### The skills do not appear in Claude Code

For the workspace install, confirm the symlink survived the clone:

```bash
ls -l .claude/skills     # should point to ../skills
```

If your filesystem dropped it, recreate it:

```bash
ln -s ../skills .claude/skills
```

## Tests

```bash
./tests/test-pagecount.sh
```

Three cases: a freshly written PDF that Spotlight has not indexed, and two PDFs with known page
counts.
