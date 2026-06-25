# Go Fresher - Finance App

Dự án **Go Fresher** là một ứng dụng quản lý tài chính cá nhân được xây dựng bằng Flutter, tập trung vào việc áp dụng các tiêu chuẩn Clean Architecture và quản lý trạng thái bằng BLoC (Cubit).

## 🎯 Mục tiêu tuần
- [x] Thiết lập cấu trúc dự án theo Clean Architecture.
- [x] Cấu hình Routing với GoRouter.
- [x] Triển khai Base Navigator và Base Page.
- [x] Tích hợp BLoC (Cubit) cho quản lý trạng thái.
- [x] Xây dựng luồng Splash, Login và Home cơ bản.
- [x] Tích hợp Local Storage (Hive & Secure Storage).
- [x] Hỗ trợ xác thực sinh trắc học (Biometrics).
- [ ] Tích hợp Firebase Auth và Cloud Firestore (In Progress).

## 🏗️ Kiến trúc dự án (Clean Architecture)

Dự án tuân thủ nghiêm ngặt mô hình Clean Architecture để đảm bảo tính dễ bảo trì, mở rộng và kiểm thử:

- **Data Layer (`lib/src/data`)**: 
  - Triển khai các Repository interfaces.
  - Xử lý các nguồn dữ liệu (Remote: Firebase, Local: Hive/Secure Storage).
  - Chuyển đổi dữ liệu (Models sang Entities).
- **Domain Layer (`lib/src/domain`)**:
  - Chứa các thực thể (Entities) cốt lõi của ứng dụng.
  - Định nghĩa các Repository interfaces.
  - (Sẽ thêm) Business Logic thông qua Usecases.
- **Presentation Layer (`lib/src/presentation`)**:
  - Giao diện người dùng (Screens & Widgets).
  - Quản lý trạng thái bằng Cubit (BLoC).
  - Điều hướng thông qua các Navigator cụ thể cho từng màn hình.
- **Core Layer (`lib/src/core`)**:
  - Chứa các tiện ích, hằng số, themes, routes và xử lý ngoại lệ dùng chung.

## 🚀 Cách chạy dự án

### Yêu cầu hệ thống
- Flutter SDK: `^3.5.0`
- Dart SDK: `^3.5.0`

### Thiết lập môi trường
1.  **Cài đặt dependencies**:
    ```bash
    flutter pub get
    ```
2.  **Sinh code tự động** (cho Hive, Equatable, v.v.):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
3.  **Chạy ứng dụng**:
    ```bash
    flutter run
    ```

## 🔄 Luồng chính (Main Flows)

1.  **Splash Flow**: 
    - Kiểm tra trạng thái "First Run".
    - Kiểm tra Session Token trong Secure Storage.
    - Nếu Token còn hạn (30s cho mục đích demo), tự động đăng nhập vào Home.
    - Nếu hết hạn hoặc lần đầu chạy, chuyển hướng sang Login.
2.  **Login Flow**:
    - Nhập thông tin đăng nhập.
    - Xác thực qua `AuthRepository` (kết hợp Hive/Firebase).
      - Lấy các tài khoản trên firebase update về Hive
      - So sánh thông tin, khớp dữ liệu thì cho đăng nhập
    - Lưu session an toàn và chuyển hướng vào Home.
3.  **Home Flow**:
    - Hiển thị thông tin người dùng từ `UserCubit`.
    - Cho phép bật/tắt xác thực sinh trắc học.
    - Thực hiện đăng xuất và xóa session.

## 🛠️ Tech Stack
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit)
- **Navigation**: [go_router](https://pub.dev/packages/go_router)
- **Local Storage**: [hive](https://pub.dev/packages/hive), [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- **Networking/Backend**: [firebase_core](https://pub.dev/packages/firebase_core), [firebase_auth](https://pub.dev/packages/firebase_auth)
- **Dependency Injection**: Provider (built-in with Bloc)
- **UI Components**: Material 3
- **Biometrics**: [local_auth](https://pub.dev/packages/local_auth)
