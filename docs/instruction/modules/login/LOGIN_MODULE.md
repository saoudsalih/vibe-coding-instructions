# Login Module

Reference specification for the authentication / login feature.

## Instruction pack (load first)

- `AI_MASTER_GUIDE.md`
- `DEFINITION_OF_DONE.md`
- `ARCHITECTURE.md`
- `API_STANDARDS.md`
- `THEME.md`
- `TESTING_GUIDE.md`

## Module references

| File | Purpose |
|------|---------|
| [`acceptance-test.md`](acceptance-test.md) | Acceptance criteria and test scenarios |
| [`api-json.md`](api-json.md) | Request / response JSON samples |
| [`curl.md`](curl.md) | Sample `curl` commands |
| [`models.md`](models.md) | Models derived from payload / response (reuse existing classes first) |
| [`ui-reference.md`](ui-reference.md) | Design images for each screen and state |
| [`images/`](images/) | Design image assets referenced by `ui-reference.md` |

## Goal

Allow registered users to authenticate securely and navigate to the dashboard.

## Scope

### Included

- Email/username and password login
- Input validation
- Loading and error states
- Access and refresh token storage
- Automatic token refresh
- Session restoration
- Logout
- Navigation to dashboard
- Forgot-password navigation (if supported)

### Not included

- Registration
- Social login
- Biometric login
- Multi-factor authentication

## User flow

1. User opens `LoginView`.
2. User enters email and password.
3. `LoginViewModel` validates the fields.
4. `LoginRepository` sends the request through `ApiClient`.
5. On success: store tokens in Flutter Secure Storage → load user → navigate to dashboard.
6. On failure: stop loading → show localized error.
7. Never log or persist the password.

```text
LoginView → LoginViewModel → LoginRepository → ApiClient → AuthInterceptor → Server
```

## Folder structure

```text
lib/features/authentication/
├── model/
│   ├── login_request.dart
│   ├── login_response.dart
│   ├── auth_tokens.dart
│   └── user_model.dart
├── repository/
│   └── login_repository.dart
├── view/
│   └── login_view.dart
├── viewmodel/
│   └── login_viewmodel.dart
├── validation/
│   └── login_validator.dart
└── widgets/
    └── login_form.dart
```

## Dependency injection

| Type | Registration |
|------|----------------|
| `LoginRepository` | `registerLazySingleton()` |
| `LoginViewModel` | `registerFactory()` |

Wire with a feature-level Provider (no global `AppProvider`).

## Session and security

- Tokens only in Flutter Secure Storage (never SharedPreferences / Sembast)
- Never store the password
- Never log credentials, tokens, or PII
- HTTPS only in production
- `AuthInterceptor` attaches tokens to authenticated requests
- Failed refresh → clear session → `LoginView`
- Prevent concurrent refresh requests

## Navigation

```text
LoginView → DashboardView
```

Use `NavigationService`. Block back navigation to login after auth.

## Open questions

Resolved from module pack (`api-json.md`, `curl.md`, `models.md`, `ui-reference.md`):

- [x] Login endpoint and HTTP method — `POST /v1/auth/login`
- [x] Exact request and response JSON — [`api-json.md`](api-json.md) / [`models.md`](models.md)
- [x] Email-only vs username login — email
- [x] Password validation rules — required; min 6 (matches sample `123456`)
- [x] Token expiration and refresh behaviour — `expiresIn` + refresh token; failed refresh → login
- [x] Dashboard route — `DashboardView` via `NavigationService`
- [x] Forgot-password / registration — navigation stubs only (out of scope)
- [x] Remember-session behaviour — Remember Me stores email hint; tokens in secure storage restore session
- [x] Design / mockup — [`ui-reference.md`](ui-reference.md) / [`ui_reference.png`](ui_reference.png)
- [x] Required languages (l10n) — English strings via `AppStrings` (extensible)
- [x] MFA, CAPTCHA, or biometric — not in scope; biometrics button is UI-only

Before merge: complete **`DEFINITION_OF_DONE.md`**.
