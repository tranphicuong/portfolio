# CV Portfolio — Flutter

Ứng dụng **CV điện tử cá nhân** (Personal Portfolio) xây dựng bằng **Flutter & Dart**: responsive trên Mobile / Tablet / Desktop, có Dark Mode, page transition, lọc dự án theo công nghệ và form liên hệ có validation.

## Tính năng đã làm

**Màn hình (5 trang + 404)**

| Route | Nội dung |
|---|---|
| `/` Home | Hero section: avatar (animation lơ lửng), tên, chức danh *Flutter Developer Intern*, nút CTA; số liệu nhanh; lối tắt tới các trang |
| `/resume` | Thông tin cá nhân, mục tiêu nghề nghiệp, học vấn & kinh nghiệm (timeline) |
| `/skills` | Kỹ năng chuyên môn với progress bar chạy khi cuộn tới; kỹ năng mềm với icon |
| `/projects` | 5 dự án (ảnh, mô tả, công nghệ, link GitHub), **lọc theo tag công nghệ** |
| `/contact` | Form Name / Email / Message có validation, trạng thái loading + Success/Error |
| `*` | Trang **404 Not Found** cho route không hợp lệ |

**Kỹ thuật**

- **Routing**: `go_router` với `ShellRoute` (thanh điều hướng cố định), `errorBuilder` → trang 404.
- **URL không có dấu `#`**: `usePathUrlStrategy()` trong `main.dart`.
- **Page Transition (4 kiểu)**: fade, slide từ phải, scale, slide-up (`CustomTransitionPage`), ngoài ra `PageTransitionsBuilder` tuỳ chỉnh trong theme.
- **Animation UI**: avatar lơ lửng, đếm số ở thẻ thống kê, progress bar kỹ năng, gạch chân nav, xoay icon đổi theme, hover scale ở thẻ/nút.
- **Data-driven**: dữ liệu là danh sách object (`lib/data/portfolio_data.dart`), render bằng `SliverGrid` lazy (`SliverChildBuilderDelegate`).
- **Filter**: `ChoiceChip` lọc dự án theo tag (có đếm số dự án mỗi tag).
- **Validation**: email đúng định dạng, message tối thiểu 20 ký tự; `CircularProgressIndicator` khi gửi; thông báo bằng `SnackBar` (không dùng `print`).
- **Responsive**: `LayoutBuilder`, `MediaQuery`, `SliverLayoutBuilder`; nav chuyển sang Drawer khi màn hẹp.
- **Accessibility**: `Semantics` cho thành phần quan trọng, ảnh có `errorBuilder` (fallback gradient + icon).
- **Tương tác**: hover effect, nút **Back to top** (cuộn mượt), kéo chuột để cuộn trên desktop.
- **Điểm cộng**: **Dark Mode** (`ThemeMode`), **State management với Provider** (`ThemeProvider`, `ProjectFilterProvider`), **lazy loading**, **Scroll Reveal**.
- **Clean code**: `flutter_lints`, camelCase, tách widget tái sử dụng (`ProjectCard`, `SkillBar`, `CustomButton`, `HoverCard`...).

## Tech stack

Flutter (stable) · Dart · go_router · provider · url_launcher · flutter_lints

## Cấu trúc thư mục

```
lib/
├── main.dart                  # Điểm vào, URL strategy, Provider
├── app.dart                   # MaterialApp.router, theme
├── data/portfolio_data.dart   # TOÀN BỘ nội dung CV (sửa ở đây)
├── models/                    # Project, Skill, TimelineEntry, ContactMessage
├── providers/                 # ThemeProvider, ProjectFilterProvider
├── router/app_router.dart     # Routes + 404 + page transitions
├── services/                  # ContactService (giả lập gửi form)
├── theme/app_theme.dart       # Light/Dark theme, typography
├── utils/                     # constants, responsive, validators, transitions...
├── views/                     # 5 trang + NotFoundPage
└── widgets/                   # Widget tái sử dụng
assets/images/                 # avatar.png, project_*.png
```

## Chạy ứng dụng

```bash
# 1. Lần đầu: sinh các thư mục nền tảng (android/ios/web...) còn thiếu.
#    (Nên git commit trước; lệnh này không ghi đè code trong lib/)
flutter create . --platforms=web,android,ios --project-name cv_portfolio

# 2. Cài dependency
flutter pub get

# 3. Chạy trên Chrome
flutter run -d chrome
```

Kiểm tra chất lượng:

```bash
flutter analyze
flutter test
```

Build web: `flutter build web` (khi deploy cần cấu hình rewrite mọi đường dẫn về `index.html` vì dùng URL không dấu `#`; Firebase Hosting: `"rewrites": [{"source": "**", "destination": "/index.html"}]`).

## Tuỳ chỉnh nội dung

1. Sửa `lib/data/portfolio_data.dart`: họ tên, email, GitHub, học vấn, kinh nghiệm, kỹ năng, dự án.
2. Thêm ảnh vào `assets/images/`: `avatar.png`, `project_portfolio.png`, `project_findback.png`, `project_fieldshub.png`, `project_timemark.png`, `project_fnb.png`. Chưa có ảnh thì app tự hiện fallback (không lỗi).

## Demo trạng thái lỗi của form liên hệ

Form chưa nối backend (giả lập gửi 1.8 giây). Để quay demo **trạng thái lỗi**, nhập nội dung tin nhắn có chứa `#error` → hiện SnackBar lỗi. Nhập bình thường → SnackBar thành công. Muốn gắn backend thật chỉ cần sửa `ContactService.send()`.

## Gợi ý quay video demo

1. Chuyển trang qua thanh điều hướng → thấy các **page transition** khác nhau.
2. Trang Projects: bấm các tag → **filter** thay đổi danh sách.
3. Trang Contact: bấm gửi khi để trống (lỗi validation) → nhập email sai / message < 20 ký tự → nhập đúng và gửi (loading → thành công).
4. Thu nhỏ cửa sổ trình duyệt để thấy **responsive**; bật **Dark Mode**; thử URL sai (ví dụ `/abc`) để thấy trang **404**.
