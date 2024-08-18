# Bài toán định tuyến 16 port Router 16x16
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/description.png)

Thiết kế mạch có khả năng truyền dữ liệu từ port đầu vào ra một trong 16 port ngõ ra.
- Tín hiệu truyền từ 1 port đầu vào là không broadcast (truyền ra tất cả) mà chỉ truyền ra một 1 port ngõ ra duy nhất.
- Các port đầu vào có khả năng truyền đồng thời ra các port ngõ ra khác nhau. Nếu nhiều hơn 2 port đầu vào cùng truyền ra 1 port ngõ ra, lúc này sẽ có bộ phân xử (arbiter) lựa chọn port đầu vào có độ ưu tiên cao hơn để cho phép truyền thông qua cơ chế ưu tiên cố định (fix priority).
- Địa chỉ truyền gồm 4 bit đầu tiên từ khi tín hiệu frame_n xuống mức thấp. Và việc xử lý các địa chỉ này sẽ do bộ máy trạng thái hữu hạn FSM xử lý và đưa ra các tín hiệu cho phép/không cho phép việc truyền dữ liệu ra port ngõ ra.

Các packets gồm 2 phần chính
- Header : chứa thông tin 4 bit địa chỉ.
- Payload: chứa thông tin dữ liệu.
## Minh họa mô hình thiết kế
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/model.png)
Thiết kế gồm:
- 16 khối FSM: xác định trạng thái và đưa ra tín hiệu ở từng trạng thái.
- 16 khối Arbiter xử lý riêng cho từng port ngõ ra.
- 16 khối DATA-ENABLE để cho phép/không cho phép truyền payload.
## 
Các tín hiệu vào ra:
- din [15:0]: các tín hiệu ngõ vào nối tiếp từng bit (serial) gồm
    - address: 4 bit địa chỉ dùng để xác định port ngõ ra.
    - padding: giai đoạn chờ khi port cần truyền đang busy.
    - payload: các bit dữ liệu cần truyền ra port ngõ ra.
- frame_n [15:0]: các tín hiệu frame truyền, bắt đầu truyền khi frame_n = 0, kết thúc truyền khi frame_n = 1;
- valid_n [15:0]: các tín hiệu valid bit truyền trong payload, bit hợp lệ khi valid_n = 0 và ngược lại.
- dout [15:0]: các tín hiệu ngõ ra nối tiếp từng bit (payload).
- frameo_n [15:0]: các tín hiệu frame nhận, bắt đầu nhận khi frameo_n = 0, kết thúc nhận khi frameo_n = 1;
- valido_n [15:0]: các tín hiệu valid bit nhận trong payload, bit hợp lệ khi valid_n = 0 và ngược lại.

## Xây dựng máy trạng thái FSM
- Sơ đồ trạng thái FSM
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/state.png)
- Kết quả waveform FSM
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/FSM.png)

## Xây dựng bộ phân xử (fix priority arbiter)
- Nguyên lý hoạt động: bộ phân xử có nhiệm vụ xử lý các yêu cầu (request) từ 16 port đầu vào và đưa ra sự cấp phát (grant) cho yêu cầu thoã mãn với các điều kiện:
    - Request[i] có độ ưu tiên giảm dần khi i tăng dần từ 0->15.
    - Request[i] sẽ được grant cho đến khi request[i] kết thúc dù cho có các request[*] có độ ưu tiên cao hơn.
- Kết quả waveform Arbiter
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/wf_arbiter.png)

## Kết quả Waveform tổng quát
- din[0], din[1], din[2], din[3] cùng truyền đồng thời.
- din[0] => dout [15]                : do dout[15] đang không busy, nên din[0] được phép truyền và cho đến khi kết thúc việc truyền.
- din[1], din[2], din[3] => dout [14]: do din[1] có độ ưu tiên cao hơn nên din[1] được truyền đầu tiên, sau đó lần lượt tới các din[2], din[3].
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/waveform.png)

## Xây dựng bộ kiểm tra dựa trên phương pháp hướng đối tượng OOP
- Minh hoạ các Verification Component của thiết kế
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/verification_component.png)
- Minh hoạ kiến trúc của test bench
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/tb_architecture.png)
- Kết quả mô phỏng
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/waveform2.png)
- Minh hoạ kết quả mô phỏng qua TCL Console (chi tiết ở file \sim_1\new\tclConsole.txt)
![github](https://github.com/PhuocTai03/Router-16x16/blob/main/media/tclConsole.png)
