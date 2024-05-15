# Bài toán định tuyến 16 port Router 16x16
Thiết kế mạch có khả năng truyền dữ liệu từ port đầu vào ra một trong 16 port ngõ ra.
- Tín hiệu truyền từ 1 port đầu vào là không broadcast (truyền ra tất cả) mà chỉ truyền ra một 1 port ngõ ra duy nhất.
- Các port đầu vào có khả năng truyền đồng thời ra các port ngõ ra khác nhau. Nếu nhiều hơn 2 port đầu vào cùng truyền ra 1 port ngõ ra, lúc này sẽ có bộ phân xử (arbiter) lựa chọn port đầu vào có độ ưu tiên cao hơn để cho phép truyền thông qua cơ chế ưu tiên cố định (fix priority).
- Địa chỉ truyền gồm 4 bit đầu tiên từ khi tín hiệu frame_n xuống mức thấp. Và việc xử lý các địa chỉ này sẽ do bộ máy trạng thái hữu hạn FSM xử lý và đưa ra các tín hiệu cho phép/không cho phép việc truyền dữ liệu ra port ngõ ra.





## Minh họa mô hình thiết kế
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/design_model.png)
Thiết kế gồm:
- 16 khối FSM: xác định trạng thái và đưa ra tín hiệu ở từng trạng thái.
- 16 khối Arbiter xử lý riêng cho từng port ngõ ra.
- 16 khối DATA-ENABLE để cho phép/không cho phép truyền payload.
## 
Các tín hiệu vào ra:
- din [15:0]: các tín hiệu ngõ vào gồm <address><padding><payload>.
- frame_n [15:0]: các tín hiệu frame truyền mức thấp, kết thúc khi frame_n = 1;
- valid_n [15:0]: các tín hiệu valid bit truyền trong <payload>, bit hợp lệ khi valid_n = 0 và ngược lại.
- dout [15:0]: các tín hiệu ngõ ra gồm <payload>.
- frameo_n [15:0]: các tín hiệu frame nhận mức thấp, kết thúc khi frameo_n = 1;
- valido_n [15:0]: các tín hiệu valid bit nhận trong <payload>, bit hợp lệ khi valid_n = 0 và ngược lại.
## Sơ đồ trạng thái FSM
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/state.png)
