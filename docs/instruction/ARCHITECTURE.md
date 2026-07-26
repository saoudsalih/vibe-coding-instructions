# Flutter Enterprise Architecture Rules
Version: 1.0

## Tech Stack

- Flutter (latest stable)
- Dart
- Feature-First Architecture
- MVVM
- Provider (ChangeNotifier)
- GetIt (Dependency Injection)
- package:http
- SharedPreferences
- Flutter Secure Storage

---

# 1. Architecture Rules

## MUST

- Use Feature-First architecture.
- Every feature is independent.
- Every feature contains its own View, ViewModel, Repository, Model and Widgets.
- Business logic belongs in ViewModel.
- Data access belongs in Repository.
- UI must never call HTTP directly.
- UI must never parse JSON.
- Repository must never update UI.
- Never use global variables.
- Register dependencies only through GetIt.
- All API requests must go through ApiClient.

---

# 2. Folder Structure

lib/

app/
core/
features/

Never create:

screens/
providers/
models/

at project root.

---

# 3. Feature Structure

features/

authentication/

model/

repository/

view/

viewmodel/

widgets/

Every feature must follow this structure.

---

# 4. View Rules

View responsibilities

✔ Display UI

✔ Receive user input

✔ Navigation

Never

❌ HTTP

❌ JSON

❌ Database

❌ Business Logic

---

# 5. ViewModel Rules

Responsible for

✔ Loading

✔ Validation

✔ Repository Calls

✔ UI State

✔ notifyListeners()

Never

❌ HTTP Requests

❌ SQL

❌ Widget creation

---

# 6. Repository Rules

Responsible for

✔ API

✔ Database

✔ Cache

Never

❌ SnackBar

❌ Dialog

❌ UI

---

# 7. API Rules

Only ApiClient can use package:http.

No Repository may directly call:

http.get()

http.post()

---

# 8. Interceptor Rules

Every request passes through AuthInterceptor.

Responsibilities

✔ Authorization Token

✔ Device Id

✔ Language

✔ Logging

✔ Retry

✔ Refresh Token

---

# 9. Retry Rules

Retry only

SocketException

TimeoutException

502

503

504

Never Retry

400

401

403

404

Maximum Retry

3

---

# 10. Error Handling

Only AppException classes.

Never throw String.

Create

AppException

NetworkException

ValidationException

UnauthorizedException

ServerException

UnknownException

---

# 11. BaseViewModel

Every ViewModel extends BaseViewModel.

Contains

isLoading

errorMessage

notifyError()

setLoading()

clearError()

---

# 12. Loading Rules

Never show CircularProgressIndicator directly.

Use

LoadingOverlay

LoadingWidget

---

# 13. Theme Rules

Never hardcode

Color

Font

Padding

BorderRadius

Always use

AppTheme

AppColors

AppTextStyles

Spacing

---

# 14. Widget Rules

Reusable widgets

PrimaryButton

SecondaryButton

AppTextField

LoadingWidget

ErrorView

EmptyView

ConfirmationDialog

AppCard

---

# 15. Form Rules

Validation must use

Validator class

Never validate inside widgets.

---

# 16. Navigation Rules

No Navigator.push()

Use NavigationService.

---

# 17. Storage Rules

SharedPreferences

↓

Settings

FlutterSecureStorage

↓

Token

Password

---

# 18. Logging Rules

Debug

Print Request

Print Response

Print Error

Release

Disable logs

---

# 19. Naming Rules

LoginView

LoginViewModel

LoginRepository

LoginModel

ProductView

OrderViewModel

Always suffix correctly.

---

# 20. Provider Rules

One Provider per screen or feature.

Never

AppProvider

GlobalProvider

---

# 21. Performance Rules

Use const widgets.

Use Consumer only where needed.

Split large widgets.

Lazy load lists.

Avoid unnecessary notifyListeners().

---

# 22. Dependency Injection

registerLazySingleton()

Repositories

Services

ApiClient

registerFactory()

ViewModels

---

# 23. Offline Rules

Repository decides

API

↓

Cache

↓

Local Database

UI never knows.

---

# 24. Security Rules

Never store JWT in SharedPreferences.

Use Secure Storage.

Hide API Keys.

Do not print tokens.

---

# 25. Testing Rules

Repository

Mock API

ViewModel

Mock Repository

No API during tests.

---

# 26. Do

✔ Small ViewModels

✔ Small Widgets

✔ Single Responsibility

✔ Feature Isolation

✔ Common Theme

✔ Common Error Handling

---

# 27. Don't

❌ HTTP in UI

❌ SQL in ViewModel

❌ Business Logic in Widgets

❌ Hardcoded Colors

❌ Duplicate Widgets

❌ Global Providers

❌ Multiple responsibilities in one class

---

# 28. Login Flow

View

↓

ViewModel

↓

Repository

↓

ApiClient

↓

AuthInterceptor

↓

Server

↓

Response

↓

Repository

↓

ViewModel

↓

notifyListeners()

↓

View

---

# 29. Feature Checklist

Before merging, complete the single shared checklist:

→ **`DEFINITION_OF_DONE.md`**

Do not maintain a separate feature checklist here.

---

# 30. AI Coding Rules

Whenever generating Flutter code:

- Follow Feature-First architecture.
- Follow MVVM.
- Use Provider.
- Use GetIt.
- Use package:http only through ApiClient.
- Use BaseViewModel.
- Extend AppException for errors.
- Use shared theme.
- Create reusable widgets.
- Avoid duplicate code.
- Follow SOLID principles.
- Keep files under ~300 lines where practical.
- Keep widgets under ~200 lines where practical.
- Keep ViewModels focused on a single feature.