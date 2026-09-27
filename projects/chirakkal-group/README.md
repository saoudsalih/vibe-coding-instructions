# Chirakkal Group Website: Build Kit

This is the design specification and Claude Code agent team for building the Chirakkal Group corporate website (Chirakkal Group → MetaPlannet, Chirakkal Traders) with Next.js, TypeScript and Tailwind CSS.

| File | Purpose |
|------|---------|
| [`DESIGN.md`](DESIGN.md) | Design system, page specs, content rules, architecture, SEO/perf/a11y targets, build stages |
| [`CLAUDE.md`](CLAUDE.md) | Rules every agent follows |
| [`PLACEHOLDERS.md`](PLACEHOLDERS.md) | Business information that still has to be supplied |
| [`.claude/agents/`](.claude/agents) | 11 specialised subagents |
| [`.claude/commands/stage.md`](.claude/commands/stage.md) | `/stage <1-8>` runs one build stage end to end |

## How to build the site

The Next.js app is generated **inside this folder**, so this folder becomes the project root. You can also copy it into a new repository first.

```bash
cd projects/chirakkal-group
claude
```

Then run the stages in order and review each one before moving on:

```text
/stage 1   Design system + global layout (scaffold, tokens, header, footer, content layer)
/stage 2   Chirakkal Group homepage
/stage 3   About + business pages
/stage 4   MetaPlannet pages
/stage 5   Chirakkal Traders pages
/stage 6   Contact + enquiry system
/stage 7   SEO, accessibility, performance
/stage 8   Responsive QA + final documentation
```

Each stage runs its builder agent(s), then the checks (`lint`, `typecheck`, `test`, `build`), then a `content-guardian` review for invented facts, and then commits.

## Agents

| Agent | Stage | Writes code |
|-------|-------|-------------|
| `design-system-architect` | 1 | yes |
| `content-architect` | 1 (and whenever content changes) | yes |
| `group-site-builder` | 2–3 | yes |
| `metaplannet-builder` | 4 | yes |
| `traders-builder` | 5 | yes |
| `enquiry-engineer` | 6 | yes |
| `seo-performance-engineer` | 7 | yes |
| `accessibility-auditor` | 7 | yes (fixes) |
| `qa-reviewer` | 8 | fixes small layout bugs only |
| `docs-writer` | 8 | docs only |
| `content-guardian` | after every stage | no (read-only) |

## Before launch

Every item in `PLACEHOLDERS.md` must be supplied or explicitly accepted, and `pnpm check:placeholders` must be clean.
