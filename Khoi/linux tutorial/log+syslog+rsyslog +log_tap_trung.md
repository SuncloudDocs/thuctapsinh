## I. Tổng quan về log ##
1. Định nghĩa
- Log ghi lại liên tục các thông báo về hoạt động của cả hệ thống hoặc dịch vụ được triển khai trên hệ thống và file tương ứng 
- LOG = TIME + DATA 
- `var/log` : là nơi lưu trữ lại các log

- demo mở 1 file log 
`tail /var/log/secure`
![Imgur](https://i.imgur.com/3DmMDHu.png)

- Ở file ảnh phía trên hiển thị 10 dòng log của file secure có 2 phần  : time + data 
2. Công dụng của log 
- Phân tích nguyên nhân và khắc phục nhanh hơn khi có sự cố xảy ta 
- Phát hiện và dự đoán vấn đề xảy ra với hệ thống 
3. Một số file có trong thư mục `/var/log`

- /var/log/boot.log : log trong quá trình khởi động hệ thống
- /var/log/cron : Các hoạt động của crond 
(Các hoạt động của crond bao gồm:
Chạy các lệnh được đặt trong tệp crontab cho người dùng hoặc các tệp crontab hệ thống.
Ghi lại các thông tin về các lệnh đã và đang được chạy bởi crond, bao gồm thời gian bắt đầu/chấm dứt và kết quả trả về (nếu có).
Gửi email thông báo cho người dùng về các lỗi xảy ra trong quá trình thực thi lệnh)
- /var/log/dmesg: Chứa các thông tin bộ đệm vòng kernel
- /var/log/message : Chứa thống tin chung về hệ thống
- /var/log/secure : Log xác thực
- /var/log/wtmp : Chứa tất cả các đăng nhập và đăng xuất lịch sử
- /var/log/btmp : Chứa thông tin đăng nhập không thành công

![Imgur](https://i.imgur.com/ipBS0lG.png)

- Các command thường dùng 
- `tail` : Đọc 10 dòng cuối của file `
- `tailf` : Đọc trực tiếp ngay khi có log bắn ra 
- `grep` : Hiển thị dòng chứa keyword cần tìm 
- `cat` : Đọc nội dung file
- `head` : Đọc 10 dòng đầu của file 


4. Demo  Log SSh 
- 3 Trường hợp 
   + Loging thành công
   + Login sai pass 
   + Login sai user 
- TH loging thành công 
![Imgur](https://i.imgur.com/aPVEk2x.png)
- TH sai pass
![Imgur](https://i.imgur.com/ZjhWGmq.png)

## Giao thức syslog 

1. Định nghĩa 
- Syslog là 1 giao thức client/server
- Port mặc định là 514
- Syslog được sử dụng để chuyển tiếp và thu thập log
- Có thể sử dụng UDP và TCP 

2. Đặc điểm
- Defining an architecture (xác định kiến trúc) : client /server 
- Message format (Định dạng tin nhắn): Header + MSG
- Specifying reliability (Chỉ định độ tin cậy) : Sử dụng UDP hoặc TCP 
- Message authenticity (xác thực thư ) : Máy client và server nói chuyện một cách an toàn và tin nhắn không bị thay đổi 

3. Cấp độ sở hữu (syslog facility level)
![Imgur](https://i.imgur.com/pwHvrae.png)

4. Mức độ cảnh báo (Syslog severity levels)

![Imgur](https://i.imgur.com/tubXela.png)

 + 0 - emerg : Thông báo khẩn cấp 
 + 1 - alert : Hệ thống cần can thiệp ngay 
 + 2 - crit : Tình trạng nguy kịch
 + 3 - err : Thông báo lỗi với hệ thống
 + 4 - warning : Mức độ cảnh báo lỗi với hệ thống
 + 5 - notice : Chú ý đối với hệ thống
 + 6 - info : Thông tin của hệ thống
 + 7 - debug : Quá trình kiểm tra hệ thống 
 
  - Mức độ nghiêm trọng của cảnh báo sẽ giảm dần từ 7 --> 0 (càng bé thì càng nghiêm trọng )
  
  ## Rsyslog ## 
  1. Định nghĩa 
  - Là một phần mềm mã nguồn mở được sử dụng trên Linux dùng để chuyển tiếp các log massage đến một địa chỉ mạng
  - Sử dụng giao thức syslog 
 2. Modules Rsyslog 
 - Rsyslog thiết kế theo kiểu modul.Điều này cho phép chức năng được tải động từ các modul . Có 6 modul cơ bản :
 + [Output Modules](https://www.rsyslog.com/doc/v7-stable/configuration/modules/idx_output.html)
 + [Input Modules](https://www.rsyslog.com/doc/v8-stable/configuration/modules/idx_input.html) 
 + [Parser Modules](https://www.rsyslog.com/doc/v8-stable/configuration/modules/idx_parser.html)
 + [Message Modification Modules](https://www.rsyslog.com/doc/v8-stable/configuration/modules/idx_messagemod.html)
 + [String Generator Modules](rsyslog.com/doc/v8-stable/configuration/modules/idx_stringgen.html)
 + [Library Modules](https://www.rsyslog.com/doc/v8-stable/configuration/modules/idx_library.html)
 
 - Thực hiện vào file cấu hình rsyslog để hiểu rõ hơn 
 `vi /etc/rsyslog.conf`

![Imgur](https://i.imgur.com/VVvQ9ee.png)
![Imgur](https://i.imgur.com/QQBuDr0.png)

- Cơ chế logrotate
  + Cơ chế xoay vòng log ,mở file logrote để xem
  `vi /etc/logrotate.conf`
  ![Imgur](https://i.imgur.com/HXbu1Xk.png)
  ![Imgur](https://i.imgur.com/PYP2GV1.png)

//Cũng có thể cấu hình lưu trữ theo site : 100MB .

## Log tập trung 
1. Tại sao cần sử dụng log tập trung 
- Sử dụng log tập trung để đẩy log của tất cả các con máy client về và sẽ quản lý ở trên con server 
- Giúp quản trị dễ dàng hơn 
- Giúp người quản trị xem được tất cả log của hệ thống , khu vực người quản lý 
- Giải quyết bài toán nếu 1 máy bị xóa , hoặc hỏng ổ cứng thì có thể dùng log tập trung để xem 

2. Nhược điểm
- Vấn để xử lý hiệu năng
- Nhu cầu lấy log 

Bài Lab demo log tập trung 
![Imgur](https://i.imgur.com/QDq1o9s.png)

- Trong server cấu hình 
`vi /etc/rsyslog.conf`
![Imgur](https://i.imgur.com/5kCfyA6.png)
![Imgur](https://i.imgur.com/Co9pLio.png)

Trên client 
`vi /etc/rsyslog.conf`
![Imgur](https://i.imgur.com/VXtkTPR.png)

Thực hành restart lại trên client 
`systemctl restart rsyslog`

Trên server thực hiện câu lệnh 
`tcpdump -nni ens33 port 514`   
cpdum 
![Imgur](https://i.imgur.com/jbJie5V.png)

Cấu hình thêm httpd mariadb 

Tại client tạo thêm file apache.conf và mariadb.conf ở thư mục `/etc/rsyslog.d/`
- cấu hình apache.conf
$ModLoad imfile
 #Apache error file :
$InputFileName /var/log/httpd/error_log
$InputFileTag errorlog
$InputFileSeverity info
$InputFileFacility local1
$InputRunFileMonitor

#Apache access file:
$InputFileName /var/log/httpd/access_log
$InputFileName accesslog
$InputFileSeverity info
$InputFileFacility local2
$InputRunFileMonitor

$InputFilePollInterval 10

![Imgur](https://i.imgur.com/rtGrtdl.png)


- Cấu hình mariadb 
 $ModLoad imfile

#mariadb.log file:
$InputFileName /var/log/mariadb/mariadb.log
$InputFileTag mariadblog
$InputFileSeverity info
$InputFileFacility local3
$InputRunFileMonitor

$InputFilePollInterval 10

![Imgur](https://i.imgur.com/4KZynif.png)

Khởi động lại dịch vụ httpd 
![Imgur](https://i.imgur.com/2lDvdup.png)

