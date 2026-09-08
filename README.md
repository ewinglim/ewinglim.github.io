# Ewe Win Lim — portfolio

Hand-written static site. No framework, no build step, no dependencies.
Open `index.html` in a browser and it works.

```
.
├── index.html                  # single-page portfolio
├── work/
│   ├── balance-hub.html        # case study 1 — editor tooling
│   ├── ether-survivors.html    # case study 2 — performance
│   ├── gun-builder-elite-2.html# case study 3 — tooling at scale
│   └── heroes-of-etheria.html  # case study 4 — architecture
├── css/style.css               # all styling, one file, sectioned & commented
├── js/main.js                  # filters, nav, reveal, TOC — degrades gracefully
├── assets/
│   ├── favicon.svg
│   ├── og-image.jpg            # social preview card
│   ├── games/<slug>/           # icon.jpg, cover.jpg, 01.jpg … per title
│   └── tools/                  # editor-tool screenshots (PNG)
├── check.sh                    # pre-publish sanity check
├── .nojekyll                   # tell GitHub Pages to serve files as-is
├── robots.txt
└── sitemap.xml
```

---

## Before you publish

Run the checker — it finds every placeholder left in the HTML:

```bash
./check.sh
```

Then read `NOTES-FOR-EWING.md`. There are five things to fix, and two of them
are visible to a recruiter, so don't skip it.

---

## Deploy to GitHub Pages

### 1. Create the repo

Name it `<your-username>.github.io` to get a clean root URL
(`https://ewewin.github.io`). Any other name works too, but the site then lives
at `https://<username>.github.io/<repo>/` — which is fine, just uglier.

```bash
cd portfolio
git init -b main
git add .
git commit -m "Portfolio: hand-written static site"
git remote add origin https://github.com/<your-username>/<repo>.git
git push -u origin main
```

### 2. Turn Pages on

Repo → **Settings** → **Pages** → Source: **Deploy from a branch** →
Branch `main`, folder `/ (root)` → Save.

It goes live in about a minute. No Actions workflow needed — this is plain
static HTML.

### 3. Updating it later

```bash
git add . && git commit -m "Add editor tool screenshots" && git push
```

Pushing to `main` redeploys. That's the whole workflow.

---

## Custom domain (optional, ~$12/year)

A personal domain reads better on a CV than a `github.io` subdomain, and it
means your portfolio URL never changes again even if you move off Pages.

1. Buy a domain — Cloudflare Registrar and Namecheap are both fine.
   Something short: `ewewin.dev`, `ewelim.com`.
2. At your DNS provider, add:

   | Type  | Name  | Value |
   |-------|-------|-------|
   | A     | `@`   | `185.199.108.153` |
   | A     | `@`   | `185.199.109.153` |
   | A     | `@`   | `185.199.110.153` |
   | A     | `@`   | `185.199.111.153` |
   | CNAME | `www` | `<your-username>.github.io` |

3. Create a file called `CNAME` in the repo root containing just your domain:

   ```
   ewewin.dev
   ```

4. Repo → Settings → Pages → Custom domain → enter it → **tick Enforce HTTPS**
   (wait a few minutes for the certificate to issue first).

5. Update the two `REPLACE-WITH-YOUR-DOMAIN` placeholders in `robots.txt` and
   `sitemap.xml`, and the `og:image` URL in `index.html` to the absolute URL
   (`https://ewewin.dev/assets/og-image.jpg`) — some social platforms won't
   resolve a relative one.

---

## Adding a new game

Everything is plain HTML, so this is copy-paste.

1. Make a folder: `assets/games/<slug>/`
2. Put a `cover.jpg` (1200×750, 16:10) and `icon.jpg` (256×256) in it.
   Store screenshots work — grab them from your Play Console listing.
3. Copy an existing `<li class="card">` block in `index.html`, change the text,
   image paths, and the `--card-accent` colour.
4. Set `data-studio` to `gempak`, `lifebelt` or `personal` so the filters pick
   it up. If you add a new studio, add a matching filter button.
5. Bump the `data-count` fallback text and the "Shipped titles" stat in the hero.

### Making a cover image

The multi-phone cover images were generated from portrait store screenshots.
If you want to regenerate them, `tools/make-cover.py` isn't included — but the
short version is: 1200×750 canvas, a dark vertical gradient in the game's
accent colour, and three screenshots centre-fanned with rounded corners and a
drop shadow. Any image editor does this in five minutes.

---

## Adding an editor-tool screenshot

Save it as `assets/tools/<name>.png` — PNG rather than JPEG, because JPEG
artefacts make small UI text mushy. Then copy the `<figure class="tool-feature">`
block in `index.html`, point the `<img>` and the wrapping `<a href>` at your new
file, and rewrite the heading, intro and the four `.tool-points` items.

Capture at the largest window size you can. The figure renders the image at
roughly 1030px wide on desktop, so anything narrower than that will look soft.
A 2x capture (around 2060px wide) will look crisp on retina displays.

## Adding a case study

Copy `work/ether-survivors.html`, change the `--card-accent` in its inline
`<style>`, rewrite the sections, and update the table of contents in the
sidebar to match your `<section id="...">` values. The TOC highlights the
active section automatically.

Then add it to the `.studies` list on `index.html` and link it from the
relevant game card.

---

## Notes on choices

- **No framework.** The whole point of this being hand-written is that it's a
  code sample. It also means nothing breaks in two years when a dependency
  goes stale.
- **Dark only.** Deliberate — game art reads better on dark, and committing to
  one theme is more coherent than hedging.
- **No tracking.** If you want analytics, [GoatCounter](https://www.goatcounter.com/)
  or [Plausible](https://plausible.io/) are one script tag and don't need a
  cookie banner. Google Analytics does.
- **Fonts from Google Fonts CDN.** If you'd rather self-host for privacy or
  offline reliability, download the woff2 files into `assets/fonts/` and swap
  the `<link>` for an `@font-face` block.
- **Accessibility.** Skip link, focus rings, `aria-pressed` on filters, live
  region on filter changes, `prefers-reduced-motion` respected, alt text on
  every image. Please keep these when you edit.

---

## Local preview

```bash
python3 -m http.server 8000
# then open http://localhost:8000
```

Opening `index.html` via `file://` also works, but a local server matches what
Pages will serve.
