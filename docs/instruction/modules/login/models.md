# Login — Models

Parent: [`LOGIN_MODULE.md`](LOGIN_MODULE.md)

JSON samples: [`api-json.md`](api-json.md)  
Request sample: [`curl.md`](curl.md)

Reuse existing shared models first. Create feature models only when missing.

---

## Dart mapping

| JSON / concern | Dart class | File |
|----------------|------------|------|
| Request body `{ email, password }` | `LoginRequest` | `login_request.dart` |
| Envelope `{ success, message, data, errors? }` | `LoginResponse` | `login_response.dart` |
| `data.token` / `refreshToken` / `expiresIn` | `AuthTokens` | `auth_tokens.dart` |
| `data.userId` / `name` / `email` / `role` | `UserModel` | `user_model.dart` |

---

## Success Response

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

## Invalid Password

```json
{
  "success": false,
  "message": "Invalid username or password"
}
```

## Validation Error

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
