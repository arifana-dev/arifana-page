# arifana_portfolio

Flutter Web personal portfolio for Arifana — Flutter Mobile Developer.

## Project Overview

Single-page portfolio with smooth scroll navigation. Built with Flutter Web, BLoC state management, and Clean Architecture.

Planned content management direction: Firebase-backed portfolio content with a protected `/admin` mini dashboard. Public content should read from Firestore; admin CRUD should use Firebase Auth + Firestore writes.

## Commands

```bash
# Development (hot reload)
flutter run -d web-server --web-port 8080

# Open in Safari while running
open -a Safari http://localhost:8080

# Analyze
flutter analyze

# Release build
flutter build web --release

# Serve release build locally
cd build/web && python3 -m http.server 8080
```

## Architecture

Clean Architecture per feature: `data` → `domain` → `presentation` (bloc + widgets).

```
lib/
├── core/
│   ├── theme/          # AppColors, AppTextStyles, AppTheme
│   ├── constants/      # AppSpacing, AppStrings
│   ├── utils/          # Responsive, SectionKeys, UrlHelper
│   ├── widgets/        # NavBar, SectionContainer, SectionHeader, SocialIconButton
│   └── router/         # AppRouter (go_router)
├── features/
│   ├── portfolio/      # PortfolioPage — assembles all sections
│   ├── hero/
│   ├── about/
│   ├── skills/
│   ├── experience/
│   ├── projects/        # Portfolio/project list section
│   ├── admin/           # Planned Firebase Auth + Firestore CRUD dashboard
│   └── contact/
└── main.dart
```

Each feature follows this structure:
```
feature/
├── data/         # Repository implementation (static data)
├── domain/       # Entity classes (Equatable)
└── presentation/
    ├── bloc/     # BLoC (event / state / bloc)
    └── widgets/  # Section widget (BlocBuilder)
```

## State Management

BLoC (`flutter_bloc ^8.x`). Each feature has one BLoC with a single `LoadRequested` event that emits a `Loaded` state. All BLoCs are provided at `PortfolioPage` via `MultiBlocProvider`.

## Navigation

`go_router ^14.x` currently serves `/` for the public portfolio. Planned admin route: `/admin` for protected content management.

Navigation between public sections uses `SectionKeys.scrollTo(PortfolioSection.xxx)` — `Scrollable.ensureVisible` with 700ms `easeInOutCubic` curve.

## Responsive Breakpoints

| Name    | Width         |
|---------|---------------|
| mobile  | < 600px       |
| tablet  | 600 – 1023px  |
| desktop | ≥ 1024px      |

Use `Responsive.value(context, mobile: ..., desktop: ...)` or `Responsive.isMobile(context)`.

## Design System

| Token       | Value     |
|-------------|-----------|
| Background  | `#0F172A` |
| Surface     | `#1E293B` |
| Surface Alt | `#334155` |
| Primary     | `#22C55E` |
| Text        | `#F8FAFC` |
| Muted       | `#64748B` |

Fonts: **Archivo** (display/headings) + **Space Grotesk** (body/labels) via `google_fonts`.

Animations: `flutter_animate ^4.x` — entrance animations use `fadeIn` + `slideY` with staggered delays (100–600ms).

## Key Files

| File | Purpose |
|------|---------|
| `core/theme/app_colors.dart` | All color constants |
| `core/theme/app_text_styles.dart` | All text styles |
| `core/constants/app_strings.dart` | All copy/content strings |
| `core/constants/app_spacing.dart` | Spacing scale + breakpoints |
| `core/utils/section_keys.dart` | GlobalKeys + scroll-to logic |
| `core/utils/responsive.dart` | Breakpoint helpers |
| `features/portfolio/portfolio_page.dart` | Root page, MultiBlocProvider |

## Adding a New Section

1. Create `lib/features/<name>/domain/<name>_entity.dart` (Equatable)
2. Create `lib/features/<name>/data/<name>_repository.dart` (impl with static data)
3. Create `lib/features/<name>/presentation/bloc/<name>_bloc.dart` (+ event + state)
4. Create `lib/features/<name>/presentation/widgets/<name>_section.dart` (BlocBuilder)
5. Add `BlocProvider` in `portfolio_page.dart`
6. Add `SizedBox(key: SectionKeys.keyOf(...), child: NameSection())` in `_PortfolioView`
7. Add entry to `PortfolioSection` enum in `section_keys.dart`
8. Add nav link in `nav_bar.dart`

## Content Updates

Static personal info, copy, and URLs live in:
`lib/core/constants/app_strings.dart`

Portfolio/project content is moving to Firebase Firestore. Use collection `projects` with fields:

```json
{
  "title": "...",
  "description": "...",
  "role": "...",
  "period": "...",
  "tags": ["Flutter"],
  "highlights": ["..."],
  "isPublished": true,
  "sortOrder": 1,
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

Public portfolio should query only `isPublished == true`, ordered by `sortOrder`. Admin UI should list all projects.

## Dependencies

```yaml
flutter_bloc: ^8.x      # State management
equatable: ^2.x         # Value equality for entities/states
go_router: ^14.x        # Routing
flutter_animate: ^4.x   # Animations
url_launcher: ^6.x      # Open URLs / mailto
google_fonts: ^6.x      # Archivo + Space Grotesk
firebase_core           # Planned Firebase bootstrap
firebase_auth           # Planned admin login
cloud_firestore         # Planned dynamic portfolio content
```
