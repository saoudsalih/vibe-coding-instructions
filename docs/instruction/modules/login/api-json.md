# Login — API JSON

Parent: [`LOGIN_MODULE.md`](LOGIN_MODULE.md)

Source of truth for Dart models: [`models.md`](models.md)  
Sample request: [`curl.md`](curl.md) / [`login.curl`](login.curl)

---

## Endpoint

`POST /v1/auth/login`

Base URL: `https://api.company.com` (see `ApiConstants`)

---

## Request body

```json
{
  "email": "admin@test.com",
  "password": "123456"
}
```

| Field | Type | Required | Notes |
|-------|------|----------|--------|
| `email` | string | yes | Email format |
| `password` | string | yes | Never logged or persisted |

`rememberMe` is UI-only (SharedPreferences for email hint). It is **not** sent to the API.

---

## Success response (`200`)

```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "userId": 1,
    "name": "Administrator",
    "email": "admin@test.com",
    "role": "Admin",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
    "refreshToken": "refresh_token_123",
    "expiresIn": 3600
  }
}
```

Maps to: `LoginResponse` → `UserModel` + `AuthTokens` ([`models.md`](models.md)).

---

## Invalid credentials

```json
{
  "success": false,
  "message": "Invalid username or password"
}
```

Maps to: `UnauthorizedException` (typically HTTP `401`).

---

## Validation error (`400` / `422`)

```json
{
  "success": false,
  "message": "Validation Failed",
  "errors": {
    "email": [
      "Email is required"
    ]
  }
}
```

Maps to: `ValidationException`.
