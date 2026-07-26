# Instruction Load Matrix

Version: 1.0  
Status: Mandatory for AI agents  
Location: `docs/instruction/`

Always start with `AI_MASTER_GUIDE.md`, then load **only** the files listed for the task.  
Use these filenames only — do not invent others.

---

## Allowed files

| File | Use when |
|------|----------|
| `AI_MASTER_GUIDE.md` | Every task |
| `DEFINITION_OF_DONE.md` | Every task — sole pre-merge checklist |
| `ARCHITECTURE.md` | New feature, structure, MVVM, DI, folders |
| `API_STANDARDS.md` | HTTP, ApiClient, auth, errors, retries |
| `THEME.md` | UI, styles, reusable widgets, a11y |
| `TESTING_GUIDE.md` | Tests, TDD, coverage |
| `DATABASE.md` | Offline-first, Sembast, sync, migrations |
| `INDEX.md` | Load matrix / canonical names |

---

## Load matrix (task → exact files)

| Task type | Exact files to load |
|-----------|---------------------|
| **Login** (or any auth / new feature with API + UI) | `AI_MASTER_GUIDE.md` · `DEFINITION_OF_DONE.md` · `ARCHITECTURE.md` · `API_STANDARDS.md` · `THEME.md` · `TESTING_GUIDE.md` |
| **Bug fix** (API / errors / behaviour) | `AI_MASTER_GUIDE.md` · `DEFINITION_OF_DONE.md` · `API_STANDARDS.md` · `TESTING_GUIDE.md` |
| **UI** (screen / theme / widgets only) | `AI_MASTER_GUIDE.md` · `DEFINITION_OF_DONE.md` · `THEME.md` |
| **Offline** (local DB / sync / Sembast) | `AI_MASTER_GUIDE.md` · `DEFINITION_OF_DONE.md` · `ARCHITECTURE.md` · `DATABASE.md` · `TESTING_GUIDE.md` |

---

## Quick copy lists

### Login

```text
AI_MASTER_GUIDE.md
DEFINITION_OF_DONE.md
ARCHITECTURE.md
API_STANDARDS.md
THEME.md
TESTING_GUIDE.md
```

### Bug fix

```text
AI_MASTER_GUIDE.md
DEFINITION_OF_DONE.md
API_STANDARDS.md
TESTING_GUIDE.md
```

### UI

```text
AI_MASTER_GUIDE.md
DEFINITION_OF_DONE.md
THEME.md
```

### Offline

```text
AI_MASTER_GUIDE.md
DEFINITION_OF_DONE.md
ARCHITECTURE.md
DATABASE.md
TESTING_GUIDE.md
```

---

## Canonical names (do not invent aliases)

| Concept | Canonical name |
|---------|----------------|
| Auth / request interceptor | `AuthInterceptor` |
| Text style tokens | `AppTextStyles` |
| Text field widget | `AppTextField` |

---

## Notes

- If a task spans types (e.g. offline login), **union** the file lists — still no invented docs.
- `AI_MASTER_GUIDE.md` wins on conflict unless architecture decisions explicitly override.
- Do not load every instruction file by default.
