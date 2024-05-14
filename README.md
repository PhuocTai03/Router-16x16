
# Bài toán định tuyến 16 port Router 16x16
Thiết kế mạch có khả năng truyền dữ liệu từ port đầu vào ra một trong 16 port ngõ ra.
- Tín hiệu truyền từ 1 port đầu vào là không broadcast (truyền ra tất cả) mà chỉ truyền ra một 1 port ngõ ra duy nhất.
- Các port đầu vào có khả năng truyền đồng thời ra các port ngõ ra khác nhau. Nếu nhiều hơn 2 port đầu vào cùng truyền ra 1 port ngõ ra, lúc này sẽ có bộ phân xử (arbiter) lựa chọn port đầu vào có độ ưu tiên cao hơn để cho phép truyền thông qua cơ chế ưu tiên cố định (fix priority).
- Địa chỉ truyền gồm 4 bit đầu tiên từ khi tín hiệu frame_n xuống mức thấp. Và việc xử lý các địa chỉ này sẽ do bộ máy trạng thái hữu hạn FSM xử lý và đưa ra các tín hiệu cho phép/không cho phép việc truyền dữ liệu ra port ngõ ra.





## Screenshots

![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/mohinhthietke.png)

