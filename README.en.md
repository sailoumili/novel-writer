# Multi-Core Collaborative Novel Writing

> [简体中文](./README.md) | English

A **multi-agent novel-writing mode** for [DeepSeek Harness (DSH)](https://github.com/deepseek-ai): one "conductor" leads the whole operation while 5 specialized subagents each own their own job — building the world, planning the plot, managing characters, writing the prose, and reviewing the quality. Pick it when you start a new session and this ready-to-work "writing studio" carries a novel from an idea all the way to a finished draft.

## What is it

It's not just a chatbot — it's a **6-person novel studio with clear division of labor**: **one "conductor" leads, 5 "specialized subagents" each do their own job**. Unlike the old approach where *one AI plays six roles by turns* in a single conversation, here every position is a real, independent agent: the one who writes prose only writes prose, the one who checks only checks, the one who owns the world only owns the world. Each subagent carries only its own slice of work in its context, so it doesn't interfere with the others — more focused, no flavor mixing.

| Role | Strength | What it does |
| --- | --- | --- |
| Conductor | Full-time general manager; doesn't write, so it can make objective calls | Assigns tasks; keeps pacing, settles disputes, signs off the final draft; if the same chapter is rejected 3 times in a row, convenes all subagents to recalibrate the *Narrative Constitution* |
| World subagent | The single authority on worldbuilding and proper nouns | Produces the *World Rules Whitepaper* and *Glossary Index*; expands every setting into "what it is + why + how it affects the story"; records the power gap between protagonist and ceiling to prevent power creep |
| Plot subagent | Chief planner of the main plot and cause-and-effect | Uses the "node method" for mainline nodes, turning points, and the foreshadowing ledger; writes an explicit "because… therefore…" causal chain for every node — no forced plot; actively plants foreshadowing and designs conflicts |
| Character subagent | Archive keeper of each character's soul and voice | Builds "four-dimension soul" JSON (surface traits / hidden desires / psychological thresholds / relationship web) and "voice gene cards" (sentence length / catchphrases / forbidden words / signature gestures); refuses stereotypes, writes growth arcs, keeps behavior believable |
| Prose subagent | The sole writer — focused, undisturbed | First obeys the other subagents' settings (constitution / foreshadowing / world / character); breaking them requires a "waiver request"; easy-to-read, non-essay-like prose; description serves the characters; no direct emotion statements (hint through action or setting); ~2000–4000 words per chapter |
| Reviewer subagent | Only finds flaws, never rewrites — objective stance | Checks the text against all settings line by line; three-color-light ruling: 🔴 fatal → reject for rewrite with reasons, 🟡 warning → approve after fixes, 🟢 pass; also verifies the "naturally unfolding" plot and outputs pacing advice plus chapter-ending hooks |

## Installation

This is a **DSH preset plugin**: once installed, it automatically registers the 「多核协同写作模式」 preset with DSH, so you can simply pick it when starting a new session.

### Option 1: Install as a plugin (recommended)

Run this single command in your DSH terminal (works on Windows / macOS / Linux):

```
dsh plugin --profile web add github:sailoumili/novel-writer
```

After installing, **restart or refresh DSH web**, then pick 「多核协同写作模式」 when starting a new session.

### Option 2: Manual install (fallback)

Prefer not to use the command line? You can also install manually:

#### One-line script

Windows (PowerShell) — copy and paste this single line:

```powershell
irm https://raw.githubusercontent.com/sailoumili/novel-writer/main/install.ps1 | iex
```

macOS / Linux (terminal):

```bash
curl -fsSL https://raw.githubusercontent.com/sailoumili/novel-writer/main/install.sh | bash
```

After installing, **refresh or restart the DSH page**, then pick 「多核协同写作模式」 when starting a new session.

#### Manual download

1. Click the green `Code` button → `Download ZIP`, then unzip.
2. Rename the extracted folder to `novel-writer` (GitHub's zip folder usually has a `-main` suffix — remove it).
3. Move the `novel-writer` folder into your DSH presets directory:
   - Windows: `C:\Users\<you>\.dsh\.agent-presets\`
   - (`~/.dsh/.agent-presets/`, where `~` is your home directory)
4. Refresh (or restart) the DSH page.
5. When starting a new session, pick **多核协同写作模式**.

## How to use

1. After picking the preset, send one message with your genre and core premise, for example:

   > Genre: Eastern fantasy + cosmic horror. Premise: a hunter who can see others' "death countdowns" tries to save a village about to be devoured by an Old One — without being corrupted himself.

2. The conductor follows a three-step flow, **pausing for your approval at every step** (it won't dump chapters on you):
   - It dispatches "World" and "Plot" to a joint session to draft the *Narrative Constitution* and the *World Whitepaper* outline → wait for your approval;
   - After approval it dispatches "Character" to generate the main character profiles → saved to local files;
   - Finally it asks for permission to write Chapter 1 → it writes only when you say go.

## It reads and writes files — please note

To keep profiles and ledgers across sessions, this preset gives the AI **file read/write permission**. For each new novel it creates a project folder in your workspace:

```
outputs/date-project-name/
├─ Narrative Constitution.md  core conflict, forbidden items, hard constraints
├─ World Rules Whitepaper.md  full world settings (incl. power ceiling and gap)
├─ Character Profiles.json    each character's "four-dimension soul" profile
├─ Foreshadowing Ledger.md    status table of every planted/recovered hook
├─ Chapter Index.md           latest version + one-line summary per chapter
├─ Ch1-v1.md                  Chapter 1 body text (versioned)
└─ Ch1-v2.md                  second revision after edits…
```

File operations still respect DSH's own sandbox policy; the preset does not bypass the sandbox.

## Chapter versioning

- Each chapter is stored in its own file with a version number: `ChN-vX.md` (N = chapter number, X = version number, starting at v1).
- **Never overwrite on revision**: a rewrite is saved as `Ch1-v2.md`, and the old version is kept as a dead draft.
- **Only the latest version counts**: when continuing, it reads only the highest version number of each chapter.

## Editing it

- The full prompt (its "brain") is in `agent.cordis.yml`.
- Save your edits and start a new session for them to take effect.
- Uninstalling the plugin (`dsh plugin --profile web remove novel-writer`) does not delete the preset files already written.
- To delete it entirely: remove the folder `~/.dsh/.agent-presets/novel-writer/`.

## License

[MIT](./LICENSE)
