# Theme Standards

Version: 1.0

Architecture

- Feature First
- MVVM
- Provider
- GetIt

---

# Purpose

This document defines all UI styling rules.

Goals

- Consistent UI
- Easy maintenance
- Easy branding
- Dark mode support
- Reusable widgets
- No hardcoded styles

---

# Folder Structure

core/

theme/

├── app_theme.dart
├── app_colors.dart
├── app_text_styles.dart
├── app_spacing.dart
├── app_radius.dart
├── app_icons.dart
├── app_dimensions.dart
├── app_shadows.dart
├── app_input_theme.dart
├── app_button_theme.dart
├── app_card_theme.dart
└── app_extensions.dart

Never place theme files outside core/theme.

---

# General Rules

Always use

AppColors

AppTextStyles

AppSpacing

AppRadius

Never use

Colors.red

Colors.blue

EdgeInsets.all(10)

SizedBox(height:15)

BorderRadius.circular(12)

TextStyle()

inside screens.

---

# Colors

Create

AppColors

Example

Primary

Secondary

Success

Warning

Error

Info

Background

Surface

Divider

Disabled

TextPrimary

TextSecondary

Hint

Never

Container(
 color: Colors.blue
)

Always

Container(
 color: AppColors.primary
)

---

# Color Naming

Correct

AppColors.primary

AppColors.error

AppColors.success

AppColors.warning

AppColors.background

Wrong

AppColors.blue

AppColors.red

AppColors.green

Reason

Name by purpose.

Not by colour.

---

# Typography

Create

AppTextStyles

Example

headlineLarge

headlineMedium

titleLarge

titleMedium

bodyLarge

bodyMedium

labelLarge

caption

---

Never

Text(

 style: TextStyle(

  fontSize:18

 )

)

Always

Text(

 style: AppTextStyles.titleLarge

)

---

# Font

Only one font family.

Example

Inter

Roboto

Poppins

Never mix fonts.

---

# Font Sizes

Create constants.

Example

12

14

16

18

20

24

32

Never use random sizes.

---

# Font Weight

Use

Regular

Medium

SemiBold

Bold

Never use

w300

w500

directly.

---

# Spacing

Create

AppSpacing

Example

xs = 4

sm = 8

md = 16

lg = 24

xl = 32

xxl = 48

Never

Padding(

 EdgeInsets.all(13)

)

Always

Padding(

 EdgeInsets.all(AppSpacing.md)

)

---

# Radius

Create

AppRadius

Example

small

medium

large

pill

circle

Never

BorderRadius.circular(7)

---

# Icons

Create

AppIcons

Example

edit

delete

search

filter

home

profile

Never hardcode icon mapping.

---

# Elevation

Create

AppElevation

Levels

0

1

2

4

8

12

Never random elevations.

---

# Shadows

Centralise shadows.

Small

Medium

Large

Cards use

AppShadows.card

Dialogs use

AppShadows.dialog

---

# Buttons

Never use ElevatedButton directly.

Always

PrimaryButton

SecondaryButton

OutlineButton

DangerButton

IconButton

LoadingButton

Every button shares

Radius

Padding

Typography

Height

Loading State

Disabled State

---

# TextField

Never use TextField directly.

Always

AppTextField

Supports

Label

Hint

Validation

Error

Prefix Icon

Suffix Icon

Password Toggle

Read Only

Search Mode

Multiline

---

# Input Theme

Configure

Border

Radius

Focused Border

Error Border

Hint Style

Label Style

Cursor Colour

Selection Colour

inside

AppInputTheme

---

# Card Theme

Create

AppCard

Standard

Radius

Padding

Shadow

Background

Margin

Never style cards individually.

---

# Dialog Theme

Create reusable dialogs.

AlertDialog

ConfirmationDialog

SuccessDialog

ErrorDialog

LoadingDialog

Never build dialogs repeatedly.

---

# Bottom Sheet

Reusable

AppBottomSheet

Supports

Header

Close Button

Action Buttons

Scrollable Content

---

# Snackbar

Never

ScaffoldMessenger.showSnackBar()

directly.

Use

SnackbarService

Supports

Success

Warning

Error

Information

---

# Loader

Never

CircularProgressIndicator()

directly.

Always

LoadingWidget

LoadingOverlay

FullscreenLoader

---

# Empty State

Create

EmptyView

Supports

Image

Title

Subtitle

Retry Button

---

# Error State

Create

ErrorView

Supports

Message

Retry Button

Contact Support

---

# Search Field

Reusable

SearchTextField

Supports

Debounce

Clear Button

Search Icon

Voice (optional)

---

# List Tiles

Create

AppListTile

Supports

Leading

Title

Subtitle

Trailing

Selection

Badge

---

# App Bar

Create

AppAppBar

Supports

Back Button

Title

Actions

Search

Filter

Notification

---

# Navigation Bar

Centralise styles.

Height

Selected Colour

Unselected Colour

Label Style

Badge

---

# Chips

Reusable

StatusChip

CategoryChip

FilterChip

SelectionChip

---

# Badges

Create

AppBadge

Supports

Count

Status

Notification

---

# Avatar

Create

AppAvatar

Supports

Image

Network

Initials

Online Status

---

# Image Rules

Use

CachedNetworkImage

Never

Image.network()

directly.

Fallback

Placeholder

Error Image

Loading

must be supported.

---

# Animations

Standardise

Duration

Curve

Fade

Scale

Slide

Do not use random timings.

---

# Dark Mode

All colours must support

Light Theme

Dark Theme

No hardcoded colours.

---

# Responsive Design

Use

LayoutBuilder

MediaQuery

Responsive helpers

Avoid fixed widths.

---

# Accessibility

Minimum touch area

48x48

Support text scaling.

Support screen readers.

Use semantic labels.

Ensure colour contrast.

---

# Localization

Never hardcode UI strings.

Use

AppLocalizations

Example

Wrong

Text("Login")

Correct

Text(context.l10n.login)

---

# Reusable Widgets

Must use

PrimaryButton

SecondaryButton

AppTextField

LoadingWidget

ErrorView

EmptyView

AppCard

SearchTextField

AppAppBar

ConfirmationDialog

---

# Performance

Use const constructors.

Extract reusable widgets.

Avoid rebuilding entire screens.

Use Selector when only part of the UI changes.

Lazy load long lists.

---

# Naming Convention

Correct

PrimaryButton

AppTextField

AppCard

AppBadge

AppAvatar

Wrong

ButtonWidget

CardWidget

TextWidget

---

# Do

✔ Centralise styles

✔ Reuse widgets

✔ Use theme extensions

✔ Support dark mode

✔ Support localisation

✔ Keep spacing consistent

✔ Use semantic colours

---

# Don't

❌ Hardcoded colours

❌ Hardcoded padding

❌ Random font sizes

❌ Duplicate button styles

❌ Duplicate dialogs

❌ Duplicate app bars

❌ Inline TextStyle

❌ Inline BoxDecoration

❌ Inline BorderRadius

❌ Random shadows

---

# Checklist

Before merging, complete the single shared checklist (UI section applies):

→ **`DEFINITION_OF_DONE.md`**

Do not maintain a separate theme checklist here.

---

# AI Rules

Whenever AI creates a screen

AI must

- Use AppTheme.
- Use AppColors.
- Use AppTextStyles.
- Use AppSpacing.
- Use AppRadius.
- Use reusable widgets only.
- Never generate inline styling.
- Never hardcode colours or dimensions.
- Support dark mode.
- Support localisation.
- Keep UI consistent with existing components.