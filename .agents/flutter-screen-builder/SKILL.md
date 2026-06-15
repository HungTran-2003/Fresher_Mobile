---
name: flutter-screen-builder
description: "Architecture guidelines and boilerplate templates (MVVM + Clean Architecture) to construct a new feature screen in the Finance Management application."
---

# Flutter Screen Construction Guide (Flutter Screen Builder Skill)

This document serves as a custom **Developer/Agent Skill** designed to guide coding agents and developers in creating, modifying, or optimizing any user interface screen in the **Finance Management App**. It guarantees absolute architectural consistency, optimal rendering performance, and premium Material 3 design standards.

---

## 📌 Core Architectural Principles

Every feature screen in the application must strictly adhere to the **MVVM + Clean Architecture** patterns. Each screen is divided into exactly **4 distinct files** located under a dedicated feature folder inside `lib/src/presentation/screens/`:

1.  **`page`** (`<feature>_page.dart`): The pure declarative UI rendering layer.
2.  **`cubit`** (`<feature>_cubit.dart`): The business logic coordinator that processes UI events and drives state transitions.
3.  **`state`** (`<feature>_state.dart`): The immutable state models emitted by the Cubit to update the visual UI.
4.  **`navigator`** (`<feature>_navigator.dart`): Strongly typed routing boundaries encapsulating all page-level navigation logic.

---

## 📂 Sơ đồ cấu trúc một thư mục Screen mẫu (Feature Directory Blueprint)

```text
lib/src/presentation/screens/add_transaction/
├── add_transaction_cubit.dart
├── add_transaction_navigator.dart
├── add_transaction_page.dart
└── add_transaction_state.dart
```

---

## 📐 Component Patterns & Standard Boilerplates

### 1. Navigator (`<feature>_navigator.dart`)
Responsible for managing screen transitions, dialog triggers, and back button behaviors. It extends `BaseNavigator` to utilize safe, context-aware navigation wrappers.
*   **Rules:**
    *   Accepts `BuildContext` via the constructor and passes it directly to `super(context)`.
    *   Exposes only transition methods (e.g., `back()`, `toDetail()`). Contains ZERO business logic.

```dart
import '../../../core/routes/base_navigator.dart';

class AddTransactionNavigator extends BaseNavigator {
  AddTransactionNavigator(super.context);

  void back() {
    pop();
  }

  // Define further strongly typed screen routes here
}
```

---

### 2. State (`<feature>_state.dart`)
Represents the screen's visual state at any given point in time.
*   **Rules:**
    *   Clearly track loading and execution lifecycles using a dedicated enum `status` (initial, loading, success, failure).
    *   All class fields must be marked as `final` to ensure immutability.
    *   Provide a factory `initial()` constructor and a type-safe `copyWith()` method.

```dart
part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final LoadStatus fetchProfileStatus;

  const SplashState({this.fetchProfileStatus = LoadStatus.initial});

  SplashState copyWith({LoadStatus? fetchProfileStatus}) {
    return SplashState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
    );
  }

  @override
  List<Object?> get props => [fetchProfileStatus];
}
```

---

### 3. Cubit (`<feature>_cubit.dart`)
The business logic brain of the screen, mediating between the UI presentation layer and Domain Usecases/Repositories.
*   **Rules:**
    *   Accepts the strongly typed Navigator and repositories through the constructor.
    *   All state updates must be dispatched using `emit(state.copyWith(...))`.
    *   Navigation tasks must be routed through the constructor-injected `navigator` instance. Direct page-level `Navigator.of(context)` lookups are strictly prohibited.

```dart
import 'package:equatable/equatable.dart';
import 'package:finance/src/domain/models/enum/load_status.dart';
import 'package:finance/src/domain/repositories/setting_repository.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:finance/src/presentation/global/user/user_cubit.dart';
import 'package:finance/src/presentation/screens/splash/splash_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthCubit _authCubit;
  final SettingRepository _settingRepository;
  final UserCubit _userCubit;
  final SplashNavigator navigator;

  SplashCubit(
      this.navigator,
      this._authCubit,
      this._userCubit,
      this._settingRepository,
      ) : super(const SplashState());

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      final isLogin = _authCubit.authRepo.isUserLoggedIn;
      if (isLogin) {
        await _userCubit.getUser();
        _authCubit.setAuthenticated(true);
        return;
      }

      final isFirstRunResult = await _settingRepository.isFirstRun();
      final isFirstRun = isFirstRunResult.getOrElse(() => false);

      if (isFirstRun) {
        navigator.toWelcome();
      } else {
        navigator.navigateToOnboard();
      }
    });
  }
}

```

---

### 4. Page (`<feature>_page.dart`)
The visual representation layer executing premium styling.
*   **Golden Page Rules:**
    1.  **1-Stateless + 1-Stateful Structure:**
        *   The outer widget must be a `StatelessWidget`. It acts as the dependency injection entry point, wrapping the page in a `BlocProvider` and building the Navigator and Cubit.
        *   The inner widget is a private `StatefulWidget` (e.g. `_AddTransactionPageContent`) that manages local UI animations, inputs, and builds the visual layouts.
    2.  **No Logic Leakage:** The Page must not contain business logic. User interactions are dispatched straight to the Cubit (e.g., `context.read<AddTransactionCubit>().submitTransaction(...)`).
    3.  **Performant Rebuilds via `buildWhen`:** Always declare a explicit `buildWhen` block in the `BlocBuilder` to avoid rendering drops, guaranteeing smooth 120Hz micro-animations.
    4.  **Context Extensions Utility:** Leverage context getters for clean, concise layout code.
    5.  **separate sub-assemblies of widgets with the same functionality into sub-widgets starting with _build.....

```dart
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:finance/src/presentation/screens/auth/create_account/widget/create_account_form.dart';
import 'package:finance/src/presentation/screens/auth/create_account/widget/create_account_header.dart';
import 'package:finance/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_account_cubit.dart';
import 'create_account_navigator.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateAccountCubit>(
      create: (context) {
        final navigator = CreateAccountNavigator(context);
        return CreateAccountCubit(
          authCubit: context.read<AuthCubit>(),
          authRepository: context.read<AuthRepository>(),
          navigator: navigator,
        );
      },
      child: const _CreateAccountPageContent(),
    );
  }
}

class _CreateAccountPageContent extends StatelessWidget {
  const _CreateAccountPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryContainer,
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = context.colors;
    return BlocListener<CreateAccountCubit, CreateAccountState>(
      listenWhen: (prev, current) => prev.status != current.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide;
        }
      },
      child: Column(
        children: [
          // Top Header Component
          CreateAccountHeader(height: size.height * 0.16),

          // Bottom Curved Content Card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: colors.onPrimaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(60),
                ),
              ),
              child: const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
                child: CreateAccountForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## ⚡ Context Extensions Quick Reference Guide

To optimize coding speed and maintain pristine codebase layouts, utilize the custom extensions defined in [context_extensions.dart](file:///Users/hungtq/AndroidStudioProjects/finance/lib/src/core/utils/context_extensions.dart):

| Deprecated / Verbose Standard | Unified Concise Extension     | Lookup Description |
| :--- |:------------------------------| :--- |
| `S.of(context).key` | `context.s.key`               | Fetches active multi-language translation strings |
| `Theme.of(context).colorScheme` | `context.colors`              | Directly accesses active Material 3 `ColorScheme` |
| `Theme.of(context).textTheme` | `context.textThemes`           | Directly accesses layout `TextTheme` typography |

### Localized Logic Switch Example:
```dart
// Do NOT use: Localizations.localeOf(context).languageCode == 'vi'
// DO USE:
if (context.s.languageCode == 'vi') {
  // Execute Vietnamese-specific numeric formatting or currency styling
}
```

---

## 🛡️ Static Analysis Compliance & Warning Prevention

To guarantee a completely clean build pipeline (Zero Warnings & Errors):

1.  **Use `.withValues(alpha: ...)` instead of `.withOpacity(...)`:**
    Recent Flutter SDK versions deprecate `.withOpacity()` in favor of `.withValues()` to prevent color precision loss.
    *   *Incorrect:* `Colors.white.withOpacity(0.05)`
    *   *Correct:* `Colors.white.withValues(alpha: 0.05)`
2.  **Centralize Radio State using `RadioGroup`:**
    Wrap related `RadioListTile` components in a single `RadioGroup` widget instead of hardcoding `groupValue` and `onChanged` handlers onto each list tile. This satisfies modern accessibility requirements and resolves compilation warnings.
3.  **Enforce `const` Usage:**
    Provide `const` constructors for static widgets to reduce rebuild cycles and optimize performance.
4.  **Final Quality Control:**
    Before pushing any screen updates, execute the final analyzer command to verify 100% compliance:
    ```bash
    flutter analyze
    ```
