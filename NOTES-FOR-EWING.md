# Read this before you publish

Everything factual on the site is verified against live store listings — titles,
install tiers, ratings, release dates, mechanics. Nothing is invented.

What follows is the short list of things only you can fill in. Run `./check.sh`
to see them flagged in the files.

---

## 1. Two links currently go nowhere — fix or delete

| Where | What | Fix |
|---|---|---|
| Hero "Download CV" button | `assets/ewe-win-lim-cv.pdf` doesn't exist | Drop your CV in at that path, or delete the button |
| Footer "GitHub" button | points at `https://github.com/` | Put your username in, or delete the button |

A recruiter clicking a 404 on your CV is the worst possible first impression, so
this is the one genuinely urgent item.

## 2. Your email address

The site uses `ewewin1995@hotmail.com`, the one from your Wix page.

Two thoughts. First, **do not** put `win@gempakgames.com` on a public job-hunting
portfolio — applications landing in your current employer's mail system is a
problem you don't need. Second, if you buy a domain (see README), `hello@ewewin.dev`
costs nothing extra with most registrars and reads better than hotmail.

Your phone number from the Wix site is **not** on the new one. A public phone
number on a portfolio mostly attracts recruiter spam and outsourcing cold calls.
Add it back if you want it, but LinkedIn plus email is enough.

## 3. Editor tool screenshots — Balance Hub is in

Your Balance Hub screenshot is now the centrepiece of the **Engineering** section:
full width at close to native size, with a written breakdown beside it and a link
to open the raw PNG. The three empty placeholder slots are gone.

I wrote the breakdown from what the screenshot demonstrably shows, so all four
points are checkable against the image:

1. It validates against design intent — the round reads 28.9–30.9s against a
   ~25s target, flagged amber.
2. It audits for absence — missing clips, unmapped PrefabIds, placeholder VFX.
3. It states what it cannot automate — no Unity scripting API for mixer groups,
   so it names the file to author by hand and the consequence of skipping it.
4. One re-check, one save across eight configs.

Point 3 is the strongest line on the whole site for a software-engineering
interviewer. A tool that documents its own limits instead of failing silently is
a judgement signal, not a feature.

### The project name is redacted — check my work

As you asked, the project name is gone from the screenshot. Both occurrences:

- the header description line → now reads `[project]`
- the mixer row in the audit table → now reads `[project].mixer`

I measured the exact pixel bounds of each and filled with the sampled background
colour, so there are no leftover half-letters. Both the caption on the home page
and the case study say the name is redacted and nothing else was altered — that
matters, because an edited screenshot with no disclosure invites the worse
assumption.

**Two things I did not touch, on purpose — tell me if you want them gone too:**

- The **"Kiosk Build"** page in the sidebar. It hints at the delivery format but
  names nothing.
- **"the booth promise is about 25 s"** in the round summary. Same. It's also
  doing real work in the argument, since it's the target the tool checks against.

If either narrows it down too far for comfort, say so and I'll redact them and
rewrite the two sentences that lean on them.

**On the timing being a live failure state:** the round is showing 28.9–30.9s
against a ~25s target. I kept it and framed it as a strength, because a tool
catching a real miss is the whole proof that it works. A screenshot of a tool
reporting all-clear proves nothing. Say the word if you'd rather it went.

### It also got its own case study

`work/balance-hub.html` is new — the fourth case study, and it now leads the case
studies section. It's the most relevant page on the site for the Grab / Sea /
Razer / Google track, because the section **"Why this is not a games skill"**
translates the whole thing into terms a non-games interviewer values: enforce
invariants at write time, treat absence as a first-class query, derive the
summary rather than maintain one, and include what you can't fix.

It has one Draft box, asking you to confirm IMGUI vs UI Toolkit and how pages get
registered. That's the only thing in it I couldn't read off the screenshot.

Bake Rush itself is **not** in the work grid, as you asked — it appears only as
the context for this tooling.

### Adding more tool screenshots

Save as `assets/tools/<name>.png` (PNG, not JPEG — it keeps UI text crisp) and
copy the `tool-feature` figure block. If you add two or more, tell me and I'll
turn it into a proper gallery instead.

## 4. Case-study numbers — the yellow boxes

Each case study has one or more yellow **Draft** boxes marking a spot where a
real number would carry the argument. There are eight in total. They're styled
to be obvious so you can't accidentally ship them — **delete each box once you've
written the content, and delete it even if you skip the content**, because a
visible "draft" note undermines the page.

The highest-value ones, in order:

1. **Gun Builder ELITE 2 → "Taking myself out of the loop"** — how long adding a
   weapon part took before vs after your pipeline work. Automation with a
   measurable effect is the single most transferable thing on this site.
2. **Ether Survivors → "What I measured"** — one before/after frame-time number
   on a named device.
3. **Heroes of Etheria → "Shared live-ops"** — whether comparing the four titles'
   funnels actually changed a decision.

If you don't have a real number, cut the claim rather than estimating one. You
will be asked about anything on this page in an interview.

## 5. Things I asserted that you should sanity-check

I wrote these from your background and the store listings. They're plausible and
I believe them to be right, but you shipped this code and I didn't — read them
and correct anything that's off:

- **The shared "Ether framework" narrative** (the whole third case study). The
  four launch dates are hard fact from Google Play: Protect the Wall NOW 21 Aug,
  Ether Defenders 28 Aug, Ether Survivors 3 Sep, Ether Trinity 8 Sep 2026. The
  *explanation* — that a shared core extracted from Heroes of Etheria made that
  possible — is my reading of it. If the real reason is different, rewrite it;
  the honest version will be more convincing anyway.
- **"Six titles have shipped under my code pipeline"** at Gempak — that's the six
  live on the Play developer page including Petairu. Adjust if your involvement
  differs per title.
- **Specific techniques** named in the case studies (object pooling, ScriptableObject
  authoring, dirty-flag stat composition, tag-based fusion rules, deterministic
  A/B bucketing). These match the capabilities you've described, but if you did
  something different, say what you actually did — including if it was simpler.
  "I chose the boring option because X" reads as senior.
- **Code snippets** are illustrative shapes, not your real code. Swap in real
  excerpts if you can share them; if not, they're fine as architecture sketches,
  but be ready to talk fluently about them.

---

## Also worth knowing

**Three of your Lifebelt links were dead.** Moto Hill Climb, Gun Range: Idle
Shooter and Max Air Motocross have all been delisted from Google Play — the URLs
on your Wix site 404. Those three are now on the new site marked "Delisted" with
no link, which is more credible than a broken one. Only Gun Builder ELITE 2
survives on the store, and it's the strongest of the four anyway (100K+ installs,
4.4★ from 2,300 ratings).

Also: the Lifebelt developer page lists **Loot Sort**, **Pancake Sort** and
**Tank Clash!**, which aren't on your portfolio at all. If you worked on any of
those, they're live and linkable — worth adding.

**Your resume title mismatch is resolved.** The exact store titles are
*Ether Defenders: Hero TD* and *Ether Survivors: Last Stand* — both plural. And
*Heroes of Etheria — TD Royale* is a separate, earlier game, not an alternative
name for them. Use those spellings on your CV and cover letters.

**The Perodua / PILoT simulation project isn't on the site.** A non-game
industrial simulation for Malaysia's national car manufacturer is unusually good
material for the software-engineering roles you're targeting — it shows you
outside the games box. I left it off because it may be under NDA and it was
Unreal rather than Unity. If you can talk about it publicly, it deserves a spot,
and I can write it up.

**Consider adding a small non-game code project.** You're studying DSA in C# and
Kotlin/Compose with a self-written backend. For the Grab/Sea/Razer/Google track,
one finished non-game app with a real backend on your GitHub would do more than
any amount of Unity work. That's the gap in this portfolio, and it's a gap no
amount of design fixes.
