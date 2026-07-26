# Definition of Done

Version: 1.0  
Status: Mandatory — single shared checklist  
Location: `docs/instruction/DEFINITION_OF_DONE.md`

This is the **only** pre-merge / feature-complete checklist.  
Do not maintain separate checklists in other instruction docs.  
Other docs must link here.

A feature or change is done only when every applicable item below is checked.

---

## Always required

```text
[ ] Feature-First folders (model / repository / view / viewmodel / widgets as needed)
[ ] Model + Repository + ViewModel + View (layers that apply to the change)
[ ] GetIt registration (factory ViewModel; lazy singleton Repository / services)
[ ] Provider wired for the screen / feature
[ ] Routes / NavigationService updated (if navigation changed)
[ ] Error handling via AppException + user-friendly messages
[ ] Loading via LoadingWidget / LoadingOverlay (no ad-hoc spinners)
[ ] Validation in validators / ViewModel (not in widgets)
[ ] Localisation ready (no hardcoded UI strings)
[ ] Accessibility reviewed (48dp targets, semantics, contrast)
[ ] Repository + ViewModel unit tests (+ Validator when present)
[ ] flutter analyze clean
[ ] flutter test green
[ ] No warnings
[ ] No untracked TODOs
[ ] No secrets committed
```

---

## When API is involved

```text
[ ] Endpoint(s) added via ApiClient only (no raw http in feature)
[ ] Request + Response models created
[ ] Error mapping completed
[ ] Retry + timeout verified where required
[ ] AuthInterceptor path verified (token / refresh) where required
[ ] No hardcoded base URLs
[ ] Logging verified (no tokens / PII in logs)
```

---

## When UI is involved

```text
[ ] Theme tokens only (AppColors / AppTextStyles / AppSpacing / AppRadius / AppTheme)
[ ] Reusable widgets used (buttons, AppTextField, AppCard, etc.)
[ ] No hardcoded colours, inline TextStyle, or magic spacing
[ ] Dark mode supported
[ ] Responsive layout verified
```

---

## When offline / database is involved

```text
[ ] Sembast store created for the feature
[ ] Access only via DatabaseService → Repository
[ ] CRUD complete
[ ] Soft delete + syncStatus (or project equivalent)
[ ] Model mapping complete (no Map returned from Repository)
[ ] Migration reviewed
[ ] Backup considered if data is critical
```

---

## Testing notes

- Repository, ViewModel, and Validators: **mandatory** unit tests.
- Widget tests: recommended for important screens.
- Integration tests: recommended for critical user journeys.
- Cover success, error, loading, and retry paths when those behaviours exist.

---

## Agent exit criteria

Before marking a task complete, paste the filled applicable sections of this checklist in the PR or response.
