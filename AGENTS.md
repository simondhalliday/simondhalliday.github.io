# Codex handover memo — rebuild simondhalliday.com

**For:** the Codex project working on the personal site.
**Repo:** `simondhalliday/simondhalliday.github.io`
**Live domain:** https://simondhalliday.com
**Owner:** Simon D. Halliday (simon.halliday@jhu.edu), Johns Hopkins University
**Prepared:** 2026-06-17

Drop this file in the repo root as `AGENTS.md` so Codex reads it automatically. The
checklist at the end is the working list to tick through.

---

## What this project is

Rebuild the personal site `simondhalliday.com` in **Quarto**, reusing the design
system already proven on the course site at https://progress.simondhalliday.com
(repo `simondhalliday/progress-fys`). That course site was built first as a
deliberate test bed; it works, and this project applies the same system and
toolchain to the personal site.

HTTPS already works on `simondhalliday.com`. Do not spend time on certificates
unless a check shows it has regressed.

## Current state of the site

The site runs the old **Jekyll / beautiful-jekyll** theme. It serves fine but
predates the move to Hopkins and the new design. Stale content to fix during the
rebuild:

- Contact/footer still shows the old Smith address `shalliday@smith.edu`. The
  correct address is `simon.halliday@jhu.edu`.
- Canonical and Open Graph URLs still point at `http://simondhalliday.github.io/`.
- Affiliation should read Johns Hopkins (Center for Economy and Society, SNF Agora
  Institute), not Smith.

Existing content to preserve and migrate: an About Me page, a Research page, a
Resources menu, a Teaching menu (Introductory Micro, Intermediate Micro, Behavioral
Economics, Stats & Econometrics, Economic Development, Political Economy of
Development in Africa), and a blog with posts back to roughly 2017. Migrate the real
content and drop dead links.

## Design system (shared with the course site)

The canonical implementation is `progress.css` in the `progress-fys` repo. Copy it
in; do not reinvent it. Tokens, reproduced here for convenience (if these disagree
with `progress.css`, `progress.css` wins):

```css
--bg:        #FAF7F2;   /* warm cream — page background */
--bg-alt:    #F3EEE6;   /* cards, code blocks */
--bg-hover:  #EDE7DB;
--ink:       #1C1812;   /* primary text */
--ink-mid:   #4A453E;   /* secondary text */
--ink-light: #7A7368;   /* metadata, labels */
--accent:      #A84A2E;  /* terracotta — links, accents */
--accent-dark: #8C3A22;  /* hover */
--accent-pale: #F2E0DA;
--bg-quote:          #E3EBE0; --bg-quote-border:   #7A9E72;  /* sage callouts */
--bg-discuss:        #DDE6F2; --bg-discuss-border: #6A8FAF;  /* slate callouts */
--rule:   #D8D0C6;  --tag-bg: #EDE6DC;
--font-serif: 'EB Garamond', Georgia, serif;
--font-sans:  'Open Sans', system-ui, sans-serif;
--col-text: 680px; --col-wide: 960px; --col-full: 1200px;
```

Fonts load from Google Fonts: EB Garamond (ital 400/500/600), Open Sans (300/400/600).

Principles, in priority order: warm cream ground, never pure white; serif-first, sans
only for UI labels; one accent (terracotta) plus the sage/slate callout pair;
generous whitespace; editorial horizontal rules over cards and shadows; small-caps
for metadata.

## Toolchain and deploy

- Quarto `website` project. `_quarto.yml` sets `output-dir: docs`.
- GitHub Pages, "Deploy from a branch", branch `main`, folder `/docs`.
- Custom domain via a `CNAME` file in the repo root containing `simondhalliday.com`.
- `.gitignore` keeps `docs/` tracked while ignoring `.quarto/`, `*_cache/`,
  `.DS_Store`. Copy the pattern from `progress-fys`.
- Build with `quarto render`; deploy by committing the rebuilt `docs/`. Match the
  course site's branch-folder model rather than `quarto publish gh-pages`.

Definition of done for any page: renders with `quarto render` without errors, uses
the shared tokens, and reads well on a ~380px mobile viewport.

## Guardrails

- Do not change DNS or GitHub repo settings without surfacing it first.
- Do not delete live content until its replacement renders and is verified.
- Preserve existing post URLs where feasible, or add redirects, so inbound links do
  not 404.
- Prose style: plain and direct. Avoid em dashes, hollow intensifiers, and inflated
  significance.

## DNS reference (only touch if a check shows a problem)

Apex `simondhalliday.com` needs four A records: `185.199.108.153`,
`185.199.109.153`, `185.199.110.153`, `185.199.111.153`. `www` needs a CNAME to
`simondhalliday.github.io.`. If Cloudflare is in front, records must be "DNS only"
(grey cloud), not proxied.

## Decision left to Simon

After the rebuild, keep `progress.simondhalliday.com` standalone or fold it in as a
subdirectory? Both are fine; standalone is the lower-risk default.

---

## Checklist

### Setup
- [ ] Create a Quarto `website` project in the repo (or alongside, then swap in).
- [ ] Write `_quarto.yml`: title, navbar (Home, About, Research, Teaching, Writing),
      footer with JHU affiliation and `simon.halliday@jhu.edu`, `output-dir: docs`.
- [ ] Copy `progress.css` from `progress-fys` as the base stylesheet.
- [ ] Add a thin site-specific override layer only if needed.
- [ ] Copy the `.gitignore` pattern (keep `docs/` tracked).

### Content migration
- [ ] Migrate About Me (`.md` → `.qmd`).
- [ ] Migrate Research.
- [ ] Migrate Teaching index and its course links.
- [ ] Migrate the blog as a Quarto listing; convert posts to `.qmd`.
- [ ] Preserve old post URLs or add redirects.

### Fix stale references
- [ ] Replace `shalliday@smith.edu` with `simon.halliday@jhu.edu` everywhere.
- [ ] Fix canonical / Open Graph URLs (no more `http://simondhalliday.github.io/`).
- [ ] Update affiliation to Johns Hopkins (CES, SNF Agora).
- [ ] Audit social links and external links; drop dead ones.

### Deploy and verify
- [ ] Add `CNAME` with `simondhalliday.com`.
- [ ] Confirm apex A-records and `www` CNAME still point at GitHub Pages.
- [ ] `quarto render`; commit `docs/`.
- [ ] Confirm the live site updates and serves over HTTPS.
- [ ] Check every page on a ~380px mobile viewport.
- [ ] Spot-check old inbound links do not 404.
