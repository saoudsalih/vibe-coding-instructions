---
description: Run one build stage (1-8) of the Chirakkal Group website using the project subagents
argument-hint: <stage number 1-8>
---

Run **Stage $ARGUMENTS** of the Chirakkal Group website build defined in `DESIGN.md` §19.

1. Read `CLAUDE.md` and `DESIGN.md` §19. Confirm the previous stages are complete (check `git log` and that the files they deliver exist). If a previous stage is missing, stop and say which one.
2. Dispatch the subagents for this stage with the Agent tool. Give each one the stage number, the exact DESIGN.md sections it owns and a summary of what earlier stages produced:

   | Stage | Agents (run in order; agents on the same line can run in parallel) |
   |-------|------|
   | 1 | `design-system-architect`, then `content-architect` (fills content and access layer, check-placeholders script) |
   | 2 | `group-site-builder` (home) |
   | 3 | `group-site-builder` (about, businesses, scrap-recycling, careers, privacy, error pages) |
   | 4 | `metaplannet-builder` |
   | 5 | `traders-builder` |
   | 6 | `enquiry-engineer` |
   | 7 | `seo-performance-engineer` and `accessibility-auditor` (parallel, then re-run the checks) |
   | 8 | `qa-reviewer`, then `docs-writer` |

   If a builder reports that it needs new content fields, dispatch `content-architect` to add them, then send the result back to the builder.
3. Run `pnpm lint && pnpm typecheck && pnpm test && pnpm build` yourself (and `pnpm test:e2e` from Stage 6 on). Send failures back to the responsible agent until everything passes.
4. Dispatch `content-guardian`. If it returns **CHANGES REQUIRED**, send the findings to the responsible agent, then re-run the guardian until it returns **APPROVED**.
5. Commit with the message `feat(stage-$ARGUMENTS): <summary>`. Push only if the user asked for it.
6. Report to the user: what was built, the check results, the guardian verdict, new or remaining placeholders (from `pnpm check:placeholders`), any decisions added to DESIGN.md §17, and the next stage.
