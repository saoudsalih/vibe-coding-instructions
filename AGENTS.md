# Agent guide

All development rules live in [`docs/instruction/`](docs/instruction/).

1. Always read [`docs/instruction/AI_MASTER_GUIDE.md`](docs/instruction/AI_MASTER_GUIDE.md) first.
2. Use [`docs/instruction/INDEX.md`](docs/instruction/INDEX.md) to load only the files your task needs.
3. Finish with the filled checklist from [`docs/instruction/DEFINITION_OF_DONE.md`](docs/instruction/DEFINITION_OF_DONE.md).

`lib/` is for application code only.

## Owner clone agent

`.claude/agents/saoud-clone.md` is a Claude Code subagent that works like the project owner.
Invoke it with e.g. *"Use the saoud-clone agent to build the login module."*
