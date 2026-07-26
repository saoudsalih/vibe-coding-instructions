# Master Development Rules

Version: 1.0

Status: Mandatory

Location: `docs/instruction/`

Applies To

- Every Flutter module
- Every feature
- Every screen
- Every API
- Every widget
- Every repository
- Every ViewModel
- Every AI-generated code

---

# Purpose

This document is the single source of truth for Flutter development.

Every feature, bug fix, enhancement, and refactoring MUST follow these rules.

If another document conflicts with this document, this document takes priority unless explicitly overridden by project architecture decisions.

---

# Technology Stack

Flutter (Latest Stable)

Dart

Feature First Architecture

MVVM

Provider

GetIt

package:http

SharedPreferences

Flutter Secure Storage

---

# Architecture

Mandatory Architecture

Feature First

↓

MVVM

↓

Repository Pattern

↓

Provider

↓

GetIt

↓

package:http

Never replace architecture without team approval.

---

# SOLID Principles

Every class should follow SOLID.

S

Single Responsibility

One class

One responsibility.

O

Open Closed

Extend behaviour.

Avoid modifying existing code.

L

Liskov

Derived classes must behave like base classes.

I

Interface Segregation

Create focused interfaces.

D

Dependency Inversion

Depend on abstractions.

Use GetIt for dependency injection.

---

# DRY Principle

Don't Repeat Yourself.

If logic appears more than once

Extract

Widget

Utility

Extension

Service

Repository

Validator

---

# KISS Principle

Keep It Simple.

Prefer

Simple code

Readable code

Small classes

Avoid unnecessary abstractions.

---

# YAGNI Principle

You Aren't Going To Need It.

Do not implement future features until required.

Avoid unnecessary complexity.

---

# Folder Rules

Allowed

lib/

app/

core/

features/

Forbidden

screens/

helpers/

misc/

utils/

at project root.

---

# Feature Rules

Each feature owns

Model

Repository

View

ViewModel

Widgets

Routes

Validation

Never share feature-specific code globally.

---

# File Size Rules

Target limits:

Widget

< 200 lines

ViewModel

< 300 lines

Repository

< 250 lines

Utility

< 200 lines

Split large files.

---

# Class Rules

One class

One responsibility.

Avoid God classes.

Avoid utility classes with unrelated methods.

---

# Widget Rules

Widgets should be

Small

Reusable

Stateless where possible

Use Consumer/Selector only where state changes.

Avoid large build methods.

---

# Build Method Rules

Never write

500-line build()

Extract

Header

Body

Footer

Card

List Item

Dialog

---

# MVVM Rules

View

UI only.

ViewModel

Business logic.

Repository

Data access.

Model

Data representation.

Never mix responsibilities.

---

# Provider Rules

One ViewModel per feature/screen.

Do not create global providers.

Use

Consumer

Selector

context.read()

context.watch()

appropriately.

Avoid unnecessary rebuilds.

---

# Dependency Injection Rules

All dependencies registered in

app/injection.dart

Repositories

registerLazySingleton()

Services

registerLazySingleton()

ViewModels

registerFactory()

Never instantiate dependencies directly inside Widgets.

---

# API Rules

Only ApiClient communicates with package:http.

Repositories call ApiClient.

ViewModels call Repository.

Views call ViewModel.

---

# Repository Rules

Repository returns

Model

List<Model>

Result<Model>

Never return

Map

Response

dynamic

---

# Error Handling Rules

Throw only AppException.

Never throw String.

Never expose raw server errors directly to users.

Convert technical errors into user-friendly messages.

---

# Logging Rules

Debug

Log request

Log response

Log duration

Log errors

Release

Disable logs

Never log

Passwords

Tokens

Personal information

---

# Theme Rules

Use only

AppTheme

AppColors

AppTextStyles

AppSpacing

AppRadius

Never hardcode

Colours

Font sizes

Padding

Margins

Border radius

---

# Reusable Widget Rules

Always reuse

PrimaryButton

SecondaryButton

AppTextField

LoadingWidget

ErrorView

EmptyView

AppCard

ConfirmationDialog

Avoid duplicate UI components.

---

# Navigation Rules

Use NavigationService or centralised routing.

Never scatter route names throughout the codebase.

---

# Local Storage Rules

SharedPreferences

Application settings

FlutterSecureStorage

Authentication

Sensitive values

Never store passwords in plain text.

---

# Validation Rules

Validation belongs in

Validator classes

Never inside Widgets.

---

# Naming Convention

Screens

LoginView

DashboardView

Repositories

LoginRepository

ViewModels

LoginViewModel

Models

UserModel

Widgets

PrimaryButton

AppTextField

Use meaningful names.

---

# State Management Rules

Keep state immutable where practical.

Update only changed state.

Avoid unnecessary notifyListeners().

Split state if ViewModel becomes too large.

---

# Async Rules

Always use async/await.

Avoid nested Future chains.

Handle exceptions.

Support cancellation where applicable.

---

# Performance Rules

Use const constructors.

Extract reusable Widgets.

Use ListView.builder.

Use cached images.

Avoid rebuilding entire screens.

Profile before optimising.

---

# Security Rules

HTTPS only.

Use Secure Storage.

Never hardcode secrets.

Never print credentials.

Sanitise user input.

Validate server responses.

---

# Accessibility Rules

Minimum touch target

48x48

Support text scaling.

Semantic labels.

Readable contrast.

Keyboard accessibility where applicable.

---

# Localisation Rules

No hardcoded UI strings.

Use AppLocalizations.

Support RTL where required.

---

# Testing Rules

Every feature should include

Repository tests

ViewModel tests

Validator tests

Critical features

Widget tests

Integration tests

---

# Git Rules

Small commits.

Meaningful commit messages.

Do not commit generated files unless required.

Do not commit secrets.

---

# Code Review Checklist

Verify against `DEFINITION_OF_DONE.md` (single shared checklist).

Also consider: duplicated code, performance, security.

---

# AI Code Generation Rules

Whenever AI generates code

It MUST

Use Feature First.

Follow MVVM.

Use Provider.

Use GetIt.

Use Repository Pattern.

Use ApiClient.

Use AppException.

Use shared theme.

Use reusable widgets.

Generate null-safe code.

Follow Dart formatting.

Keep classes focused.

Avoid duplicate code.

Generate comments only where they add value.

---

# AI Review Rules

When reviewing code

Verify

Architecture

Naming

Performance

Memory usage

Rebuilds

Security

Error handling

Testing

Accessibility

Localisation

If violations exist

Explain

Issue

Impact

Recommended Fix

---

# Feature Development Workflow

Requirement

↓

Read AI_MASTER_GUIDE.md

↓

Read task-specific docs (ARCHITECTURE.md, API_STANDARDS.md, THEME.md, TESTING_GUIDE.md, DATABASE.md)

↓

Design models

↓

Implement Repository

↓

Implement ViewModel

↓

Build reusable Widgets

↓

Create View

↓

Write tests

↓

Run analyse

↓

Run tests

↓

Complete DEFINITION_OF_DONE.md

↓

Code review

↓

Merge

---

# Definition of Done

Use the single shared checklist:

→ **`DEFINITION_OF_DONE.md`**

Do not maintain a second checklist in this file.

---

# Do

✔ Keep code simple

✔ Keep classes small

✔ Use dependency injection

✔ Write reusable code

✔ Follow architecture

✔ Test business logic

✔ Review before merging

---

# Don't

❌ API calls in Widgets

❌ Business logic in UI

❌ Hardcoded styles

❌ Duplicate code

❌ Global mutable state

❌ Direct dependency creation

❌ Large ViewModels

❌ Ignoring exceptions

❌ Committing untested code

---

# Usage

Always load this document first (`AI_MASTER_GUIDE.md`).

Then use `INDEX.md` for the one-page load matrix (task type → exact files).

Load only the files listed for the task. Real filenames only:

- AI_MASTER_GUIDE.md
- DEFINITION_OF_DONE.md
- ARCHITECTURE.md
- API_STANDARDS.md
- THEME.md
- TESTING_GUIDE.md
- DATABASE.md
- INDEX.md

## Load matrix

| Task type | Exact files |
|-----------|-------------|
| Login | AI_MASTER_GUIDE.md, DEFINITION_OF_DONE.md, ARCHITECTURE.md, API_STANDARDS.md, THEME.md, TESTING_GUIDE.md |
| Bug fix | AI_MASTER_GUIDE.md, DEFINITION_OF_DONE.md, API_STANDARDS.md, TESTING_GUIDE.md |
| UI | AI_MASTER_GUIDE.md, DEFINITION_OF_DONE.md, THEME.md |
| Offline | AI_MASTER_GUIDE.md, DEFINITION_OF_DONE.md, ARCHITECTURE.md, DATABASE.md, TESTING_GUIDE.md |

## Canonical names

| Concept | Name |
|---------|------|
| Auth / request interceptor | AuthInterceptor |
| Text style tokens | AppTextStyles |

Definition of Done (sole checklist): `DEFINITION_OF_DONE.md`.  
Full matrix and copy-paste lists: `INDEX.md`.

This document is mandatory for every development task.