# API Integration Standards

Version: 1.0

Architecture

- Feature First
- MVVM
- Provider
- GetIt
- package:http

---

# Purpose

This document defines the API integration standards for the application.

Goals

- Centralise all HTTP requests.
- Keep UI independent from networking.
- Make API layer reusable.
- Ensure consistent error handling.
- Support authentication.
- Support retry strategy.
- Support future offline capability.

---

# Architecture Flow

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

HTTP Client

↓

REST API

↓

Response

↓

Repository

↓

ViewModel

↓

UI

---

# Folder Structure

core/

api/

├── api_client.dart
├── auth_client.dart
├── api_exception.dart
├── api_response.dart
├── retry_client.dart
├── api_constants.dart
├── api_logger.dart
└── network_checker.dart

Never create HTTP logic inside features.

---

# Responsibilities

## View

Responsible

✔ Display data

✔ User interaction

Never

❌ HTTP Request

❌ JSON Parsing

❌ Headers

❌ Retry

---

## ViewModel

Responsible

✔ Loading

✔ Validation

✔ Calling Repository

✔ UI State

Never

❌ HTTP

❌ JSON

❌ Authentication

---

## Repository

Responsible

✔ Call ApiClient

✔ Convert JSON → Model

✔ Business mapping

✔ Cache

Never

❌ SnackBar

❌ Dialog

❌ Widget

---

## ApiClient

Responsible

✔ GET

✔ POST

✔ PUT

✔ PATCH

✔ DELETE

✔ Multipart Upload

✔ Download

✔ Timeout

✔ Status Code Mapping

✔ Error Mapping

Never

❌ Business Logic

---

# HTTP Package

Only

package:http

is allowed.

Never

http.get()

inside Repository.

Always

ApiClient.get()

---

# Base URL

Store in

api_constants.dart

Example

Base URL

API Version

Timeout

Headers

Never hardcode URLs.

---

# Request Flow

Repository

↓

ApiClient

↓

AuthInterceptor

↓

HTTP Client

↓

Server

---

# Response Flow

Server

↓

HTTP Client

↓

ApiClient

↓

Repository

↓

Model

↓

ViewModel

↓

UI

---

# Request Headers

Every request must include

Accept

Content-Type

App-Version

Platform

Language

Timezone

Request-ID

Authorization (if required)

---

# Authentication

Authentication handled only inside

AuthInterceptor

Never

Repository

ViewModel

UI

---

# Token Rules

Read token from

Secure Storage

Never

SharedPreferences

Never print token in logs.

---

# Refresh Token

Flow

401

↓

Refresh Token

↓

Save Token

↓

Retry Original Request

↓

Return Response

If refresh fails

↓

Logout

↓

Navigate Login

---

# HTTP Methods

GET

Read data

POST

Create

PUT

Replace

PATCH

Partial Update

DELETE

Remove

Use proper HTTP methods.

---

# Timeout

Default

30 Seconds

Throw

NetworkException

after timeout.

---

# Retry Rules

Retry only

SocketException

TimeoutException

502

503

504

Maximum

3 Attempts

Backoff

1 sec

2 sec

4 sec

Never Retry

400

401

403

404

422

---

# Error Mapping

200

Success

201

Created

204

No Content

400

ValidationException

401

UnauthorizedException

403

ForbiddenException

404

NotFoundException

409

ConflictException

422

ValidationException

429

RateLimitException

500

ServerException

503

ServerUnavailableException

Default

UnknownException

---

# API Response Format

Preferred

{
  "success": true,
  "message": "",
  "data": {}
}

Error

{
  "success": false,
  "message": "Invalid Login",
  "errors": {}
}

---

# JSON Parsing

Repository converts

JSON

↓

Model

Never parse JSON

inside UI

or

ViewModel

---

# Multipart Upload

ApiClient handles

Image Upload

Document Upload

Audio Upload

Never duplicate upload logic.

---

# File Download

Centralise download

Progress

Permission

Storage

Error Handling

---

# Pagination

ApiClient supports

Page

Limit

Offset

Cursor

Repository returns

Paginated Result

Never implement pagination inside UI.

---

# Search

Repository accepts

Keyword

Filter

Sort

ApiClient builds query parameters.

---

# Logging

Debug Only

Request URL

Method

Headers

Body

Response Code

Response Time

Error

Release

Disable logging

Never log

Password

Token

OTP

Personal Information

---

# Network Checking

Always verify

Internet

before API call.

Throw

NetworkException

if offline.

---

# SSL

HTTPS only.

Never allow HTTP in production.

Support SSL Pinning if required.

---

# Certificate Handling

Production

Strict validation

Development

Optional self-signed

---

# API Versioning

Store version centrally.

Example

v1

v2

Never hardcode.

---

# Repository Rules

Repository only calls

ApiClient

Repository returns

Model

List<Model>

Result<Model>

Never return

Response

Map

JSON

---

# Model Rules

Every API has

Request Model

Response Model

No dynamic maps.

---

# Exception Rules

Throw only

AppException

Examples

NetworkException

UnauthorizedException

ValidationException

ServerException

UnknownException

---

# Offline Ready

Repository decides

API

↓

Cache

↓

Database

UI never knows.

---

# Loading

ViewModel controls loading.

ApiClient never controls UI.

---

# Security

Never

Hardcode API Key

Hardcode Token

Print Credentials

Store Password in Plain Text

---

# Dependency Injection

Register

ApiClient

AuthInterceptor

RetryClient

NetworkChecker

using GetIt.

---

# Performance

Reuse HTTP Client

Avoid duplicate API calls

Cache frequently used data

Lazy load lists

Batch requests where possible

---

# Unit Testing

Mock

ApiClient

Never call real API.

Test

Success

Failure

Timeout

Retry

Mapping

---

# Integration Testing

Verify

Login

Refresh Token

Retry

Pagination

Upload

Download

Logout

---

# Do

✔ Centralise networking

✔ Reuse ApiClient

✔ Use Repository Pattern

✔ Map exceptions

✔ Keep API layer independent

✔ Mock API in tests

✔ Use HTTPS

✔ Use Secure Storage

---

# Don't

❌ HTTP in UI

❌ HTTP in ViewModel

❌ JSON parsing in UI

❌ Duplicate headers

❌ Hardcoded URLs

❌ Hardcoded timeout

❌ Duplicate upload code

❌ Ignore status codes

❌ Print tokens

❌ Use dynamic maps everywhere

---

# Checklist

Before merging, complete the single shared checklist (API section applies):

→ **`DEFINITION_OF_DONE.md`**

Do not maintain a separate API checklist here.

---

# AI Coding Rules

Whenever AI creates API code

AI must

- Use ApiClient only.
- Never call package:http directly from Repository.
- Convert JSON into Models.
- Handle all HTTP status codes.
- Use AppException.
- Support timeout.
- Support retry.
- Support authentication.
- Keep Repository free from UI logic.
- Generate unit tests for Repository.