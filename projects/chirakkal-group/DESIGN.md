# Chirakkal Group — Design & Build Specification

Version: 1.0
Status: Source of truth for design, content and architecture
Audience: Human developers and the AI agents in `.claude/agents/`

> Read this file before writing any code. If code and this document disagree, this document wins.
> If this document is silent, choose the most conservative, professional option and record it in §17 "Decision log".

---

## Contents

1. Product definition
2. Brand relationship
3. Non-negotiable content rules
4. Design principles
5. Design tokens (color, type, spacing, radius, elevation, motion, breakpoints)
6. Layout & grid
7. Component library
8. Imagery strategy
9. Site map & routes
10. Page specifications
11. Content architecture
12. Contact & enquiry system
13. SEO
14. Performance budget
15. Accessibility
16. Error handling
17. Decision log
18. Placeholder register
19. Build stages & exit criteria

---

## 1. Product definition

A corporate **information website** for Chirakkal Group and its two business divisions.

| It is | It is NOT |
|-------|-----------|
| A business introduction and enquiry site | An e-commerce store |
| A product-category showcase | A product catalog with prices/stock |
| Lead generation via call / WhatsApp / form | Cart, checkout, payment, accounts |

Visitors must be able to answer, within one scroll of each page:

1. Who is Chirakkal Group?
2. Which businesses does it operate?
3. What does MetaPlannet do, and what does it offer?
4. What does Chirakkal Traders do?
5. Why contact them?
6. How do I contact them — right now?

Priority order for every design decision: **Trust → Clarity → Business credibility → Product understanding → Contact**.

---

## 2. Brand relationship

```text
Chirakkal Group  (parent · Scrap & Recycling)
├── MetaPlannet        (Roofing Solutions)
└── Chirakkal Traders  (Trading & Distribution)
```

Rules:

- The three businesses share **one design system**, one accent color, one typeface pairing, one header/footer pattern. They must never look like unrelated companies.
- Division pages carry an **endorsement line**: "A Chirakkal Group company", linked to `/`.
- The group header always shows the division switcher ("Our Businesses") so a visitor can move between divisions from anywhere.
- Division identity is expressed through: its wordmark, its hero imagery and its category label — **not** through a different palette.
- The spelling is exactly **MetaPlannet** (double "n"). Never "MetaPlanet", "Meta Plannet" or "Metaplannet" in visible copy. Slug: `metaplannet`.

---

## 3. Non-negotiable content rules

These override every other instruction, including requests to "make it look complete".

**Never invent:** company history, founding year, years of experience, employee counts, certifications, awards, clients, projects, testimonials, revenue, tonnage/volumes, locations/branches, product specifications (gauge, thickness, dimensions, warranty, load ratings, brands), technical certifications, partner logos.

**Never claim:** "industry leader", "No.1", "best in India/Kerala", "trusted by thousands", "leading", "premier", or any superlative that needs evidence.

**When information is missing:**

- Use a bracketed placeholder string: `[Company description to be provided]`.
- Mark the containing content item `status: "placeholder"` (see §11).
- Add it to the placeholder register (§18) and to `PLACEHOLDERS.md` in the project root.

**Allowed without confirmation** (because they are the brief itself):

- Business names, the parent/child relationship, and each division's category.
- The example headings and short descriptions quoted in the brief (hero lines, business card copy, value statements). These are listed as "approved copy" in §18.
- Generic, non-factual value statements (Reliability, Quality, Customer Focus) with no numbers attached.

"Experience" as a value is allowed only as a statement of intent ("Practical business knowledge across different industries") — never with a number of years.

**Tone:** professional, confident, clear, simple. Short sentences. No hype, no exclamation marks, no emoji.

---

## 4. Design principles

Direction: **Modern Corporate + Industrial + Premium + Minimal.**

| Do | Don't |
|----|-------|
| Large, real, relevant photography | Abstract blobs, 3D shapes, random office stock |
| Strong, bold headings; calm body text | Decorative or script fonts |
| Generous whitespace, strict grid | Crowded sections, floating elements |
| Flat surfaces, 1px borders, sharp-ish corners | Heavy shadows, glassmorphism, pill-shaped cards |
| One accent color used with discipline | Gradients, neon, multiple brand colors |
| Short, fast, subtle motion | Parallax, scroll-jacking, looping animations |
| Clear CTAs on every page | Hidden contact details |

Signature details that stop it looking like a template:

1. **Industrial rule**: a 48×3px accent bar above every section eyebrow.
2. **Eyebrow labels**: small uppercase tracked labels (e.g. `OUR BUSINESSES`) above section headings.
3. **Index numbers** on business cards and value items (`01`, `02`, `03`) set in the display face.
4. **Dark charcoal bands** alternating with white/light-gray bands to give sections a solid, architectural rhythm.
5. **Square-cornered imagery** with a 2px radius at most.

---

## 5. Design tokens

All tokens live in `src/styles/globals.css` under Tailwind v4 `@theme`. Components use token classes only — **no raw hex values, no arbitrary pixel values** in components.

### 5.1 Color

| Token | Hex | Use |
|-------|-----|-----|
| `charcoal-950` | `#0F1113` | Footer background |
| `charcoal-900` | `#16181B` | Dark bands, hero overlay base, primary text on light |
| `charcoal-800` | `#22252A` | Cards on dark bands |
| `charcoal-700` | `#33373D` | Borders on dark |
| `steel-600` | `#4B5159` | Secondary text on light |
| `steel-500` | `#6B7280` | Muted text, meta |
| `steel-300` | `#C9CDD2` | Borders (strong) |
| `steel-200` | `#E3E6E9` | Borders (default), dividers |
| `steel-100` | `#F1F3F5` | Light-gray bands, input backgrounds |
| `white` | `#FFFFFF` | Page background |
| `copper-700` | `#9A3412` | Accent hover/pressed on light |
| `copper-600` | `#C2410C` | **Brand accent** — primary buttons, links, icons, active nav (on light) |
| `copper-400` | `#F08A4B` | Accent on dark backgrounds (text, icons, rules) |
| `copper-50` | `#FFF4ED` | Tinted badge / focus background |
| `success-600` | `#15803D` | Form success (always paired with icon + text) |
| `danger-600` | `#B91C1C` | Form errors (always paired with icon + text) |

Why copper: it references metal (scrap/recycling) and roofing sheet tones, reads as industrial and premium, and is distinct from generic corporate blue.

Contrast rules (verified targets, WCAG 2.2 AA):

- `copper-600` on white ≈ 5.2:1 → OK for text and buttons (white label on `copper-600` ≈ 5.2:1).
- `copper-600` on `charcoal-900` fails for text → on dark bands use `copper-400` (≈ 7:1).
- `steel-500` is for text ≥ 14px on white only; never on `steel-100` for body text — use `steel-600`.
- Body text on dark bands: `white` or `steel-200`. Never `steel-500` on dark.

Semantic aliases (use these in components):

```text
--color-bg            white
--color-bg-subtle     steel-100
--color-bg-inverse    charcoal-900
--color-fg            charcoal-900
--color-fg-muted      steel-600
--color-fg-inverse    white
--color-border        steel-200
--color-accent        copper-600
--color-accent-hover  copper-700
--color-accent-on-dark copper-400
--color-focus         copper-600 (ring) with white 2px offset
```

The site is **light-themed only** in v1. Dark bands are a layout device, not a dark mode. (Decision D-04.)

### 5.2 Typography

| Role | Font | Loaded via |
|------|------|-----------|
| Display / headings / numbers / buttons | **Archivo** (600, 700, 800) | `next/font/google`, `display: swap`, subset `latin` |
| Body / UI | **Inter** (400, 500, 600) | `next/font/google`, `display: swap`, subset `latin` |

Both are exposed as CSS variables (`--font-display`, `--font-sans`) so the font can be swapped in one place.

Type scale (fluid with `clamp`, mobile → desktop):

| Token | Size | Line height | Weight | Tracking | Use |
|-------|------|-------------|--------|----------|-----|
| `display` | clamp(2.5rem, 6vw, 4.5rem) | 1.05 | 800 | -0.02em | Home hero only |
| `h1` | clamp(2.25rem, 4.5vw, 3.5rem) | 1.1 | 700 | -0.015em | Page hero headings |
| `h2` | clamp(1.75rem, 3vw, 2.5rem) | 1.15 | 700 | -0.01em | Section headings |
| `h3` | clamp(1.25rem, 2vw, 1.5rem) | 1.25 | 600 | -0.005em | Card titles |
| `h4` | 1.125rem | 1.35 | 600 | 0 | Sub-items |
| `lead` | clamp(1.125rem, 1.5vw, 1.25rem) | 1.6 | 400 | 0 | Intro paragraphs |
| `body` | 1rem | 1.65 | 400 | 0 | Default |
| `small` | 0.875rem | 1.5 | 400/500 | 0 | Meta, captions, helper text |
| `eyebrow` | 0.75rem | 1.2 | 600 (Inter) | 0.14em, uppercase | Section labels, categories |
| `button` | 0.9375rem | 1 | 600 (Archivo) | 0.01em | Button labels |

Rules:

- Exactly one `<h1>` per page. Headings never skip levels.
- Max line length for body text: `65ch`.
- No text below 14px except legal footer text (13px minimum).
- Never justify text. Never set body copy in all caps.

### 5.3 Spacing

4px base unit (Tailwind default scale). Use the following named rhythm:

| Token | Mobile | Tablet (md) | Desktop (lg+) | Use |
|-------|--------|-------------|---------------|-----|
| `section-y` | 64px (`py-16`) | 80px (`md:py-20`) | 112px (`lg:py-28`) | Vertical padding of every section |
| `section-gap` | 40px | 48px | 64px | Heading block → content |
| `stack-lg` | 24px | 32px | 32px | Between major blocks within a section |
| `stack-md` | 16px | 16px | 20px | Between paragraphs / items |
| `stack-sm` | 8px | 8px | 12px | Label → value, eyebrow → heading |
| `gutter` | 16px | 24px | 32px | Container side padding |
| `grid-gap` | 16px | 24px | 32px | Card grids |

### 5.4 Radius

| Token | Value | Use |
|-------|-------|-----|
| `radius-none` | 0 | Section bands, hero, full-bleed images |
| `radius-sm` | 2px | Images, cards, badges |
| `radius-md` | 4px | Buttons, inputs |
| `radius-lg` | 6px | Modal only |

No `rounded-full` except icon buttons and avatar-like icon containers.

### 5.5 Elevation

| Token | Value | Use |
|-------|-------|-----|
| `shadow-none` | none | Default for all cards |
| `shadow-sm` | `0 1px 2px rgb(15 17 19 / 0.06)` | Sticky header after scroll |
| `shadow-md` | `0 8px 24px -8px rgb(15 17 19 / 0.16)` | Card hover (desktop pointer only), mobile drawer, modal |

Cards are defined by a 1px `--color-border`, not by shadow.

### 5.6 Motion

| Token | Value |
|-------|-------|
| `duration-fast` | 150ms (hover, focus, color) |
| `duration-base` | 250ms (drawer, accordion) |
| `duration-reveal` | 450ms (section fade/slide-in) |
| `ease-standard` | `cubic-bezier(0.2, 0, 0, 1)` |

Allowed patterns:

- **Reveal**: opacity 0→1 and translateY 16px→0, once, when entering the viewport. Implemented with one tiny client component using `IntersectionObserver` + CSS classes. No animation library.
- **Card hover**: image `scale(1.03)` over `duration-base`, border → `steel-300`, arrow icon translateX 4px.
- **Button hover**: background color change only; no bounce, no scale.
- **Nav**: underline grows from left on hover; active page has a permanent 2px accent underline.
- **Drawer**: slides from the right, `duration-base`, backdrop fades.

`prefers-reduced-motion: reduce` → all transforms disabled, reveals render instantly visible, only color transitions remain. Content must be fully visible with JavaScript disabled (reveal classes are added by JS, never hidden by default in CSS).

### 5.7 Breakpoints

Tailwind defaults, mobile-first:

| Name | Min width | Target devices | QA widths |
|------|-----------|----------------|-----------|
| base | 0 | Phones | 360, 390 |
| `sm` | 640px | Large phones | 640 |
| `md` | 768px | Tablets portrait | 768 |
| `lg` | 1024px | Tablets landscape, small laptops | 1024 |
| `xl` | 1280px | Laptops / desktops | 1280, 1440 |
| `2xl` | 1536px | Large desktops | 1920 |

Container: `max-w-[1280px]` (token `--container-max: 80rem`) centered, with `gutter` padding. Hero and dark bands are full-bleed; their content aligns to the container.

---

## 6. Layout & grid

- 4 columns on mobile, 8 on `md`, 12 on `lg+`.
- Standard layouts:
  - **Split 6/6** (text + image): About, MetaPlannet intro. Image first on mobile only when the image adds context; otherwise text first.
  - **Split 5/7**: section heading left, content right (Why Chirakkal Group on desktop).
  - **3-up cards**: 1 col → 2 col at `md` (third card spans full or centered) → 3 col at `lg`.
  - **4-up items**: 1 → 2 (`sm`) → 4 (`lg`).
- Section background rhythm on the group home: white → steel-100 → white → charcoal-900 → white → steel-100 → charcoal-900 (CTA) → charcoal-950 (footer). Never two dark bands adjacent except CTA → footer.

---

## 7. Component library

All components live in `src/components/`. They receive **typed props from content**, never hard-coded business copy. Server Components by default; the only client components allowed are marked **(client)**.

### 7.1 Primitives — `src/components/ui/`

| Component | Notes |
|-----------|-------|
| `Button` | Variants: `primary` (copper bg, white label), `secondary` (charcoal outline on light / white outline on dark), `ghost` (text + arrow). Sizes `md` (44px high) and `lg` (52px). Renders `<a>` via `href` prop or `<button>`. Optional leading icon (phone, WhatsApp). Min touch target 44×44. |
| `Container` | Max width + gutters. |
| `Section` | `tone`: `light` \| `subtle` \| `dark`; applies `section-y`, background, text color, and exposes `id` for anchor links. |
| `SectionHeading` | Accent rule + eyebrow + heading (level configurable) + optional lead + optional alignment. |
| `Badge` | `neutral` \| `accent` \| `placeholder` (dashed border, "Placeholder" text — never color-only). |
| `Icon` | Wrapper around `lucide-react` icons with `aria-hidden` by default. Only icons actually used are imported. |
| `SmartImage` | Wraps `next/image`: requires `alt`, sets `sizes`, uses blur placeholder when available, and renders a neutral `steel-100` block with a small icon + "Image to be provided" if `src` is missing or fails to load. Never a broken image. |
| `Breadcrumb` | `<nav aria-label="Breadcrumb">`, ordered list, `aria-current="page"` on last item. Also emits BreadcrumbList JSON-LD. |
| `Accordion` | Native `<details>/<summary>` styled; no JS required. |
| `Modal` **(client)** | Only if required (e.g. image preview). Focus trap, Esc to close, returns focus. Not used in v1 unless a need is recorded in §17. |
| `VisuallyHidden`, `SkipLink` | Accessibility helpers. |

### 7.2 Layout — `src/components/layout/`

| Component | Notes |
|-----------|-------|
| `SiteHeader` | Server shell + `HeaderScrollState` **(client)** that toggles a `data-scrolled` attribute for the compact/sticky state. Height 72px desktop → 64px scrolled; 64px mobile. White background, bottom border appears after scroll. |
| `DesktopNav` | Home · About · Our Businesses (dropdown: Chirakkal Group Scrap & Recycling, MetaPlannet, Chirakkal Traders) · MetaPlannet · Chirakkal Traders · Contact, plus primary CTA **Contact Us**. Shown at `lg+`. Dropdown is keyboard operable (button with `aria-expanded`, Esc closes). |
| `MobileNav` **(client)** | Menu button (`aria-expanded`, `aria-controls`) opens a right-side drawer: nav links (large, 56px rows), the business list with category labels, then a sticky bottom block with **Call** and **WhatsApp** buttons. Focus trapped, Esc closes, body scroll locked, closes on route change. |
| `SiteFooter` | 4 columns (`lg`), 2 (`md`), 1 (mobile): Brand + short description · Businesses · Company (About, Contact, Careers, Privacy Policy) · Contact (phone, email, address). Bottom bar: © {current year} Chirakkal Group. All rights reserved. |
| `DivisionBar` | Thin bar under the header on division pages: division wordmark + "A Chirakkal Group company" link. |
| `MobileContactBar` **(client not needed)** | Fixed bottom bar on mobile (< `md`) with Call / WhatsApp / Enquire, hidden on the contact page. Respects safe-area inset. Page gets bottom padding so content isn't hidden. |

### 7.3 Content blocks — `src/components/blocks/`

| Component | Notes |
|-----------|-------|
| `Hero` | Variants: `home` (full-bleed image, dark overlay `charcoal-900/70` gradient from left, `display` heading), `page` (shorter, `h1`, breadcrumb), `division` (image + division wordmark + endorsement). Image is `priority` and the LCP element. Two CTAs max. |
| `BusinessCard` | Index number, image (4:3), eyebrow category, name (`h3`), description, "Explore" ghost link with arrow. Whole card clickable via a stretched link on the title (one link per card, not nested links). |
| `ProductCategoryCard` | Image (4:3), name, short description, "Applications" list, "Key characteristics" list, **Enquire Now** button (links to `/contact?business=metaplannet&interest=<slug>`), placeholder badge when `status: "placeholder"`. |
| `ImageCard` | Image + caption/title for application galleries. |
| `ValueItem` | Index number, icon, title, one-sentence description. |
| `FeatureList` | Check-style bullet list (icon + text, not color only). |
| `Timeline` | Only rendered if confirmed milestones exist in content. If the list is empty, the section is omitted entirely (never faked). |
| `CtaBand` | Dark band: heading, short line, buttons **Call Us**, **WhatsApp Us**, **Send Enquiry**. |
| `ContactDetails` | Phone, WhatsApp, email, address, map link, business hours — each with icon, label and value; placeholder values are shown as text but links are disabled when the value is a placeholder. |
| `ContactForm` **(client)** | See §12. |
| `Placeholder` | Renders placeholder strings. In development: dashed copper outline + tooltip. In production: plain text (placeholders should not ship; see §18 check). |
| `EmptyState` | "Details coming soon. Contact us for current availability." + Enquire button. Used when a content list is empty. |

---

## 8. Imagery strategy

### 8.1 Rules

- Real company photography (yard, stock, installations, trucks, team at work) is always preferred. Request it from the business (see §18).
- Until provided, use **licensed stock** (Unsplash / Pexels) that is **relevant** to the section, recorded in `content/shared/image-credits.ts` with source URL and licence. Stock must **never be captioned or implied** as the company's own facility, project or team.
- If no suitable image exists, `SmartImage` shows the neutral placeholder. Never use unrelated office/handshake stock.
- All images stored in `public/images/<business>/<section>-<descriptor>.<ext>`, sourced at ≥ 2400px wide for heroes, ≥ 1600px for cards; `next/image` handles AVIF/WebP and responsive sizes.
- Consistent grade: slightly cool, desaturated, natural light. No heavy filters or color overlays beyond the hero overlay.
- Every image has meaningful `alt` text stored in content next to the `src`. Decorative images use `alt=""`.

### 8.2 Aspect ratios

| Use | Ratio |
|-----|-------|
| Home hero | 16:9 desktop, 4:5 crop on mobile (art-directed via `object-position`) |
| Page / division hero | 21:9 desktop, 4:3 mobile |
| Business & product cards | 4:3 |
| Split sections | 4:5 portrait (desktop), 16:10 (mobile) |
| Application tiles | 1:1 |

### 8.3 Per-section image plan

| Page / section | Subject |
|----------------|---------|
| Group home hero | Wide industrial yard / sorted metal stock / warehouse at golden hour — conveys scale and operations |
| Business card — Chirakkal Group | Sorted ferrous/non-ferrous metal scrap, bales or piles |
| Business card — MetaPlannet | Close-up of profiled roofing sheets or a completed metal roof |
| Business card — Chirakkal Traders | Organised warehouse racking / materials ready for dispatch |
| About (group) | Workers/operations in a yard or warehouse (no identifiable faces unless company-owned photo) |
| Why Chirakkal Group | No image — typographic section on light band |
| Scrap & Recycling page hero | Metal recovery / sorting / loading |
| MetaPlannet hero | Commercial or industrial building with metal roof, sky visible |
| MetaPlannet — Roofing Sheets | Stacked colour-coated profile sheets |
| MetaPlannet — Polycarbonate | Translucent polycarbonate roof with daylight coming through |
| MetaPlannet — Accessories | Close-up of roofing screws, ridge caps or flashing |
| MetaPlannet applications | Residential roof · commercial shed · industrial warehouse · covered walkway/carport |
| Chirakkal Traders hero | Warehouse/distribution, loading bay |
| Contact | Optional: building exterior only if the real premises photo is supplied; otherwise no image |

---

## 9. Site map & routes

v1 is a **single Next.js app** that serves all three businesses under one domain, structured so each business can be split into its own app/domain later (Decision D-01).

```text
/                                   Group home
/about                              About Chirakkal Group
/businesses                         Our Businesses overview
/businesses/scrap-recycling         Chirakkal Group — Scrap & Recycling
/metaplannet                        MetaPlannet home
/metaplannet/products               MetaPlannet product categories overview
/metaplannet/products/[category]    roofing-sheets | polycarbonate | accessories
/metaplannet/contact                MetaPlannet enquiry (pre-selects business)
/traders                            Chirakkal Traders home
/traders/contact                    Traders enquiry (pre-selects business)
/contact                            Group contact & enquiry
/careers                            Placeholder page ("No current openings listed. Send your CV to [email to be provided]")
/privacy-policy                     Privacy policy (placeholder text, must be reviewed by the business)
/sitemap.xml, /robots.txt           Generated
```

Header nav labels map to: Home `/` · About `/about` · Our Businesses `/businesses` · MetaPlannet `/metaplannet` · Chirakkal Traders `/traders` · Contact `/contact`.

---

## 10. Page specifications

Each section lists: purpose → content source → layout → CTA.

### 10.1 Group home `/`

1. **Header** (§7.2).
2. **Hero** (`home`): eyebrow "Chirakkal Group"; heading "Building Businesses. / Creating Value." (line break after the full stop on `md+`); lead "Chirakkal Group brings together businesses across scrap, roofing solutions and trading, built on reliability, quality and long-term relationships."; CTAs **Explore Our Businesses** (`#businesses`, primary) and **Contact Us** (`/contact`, secondary on dark). Below the CTAs on `lg+`: a thin row listing the three businesses with categories as text links (reinforces the group structure immediately).
3. **Introduction** (light): split 5/7 — eyebrow "Who we are", `h2` "One group. Three focused businesses.", paragraph from content (placeholder until provided).
4. **Our Businesses** (subtle, `id="businesses"`): SectionHeading "Our Businesses"; 3 × `BusinessCard` (copy in §18 approved copy). Explore links → `/businesses/scrap-recycling`, `/metaplannet`, `/traders`.
5. **Business highlights** (light): for each business, one horizontal strip: category, 3 short capability bullets from content (placeholders where unconfirmed), text link. Stacks on mobile.
6. **Why Chirakkal Group** (dark): split 5/7 — heading left, 4 × `ValueItem` right in 2×2 (Reliability, Quality, Experience, Customer Focus).
7. **About / Company overview** (light): split 6/6 — image left, right: eyebrow, `h2`, approved overview paragraph, 3 key points, **Learn More** → `/about`.
8. **Journey / Timeline**: rendered only when `content/group/timeline.ts` has confirmed entries. Omitted in v1.
9. **Contact CTA** (`CtaBand`).
10. **Footer**.

### 10.2 About `/about`

Page hero with breadcrumb → Company overview (split) → Our approach (3 values) → Group structure diagram (parent card with two child cards connected by 1px lines; on mobile a vertical tree) → Leadership/team **omitted unless provided** → CTA band.

### 10.3 Our Businesses `/businesses`

Page hero → intro line → three large alternating split rows (image/text), each with category, description, highlights, Explore button → CTA band.

### 10.4 Scrap & Recycling `/businesses/scrap-recycling`

Division hero (group branding) → what we do (placeholder description) → materials/areas handled (**placeholder list**, `status: "placeholder"`) → how it works (generic 3-step: Enquire → Assessment → Collection/Trade, each step marked placeholder until the business confirms the process) → why us (shared values) → CTA band with business pre-selected.

### 10.5 MetaPlannet home `/metaplannet`

1. `DivisionBar` + Hero (`division`): eyebrow "MetaPlannet — Roofing Solutions"; heading "Roofing Solutions / Built for Every Space."; lead "Explore roofing sheets, polycarbonate solutions and roofing accessories for residential, commercial and industrial applications."; CTAs **Explore Products** (`/metaplannet/products`) and **Enquire Now**.
2. About MetaPlannet (split, placeholder description).
3. Product categories: 3 × `ProductCategoryCard` summary (Roofing Sheets, Polycarbonate Sheets, Roofing Accessories) → category pages.
4. Applications: 4 × `ImageCard` (Residential, Commercial, Industrial, Covered areas) — application names are generic and allowed; any claim of completed projects is not.
5. Why Choose MetaPlannet: 4 `ValueItem`s (Product range, Guidance on selection, Accessories in one place, Responsive enquiries) — phrased as intent, no numbers.
6. Product/solution highlights: short list per category from content.
7. CTA band (MetaPlannet-specific phone/WhatsApp if provided, else group contact).
8. Footer.

### 10.6 MetaPlannet category page `/metaplannet/products/[category]`

Page hero with breadcrumb (Home › MetaPlannet › Products › {Category}) → category intro → grid of sub-category `ProductCategoryCard`s → "Not sure what you need?" guidance block with Enquire → CTA band.

Sub-categories (all `status: "placeholder"` until confirmed by the business; hidden in production unless `SHOW_UNCONFIRMED_CONTENT=true`, see §11.3):

- Roofing Sheets: Metal Roofing Sheets · Profile Sheets · Corrugated Sheets · Colour Coated Sheets
- Polycarbonate: Polycarbonate Roofing · Skylight Solutions
- Accessories: Roofing Screws · Fasteners · Ridge Caps · Flashings · Sealants

Each card: image, name, short description, Applications, Key characteristics (qualitative only, e.g. "Available in multiple profiles — to be confirmed"; **no specs**), **Enquire Now**.

`generateStaticParams` builds the three categories; unknown slugs → `notFound()`.

### 10.7 Chirakkal Traders `/traders`

`DivisionBar` + Hero: eyebrow "Chirakkal Traders"; heading "Trading and distribution solutions built around reliability."; CTAs **Request Information**, **Contact Us** → About (placeholder) → Product categories (**empty list until supplied** → `EmptyState`) → Services (Trading · Distribution · Sourcing support — each placeholder description) → Business approach (4 values) → Contact block + CTA band.

### 10.8 Contact `/contact` (and division contact pages)

Page hero (short, no image) → two columns (`lg`): left `ContactDetails` + business hours + **Open in Google Maps** link; right `ContactForm`. Division contact pages reuse the same template with the `business` field pre-selected and division contact details if provided. Below: "Which business do you need?" three compact cards linking to division contact pages.

### 10.9 Careers `/careers`, Privacy Policy `/privacy-policy`

Simple text pages from content. Privacy text is a clearly marked placeholder covering the enquiry form data (what is collected, why, how to request deletion) and **must be reviewed by the business** before launch.

### 10.10 System pages

`not-found.tsx` (friendly message + links to home, businesses, contact) and `error.tsx` (friendly message + retry + contact details). Never show stack traces.

---

## 11. Content architecture

### 11.1 Folder layout

```text
content/
  shared/
    company.ts          # legal name, contact channels, hours, social links, address
    navigation.ts       # header + footer nav
    image-credits.ts
  group/
    home.ts
    about.ts
    businesses.ts       # the three business summaries (single source for cards everywhere)
    scrap-recycling.ts
    values.ts
    timeline.ts         # empty array until confirmed
  metaplannet/
    home.ts
    categories.ts       # categories + sub-categories
    applications.ts
    contact.ts          # division-specific contact overrides (optional)
  traders/
    home.ts
    categories.ts       # [] until supplied
    services.ts
    contact.ts
  legal/
    privacy.ts
    careers.ts
```

Content is **typed TypeScript** (`satisfies` the types in `src/types/content.ts`) so mistakes fail the build and the shape maps 1:1 to a future CMS schema.

### 11.2 Core types (shape, not final code)

```ts
type ContentStatus = "confirmed" | "placeholder";

interface ImageAsset { src: string | null; alt: string; credit?: string; }

interface Business {
  slug: "chirakkal-group" | "metaplannet" | "chirakkal-traders";
  name: string; category: string; summary: string;
  href: string; image: ImageAsset; highlights: TextItem[];
}

interface TextItem { text: string; status: ContentStatus; }

interface ProductCategory {
  slug: string; name: string; description: string; image: ImageAsset;
  applications: TextItem[]; characteristics: TextItem[];
  status: ContentStatus; children?: ProductCategory[];
}

interface ContactChannels {
  phone: Placeholderable<string>; whatsapp: Placeholderable<string>;
  email: Placeholderable<string>; address: Placeholderable<string[]>;
  mapUrl: Placeholderable<string>; hours: Placeholderable<string>[];
}
```

### 11.3 Access layer

- UI never imports from `content/` directly. It calls functions in `src/lib/content/` (`getBusinesses()`, `getMetaplannetCategory(slug)`, `getCompanyContact(business?)`…).
- The access layer is the **only** place that decides whether placeholder items are returned: `SHOW_UNCONFIRMED_CONTENT` (default `true` in development, `false` in production). This lets a CMS replace the source later without touching components.
- Access functions return `Result`-style values or `null`; pages handle `null` with `EmptyState` / `notFound()`.

### 11.4 Placeholder convention

- Placeholder text always starts with `[` and ends with `]`: `[MetaPlannet description to be provided]`.
- `isPlaceholder(value)` in `src/lib/content/placeholder.ts`.
- `pnpm check:placeholders` script lists every placeholder string and every `status: "placeholder"` item with file and key. CI prints it; the launch checklist requires it to be empty (or explicitly accepted).

---

## 12. Contact & enquiry system

- **Channels:** `tel:` link, WhatsApp `https://wa.me/<E.164 digits>?text=<url-encoded prefilled message naming the business>`, `mailto:`, Google Maps link (`mapUrl`), business hours. When a value is a placeholder, it is displayed but not linked.
- **Form fields:** Name (required, 2–80 chars) · Phone (required, Indian or international format, 7–15 digits after normalising) · Email (optional **unless** phone is missing — v1: required, see D-06) · Company (optional) · Business (select: Chirakkal Group / MetaPlannet / Chirakkal Traders / Not sure — pre-filled from `?business=`) · Interest (hidden, from `?interest=`) · Message (required, 10–2000 chars) · honeypot field (hidden from users and AT).
- **Validation:** one `zod` schema in `src/lib/enquiry/schema.ts`, shared by client and server. Client validates on blur and on submit; server re-validates always.
- **Submission:** Server Action `submitEnquiry` in `src/app/actions/enquiry.ts` → `src/lib/enquiry/service.ts` (business logic) → `src/lib/enquiry/providers/` (email adapter). Default adapter: Resend REST API via `fetch` (no SDK). A `console` adapter is used when `ENQUIRY_PROVIDER=console` (local dev).
- **Anti-spam:** honeypot + minimum fill time (3s) + simple per-IP rate limit (in-memory, documented as best-effort; swap for Upstash/Vercel KV if needed).
- **States:** idle → submitting (button disabled, spinner + "Sending…") → success (inline panel with icon, "Thank you. We have received your enquiry and will contact you soon." and form reset) or error (inline alert with icon: "We couldn't send your enquiry. Please try again, or call/WhatsApp us." — with the actual links). Field errors appear under each field, linked with `aria-describedby`, and focus moves to the first invalid field. A summary is announced via `aria-live="polite"`.
- Works without JavaScript (progressive enhancement via `<form action={serverAction}>`).
- Never log full personal data in production logs; log a request ID and error class only.

---

## 13. SEO

- Metadata via the App Router `metadata` / `generateMetadata` API, built by `src/lib/seo/buildMetadata()` so every page has: unique `title` (template `%s | Chirakkal Group`; division pages `%s | MetaPlannet — Chirakkal Group`), meta description (≤ 160 chars, human-written in content), `alternates.canonical`, Open Graph (title, description, url, siteName, locale `en_IN`, image 1200×630), Twitter `summary_large_image`.
- `metadataBase` from `NEXT_PUBLIC_SITE_URL`.
- `app/sitemap.ts` and `app/robots.ts`. In non-production environments `robots` disallows all.
- Structured data (JSON-LD via a `JsonLd` server component):
  - `Organization` for Chirakkal Group with `subOrganization` → MetaPlannet, Chirakkal Traders; each division page emits its own `Organization` with `parentOrganization`.
  - `WebSite` on home.
  - `BreadcrumbList` on every non-home page.
  - `LocalBusiness` **only** after a real address and phone are confirmed.
  - No `Product`/`Offer` schema (no prices, not e-commerce). No `Review`/`AggregateRating`.
- Semantic landmarks: `header`, `nav`, `main`, `footer`, `section` with headings.
- OG images: static per page type in `public/og/`, or `opengraph-image.tsx` with the brand layout.

---

## 14. Performance budget

| Metric | Target (mobile, 4G, mid-tier device) |
|--------|---------------------------------------|
| LCP | < 2.0s |
| CLS | < 0.05 |
| INP | < 150ms |
| First-load JS per route | < 110 KB gzipped |
| Lighthouse Performance / A11y / Best Practices / SEO | ≥ 95 / 100 / 100 / 100 |

Rules: all pages statically generated; client components limited to those marked in §7; hero image `priority` + correct `sizes`; all other images lazy; fonts via `next/font` (self-hosted, no layout shift); no animation, carousel, or UI-kit libraries; allowed runtime deps: `next`, `react`, `react-dom`, `zod`, `lucide-react`, `clsx`. Any addition must be recorded in §17 with a reason.

---

## 15. Accessibility (WCAG 2.2 AA)

- Skip link to `#main` as the first focusable element.
- Visible focus: 2px `copper-600` outline with 2px white offset (on dark: `copper-400`). Never remove outlines.
- All interactive targets ≥ 44×44 CSS px.
- Keyboard: full navigation, dropdown and drawer operable by keyboard; Esc closes; focus returns to the trigger.
- Forms: visible `<label>` for every field, required marked with text "(required)" not only `*`, errors with icon + text, `aria-invalid`, `aria-describedby`, `autocomplete` attributes (`name`, `tel`, `email`, `organization`).
- Color never the only signal (badges have text, errors have icons + text, active nav has underline).
- Images: meaningful alt; decorative `alt=""`; no text baked into images.
- `lang="en-IN"` on `<html>`.
- Reduced motion respected (§5.6).
- Automated check: `@axe-core/playwright` on every route at mobile and desktop widths — zero violations.

---

## 16. Error handling

| Case | Behaviour |
|------|-----------|
| Form validation | Inline field errors + summary; no submission. |
| Form server/provider failure | Generic friendly error + alternative contact links; error logged server-side with request ID. |
| Network failure (client) | Same friendly error; form data preserved. |
| Rate limit / spam | Friendly "Please wait a moment and try again." |
| Content missing (null / empty list) | `EmptyState` or section omitted; page never crashes. |
| Unknown route / category | `notFound()` → custom 404. |
| Unexpected render error | Route `error.tsx` with retry + contact details; `global-error.tsx` as last resort. |
| Missing / failed image | `SmartImage` neutral placeholder. |
| Missing env var | Validated at startup in `src/lib/env.ts` (zod); build fails with a clear message in production for required vars. |
| Future CMS error | Access layer catches, logs, returns `null` → handled as "content missing". |

Users never see raw error messages, codes, or stack traces.

---

## 17. Decision log

| ID | Decision | Reason |
|----|----------|--------|
| D-01 | v1 is a single Next.js (App Router, TypeScript strict) app. Code is organised so it can become `apps/{group,metaplannet,traders}` + `packages/{ui,config,utils,seo}` without rewrites: `src/components/ui` → `packages/ui`, `src/lib/seo` → `packages/seo`, `src/lib/utils` → `packages/utils`, `content/<business>` stays per app. | Brief allows single app first; avoids monorepo overhead before separate domains are needed. |
| D-02 | Tailwind CSS v4 with CSS-first `@theme` tokens. | Tokens in one file, no config sprawl. |
| D-03 | Accent color: copper `#C2410C`. | Industrial/metal reference, distinct from generic corporate blue, AA-compliant. |
| D-04 | Light theme only in v1. | Corporate info site; dark bands give contrast; halves QA surface. |
| D-05 | Fonts: Archivo (display) + Inter (body). | Industrial grotesk headings, highly readable body. |
| D-06 | Email is required in v1 enquiry form. | Needed for reply by the provider; revisit if the business prefers phone-only. |
| D-07 | Package manager: pnpm. Node LTS. | Fast, strict, monorepo-ready. |
| D-08 | Unconfirmed content hidden in production by default (`SHOW_UNCONFIRMED_CONTENT=false`). | Prevents presenting unconfirmed products as fact. |

Agents append new decisions here (next ID) instead of silently deviating.

---

## 18. Placeholder register

### 18.1 Approved copy (from the brief — may be used as-is)

- Hero: "Building Businesses. Creating Value." / "Chirakkal Group brings together businesses across scrap, roofing solutions and trading, built on reliability, quality and long-term relationships."
- Business cards:
  - Chirakkal Group — Scrap & Recycling — "Focused on scrap, metal recovery and related trading activities."
  - MetaPlannet — Roofing Solutions — "Roofing sheets, polycarbonate solutions and roofing accessories."
  - Chirakkal Traders — Trading & Distribution — "Trading and distribution of selected materials and products."
- About: "Chirakkal Group is a growing business group with operations across multiple sectors. Our businesses are built around quality, reliability and long-term relationships."
- Values: Reliability — "Building long-term relationships through dependable service." · Quality — "Focused on maintaining consistent standards across our businesses." · Experience — "Practical business knowledge across different industries." · Customer Focus — "Understanding customer requirements and delivering suitable solutions."
- MetaPlannet hero: "Roofing Solutions Built for Every Space." / "Explore roofing sheets, polycarbonate solutions and roofing accessories for residential, commercial and industrial applications."
- Chirakkal Traders positioning: "Trading and distribution solutions built around reliability."

### 18.2 Must be supplied by the business owner

| # | Item | Used on |
|---|------|---------|
| P-01 | Logo files (SVG) for Chirakkal Group, MetaPlannet, Chirakkal Traders | Header, footer, OG images, favicon |
| P-02 | Registered/legal company names | Footer, privacy policy, structured data |
| P-03 | Group company description (2–3 paragraphs) | Home intro, About |
| P-04 | Phone number(s) — group and per division | Header drawer, contact, CTA bands, footer |
| P-05 | WhatsApp number(s) | Same as above |
| P-06 | Email address(es) — public and enquiry recipient | Contact, footer, `CONTACT_TO_EMAIL` |
| P-07 | Full postal address(es) | Contact, footer, LocalBusiness schema |
| P-08 | Google Maps link | Contact |
| P-09 | Business hours | Contact |
| P-10 | Scrap & Recycling: materials handled, services, process | `/businesses/scrap-recycling` |
| P-11 | MetaPlannet: description | MetaPlannet home |
| P-12 | MetaPlannet: confirmed product categories and sub-categories | Products pages |
| P-13 | MetaPlannet: applications and qualitative characteristics per product (specs only if officially provided) | Product cards |
| P-14 | Chirakkal Traders: description, product categories, services | Traders pages |
| P-15 | Real photography (yard, stock, products, installations, premises) | All image slots in §8.3 |
| P-16 | Timeline/milestones (optional) | Home timeline, About |
| P-17 | Careers information / CV email | `/careers` |
| P-18 | Privacy policy review/approval | `/privacy-policy` |
| P-19 | Production domain(s) | `NEXT_PUBLIC_SITE_URL`, canonical URLs |
| P-20 | Social media profiles (optional) | Footer, `sameAs` in schema |

`PLACEHOLDERS.md` in the project root is the live version of this table, maintained by the `content-architect` agent.

---

## 19. Build stages & exit criteria

| Stage | Scope | Lead agent(s) | Exit criteria |
|-------|-------|---------------|---------------|
| 1 | Project scaffold, tokens, fonts, primitives, header, mobile nav, footer, `Section`/`Container`, content types + access layer, env validation | `design-system-architect`, `content-architect` | `pnpm lint`, `pnpm typecheck`, `pnpm build` pass; `/` renders header + footer at all breakpoints; token-only styling |
| 2 | Group home (§10.1) | `group-site-builder` | All sections implemented from content; CTA links work |
| 3 | About, Businesses, Scrap & Recycling, Careers, Privacy | `group-site-builder` | Breadcrumbs, metadata stubs |
| 4 | MetaPlannet home + products + category pages | `metaplannet-builder` | Placeholder gating works; Enquire Now pre-fills contact |
| 5 | Chirakkal Traders pages | `traders-builder` | EmptyState for missing categories |
| 6 | Contact pages, form, server action, provider adapter | `enquiry-engineer` | Validation, success, error, no-JS, rate-limit paths tested |
| 7 | SEO, a11y, performance | `seo-performance-engineer`, `accessibility-auditor` | Metadata/sitemap/robots/JSON-LD on all routes; axe zero violations; budgets in §14 met |
| 8 | Responsive QA + docs | `qa-reviewer`, `docs-writer` | Screenshots at every QA width reviewed; README/setup/env/content/deploy docs; final placeholder list |

After **every** stage: `content-guardian` reviews the diff for invented facts and banned claims before commit.
