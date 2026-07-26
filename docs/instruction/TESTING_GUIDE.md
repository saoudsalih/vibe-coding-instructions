# Flutter Testing & TDD Standards

Version: 1.0

Architecture:
- Feature First
- MVVM
- Provider
- GetIt
- package:http

---

# Purpose

This document defines the testing standards for the Flutter application.

Goals

- Prevent regressions
- Improve code quality
- Enable safe refactoring
- Increase confidence before release
- Ensure all business logic is testable

---

# Testing Pyramid

              Integration Test
                    ▲
             Widget Test
                    ▲
              Unit Test

Always write more Unit Tests than Widget Tests.

Widget Tests should be fewer.

Integration Tests should only cover critical user journeys.

---

# Test Coverage Standard

| Layer | Required | Target |
|---------|----------|---------|
| Model | Optional | 0-20% |
| Repository | Mandatory | 90%+ |
| ViewModel | Mandatory | 90%+ |
| Validator | Mandatory | 100% |
| Utility | Mandatory | 100% |
| Widget | Recommended | Important Screens |
| Integration | Recommended | Critical Flow |

---

# TDD Cycle

Follow Red → Green → Refactor

Step 1

Write a failing test.

Step 2

Implement the smallest amount of code.

Step 3

Run tests.

Step 4

Refactor.

Never write large features before writing tests.

---

# Folder Structure

test/

core/

features/

authentication/

repository/

viewmodel/

widget/

products/

orders/

---

# Naming Convention

login_repository_test.dart

login_viewmodel_test.dart

product_repository_test.dart

validator_test.dart

api_client_test.dart

---

# Test Rules

Every new feature MUST include

✔ Repository Test

✔ ViewModel Test

Recommended

✔ Widget Test

Critical Features

✔ Integration Test

---

# Repository Testing

Repository tests verify

- API mapping
- Error mapping
- JSON parsing
- Cache logic
- Offline logic

Repository should never call real APIs.

Always mock ApiClient.

Example

Repository

↓

Mock ApiClient

↓

Fake Response

↓

Verify Model

---

# Repository Test Example

Given

Login API returns 200.

When

login()

Then

Return UserModel.

---

Given

API returns 401.

When

login()

Then

Throw UnauthorizedException.

---

Given

Network unavailable.

When

login()

Then

Throw NetworkException.

---

# ViewModel Testing

Never test UI inside ViewModel tests.

Test only

Loading

Error

Success

Repository calls

notifyListeners()

---

Example

Given

Repository returns User.

When

login()

Then

loading == false

user != null

error == null

---

Example

Given

Repository throws NetworkException.

When

login()

Then

error == "No Internet"

loading == false

---

Verify

Repository.login()

called exactly once.

---

# Widget Testing

Widget Tests verify

UI

Navigation

Loading

Buttons

Error Widget

---

Do NOT test

API

Database

Business Logic

---

Example

Tap Login Button

↓

Loading Indicator Visible

↓

Success Message Visible

---

# Integration Testing

Only critical flows.

Examples

Login

Checkout

Payment

Sync

Logout

---

Example

Launch App

↓

Login

↓

Dashboard

↓

Logout

---

# Mocking Rules

Never call

Real API

Real Database

Real Secure Storage

Always mock

Repository

ApiClient

Storage

Connectivity

---

Recommended

mocktail

or

mockito

---

# Fake Data

Use fake models.

Never use production data.

Example

User

Id = 1

Name = Test User

Email = test@example.com

---

# Test Data Builder

Avoid duplicated fake objects.

Create builders.

Example

FakeUserBuilder

FakeProductBuilder

FakeOrderBuilder

---

# Validator Testing

Every validator requires tests.

Examples

Email

Password

Phone

GST

Pin Code

Quantity

Price

---

Example

Given

abc@test.com

Expect

Valid

---

Given

abc

Expect

Invalid

---

# Utility Testing

Test

Date Formatter

Currency Formatter

Extension Methods

Calculator

Tax

Discount

Percentage

---

Coverage Target

100%

---

# Exception Testing

Every custom exception requires tests.

Examples

NetworkException

UnauthorizedException

ValidationException

ServerException

UnknownException

---

# Retry Testing

Verify

Retries 3 times.

Stops after success.

Throws after final retry.

Does not retry

400

401

403

404

---

# Interceptor Testing

Verify

Authorization header added.

Language header added.

Request ID added.

Logs generated.

Refresh Token called on 401.

---

# API Client Testing

Verify

GET

POST

PUT

DELETE

Timeout

Error Mapping

Status Code Mapping

---

# Provider Testing

Never test Provider directly.

Test ViewModel behaviour.

Provider only exposes ViewModel.

---

# Performance Testing

Verify

No duplicate API calls.

Pagination loads correctly.

No unnecessary loading state.

---

# Golden Tests

Recommended

Login Screen

Dashboard

Invoice Screen

Reports

Dark Theme

Light Theme

---

# Smoke Test

Before Release

App Launch

Login

Dashboard

Create Item

Edit Item

Delete Item

Logout

---

# Regression Test

Whenever fixing a bug

1.

Write a failing test.

2.

Fix bug.

3.

Run test.

Bug must never return.

---

# Continuous Integration

Every Pull Request must

Run flutter analyze

Run flutter test

Fail build if any test fails.

---

# Code Coverage

Minimum

80%

Recommended

90%

Critical Modules

95%

---

# AI Coding Rules

Whenever AI generates a feature

AI must also generate

Repository Test

ViewModel Test

Validator Test

If requested

Generate Widget Test.

---

# Do

✔ Test business logic

✔ Mock dependencies

✔ Keep tests independent

✔ One assertion per behaviour

✔ Small readable tests

✔ Arrange Act Assert pattern

✔ Test failure scenarios

✔ Test success scenarios

---

# Don't

❌ Test Flutter SDK

❌ Test package:http

❌ Test Provider package

❌ Call real API

❌ Depend on execution order

❌ Duplicate fake data

❌ Write huge test methods

---

# Checklist

Before merging, complete the single shared checklist (testing notes apply):

→ **`DEFINITION_OF_DONE.md`**

Do not maintain a separate testing checklist here.

---

# Testing Workflow

Developer

↓

Write Test

↓

Run Test

↓

Fail

↓

Implement Feature

↓

Run Test

↓

Pass

↓

Refactor

↓

Run Test

↓

Commit

↓

CI

↓

Merge