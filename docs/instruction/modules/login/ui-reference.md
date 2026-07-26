# Login — UI Reference

Parent: [`LOGIN_MODULE.md`](LOGIN_MODULE.md)

Design asset: [`ui_reference.png`](ui_reference.png)  
Acceptance: [`acceptance-test.md`](acceptance-test.md)

---

## Screen: `LoginView` (tablet landscape)

Split layout:

| Region | Content |
|--------|---------|
| Left (~40%) | Branding panel — logo, “COMPANY”, product name, illustration, slogan |
| Right (~60%) | White form card — welcome, email, password, remember me, forgot password, LOGIN, OR, biometrics stub, contact admin |

### Branding (left)

- Logo mark (hexagonal “E”)
- **COMPANY** / Enterprise Management System
- Slogan: Manage. Track. Succeed.
- Supporting copy under slogan
- Version `1.0.0` bottom-right of screen

### Form (right)

- Title: Welcome Back
- Subtitle: Please login to continue
- Email field with mail icon (value example: `admin@test.com`)
- Password field with lock + visibility toggle
- Remember Me checkbox + Forgot Password? link
- Primary **LOGIN** button
- OR divider
- Outlined “Login with Biometrics” (UI only — biometric auth out of module scope)
- “Don't have an account? Contact Administrator”

### Theme cues from mock

- Primary blue ≈ `#0052FF`
- Clean white form card, soft blue-tinted background
- Use `AppColors` / `AppTextStyles` / `AppSpacing` / `AppRadius` only

### States to support

| State | Behaviour |
|-------|-----------|
| Idle | Form editable |
| Invalid fields | Inline field errors; no API call |
| Loading | Overlay / button loading; block duplicate submit |
| API error | Localized message; loading off |
| Success | Navigate to dashboard; tokens stored |

---

## Out of scope (shown in mock, not implemented)

- Real biometric authentication
- Registration / contact-admin backend
- Forgot-password flow (navigation stub only)
