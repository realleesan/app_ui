# Demo App - Màn hình Ca làm việc

## Mô tả
Ứng dụng demo Flutter với màn hình "Ca làm việc" được thiết kế dựa trên Figma của khách hàng.

## Tính năng đã hoàn thành

### 🏠 Màn hình chính (Home)
- Header gradient đẹp mắt với màu tím-xanh
- Thanh tìm kiếm hiện đại
- Thống kê người dùng và độ hài lòng
- Grid 4 tính năng chính với icon và màu sắc
- Bottom navigation với 4 tab
- Thiết kế Material Design 3

### 📅 Màn hình Ca làm việc (Work Shift)
- **Status bar** hiển thị thời gian và pin
- **Header** với nút back và title
- **Card ca làm việc hôm nay** với:
  - Thời gian còn lại đến ca
  - Giờ làm việc (09:00 AM - 05:00 PM)
  - Thời lượng ca làm
- **Nút đăng ký ca làm** màu xanh nổi bật
- **2 nút hành động**:
  - Bổ sung công (màu cam)
  - Xin nghỉ phép (màu đỏ)
- **Lịch tuần** với:
  - Dropdown chọn tháng
  - 5 ngày trong tuần
  - Highlight ngày được chọn
- **Timeline lịch làm việc** với:
  - Cột thời gian từ 07:00 - 22:00
  - Khối ca sáng (09:00-12:00) màu vàng
  - Khối ca chiều (13:00-17:00) màu xanh
- **Hoạt động gần đây** với:
  - Check in/out
  - Đăng ký ca
  - Họp đồng
- **Bottom navigation** tùy chỉnh

## Cách chạy ứng dụng

### 1. Chạy trên Web (Edge)
```bash
cd demo_app
flutter run -d edge
```

### 2. Chạy trên Web (Chrome) - nếu có lỗi thì dùng Edge
```bash
cd demo_app
flutter run -d chrome
```

### 3. Xem danh sách thiết bị
```bash
flutter devices
```

## Cách sử dụng

1. **Màn hình chính**: Nhấn vào card "Mobile First" để chuyển đến màn hình Ca làm việc
2. **Màn hình Ca làm việc**: 
   - Xem thông tin ca làm việc hôm nay
   - Nhấn "Đăng ký ca làm" để đăng ký ca mới
   - Nhấn "Bổ sung công" hoặc "Xin nghỉ phép"
   - Chọn ngày khác trong tuần
   - Xem timeline lịch làm việc
   - Xem hoạt động gần đây

## Cấu trúc code

```
lib/
├── main.dart              # Màn hình chính với navigation
├── work_shift_screen.dart # Màn hình Ca làm việc
└── ...
```

## Màu sắc chính

- **Primary**: `#21D4D4` (Xanh ngọc)
- **Secondary**: `#6366F1` (Tím)
- **Warning**: `#F79009` (Cam)
- **Error**: `#F95555` (Đỏ)
- **Success**: `#10B981` (Xanh lá)
- **Background**: `#F8F8FB` (Xám nhạt)
- **Text**: `#111927` (Đen)

## Fonts
- **Primary**: Roboto
- **Secondary**: Inter

## Responsive Design
- Thiết kế tối ưu cho mobile (390x844)
- Tương thích với các kích thước màn hình khác
- Sử dụng Expanded và Flexible widgets

## Hot Reload
Khi ứng dụng đang chạy, bạn có thể:
- Nhấn `r` để hot reload
- Nhấn `R` để hot restart
- Nhấn `q` để thoát

## Ghi chú
- Code được tối ưu hóa từ Figma design
- Sử dụng Material Design 3
- Responsive và clean code
- Dễ dàng customize màu sắc và layout