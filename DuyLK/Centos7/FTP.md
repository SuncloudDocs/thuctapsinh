# FTP và Cài đặt FTP-Server bằng VSFTPD






## 1. FTP
- Khái niệm: [FTP](https://vi.wikipedia.org/wiki/FTP) (File Transfer Protocol) là giao thức truyền tải tập tin được dùng trong việc trao đổi dữ liệu qua mạng thông qua [giao thức TCP/IP](https://www.totolink.vn/article/149-mo-hinh-tcp-ip-la-gi-chuc-nang-cua-cac-tang-trong-mo-hinh-tcp-ip.html), thường hoạt động trên 2 cổng là cổng 20 và 21.
- Với giao thức FTP, các client trong mạng có thể truy cập đến máy chủ FTP để gửi hoặc lấy dữ liệu. Điểm nổi bật là người dùng có thể truy cập vào máy chủ FTP để truyền và nhận dữ liệu dù đang ở xa.

### Mô hình hoạt động của giao thức FTP
![FTP](https://user-images.githubusercontent.com/84270045/155478505-bd3a9433-6eaf-4d42-9171-5d380b0ed18f.png)

- `Control Connection`: Đây là phiên làm việc TCP logic đầu tiên được tạo ra khi quá trình truyền dữ liệu bắt đầu. Tuy nhiên, tiến trình này chỉ kiểm soát các thông tin điều khiển đi qua nó, ví dụ như các tập lệnh. Quá trình này sẽ được duy trì trong suốt quá trình phiên làm việc diễn ra.
- `Data Connection`: Khác với tiến trình Control Connection, Data Connection là một kết nối dữ liệu TCP được tạo ra với mục đích chuyên biệt là truyền tải dữ liệu giữa máy Client và máy Server. Kết nối sẽ tự động ngắt khi quá trình truyền tải dữ liệu hoàn tất.

### Các phương thức truyền dữ liệu trong giao thức FTP

FTP có 3 phương thức truyền tải dữ liệu là `stream mode`, `block mode`, và `compressed mode`.
- `Stream mode`: Phương thức này hoạt động dựa vào tính tin cậy trong việc truyền dữ liệu trên giao thức TCP. Dữ liệu sẽ được truyền đi dưới dạng các byte có cấu trúc không liên tiếp. Thiết bị gửi chỉ đơn thuần đẩy luồng dữ liệu qua kết nối TCP tới phía nhận mà không có một trường tiêu đề nhất định.

- `Block mode`:  Là phương thức truyền dữ liệu mang tính quy chuẩn hơn. Với phương thức này, dữ liệu được chia thành nhiều khối nhỏ và được đóng gói thành các FTP blocks. Mỗi block sẽ chứa thông tin về khối dữ liệu đang được gửi.

- `Compressed mode`:  Phương thức truyền sử dụng kỹ thuật nén dữ liệu khá đơn giản là `run-length encoding`. Với thuật toán này, các đoạn dữ liệu bị lặp sẽ được phát hiện và loại bỏ để giảm chiều dài của toàn bộ thông điệp khi gửi đi.


## 2. Cài đặt FTP Server bằng VSFTPD

#### Bước 1: Cập nhật trình quản lý gói.
Ta dùng lệnh `yum update`

Tiếp theo ta cài đặt `VSFTPD`: `yum install vsftpd`

Khởi động dịch vụ và đặt tự động bắt đầu khi khởi động:
```
systemctl start vsftpd
systemctl enable vsftpd
```

Mở Port FTP 21 và FTP Service:
```
firewall-cmd --zone=public --permanent --add-port=21/tcp
firewall-cmd --zone=public --permanent --add-service=ftp
firewall-cmd --reload
```

#### Bước 2: Cấu hình VSFTPD
Mặc định file cấu hình FTP service ở vị trí `/etc/vsftpd/vsftpd.conf`.

1. Trước khi start, tạo một bản copy of the default file cấu hình: `cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default`

2. Kế tiếp chỉnh sửa file cấu hình: `vi /etc/vsftpd/vsftpd.conf`

3. Đặt máy chủ FTP vô hiệu hóa người dùng ẩn danh và cho phép người dùng cục bộ: 
```
anonymous_enable=NO
local_enable=YES
```

4. Tiếp theo, cho phép người dùng đăng nhập để tải các tập tin lên máy chủ FTP của bạn.

Tìm kiếm sau đây và chỉnh sửa để khớp như sau:
```
write_enable=YES
```

5. Giới hạn FTP users vào thư mục riêng:
```
chroot_local_user=YES
allow_writeable_chroot=YES
```

Lưu ý: với mục đích kiểm tra, tùy chọn `allow_writable_chroot=YES` sẽ tạo một máy chủ FTP đang hoạt động mà bạn có thể kiểm tra và sử dụng. Một số quản trị viên ủng hộ việc sử dụng tùy chọn `user_sub_token` để bảo mật tốt hơn. 

6. Tiện ích `vsftpd` cung cấp một cách để tạo danh sách người dùng được phê duyệt. Để quản lý người dùng theo cách này, hãy tìm mục nhập `userlist_enable`, sau đó chỉnh sửa tệp để xem như sau :
```
userlist_enable=YES
userlist_file=/etc/vsftpd/user_list
userlist_deny=NO
```

Bạn có thể sửa nội dung file `/etc/vsftpd/user_list`, và thêm user vào list. (Mỗi user cách nhau một dòng.)tùy chọn `userlist_deny` cho phép bạn thêm một số users đặt biệt vào; Đặt là `yes` sẽ thay đổi các user có trong list sẽ bị blocked.

7. Mỗi khi chỉnh sữa file cấu hình. Bạn cần restart service vsftpd để áp dụng:
```
systemctl restart vsftpd
```

#### Bước 3: Tạo một FTP user.
1. Tạo một FTP User như sau:
```
adduser testuser
passwd testuser
```
**Ở trên ta đang tạo 1 user có tên là `testuser` và pass là `testuser`**
**Hệ thống sẽ nhắc bạn nhập và xác nhận mật khẩu cho người dùng mới.**

2. Thêm user mới vào userlist:
```
echo "testuser" | sudo tee –a /etc/vsftpd/user_list
```

3. Tạo thư mục cho user, và gán quyền permissions:
```
mkdir -p /home/testuser/ftp/upload
chmod 550 /home/testuser/ftp
chmod 750 /home/testuser/ftp/upload
chown -R testuser: /home/testuser/ftp
```


**Vậy là đã hoàn thành cài đặt FTP Server trên Centos7. Chúc các bạn thành công.**
