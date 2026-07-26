# Instruction Folder Review — Vibe Coding Validation

Version: 1.0  
Date: 2026-07-26  
Status: Review complete

---

## Documents Found

| File | Role | Status |
|------|------|--------|
| `AI_MASTER_GUIDE.md` | Single source of truth / mandatory rules | Strong |
| `DEFINITION_OF_DONE.md` | Sole pre-merge / agent exit checklist | Active |
| `INDEX.md` | Load matrix + canonical names | Active |
| `ARCHITECTURE.md` | Feature-First + MVVM structure | Strong |
| `API_STANDARDS.md` | HTTP / ApiClient / errors | Strong |
| `DATABASE.md` | Sembast offline-first | Strong |
| `THEME.md` | UI tokens + reusable widgets | Strong |
| `TESTING_GUIDE.md` | TDD + coverage pyramid | Strong |
| `REVIEW.md` | This review | Active |

---

## Vibe Coding Prerequisites Checklist

Use this before feeding tasks to an AI agent. Items marked **FAIL** block reliable vibe coding today.

### A. Instruction pack (docs)

| # | Prerequisite | Result | Notes |
|---|--------------|--------|-------|
| A1 | Master rules document exists | PASS | `AI_MASTER_GUIDE.md` |
| A2 | Architecture document exists | PASS | `ARCHITECTURE.md` |
| A3 | API standards exist | PASS | `API_STANDARDS.md` |
| A4 | Theme standards exist | PASS | `Theme.md` |
| A5 | Testing standards exist | PASS | `TESTING_GUIDE.md` |
| A6 | Database standards exist | PASS | `DATABASE.md` |
| A7 | Doc names match what master guide tells AI to load | FAIL | Guide references `common_rules.md`, `feature_first.md`, `mvvm.md`, etc. — those files do not exist |
| A8 | Terminology consistent across docs | PASS | Canonical: `AuthInterceptor`, `AppTextStyles` |
| A9 | Priority / conflict rule clear | PASS | Master guide wins unless architecture overrides |
| A10 | Selective loading guidance exists | PARTIAL | Examples exist but point at missing filenames |

### B. Project scaffold (codebase)

| # | Prerequisite | Result | Notes |
|---|--------------|--------|-------|
| B1 | `lib/app/`, `lib/core/`, `lib/features/` exist | FAIL | Only `lib/main.dart` (instruction pack is under `docs/instruction/`) |
| B2 | Stack packages in `pubspec.yaml` | FAIL | Missing `provider`, `get_it`, `http`, `shared_preferences`, `flutter_secure_storage`, `sembast`, `mocktail` |
| B3 | Core stubs (`ApiClient`, `BaseViewModel`, theme, DI) | FAIL | Not scaffolded |
| B4 | Reusable widget stubs | FAIL | Documented but not implemented |
| B5 | Localization setup (`AppLocalizations`) | FAIL | Required by docs, not set up |
| B6 | `flutter analyze` / `flutter test` baseline | PARTIAL | Default Flutter template only |

### C. Agent feeding (process)

| # | Prerequisite | Result | Notes |
|---|--------------|--------|-------|
| C1 | README with sample prompts | FIXED | See root `README.md` |
| C2 | Cursor rule / AGENTS.md pointing at instruction pack | MISSING | Recommended |
| C3 | Task prompt template (load docs → implement → checklist) | FIXED | See root `README.md` |
| C4 | Definition of Done usable as agent exit criteria | PASS | Single shared `DEFINITION_OF_DONE.md`; other docs link to it |

**Overall vibe-coding readiness: NOT READY** until A7, A8, B1–B5 are fixed.

---

## Checklist Validation (Definition of Done)

**Status: consolidated.** One shared checklist lives in `DEFINITION_OF_DONE.md`.

- `AI_MASTER_GUIDE.md`, `ARCHITECTURE.md`, `API_STANDARDS.md`, `THEME.md`, `TESTING_GUIDE.md`, and `DATABASE.md` link to it — they do not keep their own `[ ]` lists.
- Conditional sections cover Always / API / UI / Offline + testing notes.
- Agents must paste the filled applicable sections before marking a task complete.

---

## Cross-Document Issues (must fix)

### 1. Broken load paths in master guide

`AI_MASTER_GUIDE.md` tells agents to read:

- `common_rules.md` → should be `AI_MASTER_GUIDE.md`
- `feature_first.md` / `mvvm.md` / `provider.md` → fold into `ARCHITECTURE.md`
- `api_integration.md` → `API_STANDARDS.md`
- `theme.md` → `Theme.md` (or rename file to `THEME.md`)
- `testing_tdd.md` → `TESTING_GUIDE.md`
- `error_handling.md` / `widgets.md` → missing; extract sections or merge into existing docs

### 2. Naming conflicts

| Topic | Canonical name | Status |
|-------|----------------|--------|
| Auth layer | `AuthInterceptor` | Synced across docs |
| Text styles | `AppTextStyles` | Synced across docs |
| Theme filename | `THEME.md` | Prefer this casing in all references |

### 3. Policy tension

- Master guide forbids project-root `utils/` but also says extract “Utility”. Clarify: allow `lib/core/utils/` (or `lib/core/helpers/`) — forbid only root-level dumping grounds.
- Architecture forbids root `providers/` / `models/` — good; keep that.
- Theme requires localisation; master DoD includes it — good. Scaffold l10n early or AI will hardcode strings.

### 4. Stack vs empty project

Docs mandate Provider + GetIt + http + Secure Storage + SharedPreferences + Sembast. `pubspec.yaml` has none of these. **Bootstrap scaffold before feature vibe coding**, or every prompt will invent inconsistent core APIs.

---

## Other Suggestions

### Instruction pack improvements

1. Add `INDEX.md` (or update master “Usage”) with a **load matrix**: task type → exact file list (real filenames only).
2. Keep each doc under a hard token budget for agents (~short “MUST” sections at top; long examples optional).
3. Add a one-page `SCAFFOLD.md`: exact folders + stub class names the AI must not reinvent.
4. Add Cursor rule: “Always load `AI_MASTER_GUIDE.md` first; never invent architecture.”
5. ~~Move `lib/instruction/` to `docs/instruction/`~~ Done.

### Vibe coding process improvements

1. **Two-phase prompts**: (1) scaffold / plan, (2) implement feature — do not ask for a full feature on an empty `lib/`.
2. **Scope one feature per prompt** with explicit acceptance criteria copied from the unified checklist.
3. **Require output order**: Models → Repository → ViewModel → Widgets → View → Tests → DI/routes.
4. **Forbid inventing** `ApiClient` / theme APIs if stubs already exist; if missing, create stubs in `core/` first.
5. **Always attach** only the docs needed for the task (avoid dumping all six files every time).

### Quality gates

1. CI: `flutter analyze` + `flutter test` on every PR (already in testing guide).
2. Agent exit: paste filled checklist in the PR/description.
3. Prefer `mocktail` for new tests (lighter than codegen).

---

## Priority Fix Order

1. ~~Fix master guide filenames + Auth/TextStyle naming.~~ Done.
2. Add packages + generate `lib/app`, `lib/core`, `lib/features` stubs.
3. Add Cursor/AGENTS rule + use sample prompts in root `README.md`.
4. ~~Align all merge checklists to the unified list above.~~ Done — `DEFINITION_OF_DONE.md`.
5. Then vibe-code the first real feature (e.g. Login).
