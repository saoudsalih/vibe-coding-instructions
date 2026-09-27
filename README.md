# vibe_coding_test

A Flutter project developed with vibe coding.

## Instruction pack

All development rules for AI agents live in **`docs/instruction/`** (not under `lib/`).

| Start here | Purpose |
|------------|---------|
| [`docs/instruction/INDEX.md`](docs/instruction/INDEX.md) | Load matrix (task → files) |
| [`docs/instruction/AI_MASTER_GUIDE.md`](docs/instruction/AI_MASTER_GUIDE.md) | Mandatory master rules |
| [`docs/instruction/DEFINITION_OF_DONE.md`](docs/instruction/DEFINITION_OF_DONE.md) | Sole pre-merge checklist |

`lib/` is reserved for application code only.

## Agent clone

`.claude/agents/saoud-clone.md` is a Claude Code subagent that acts as the project owner. It loads the instruction pack, builds features using the workflow, and closes every task with the Definition of Done. Example prompt:

```text
Use the saoud-clone agent to implement the login module from docs/instruction/modules/login/.
```
