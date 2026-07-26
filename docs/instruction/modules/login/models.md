# Login — Models (from payload + response)

Parent: [`LOGIN_MODULE.md`](LOGIN_MODULE.md)

Source of truth: [`api-json.md`](api-json.md) · verify with [`curl.md`](curl.md)

Models are derived **only** from the actual request payload and API response.
Do not invent fields the API does not return.

---

## Reuse first

Before creating any class, search the codebase and reuse what exists.

```bash
rg "class (UserModel|AuthTokens|LoginRequest|LoginResponse)" lib/
rg -l "model" lib/features lib/core
```

Decision rule:

| Situation | Action |
|-----------|--------|
| Class already exists and matches the payload | **Reuse it** — import, do not duplicate |
| Class exists but is missing a field | Extend the existing class (add nullable field) |
| Class exists in another feature and is shared (e.g. `UserModel`) | Move to a shared location, then reuse |
| No matching class | Create it in `lib/features/authentication/model/` |

Never create `LoginUserModel`, `UserModel2`, or a near-duplicate of an existing model.

---

## Field mapping

### Request payload → `LoginRequest`

Payload from [`api-json.md`](api-json.md):

```json
{
  "email": "user@example.com",
  "password": "example-password"
}
```

| JSON key | Dart field | Type | Required |
|----------|------------|------|----------|
| `email` | `email` | `String` | Yes |
| `password` | `password` | `String` | Yes |

Request models need `toJson()` only.

### Response `data` → `AuthTokens`

| JSON key | Dart field | Type | Required |
|----------|------------|------|----------|
| `accessToken` | `accessToken` | `String` | Yes |
| `refreshToken` | `refreshToken` | `String` | Yes |
| `expiresIn` | `expiresIn` | `int?` | No |

### Response `data.user` → `UserModel`

| JSON key | Dart field | Type | Required |
|----------|------------|------|----------|
| `id` | `id` | `String` | Yes |
| `name` | `name` | `String` | Yes |
| `email` | `email` | `String` | Yes |

### Envelope → `LoginResponse`

| JSON key | Dart field | Type |
|----------|------------|------|
| `success` | `success` | `bool` |
| `message` | `message` | `String` |
| `data` | `tokens` | `AuthTokens` |
| `data.user` | `user` | `UserModel` |

Response models need `fromJson()`; add `copyWith()` only where state is updated.

---

## Reference implementations

Use these shapes only if the class does not already exist.

### `login_request.dart`

```dart
class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
```

### `auth_tokens.dart`

```dart
class AuthTokens {
  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    this.expiresIn,
  });

  final String accessToken;
  final String refreshToken;
  final int? expiresIn;

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as int?,
    );
  }
}
```

### `user_model.dart`

Shared across features — check for an existing `UserModel` before adding this.

```dart
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
```

### `login_response.dart`

```dart
class LoginResponse {
  const LoginResponse({
    required this.success,
    required this.message,
    required this.tokens,
    required this.user,
  });

  final bool success;
  final String message;
  final AuthTokens tokens;
  final UserModel user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return LoginResponse(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String? ?? '',
      tokens: AuthTokens.fromJson(data),
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
    );
  }
}
```

---

## Rules

- Typed models only — repository never returns `Map`, `Response`, or `dynamic`
- Parsing happens in the repository layer, never in ViewModel or UI
- Every model field must exist in [`api-json.md`](api-json.md)
- Nullable in JSON → nullable in Dart
- Do not store `password` on any persisted model
- Path for new auth models: `lib/features/authentication/model/`

---

## Naming

| File | Class |
|------|--------|
| `login_request.dart` | `LoginRequest` |
| `login_response.dart` | `LoginResponse` |
| `auth_tokens.dart` | `AuthTokens` |
| `user_model.dart` | `UserModel` |
