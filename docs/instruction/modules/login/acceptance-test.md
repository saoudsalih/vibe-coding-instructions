# Login — Acceptance Tests

Parent: [`LOGIN_MODULE.md`](LOGIN_MODULE.md)

Complete the shared checklist in **`DEFINITION_OF_DONE.md`** before merge.

---

## Acceptance criteria

- [ ] Valid credentials navigate to the dashboard
- [ ] Invalid fields prevent the API request
- [ ] Invalid credentials show a localized message
- [ ] Multiple taps do not create duplicate requests
- [ ] Loading always stops after success or failure
- [ ] Tokens are stored securely (Flutter Secure Storage)
- [ ] Passwords and tokens never appear in logs
- [ ] Existing valid sessions bypass the login screen
- [ ] Expired sessions attempt refresh or return to login
- [ ] Repository and ViewModel tests pass
- [ ] `flutter analyze` clean
- [ ] `flutter test` green

---

## Validation scenarios

| # | Given | When | Then |
|---|--------|------|------|
| V1 | Empty email and password | Tap Login | Show field errors; **no** API call |
| V2 | Invalid email format | Tap Login | Show email error; **no** API call |
| V3 | Empty password | Tap Login | Show password error; **no** API call |
| V4 | Valid email + password | Tap Login | Validation passes; API called once |

---

## API / behaviour scenarios

| # | Given | When | Then |
|---|--------|------|------|
| A1 | API returns 200 + tokens + user | Login | Tokens saved; navigate to dashboard; loading off |
| A2 | API returns 401 | Login | Localized invalid-credentials message; loading off |
| A3 | API returns 400 / 422 | Login | Localized validation message; loading off |
| A4 | Offline / timeout | Login | Localized network message; loading off |
| A5 | API returns 500 | Login | Localized server message; loading off |
| A6 | User taps Login twice quickly | Login | Only **one** API request |
| A7 | Valid session already stored | App launch | Skip login; open dashboard |
| A8 | Access token expired; refresh succeeds | Authenticated call | Refresh once; retry original request |
| A9 | Refresh fails | Authenticated call | Clear session; navigate to `LoginView` |
| A10 | Logout | User logs out | Tokens cleared; navigate to `LoginView` |

---

## Mandatory automated tests

### Validator

- Email required / invalid / valid
- Password required / min-max length

### Repository (mock `ApiClient`)

- Success → returns `UserModel` / auth result
- 401 → `UnauthorizedException`
- Network unavailable → `NetworkException`
- Maps JSON → models (no raw `Map` returned)

### ViewModel (mock repository)

- Success → `isLoading == false`, user set, error cleared
- Failure → `isLoading == false`, error message set
- Invalid form → repository **not** called
- Repository.login called exactly once on valid submit

---

## Recommended tests

- `LoginView` widget: fields, button, loading, error visible
- Integration: launch → login → dashboard → logout
- Session restore smoke test
- Token refresh interceptor test
- Duplicate-submit prevention

---

## Test rules

- Never call real API, real DB, or real secure storage in unit tests
- Use mocktail (or project mock library)
- Cover success, error, loading, and retry paths where they exist
