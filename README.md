# Go Fresher - BLoC Architecture Documentation

Tài liệu này mô tả kiến trúc sử dụng **BLoC (Business Logic Component)** đã được áp dụng cho các module ổn định (như Login) trong dự án.

## 🏗 Kiến trúc BLoC (Event-State Pattern)

Dự án sử dụng thư viện `flutter_bloc` để thực hiện quản lý trạng thái theo luồng dữ liệu đơn hướng (Unidirectional Data Flow).

- **Events**: Các sự kiện đầu vào từ UI (ví dụ: `LoginButtonPressed`).
- **States**: Các trạng thái đầu ra mà UI sẽ lắng nghe để hiển thị (ví dụ: `LoginLoading`, `LoginSuccess`).
- **Bloc/Cubit**: Thành phần trung gian nhận Event, xử lý logic nghiệp vụ và phát ra (emit) State tương ứng.
- **BlocProvider/BlocBuilder**: Các widget cung cấp và lắng nghe sự thay đổi trạng thái để vẽ lại giao diện.

---

## 🔄 Unidirectional Data Flow

Quy trình xử lý dữ liệu chuẩn hóa trong BLoC:

```mermaid
graph LR
    UI[View/UI] -- Add Event --> BLOC[BLoC/Cubit]
    BLOC -- Call --> REPO[Repository]
    REPO -- Return Data --> BLOC
    BLOC -- Emit State --> UI
```

---

## ⚖️ Phân tích kiến trúc (Trade-offs)

Kiến trúc BLoC mang lại tính kỷ luật cao và sự minh bạch trong việc quản lý trạng thái:

### ✅ Ưu điểm (Pros)
1. **Tính dự đoán cao (Predictability)**: Trạng thái của ứng dụng luôn rõ ràng và có thể dự đoán được dựa trên chuỗi Event và State đã định nghĩa. Điều này giúp việc gỡ lỗi (debugging) trở nên dễ dàng hơn.
2. **Tách biệt hoàn toàn (Strict Separation of Concerns)**: UI không hề biết về logic nghiệp vụ bên dưới. Nó chỉ gửi Event và chờ nhận State, giúp code cực kỳ sạch sẽ và dễ bảo trì.
3. **Khả năng kiểm thử (Excellent Testability)**: Do logic được tách biệt hoàn toàn và dựa trên luồng dữ liệu vào/ra rõ ràng, việc viết Unit Test cho BLoC/Cubit rất trực quan bằng thư viện `bloc_test`.
4. **Kiểm soát render (State comparison)**: Thông qua `buildWhen` và `listenWhen`, lập trình viên có quyền quyết định chính xác khi nào một phần giao diện cần được vẽ lại hoặc khi nào cần thực hiện một action (như hiện thông báo).

### ⚠️ Thách thức (Considerations)
1. **Lượng code mẫu (Boilerplate)**: Đòi hỏi phải tạo nhiều file và class (Event, State, Bloc) ngay cả cho các tính năng đơn giản, điều này có thể làm tăng thời gian phát triển ban đầu.
2. **Độ dốc học tập (Learning Curve)**: Khái niệm về Stream và kiến trúc Reactive trong BLoC có thể gây khó khăn cho những người mới tiếp cận Flutter.
3. **Cây widget phức tạp**: Việc sử dụng nhiều `BlocProvider` lồng nhau có thể khiến cây widget trở nên sâu và khó theo dõi nếu không tổ chức tốt.

---
