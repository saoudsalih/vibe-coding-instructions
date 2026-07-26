# Database Standards

Version: 1.0

Status: Mandatory

Database

Sembast

Architecture

- Feature First
- MVVM
- Provider
- GetIt

---

# Purpose

This document defines the database architecture, standards and best practices.

Goals

- Offline First
- Fast Local Storage
- Easy Maintenance
- Feature Isolation
- Easy Migration
- Testable Database Layer

---

# Database Architecture

UI

↓

ViewModel

↓

Repository

↓

DatabaseService

↓

Sembast

Never access Sembast directly from

- View
- ViewModel
- Widget

Only Repository can access DatabaseService.

---

# Folder Structure

lib/

core/

database/

├── database_service.dart
├── database_manager.dart
├── database_constants.dart
├── database_exception.dart
├── migrations.dart
├── database_backup.dart
└── stores/

features/

customer/

repository/

customer_repository.dart

model/

customer_model.dart

---

# Responsibilities

DatabaseService

Responsible

✔ Open Database

✔ Close Database

✔ CRUD Operations

✔ Transactions

✔ Backup

✔ Restore

✔ Database Migration

Never

❌ Business Logic

❌ UI Logic

---

# Store Rules

Each feature owns one store.

Example

customer_store

product_store

order_store

payment_store

voucher_store

settings_store

Never mix unrelated data.

Wrong

app_store

master_store

all_data_store

---

# Naming Convention

Correct

customer_store

product_store

invoice_store

payment_store

Wrong

store1

test

database

temp

---

# Primary Key

Every record must have

id

Example

Customer

id

name

phone

address

createdAt

updatedAt

Never use index as identifier.

---

# Common Fields

Every model should contain

id

createdAt

updatedAt

isDeleted

syncStatus

version

Example

{
"id":"",
"createdAt":"",
"updatedAt":"",
"isDeleted":false,
"syncStatus":"pending",
"version":1
}

---

# Soft Delete

Never permanently delete records.

Use

isDeleted = true

Repository filters deleted records.

---

# Sync Status

Every record contains

pending

synced

failed

conflict

Useful for future online synchronisation.

---

# CRUD Rules

Create

Insert

Read

Find

Update

Update

Delete

Soft Delete

Never expose Sembast directly.

---

# Transactions

Use transaction for

Invoice

Payment

Stock Update

Voucher

Never update multiple tables separately.

---

# Batch Operations

Use batch

Import

Sync

Migration

Bulk Delete

Bulk Update

Avoid multiple write calls.

---

# Repository Rules

Repository converts

Database Record

↓

Model

Never return

Map

dynamic

Database Snapshot

Return only Models.

---

# Model Rules

Every model contains

fromJson()

toJson()

copyWith()

Never store UI state.

---

# Query Rules

Repository handles

Sorting

Filtering

Searching

Pagination

Never perform filtering in UI.

---

# Search

Search inside Repository.

Never

List.where()

inside ViewModel.

---

# Pagination

Repository returns

Page Result

Never paginate inside Widget.

---

# Backup

Support

Export Database

Import Database

JSON Backup

Never expose database file.

---

# Database Migration

Maintain version number.

Example

Version 1

Customer

Version 2

Customer + Address

Migration must never lose data.

---

# Encryption

Sensitive information

Encrypt before saving.

Never store

Password

Access Token

Secret Keys

inside Sembast.

Use

Flutter Secure Storage

---

# Settings

Application settings

Store separately.

Example

theme

language

currency

printer

Never mix settings with business data.

---

# Offline First

Repository flow

Read

↓

Local Database

↓

If Online

↓

Sync API

↓

Update Database

↓

Notify UI

UI should never know where data came from.

---

# Error Handling

Throw

DatabaseException

DatabaseNotFoundException

MigrationException

StorageFullException

Never throw String.

---

# Logging

Debug

Open Database

Close Database

Insert

Update

Delete

Migration

Release

Disable logging.

---

# Performance

Open database once.

Reuse instance.

Use indexes where possible.

Avoid reading full collections.

Query only required data.

Close unused streams.

Use batch updates.

---

# Dependency Injection

Register

DatabaseService

as Lazy Singleton.

Only one database instance.

---

# Testing

Mock DatabaseService.

Never use real database in unit tests.

Test

Insert

Update

Delete

Search

Migration

Soft Delete

Backup

Restore

---

# Security

Never expose database path.

Never expose raw records.

Validate data before insert.

Encrypt sensitive values.

---

# Feature Example

Customer

customer_store

↓

CustomerRepository

↓

CustomerViewModel

↓

CustomerView

Product

product_store

↓

ProductRepository

↓

ProductViewModel

↓

ProductView

---

# Do

✔ One store per feature

✔ One database instance

✔ Repository Pattern

✔ Transactions

✔ Batch Updates

✔ Offline First

✔ Soft Delete

✔ Migration Support

✔ Backup Support

✔ Model Mapping

---

# Don't

❌ Direct Sembast calls in UI

❌ Database inside ViewModel

❌ Hardcoded store names

❌ Multiple database instances

❌ Delete records permanently

❌ Store passwords

❌ Return Map from Repository

❌ Business logic inside DatabaseService

---

# Checklist

Before merging, complete the single shared checklist (offline / database section applies):

→ **`DEFINITION_OF_DONE.md`**

Do not maintain a separate database checklist here.

---

# AI Coding Rules

Whenever AI creates a new feature

AI must

- Create one Sembast store per feature.
- Use DatabaseService only.
- Never access Sembast directly.
- Return Models only.
- Support Offline First.
- Support Soft Delete.
- Use transactions where required.
- Register DatabaseService in GetIt.
- Generate repository tests.