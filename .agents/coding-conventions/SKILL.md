---
name: coding-conventions
description: "Rules for UI development: localization, common widgets, and theme-based coloring."
---

# Coding Conventions & UI Development Rules

This document defines the mandatory coding standards for UI development in the **Finance Management App** to ensure maintainability, scalability, and design consistency.

---

## 🌍 1. Localization (l10n)
**Rule:** NEVER hardcode strings in the UI. All user-facing text, including hint texts, placeholders, date/time format templates, and format indicators, must be externalized using the localization system.

*   **Implementation:**
    *   Add strings to `lib/l10n/intl_en.arb` and `lib/l10n/intl_vi.arb`.
    *   Access strings in the UI using the `context.s` extension.
*   **Example:**
    ```dart
    // ❌ Incorrect
    Text('Add Transaction')
    AppTextField(hintText: 'example@example.com')

    // ✅ Correct
    Text(context.s.addTransaction)
    AppTextField(hintText: context.s.emailHint)
    ```

---

## 🧱 2. Common Widgets (Reusable Components)
**Rule:** Prioritize using existing common widgets or creating new ones for repetitive UI elements.

*   **Input & Action Widgets:**
    *   Avoid using raw `TextField`, `TextFormField`, or standard Material buttons (`ElevatedButton`, `OutlinedButton`, `TextButton`) directly in screens.
    *   Inputs must be centralized in the global shared inputs directory `lib/src/presentation/widgets/inputs/`.
    *   Use wrappers like `AppTextField` and `AppDateField` to guarantee styling, validation, and theme consistency across all app forms.
    *   Use predefined button widgets from `lib/src/presentation/widgets/inputs/buttons/`:
        *   `AppFilledButton`: For buttons with background color
        *   `AppOutlinedButton`: For buttons with border color.
        *   `AppBackButton`: For standard back navigation.
*   **Image Widgets:**
    *   Use the predefined image wrappers in `lib/src/presentation/widgets/images/`:
        *   `AppSvgImage`: For vector assets.
        *   `AppAssetImage`: For local raster assets.
        *   `AppCacheImage`: For network images.
*   **Loading Indicators:**
    *   Use `AppCircularProcessIndicator` or `AppLoadingOverlay` from `lib/src/presentation/widgets/feedback/`.
*   **Dialogs & Feedback:**
    *   Use `AppDialog` for consistent popups and alerts.

---

## 🎨 3. Color & Theme Management
**Rule:** Colors must be centralized and accessed via the Theme. Direct `Color(0xFF...)` or `Colors.blue` usage in UI files is strictly prohibited.

*   **Step 1: Define in AppColor**
    *   All raw hex values must be defined as constants in [app_color.dart](file:///Users/hungtq/AndroidStudioProjects/finance/lib/src/core/dimensions/app_color.dart).
*   **Step 2: Map in AppThemeData**
    *   Map these colors to the `AppColorScheme` (Light/Dark) in [app_theme_data.dart](file:///Users/hungtq/AndroidStudioProjects/finance/lib/src/core/theme/app_theme_data.dart).
*   **Step 3: Access in UI**
    *   Use the `context.colors` extension to retrieve colors based on the current theme.
*   **Example:**
    ```dart
    // ❌ Incorrect
    Container(color: Color(0xFF00D09E))
    Container(color: AppColor.primary)

    // ✅ Correct
    Container(color: context.colors.primary)
    ```

---

## 🛠️ 4. Form Validation & Picker Utilities
**Rule:** Decouple all validation logic and visual picker triggers from UI widgets.

*   **Form Validation:**
    *   Do not hardcode validation rules (regex matching, password constraints) in UI or page files.
    *   Consolidate and encapsulate all validators in `AppValidators` under `lib/src/core/utils/app_validators.dart`.
    *   Validators should receive `BuildContext` to lookup localized error strings.
*   **Pickers & Overlays:**
    *   Display configurations for Date/Time picker overlays must not live in UI widgets.
    *   Isolate calendar picker display logic and color injections inside `DatePickerUtils` under `lib/src/core/utils/date_picker_utils.dart`.

---

## 📦 5. Modularity & Granular Layouts
**Rule:** Avoid creating monolithic page/screen files containing entire layout trees.

*   **Implementation:**
    *   Slice large layout trees into distinct, reusable private module widgets.
    *   Place these widgets in a local `widget/` subdirectory of the screen (e.g. `lib/src/presentation/screens/welcome/widget/welcome_form.dart`).
    *   Keep the primary `<feature>_page.dart` extremely lightweight, acting strictly as the declarative entry point for dependency injection and screen layout orchestration.

---

## 🛡️ Verification
Before submitting code, ensure:
1. `flutter analyze` returns no errors or warnings.
2. No hardcoded strings are present (check both labels and hints in `.dart` files in `presentation`).
3. Colors are accessed exclusively through `context.colors`.
4. Monolithic pages are sliced into granular child module components inside `widget/` subfolders.
5. Form validators and pickers are cleanly encapsulated in static helper utilities under `/core/utils/`.
