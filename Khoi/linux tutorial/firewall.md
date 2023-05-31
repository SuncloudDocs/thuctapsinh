#Giới thiệu về firewall và cách thức sử dụng trên centOS7
##1. Cách thức sử dụng firewall 
- Firewalld là một giải pháp quản lý firewall có sẵn cho nhiều bản phân phối Linux hoạt động như một giao diện người dùng cho hệ thống lọc gói iptables do hạt nhân Linux cung cấp. Firewalld được cài đặt mặc định trên RHEL 7 và CentOS 7, nhằm thay thế Iptables với những khác biệt cơ bản
- Firewalld sử dụng “zones” và “services”
##2. Các khái niệm cơ bản trong firewall
- zone : Là một nhóm giao diện mạng có tính bảo mật tương đương . Mỗi zone có một cách thức xử lý riêng biệt đối với các kết nối mạng

- Service: Là một tập hợp các cổng và giao thức được sử dụng để cung cấp một dịch vụ cụ thể (ví dụ như HTTP, FTP, SSH).
- Port: Là một số nguyên dương đại diện cho một cổng mạng. Các cổng này được sử dụng để giao tiếp giữa các máy tính và thiết bị trên mạng.
- Source: Đại diện cho các địa chỉ IP hoặc phân đoạn mạng từ nơi các kết nối được phép đến máy tính.
- Destination: Đại diện cho các địa chỉ IP hoặc phân đoạn mạng của máy tính mà các kết nối được điều hướng tới.
- Masquerade: Là một quy tắc NAT cho phép các máy tính trong một mạng riêng tư truy cập internet thông qua một địa chỉ IP công khai chung của router hoặc gateway.
- Forward: Là một quy tắc cho phép các gói tin được điều hướng từ một zone sang zone khác.

##2.2 Quy tắc Runtime/Permanent
2.2.1 Trong Firewalld, các quy tắc được cấu hình thời gian hiệu lực Runtime hoặc Permanent.
- Runtime(mặc định): có tác dụng ngay lập tức, mất hiệu lực khi reboot hệ thống.
- Permanent: không áp dụng cho hệ thống đang chạy, cần reload mới có hiệu lực, tác dụng vĩnh viễn cả khi reboot hệ thống.

- VD
`firewall-cmd --permanent --zone=public --add-service=http`
`firewall-cmd --zone=public --add-service=http --permanent`
`firewall-cmd --reload`
##3.Cài dặt firewall
- Thường thì sẽ được cài đặt sẵn mặc định trên centOS7 . Cài đặt nếu chưa có 
`yum install -y firewall`
- Sau khi cài đặt xong khởi động Firewall
`systemctl start firewall`
- Kiểm tra hoạt động của Firewalld:
`systemctl status firewall`
- Thiết lập Firewalld khởi động cùng hệ thống
`systemctl enable firewall`
- Khởi động lại Firewalld
`systemctl restart firewall`
`firewall-cmd --reload`

- Dừng và vô hiệu hóa Firwalld
`systemctl stop firewall`
`systemctl disable firewall` //câu lệnh này là vô hiệu hóa 

##4. Thiết lập cho service 
- Đầu tiên, xác định các services trên hệ thống:
`firewall-cmd --get-services`
Hệ thống thông thường cần cho phép các services sau: ssh(22/TCP), http(80/TCP), https(443/TCP), smtp(25/TCP)

- Thiết lập cho phép services trên FirewallD, sử dụng –add-service. Ví dụ, cho phép service http:
`firewall-cmd --zone=public --add-service=http`

` firewall-cmd --zone=public --add-service=http --permanent`

- Vô hiệu hóa services trên FirewallD, sử dụng –remove-service:
`firewall-cmd --zone=public --remove-service=http`

`firewall-cmd --zone=public --remove-service=http --permanent`
##5 Mở port
- Mở port với tham số -add-port
`firewall-cmd --zone=public --add-port=80/tcp`

`firewall-cmd --zone=public --add-port=200/tcp --permanent `
- Kiểm tra lại port đang mở: 
`firewall-cmd --zone=public --list-ports`