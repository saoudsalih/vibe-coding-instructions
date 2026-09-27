# Chirakkal Group Website — Agent Rules

This folder is the project root for the Chirakkal Group corporate website (Next.js + TypeScript + Tailwind CSS).
Run Claude Code **from this folder** so the agents in `.claude/agents/` and the `/stage` command are available.

## Source of truth

1. `DESIGN.md`: design system, pages, content rules, architecture, stages. Read the sections relevant to your task before writing code.
2. `PLACEHOLDERS.md`: the list of business information still missing.
3. This file: working rules.

If code, a request or your own judgement conflicts with `DESIGN.md` §3 (content rules), §3 wins.

## Hard rules

- **Never invent business facts.** No history, years, counts, certifications, awards, clients, projects, testimonials, locations, product specs or superlatives. Use `[... to be provided]` placeholders and `status: "placeholder"`, then add the item to `PLACEHOLDERS.md`.
- **No e-commerce.** No cart, checkout, prices, stock, accounts or payments.
- **Content lives in `content/`**, accessed only through `src/lib/content/`. Components receive props; no business copy is hard-coded in components.
- **Design tokens only.** No raw hex values or arbitrary pixel values in components. Tokens live in `src/styles/globals.css`.
- **Server Components by default.** Client components are allowed only where `DESIGN.md` §7 marks them **(client)**.
- **Dependencies:** only those allowed in `DESIGN.md` §14. Adding one requires a new entry in `DESIGN.md` §17.
- **Spelling:** MetaPlannet (double n), Chirakkal Group, Chirakkal Traders.
- No secrets in code. Use env vars validated in `src/lib/env.ts` and documented in `.env.example`.
- Users never see raw errors.

## Commands (after Stage 1 scaffold)

```bash
pnpm dev                 # local dev
pnpm lint                # ESLint
pnpm typecheck           # tsc --noEmit
pnpm test                # unit tests (Vitest)
pnpm test:e2e            # Playwright + axe (responsive + a11y)
pnpm build               # production build
pnpm check:placeholders  # list remaining placeholder content
```

A stage is complete only when `lint`, `typecheck`, `test` and `build` pass and `content-guardian` has approved the diff.

## Orchestration

Subagents cannot start other subagents, so the main session runs the build: `/stage <n>` dispatches the right agents for a stage (see `.claude/commands/stage.md`), then runs `content-guardian`, then commits.

| Agent | Role |
|-------|------|
| `design-system-architect` | Stage 1: scaffold, tokens, fonts, primitives, layout shell |
| `content-architect` | Content types, `content/` files, access layer, placeholder register |
| `group-site-builder` | Stages 2–3: group home, about, businesses, scrap & recycling, careers, privacy |
| `metaplannet-builder` | Stage 4: MetaPlannet pages |
| `traders-builder` | Stage 5: Chirakkal Traders pages |
| `enquiry-engineer` | Stage 6: contact pages, form, server action, email provider |
| `seo-performance-engineer` | Stage 7: metadata, sitemap, robots, JSON-LD, performance budget |
| `accessibility-auditor` | Stage 7: WCAG 2.2 AA audit and fixes |
| `qa-reviewer` | Stage 8: responsive QA with Playwright screenshots, final checks |
| `docs-writer` | Stage 8: README, setup, env, content editing, deployment docs |
| `content-guardian` | After every stage: read-only review for invented facts and banned claims |
