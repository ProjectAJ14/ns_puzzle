# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get              # Install dependencies
flutter analyze              # Run linter (strict-casts, strict-raw-types, trailing commas, 80-char lines)
flutter test                 # Run all tests
flutter test test/foo_test.dart  # Run a single test file
flutter build web            # Build for web (the primary deploy target)
flutter run                  # Run on connected device or emulator
flutter run -d chrome        # Run in Chrome
```

Code generation (after modifying `@JsonSerializable` models):
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Architecture

**State management:** GetX — controllers extend `GetxController`, UI rebuilds via `GetBuilder<T>`. No Rx observables are used; state updates trigger via `update()`.

**Dependency injection:** All services and repos are registered as singletons in `lib/app/init/init_dependencies.dart` using `Get.put<T>()`. Global access via top-level getters (`authService`, `fireStoreRepo`) that call `Get.find<T>()`.

**Routing:** GetX `GetMaterialApp` with named routes defined in `lib/ui/routes/routes.dart`. Entry point is `HomeScreen` ("/") which gates on auth state — shows `GameScreen` if authenticated, `SignInScreen` otherwise.

**Screen pattern:** Each screen has a controller (business logic) and a screen widget (UI). Game-specific widgets live in `widgets/` subdirectories. The app uses NES UI components (`NesButton`, `NesContainer`, `NesDialog`, `NesWindow`) for a retro pixel-art aesthetic.

**Game engine:** River-crossing puzzle where `Subject` is the base class (`CARTCell`, `CancerCell` in `lib/data/models/subjects.dart`). `GameController` manages three lists (`leftSide`, `rightSide`, `onBoat`) and validates win/loss via `checkGameEnd()` and `checkWin()`. Kill conditions in `lib/game_engine/kill_conditions.dart` use a map-based evaluator — if cancer cells outnumber CAR-T cells on either side, the player loses.

**Firebase:** Auth via Google Sign-In (`AuthService` in `lib/app/services/`). Firestore stores user scores in a `users` collection. Repository pattern in `lib/app/repo/` exposes streams for leaderboard data. `lib/firebase_options.dart` is not committed — it's injected from a base64 secret in CI.

## Lint Rules

Uses `flutter_lints` with these enforced rules:
- `require_trailing_commas`
- `lines_longer_than_80_chars`
- `avoid_print` (use `dart:developer` `log()` instead)
- `prefer_relative_imports`
- `prefer_interpolation_to_compose_strings`
- Strict casts and strict raw types enabled

## CI/CD

Push to `master` triggers GitHub Actions: analyze → test → build web → deploy to Firebase Hosting. Flutter version pinned to 3.22.2 in CI.
