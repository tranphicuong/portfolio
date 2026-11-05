# CV Portfolio — Flutter

Ứng dụng **CV điện tử cá nhân** (Personal Portfolio) của **Trần Phi Cường**, xây dựng bằng **Flutter & Dart** cho bài test vòng 02 — Thực tập sinh Lập trình Mobile.

- **Video demo: https://drive.google.com/drive/folders/1dPsLx4YYVLkNlyQ4eZbTlwWHHo-lqWe5?usp=sharing
- **Source code: https://github.com/tranphicuong/portfolio

## Tính năng đã làm

### Các màn hình (5 trang + 404)

| Route | Nội dung |
|---|---|
| `/` Home | Hero section: avatar (animation lơ lửng), tên, chức danh *Flutter Developer Intern*, nút CTA (**Xem dự án**, **Liên hệ**, **Tải CV**), số liệu nhanh, lối tắt tới các trang |
| `/resume` | Thông tin cá nhân, mục tiêu nghề nghiệp, học vấn và kinh nghiệm (timeline) |
| `/skills` | Kỹ năng chuyên môn hiển thị bằng progress bar + icon, kỹ năng mềm |
| `/projects` | 4 dự án (ảnh chụp màn hình, mô tả, công nghệ, link GitHub), **lọc theo tag công nghệ** |
| `/contact` | Form Name / Email / Message có validation, lưu vào Firestore và gửi email thông báo |
| `*` | Trang **404 Not Found** cho mọi route không hợp lệ |

### Yêu cầu kỹ thuật

- **Navigation / Routing:** `go_router` với `ShellRoute` (thanh điều hướng cố định), `errorBuilder` hiển thị trang 404.
- **URL không có dấu `#`:** `usePathUrlStrategy()` trong `main.dart`.
- **Page Transition:** 4 hiệu ứng chuyển trang khác nhau (fade, slide từ phải, scale, slide lên) bằng `CustomTransitionPage`, thêm `PageTransitionsBuilder` tuỳ chỉnh trong theme.
- **Animation UI:** avatar lơ lửng, đếm số ở thẻ thống kê, progress bar kỹ năng chạy khi cuộn tới, gạch chân menu, xoay icon khi đổi theme.
- **Data-driven:** dữ liệu dự án là danh sách object (`lib/data/portfolio_data.dart`), render bằng **`GridView.builder`**.
- **Filter:** lọc dự án theo tag công nghệ bằng `ChoiceChip` (có đếm số dự án mỗi tag).
- **Contact form validation:**
  - Họ tên không để trống, email đúng định dạng, nội dung tối thiểu 20 ký tự.
  - Hiển thị `CircularProgressIndicator` khi đang gửi, thông báo Success / Error bằng `SnackBar` (không dùng `print()`).
  - Gửi thành công thì xoá form.
- **Responsive:** hiển thị tốt trên Mobile / Tablet / Desktop bằng `LayoutBuilder` và `MediaQuery`, menu chuyển sang Drawer khi màn hình hẹp.
- **Tương tác:** hiệu ứng hover trên nút và thẻ, nút **Back to top** cuộn mượt.
- **Accessibility:** dùng `Semantics` cho các thành phần quan trọng, ảnh có `errorBuilder` (hiện khung dự phòng khi ảnh lỗi hoặc thiếu).
- **Project structure & clean code:** thư mục `models`, `views`, `widgets`, `utils`; tách widget tái sử dụng (`ProjectCard`, `SkillBar`, `CustomButton`, `HoverCard`...); dùng `flutter_lints`, đặt tên camelCase.

### Điểm cộng

- **Dark Mode** (`ThemeMode`), chuyển Sáng / Tối bằng nút trên thanh điều hướng.
- **State management** bằng **Provider** (`ThemeProvider`, `ProjectFilterProvider`).
- **Micro-interactions:** Scroll Reveal (nội dung mờ dần và trượt nhẹ khi cuộn tới).
- Backend thật cho form liên hệ: **Firebase Firestore** + **EmailJS**.

## Tech stack

| Nhóm | Công nghệ |
|---|---|
| Framework | Flutter (stable), Dart |
| Routing | go_router |
| State management | provider |
| Backend | Firebase Firestore (`firebase_core`, `cloud_firestore`) |
| Email thông báo | EmailJS (REST, package `http`) |
| Khác | url_launcher, flutter_lints |

## Hướng dẫn chạy

Yêu cầu: đã cài Flutter SDK (bản stable mới nhất) và trình duyệt Chrome.

```bash
# 1. Cài dependency
flutter pub get

# 2. Chạy trên Chrome
flutter run -d chrome
```

Kiểm tra chất lượng code:

```bash
flutter analyze
flutter test
```

Build web: `flutter build web`. Khi deploy cần cấu hình rewrite mọi đường dẫn về `index.html` vì app dùng URL không có dấu `#`.

## Cấu trúc thư mục

```
lib/
├── main.dart                  # Điểm vào: khởi tạo Firebase, URL strategy, Provider
├── app.dart                   # MaterialApp.router, theme
├── firebase_options.dart      # Cấu hình Firebase (tạo bằng flutterfire configure)
├── data/portfolio_data.dart   # Toàn bộ nội dung CV
├── models/                    # Project, Skill, TimelineEntry, ContactMessage
├── providers/                 # ThemeProvider, ProjectFilterProvider
├── router/app_router.dart     # Routes, trang 404, page transitions
├── services/                  # ContactService (Firestore + EmailJS)
├── theme/app_theme.dart       # Theme sáng / tối, typography
├── utils/                     # constants, responsive, validators, launcher...
├── views/                     # 5 trang + NotFoundPage
└── widgets/                   # Widget tái sử dụng
assets/images/                 # avatar và ảnh chụp màn hình dự án
web/cv/                        # File CV (PDF) cho nút Tải CV
```

## Cấu hình backend form liên hệ (tuỳ chọn)

Repo đã kèm sẵn cấu hình để chạy ngay. Muốn dùng project Firebase / EmailJS của riêng mình:

**Firebase Firestore**

1. Tạo project Firebase, bật Firestore Database.
2. Chạy `flutterfire configure --platforms=web` để sinh lại `lib/firebase_options.dart`.
3. Đặt Firestore Rules: cho phép tạo document trong collection `contacts` với dữ liệu hợp lệ, không cho đọc / sửa / xoá.

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /contacts/{id} {
      allow create: if request.resource.data.keys().hasOnly(['name', 'email', 'message', 'createdAt'])
        && request.resource.data.name is string
        && request.resource.data.name.size() >= 2
        && request.resource.data.name.size() <= 100
        && request.resource.data.email is string
        && request.resource.data.email.size() <= 200
        && request.resource.data.message is string
        && request.resource.data.message.size() >= 20
        && request.resource.data.message.size() <= 2000
        && request.resource.data.createdAt == request.time;
      allow read, update, delete: if false;
    }
  }
}
```

**EmailJS:** điền `serviceId`, `templateId`, `publicKey` vào class `EmailJsConfig` trong `lib/utils/constants.dart`. Template dùng các biến `from_name`, `from_email`, `message`, `reply_to`. Email chỉ là thông báo phụ, nếu gửi email lỗi thì tin nhắn vẫn được lưu vào Firestore.

Các khoá Firebase web và EmailJS public key được thiết kế để công khai ở phía client, việc bảo vệ nằm ở Firestore Rules và giới hạn domain trên EmailJS.

## Tuỳ chỉnh nội dung

1. Sửa `lib/data/portfolio_data.dart`: họ tên, email, GitHub, học vấn, kinh nghiệm, kỹ năng, dự án.
2. Thêm ảnh vào `assets/images/`: `avatar.png`, `project_portfolio.png`, `project_fieldshub.png`, `project_timemark.png`, `project_findback.png`. Thiếu ảnh thì app tự hiện khung dự phòng.
3. Thay file CV trong `web/cv/TranPhiCuong_CV.pdf` (giữ nguyên tên file) để cập nhật nút **Tải CV**. Nút này mở PDF ở tab mới và chỉ hoạt động trên bản web.

