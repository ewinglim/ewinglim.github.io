# ewinglim.github.io

My portfolio — thirteen mobile titles (ten shipped, one in closed testing) and five technical case studies.

**Live:** https://ewinglim.github.io

Static HTML, CSS and vanilla JavaScript. No framework, no build step, no
dependencies. Clone it and open `index.html` and it works.

## Structure

```
index.html                     single-page portfolio
work/
  kingsguard-td.html           case study — server-authoritative backend and live-ops
  balance-hub.html             case study — editor tooling
  ether-survivors.html         case study — performance budgeting
  gun-builder-elite-2.html     case study — modular systems, A/B, pipeline
  heroes-of-etheria.html       case study — shared framework across four titles
css/style.css                  all styling, one sectioned file
js/main.js                     filters, nav, scroll reveal, TOC
assets/
  games/<slug>/                icon.jpg, cover.jpg, screenshots per title
  tools/                       editor tool screenshots
check.sh                       pre-deploy link and asset check
```

## Local preview

```bash
python3 -m http.server 8000
```

Then open http://localhost:8000. Opening the file directly over `file://`
mostly works, but a server matches what GitHub Pages actually serves —
notably its case-sensitive paths, which Windows will happily let you get wrong.

## Deploying

Pushing to `main` redeploys. `.nojekyll` is there so Pages serves the files
as-is rather than running them through Jekyll.

Before pushing:

```bash
./check.sh
```

It walks every `src` and `href` in the HTML and reports anything that doesn't
resolve on disk. Cheap insurance against a broken image or a dead CV link,
both of which I have shipped before.

## Adding a title

1. Create `assets/games/<slug>/` with a `cover.jpg` (1200×750) and
   `icon.jpg` (256×256).
2. Copy an existing `<li class="card">` block in `index.html`. Update the text,
   the image paths and the `--card-accent` colour.
3. Set `data-studio` to the studio key — `gempak`, `lifebelt`, `gamelobb` or
   `personal`. The filter buttons read that attribute; a new key needs a
   matching button.
4. Update the count in `data-count` and the stat in the hero.

## Adding a case study

Copy any file in `work/`, change `--card-accent` in its inline `<style>`, and
keep the sidebar table of contents in step with the `<section id="...">`
values — the active-section highlight is driven off those ids. Then add it to
the `.studies` list on the home page.

## Notes on the build

**No framework.** The site is four pages of static content. A framework would
add a build step, a dependency tree and a future upgrade I don't want to do,
in exchange for nothing I need here.

**Dark only.** Game art reads better on a dark ground, and committing to one
theme is more coherent than hedging with two.

**Progressive enhancement.** The scroll-reveal animation is gated behind a `.js`
class set in `<head>`, so with JavaScript disabled or broken every section is
simply visible. Content should never depend on a script running.

**Accessibility.** Skip link, visible focus rings, `aria-pressed` on the
filters, a live region announcing filter results, `prefers-reduced-motion`
respected, alt text on every image.

**No tracking.** No analytics, no cookies, no consent banner needed.

**Performance.** Images are sized to their display dimensions rather than
shipped at store resolution, everything below the fold is lazy-loaded, and
the whole site is about 6 MB including all the screenshots.
