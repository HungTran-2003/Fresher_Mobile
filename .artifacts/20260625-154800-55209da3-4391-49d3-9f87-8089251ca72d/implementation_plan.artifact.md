# Refactor Project to include UseCase Layer in Domain

This plan outlines the steps to introduce a `usecases` layer within the `domain` folder and refactor the project (Controllers and Bindings) to use these UseCases, ensuring strict adherence to Clean Architecture.

## Proposed Changes

### Domain Layer (New UseCases)

I will create a base `UseCase` class and specific UseCases for each feature area.

#### [NEW] [use_case.dart](file:///D:/study/Fresher_Mobile/lib/src/domain/usecases/use_case.dart)
- Base abstract class for all UseCases.

#### [NEW] [Auth UseCases](file:///D:/study/Fresher_Mobile/lib/src/domain/usecases/auth/)
- `LoginUseCase`
- `LogoutUseCase`
- `ReloginUseCase`
- `GetLastLoginUseCase`

#### [NEW] [Product UseCases](file:///D:/study/Fresher_Mobile/lib/src/domain/usecases/product/)
- `GetProductsUseCase`
- `GetCategoriesUseCase`
- `AddProductUseCase`
- `UpdateProductUseCase`
- `DeleteProductUseCase`

#### [NEW] [User UseCases](file:///D:/study/Fresher_Mobile/lib/src/domain/usecases/user/)
- `GetCurrentUserUseCase`

#### [NEW] [Setting UseCases](file:///D:/study/Fresher_Mobile/lib/src/domain/usecases/setting/)
- `GetLanguageUseCase`, `SetLanguageUseCase`
- `GetThemeModeUseCase`, `SetThemeModeUseCase`
- `GetBiometricsUseCase`, `SetBiometricsUseCase`
- `CheckFirstRunUseCase`, `SetFirstRunUseCase`

#### [NEW] [Upload UseCases](file:///D:/study/Fresher_Mobile/lib/src/domain/usecases/upload/)
- `UploadImageUseCase`

---

### Presentation Layer (Refactoring)

#### [Controllers]
- Update `LoginController`, `HomeController`, `AddProductController`, `AuthController`, `UserController`, `AppSettingsController`, and `SplashController`.
- Replace `Repository` injections with specific `UseCase` injections.
- Update method calls to use UseCases.

#### [Bindings]
- Update all binding files (e.g., `login_binding.dart`, `home_binding.dart`) to provide the necessary UseCases to the controllers.

## Verification Plan

### Manual Verification
- **Build Check**: Ensure the app compiles after refactoring.
- **Runtime Check**:
    - Verify Login/Logout flow.
    - Verify Product listing, adding, and deleting.
    - Verify Settings (Language, Theme, Biometrics).
    - Verify Splash auto-login.
