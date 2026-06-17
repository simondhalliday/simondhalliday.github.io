# Memo: Course Design System & Web Presence
## FYS: Progress — AS.001.219
**Simon D. Halliday · Johns Hopkins University · April 2026**

---

## Purpose

This memo documents the design direction for the course, the technical plan for the course website, and the steps needed to fix the current `simondhalliday.com` infrastructure. It is intended as a standing reference as work proceeds over spring and summer 2026.

---

## 1. Design Direction

### Reference sites
The course visual identity draws on four reference points, all sharing a warm editorial aesthetic:

| Site | What it contributes |
|------|---------------------|
| [Roots of Progress Institute](https://rootsofprogress.org/) | Warm cream ground, humanist serif, terracotta link color, generous whitespace |
| [Kevin A. Bryan](https://www.kevinbryanecon.com/) | Bold serif headings, red accent, small-caps metadata, hand-drawn illustration |
| [Works in Progress](https://worksinprogress.co/) | Editorial magazine structure, fine-art illustration, golden accent stripe |
| [Stripe Press / Origins of Efficiency](https://press.stripe.com/origins-of-efficiency) | Bookish restraint, Garamond serif, constrained column width, horizontal rules as dividers |

### Color decision: Terracotta (Option A) ✓ CONFIRMED
Terracotta was chosen over amber/gold. Confirmed by Simon and his wife, April 2026. Two reasons: (1) it sits in the same red family as the UOE textbook accent (`#E40132`), creating visual kinship without clash; (2) it is the established color idiom of the progress-studies intellectual community (Roots of Progress, Kevin Bryan).

### Design tokens (Option A — Terracotta)

```css
/* progress.css — single source of truth */
--bg:          #FAF7F2;   /* warm cream — page background */
--bg-alt:      #F3EEE6;   /* slightly darker cream — cards, code blocks */
--ink:         #1C1812;   /* near-black — primary text */
--ink-mid:     #4A453E;   /* warm dark grey — secondary text, captions */
--ink-light:   #7A7368;   /* warm mid-grey — metadata, labels */
--accent:      #A84A2E;   /* terracotta — links, active states, accents */
--accent-dark: #8C3A22;   /* darker terracotta — hover states */
--rule:        #D8D0C6;   /* warm light grey — borders, horizontal rules */
--tag-bg:      #EDE6DC;   /* very light warm — tags, inline highlights */

/* Typography */
--font-serif:  'EB Garamond', Georgia, serif;   /* headings + body */
--font-sans:   'Open Sans', system-ui, sans-serif; /* labels, nav, small UI text */

/* Spacing scale */
--space-xs:  4px;
--space-sm:  8px;
--space-md:  16px;
--space-lg:  32px;
--space-xl:  56px;

/* Reading column */
--col-text:  680px;   /* max-width for body text */
--col-wide:  960px;   /* max-width for full-page layouts */
```

### Typography
- **Primary font:** EB Garamond (Google Fonts, free) — headings and body text
- **Secondary font:** Open Sans (Google Fonts, free) — navigation, labels, metadata, small UI text
- **Loading:** Via Google Fonts CDN; include in `<head>` of every HTML file:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=EB+Garamond:ital,wght@0,400;0,500;0,600;1,400;1,500&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
```

### Design principles
1. Warm (not cold) — cream ground, never pure white or grey
2. Serif-first — EB Garamond throughout; sans only for UI labels
3. One accent — terracotta only; no secondary accent colors
4. Generous whitespace — text should breathe; resist the urge to fill space
5. Editorial over UI — horizontal rules, not cards and drop shadows
6. Illustration over photography — hand-drawn or fine-art images preferred
7. Small-caps for metadata — session numbers, dates, labels in tracked small caps

---

## 2. Files Already Created

| File | Location | Status |
|------|----------|--------|
| Design comparison demo | `design_options.html` | Done — Option A vs Option B |
| Baltimore progress map | `Maps_and_Sites/baltimore_progress_map.html` | Done — mobile-responsive, verified coordinates |
| Baltimore sites notes | `Maps_and_Sites/baltimore_sites.md` | Done |
| Syllabus draft | `Syllabus/progress_syllabus_draft_v1.md` | Done |
| CLAUDE.md | `CLAUDE.md` | Done — course planning context |

**Still to build:**
- `progress.css` — the canonical stylesheet (extract tokens above into a real CSS file)
- Course homepage HTML — full public-facing page
- Canvas-safe inline-style version of homepage
- Assignment brief HTMLs (video assignment, data project)
- Print stylesheet for syllabus PDF

---

## 3. Website Architecture

### Structure
The course website lives as a standalone GitHub Pages site, independent of the main `simondhalliday.com` rebuild.

```
Repository:  simondhalliday/progress-fys   (new repo to create)
GitHub Pages URL:  simondhalliday.github.io/progress-fys/
Custom URL:  progress.simondhalliday.com   (via CNAME — see Section 5)
```

### File structure for the repo

```
progress-fys/
├── index.html          ← course homepage (syllabus overview)
├── syllabus.html       ← full session-by-session schedule
├── assignments.html    ← assignment briefs
├── baltimore.html      ← Baltimore sites + embedded map
├── map.html            ← standalone Baltimore map (embeddable)
├── progress.css        ← canonical stylesheet
├── assets/
│   └── (any images, illustrations)
└── CNAME               ← contains: progress.simondhalliday.com
```

### Why standalone, not a subdirectory of the main site
- The main `simondhalliday.com` rebuild is in progress; keeping the course repo separate means it is not blocked by the main site rebuild timeline
- The course can go live in summer 2026, months before the main site is rebuilt
- After the main site rebuild, the same HTML files can be migrated in as a subdirectory with minimal changes

---

## 4. Fixing HTTPS on `simondhalliday.com`

Your site currently serves over HTTP only, which browsers now flag as "Not Secure." This is a fixable GitHub Pages issue. Here is the complete diagnosis and fix.

### Why this happens
GitHub Pages supports free HTTPS via Let's Encrypt certificates, but the certificate is only provisioned and enforced when (a) the DNS records are configured correctly AND (b) you explicitly enable "Enforce HTTPS" in the repository settings. One of these is likely misconfigured or was never completed.

### Step-by-step fix

**Step 1 — Check your current DNS records**

Log in to wherever your domain is registered (GoDaddy, Namecheap, Google Domains / Squarespace Domains, Cloudflare, etc.). Go to the DNS management page for `simondhalliday.com` and confirm the following:

For an apex domain (`simondhalliday.com` without `www`), you need **A records** pointing to all four GitHub Pages IP addresses:

```
Type   Name   Value
A      @      185.199.108.153
A      @      185.199.109.153
A      @      185.199.110.153
A      @      185.199.111.153
```

For the `www` subdomain, add a CNAME:
```
Type    Name   Value
CNAME   www    simondhalliday.github.io.
```

If you are using **Cloudflare** (check by looking for orange cloud icons next to DNS records): make sure the A records are set to "DNS only" (grey cloud), not "Proxied" (orange cloud). Cloudflare's proxy can interfere with GitHub Pages' certificate verification.

**Step 2 — Confirm the custom domain in GitHub repo settings**

1. Go to `github.com/simondhalliday/simondhalliday.github.io` (or whatever your repo is named)
2. Click **Settings** → **Pages** (left sidebar)
3. Under "Custom domain," the field should show `simondhalliday.com`
4. If it is blank or shows an error, type `simondhalliday.com` and click **Save**
5. GitHub will then run a DNS check — this can take a few minutes

**Step 3 — Wait for certificate provisioning**

After DNS is correctly configured and saved in GitHub:
- GitHub automatically requests a Let's Encrypt certificate
- This typically takes **15 minutes to 24 hours**
- You can monitor progress: in the same Pages settings, there is a status message that will say either "Certificate provisioning..." or show a green checkmark

**Step 4 — Enable "Enforce HTTPS"**

Once the certificate is provisioned, the "Enforce HTTPS" checkbox in Pages settings becomes clickable (it is greyed out until the certificate is ready). Check it. This redirects all HTTP traffic to HTTPS automatically.

### If the checkbox stays greyed out after 24 hours
This usually means DNS isn't fully propagated or there's a conflict. Try:
1. Remove the custom domain from Pages settings → Save
2. Wait 5 minutes
3. Re-enter `simondhalliday.com` → Save
4. This forces GitHub to re-request the certificate

You can also check DNS propagation globally at [dnschecker.org](https://dnschecker.org) — search for `simondhalliday.com` with type `A` and confirm all four GitHub IPs appear.

### For the new `progress.simondhalliday.com` subdomain (future)
When you create the course repo and want a clean URL, add this DNS record:
```
Type    Name       Value
CNAME   progress   simondhalliday.github.io.
```
Then add a `CNAME` file to the root of the `progress-fys` repo containing exactly:
```
progress.simondhalliday.com
```
GitHub Pages handles the HTTPS certificate automatically for subdomains — no extra steps needed.

---

## 5. Canvas Integration Strategy

### What Canvas can do (at JHU, without admin access)
- **Course Home Page:** Set to a custom Canvas "Page" with inline-styled HTML — use this as the welcome screen and link out to the external course site
- **Custom CSS per course:** Check Settings → Course Details → scroll to the very bottom for a "Custom CSS" field — this may or may not be exposed at JHU. If present, a 50-line terracotta override can be injected.
- **HTML in Pages:** The Rich Content Editor → HTML Source mode accepts inline `style=""` attributes (but strips `<style>` blocks inconsistently). All Canvas-facing materials should use inline styles.
- **Module items:** Point to external URLs (the course website pages) rather than duplicating content inside Canvas

### What Canvas is for (use it as plumbing only)
- Assignment submission (SpeedGrader, Turnitin integration)
- Gradebook
- Announcements and messaging
- Due dates and calendar
- Reading response submission

### What the external site is for (the designed experience)
- Syllabus and schedule
- Assignment briefs with full context
- Baltimore map
- Reading guides
- Anything you want cited, shared, or seen outside JHU

### Canvas homepage HTML (to build)
A single Canvas Page using only inline styles that:
1. Shows the course title and term in the course design aesthetic
2. Links to `progress.simondhalliday.com` for the full syllabus
3. Links to Canvas Modules for readings and submissions
4. Includes the instructor's contact info and office hours

---

## 6. *Competition, Conflict, and Coordination* — Bowles & Halliday Book Site

### Context
**Full title:** *Microeconomics: Competition, Conflict and Coordination* — co-authored with Samuel Bowles (and potentially additional co-authors in future; keep naming conventions author-agnostic). Previously published by Oxford University Press; rights reverting to the authors (OUP attributed underperformance to the open PDF distributed alongside the print edition). Plan is an open-access web publication: public GitHub repo, Quarto book, custom domain. Summer 2026 start.

Since rights are reverting and the book will be openly published, the repo can and should be **public from day one** — this aligns with CORE-econ's model and signals the open-access commitment clearly.

### Domain purchase
Buy a domain before starting — it takes minutes and costs ~$12–15/year. Recommended registrars (in order of preference):

| Registrar | Why | Notes |
|-----------|-----|-------|
| **Cloudflare Registrar** (cloudflare.com/products/registrar) | At-cost pricing — cheapest renewals, no markup | Requires a free Cloudflare account; excellent DNS management |
| **Namecheap** (namecheap.com) | Cheap first year, good UI, reliable | Renewal prices slightly higher than Cloudflare |
| **Squarespace Domains** (formerly Google Domains) | Clean interface, fair pricing | Acquired by Squarespace in 2023; still reliable |

**Avoid:** GoDaddy (aggressive upsells, renewal price spikes), Network Solutions (expensive), Wix/Squarespace website builders that bundle domains (hard to move later).

### Domain name options
Full title: *Microeconomics: Competition, Conflict and Coordination*. Avoid author-name domains (future co-authors possible). Look for something that travels with the book, not the authors.

Model to follow: CORE-Econ used `core-econ.org` — short, memorable, initialism-based, institution-agnostic. Aim for the same.

| Option | Notes |
|--------|-------|
| **`ccc-econ.org`** | ★ Best option — initials + "econ", .org signals open/academic, mirrors CORE-econ pattern |
| `cccecon.org` | Same idea without hyphen — check which reads better |
| `ccc-micro.com` | Adds "micro" for disambiguation; .com is more universally trusted |
| `microecon-ccc.com` | Slightly longer but very clear |
| `competitionconflict.org` | Drops "coordination" but flows better spoken; .org appropriate |
| `ccc-microeconomics.com` | Unambiguous but long |

**Avoid:** `bowleshalliday.com` (excludes future co-authors), `microeconomicsbook.com` (generic), `oup-ccc.com` (wrong — rights reverting).

Check availability at [instantdomainsearch.com](https://instantdomainsearch.com) — it checks .com/.org/.net simultaneously. Register whichever you choose at Cloudflare Registrar for cheapest renewals.

### Quarto + GitHub Pages workflow for the book

**Why Quarto is the right choice here:**
- Designed specifically for academic books and reports (`quarto book` project type)
- Handles numbered chapters, cross-references, bibliography, figures, and equations natively
- Produces a beautiful web version AND a PDF from the same source files
- Used by major open textbooks including Hadley Wickham's R for Data Science
- Samuel Bowles's team at SFI likely already has familiarity with this kind of toolchain

**Setup steps:**

1. **Install Quarto** (free): [quarto.org/docs/get-started](https://quarto.org/docs/get-started)

2. **Create a new Quarto book project:**
```bash
quarto create project book ccc-book
cd ccc-book
```
This scaffolds:
```
ccc-book/
├── _quarto.yml       ← book config (title, authors, chapters)
├── index.qmd         ← preface / landing page
├── chapter-01.qmd    ← Chapter 1
├── references.bib    ← bibliography
└── _book/            ← rendered output (gitignored during dev)
```

3. **Configure `_quarto.yml`** for GitHub Pages output:
```yaml
project:
  type: book
  output-dir: docs   # GitHub Pages reads from /docs

book:
  title: "Competition, Conflict, and Coordination"
  author:
    - name: Samuel Bowles
    - name: Simon D. Halliday
  chapters:
    - index.qmd
    - chapter-01.qmd

format:
  html:
    theme: cosmo       # override with custom CSS
    css: ccc.css       # your design stylesheet
  pdf:
    documentclass: scrbook
```

4. **Create a GitHub repo**, push, and enable GitHub Pages from the `/docs` folder:
   - Repo Settings → Pages → Source: "Deploy from a branch" → Branch: `main` → Folder: `/docs`

5. **Add custom domain:**
   - Create a `CNAME` file in the repo root containing your domain (e.g., `ccceconomics.com`)
   - Add DNS records at your registrar pointing to GitHub Pages IPs (same as Section 4 above)
   - HTTPS is provisioned automatically

6. **For collaborative writing with Bowles:**
   - Both authors commit to the same repo
   - Use branches for draft chapters; merge via pull requests
   - GitHub's diff view works well on `.qmd` (plain text) files
   - Consider using GitHub Issues to track chapter-level to-dos and editorial notes

### Design connection
The `ccc.css` stylesheet for the book site can draw from the same design tokens as `progress.css` — same type stack, same cream ground, potentially same accent color (or a distinct one if Bowles & Halliday book needs its own identity). Decide this once `simondhalliday.com` is rebuilt and the overall system is settled.

---

## 7. Main Site Rebuild Notes (for summer 2026)

When rebuilding `simondhalliday.com`, the Progress FYS course page serves as the design prototype. The rebuild should:

- Adopt the same design tokens (`progress.css`) for consistency across the whole site
- Use the same EB Garamond + Open Sans type stack
- The current site uses Jekyll (GitHub Pages' default). **Switch to Quarto** — given the CCC book will be in Quarto anyway, using the same system for the main site eliminates context-switching and lets you share CSS and components across projects.
  - Quarto websites (`quarto website` project type) support blogs, research pages, teaching pages, and arbitrary HTML pages in one system
  - All existing `.md` content migrates to `.qmd` with zero changes
  - `quarto publish gh-pages` deploys in one command
- Either way, `progress.css` migrates in with minimal changes.

---

## 8. To-Do List

### Immediate
- [x] Confirm terracotta vs. amber with your wife — **done, April 2026: terracotta confirmed**
- [ ] Fix HTTPS on `simondhalliday.com` (follow Section 4 above)

### Now that color is confirmed
- [ ] Create `progress.css` canonical stylesheet from design tokens
- [ ] Build full course homepage HTML (`index.html`)
- [ ] Update Baltimore map to use `progress.css` colors (currently uses near-black rather than terracotta accent)
- [ ] Create new GitHub repo: `simondhalliday/progress-fys`
- [ ] Enable GitHub Pages on the new repo
- [ ] Add CNAME file → `progress.simondhalliday.com`
- [ ] Add DNS CNAME record at your domain registrar → see Section 4

### Before fall semester (by late August 2026)
- [ ] Build `syllabus.html` — full designed session list
- [ ] Build `assignments.html` — video assignment + data project briefs
- [ ] Build `baltimore.html` — sites page with embedded map
- [ ] Build Canvas homepage (inline-style HTML)
- [ ] Check JHU Canvas for Custom CSS field; apply terracotta override if available
- [ ] Test all pages on mobile
- [ ] Confirm all reading PDFs are organized in `Readings/` with week subfolders

### Summer 2026 (main site rebuild)
- [ ] Install Quarto locally: [quarto.org/docs/get-started](https://quarto.org/docs/get-started)
- [ ] Create new Quarto website project for `simondhalliday.com`
- [ ] Migrate existing Jekyll content (`.md` → `.qmd`, zero changes needed)
- [ ] Apply `progress.css` design tokens as the base stylesheet
- [ ] Rebuild `simondhalliday.com` with the new design and deploy via `quarto publish gh-pages`
- [ ] Redirect `progress.simondhalliday.com` to a subdirectory of main site OR keep standalone (both fine)

### Summer 2026 — *Microeconomics: Competition, Conflict and Coordination* book site
- [ ] Choose and purchase a domain (check `ccc-econ.org`, `cccecon.org`, `ccc-micro.com` — see Section 6 for full options and registrar guidance)
- [ ] Install Quarto if not already done
- [ ] Create Quarto book project: `quarto create project book ccc-book`
- [ ] Create GitHub repo (decide: public from day one, or private during drafting?)
- [ ] Configure `_quarto.yml` with both authors, chapter list, output to `/docs`
- [ ] Enable GitHub Pages from `/docs` folder in repo settings
- [ ] Add CNAME file and DNS records for custom domain
- [ ] Create `ccc.css` (can share `progress.css` tokens or establish a distinct palette)
- [ ] Set up collaboration workflow with Samuel Bowles (branch-per-chapter or direct commits to main)
- [ ] Add GitHub Actions workflow for auto-build on push (optional but convenient)

---

*Memo drafted April 2026. Update as decisions are made.*
