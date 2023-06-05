# Nginx 
## Định nghĩa 
![Imgur](https://i.imgur.com/z5gPl85.png)
- Nginx là một máy chủ web server mã nguồn mở, được sử udnjg như 1 web server 
- Được thiết kế hướng tối mục đích cải thiện hiệu năng và sự ổn định 
- Có thể hoạt động như 1 proxy server ,resver proxy, và trung gian để cân bằng tải các máy chủ HTTP,TCP,UDP
- Nginx cung cấp gần như tất cả các chức năng máy chủ web
## 2. Nginx có thể làm được những tính năng gì?
### 2.1 web server 
 + nginx có thể được sử dụng như một web server cho một trang web tĩnh, và nó có thể hỗ trợ nhiều ngôn ngữ ,nginx được phát triển để tối ưu hóa nhất .Hiệu suất cực kì lớn . Theo báo cáo nó có thể hỗ trợ 50,000 lượt truy cập

### 2.2 Forword Proxy
+ Nginx không chỉ hoạt động như 1 reverse proxy mà nó có thể cân bằng tải .Nó có thể thực hiện chuyển tiếp các chức năng như lướt web.
+ Có thể hiểu Forword Proxy : Nếu  kết nối bên ngoài mạng LAN được hình dung rất lớn , thì máy khách hàng trong mạng LAN cần truy cập internet thông qua 1 máy chủ proxy => Loại dịch vụ này có thể hiểu là forword proxy

### 2.3 Reverse Proxy 
 + Máy client sẽ gửi 1 request đến reverse proxy server . Sau đó reverse proxy server sẽ lấy dữ liệu từ máy chủ để gửi về máy client , trong một khoảng thời gian thì reserse proxy server taget 1 máy chủ server ở bên ngoài . Nhằm mục đích ẩn IP của máy chủ 
 
 ### 2.4 Load balacing(cân bằng tải) 
 + Khi khách hàng gửi nhiều request đến một server , và sau đó server xử lý các yêu cầu . Một số có yêu cầu có thể tương tác database . Sau khi server xử lý xong trả về kết quả cho client 
 + Mục tiêu chính của cân bằng tải là tối ưu hóa việc sử dụng tài nguyên, tối đa hóa thông lượng, giảm thiểu thời gian phản hồi và tránh quá tải trên bất kỳ máy nào
## 3. Chức năng của nginx
- Cung cấp dịch vụ máy chủ web: Nginx có thể đóng vai trò là một máy chủ web để phục vụ các trang web tĩnh và động.
- Cân bằng tải: Nginx có thể chia sẻ khối lượng công việc giữa nhiều máy chủ để nâng cao hiệu suất.
- Bảo mật: Nginx cung cấp hàng loạt tính năng bảo mật như bảo vệ chống DDOS, giới hạn tốc độ truy cập và bảo mật SSL/TLS.
- Tăng tốc độ truy cập: Nginx có thể tối ưu hóa tài nguyên và giảm thời gian phản hồi cho các yêu cầu web.
- Phục vụ nội dung tĩnh: Nginx có thể phục vụ các tài liệu tĩnh như CSS, HTML, JS, hình ảnh, video và âm thanh.
- Tích hợp với ứng dụng web: Nginx có thể làm việc với các ứng dụng web như WordPress, Drupal, Joomla và Django để cung cấp trang web nhanh hơn và ổn định hơn.
- Proxy: Nginx có thể hoạt động như một proxy server, giúp điều hướng các yêu cầu từ người dùng tới máy chủ web.
### 4. Nhược điểm của nginx 
- Không hỗ trợ các ứng dụng CGI
- Hạn chế một vài tính năng so với apache : Mặc dù có một số tính năng mạnh mẽ hơn apache nhưng nó không nhiều plugin và module như apache => Khiến cho việc mở rộng khó hơn
- Khó khăn trong việc cấu hình ban đầu : Vì yêu cầu kinh nghiệm
- Chi phí cao cho phiên bản thương mại 
- Khó sửa lỗi 

### 5. Khác biệt giữa apache và nginx
- apache hoạt động theo kiến trúc module , nginx hoạt động theo kiểu kiến trúc ngăn xếp => do đó nginx có thể xử lý cùng lúc hàng ngàn kết nối mà không ảnh hưởng tới hiệu suất 
- Hiệu suất: Nhờ kiến trúc ngắn xếp và việc xử lý bất đồng bộ, Nginx thường có hiệu suất cao hơn Apache trong các tình huống tải cao.
- Cấu hình: Cấu hình của Nginx được viết bằng ngôn ngữ cấu trúc, dễ dàng hiểu và sửa đổi hơn so với các tập tin cấu hình của Apache.
- Tính năng: Apache có nhiều tính năng phong phú hơn so với Nginx, ví dụ như mod_rewrite, mod_ssl và mod_perl. Tuy nhiên, Nginx đã phát triển thêm một số tính năng mới trong những năm gần đây như hỗ trợ FastCGI cache, SPDY và HTTP/2.
- Sử dụng tài nguyên: Nginx sử dụng ít bộ nhớ hơn so với Apache trong khi hoạt động, do đó có thể phù hợp hơn với các máy chủ có tài nguyên hạn chế.
- Phù hợp với ứng dụng cụ thể: Mỗi máy chủ web có những điểm mạnh riêng và phù hợp với ứng dụng cụ thể. Ví dụ, Apache làm việc tốt hơn với các ứng dụng CGI, trong khi Nginx làm việc tốt hơn với các ứng dụng API RESTful.

 ## Phiên bản Nginx Plus 
 ![Imgur](https://i.imgur.com/aGrbMCH.png)
### Một số lợi ích của Nginx Plus 
- 1. Hỗ trợ khác hàng chuyên nghiệp : Không chỉ cung cấp các tính năng cơ bản như web server , Nginx Plus còn hỗ trợ chuyên sâu về các tính năng như Load Balancing ,Health Checks, Session Persistence và nhiều tính năng khác giúp các khách hàng doanh nghiệp có thể tối ưu hóa hiệu suất và độ tin cậy của trang web của mình.
- 2. Hỗ trợ khác hàng với môi trường đa nền tảng : Windows, Linux, Unix, Solaris và FreeBSD.
- 3.  Nginx Plus có kênh hỗ trợ riêng cho khách hàng cao cấp, giúp hỗ trợ và giải quyết các vấn đề nhanh chóng và hiệu quả.

## Cách thức cài đặt Nginx

### 1. Tải và lựa chọn phiên bản 
- Update lại hệ thống 
`sudo yum install update`
`yum install -y epel-release`
- Cài đặt sử dụng câu lệnh 
`sudo yum install nginx -y`
- Sau khi tải về muốn khởi động nginx
- `systemctl start nginx`

- Cấu hình firewall và restart lại dịch vụ:
`sudo firewall-cmd --permanent --zone=public --add-service=http `
`sudo firewall-cmd --permanent --zone=public --add-service=https`
`sudo firewall-cmd --reload`

- Để cho phép Nginx khởi động cùng server 
`systemctl enable nginx`

Kiểm tra xem bạn cìa đặt thành công nginx chưa bằng cách truy cập vào địa chỉ IP của máy 
![Imgur](https://i.imgur.com/UKcRYio.png)

### Các lệnh và tập lệnh phổ biến của nginx
1. Xem số phiên bản của nginx 
`nginx -v`

2. Bắt đầu nginx 
`systemctl nginx start`
3. Reaload nginx
`nginx -s reload`
4. Dừng nginx
`nginx -s stop`

![Imgur](https://i.imgur.com/4Jvo6y7.png)

### Các thành phần của nginx
mở file `/etc/nginx/nginx.conf` :

`cat /etc/nginx/nginx.conf`


#### 1. Khối toàn cầu
worker_processes auto;
Đây là cấu hình chính của dịch vụ xử lý , Giá trị của worker_processes càng lớn thì nó có thể xử lỹ hỗ trợ càng nhiều ,nhưng nó sẽ bị hàn chế bởi phần cứng phần mềm , nên thường để là auto

##### 2. Phần khối sự kiện 
events {
worker_connections 1024;
}
Nó ảnh hưởng đến kết nối mạng giữa máy chủ nginx và người dùng ,Cho phép nhận nhiều kết nối cùng một lúc và chọn mô hình nào để xử lý yêu cầu kết nối.Ví dụ trên chỉ ra rằng số lượng kết nối tối đa được hỗ trợ trong mỗi quy trình làm việc la 1024

##### 3. Phần thứ 3
 http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

  

- 1. Định dạng ghi chú trong tệp nhật ký truy cập: Các thông tin về yêu cầu được ghi lại trong tệp nhật ký truy cập, và định dạng được xác định bởi chuỗi định dạng log_format.
- 2. Ghi nhật ký truy cập: Tệp nhật ký truy cập được lưu trữ tại đường dẫn /var/log/nginx/access.log, và bao gồm thông tin về các yêu cầu đã được xử lý bởi máy chủ Nginx.
- 3. Thiết lập hiệu suất: Nginx có thể được cấu hình để cải thiện hiệu suất bằng cách sử dụng các tùy chọn như sendfile, tcp_nopush, tcp_nodelay và keepalive_timeout.
- 4. Định dạng MIME: File /etc/nginx/mime.types chứa danh sách các định dạng tệp được hỗ trợ bởi máy chủ Nginx.
- 5. Thư mục cấu hình: Các tệp cấu hình được tải vào từ thư mục /etc/nginx/conf.d/, bao gồm các cấu hình cho ứng dụng và trang web được phục vụ trên máy chủ Nginx.
	
		server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
		

- #### Về phía phần server 
	- 1. Dòng đầu tiên chỉ định rằng máy chủ Nginx sẽ lắng nghe trên cổng 80 (HTTP) trên giao diện mạng mặc định.
	- 2. Dòng thứ 2 :  chỉ định rằng máy chủ Nginx cũng sẽ lắng nghe trên cổng 80 trên tất cả các giao diện mạng IPv6.
	- 3. Dòng thứ 3 :  chỉ định rằng máy chủ này sẽ xử lý tất cả các yêu cầu được gửi đến địa chỉ IP của nó hoặc tên miền không biết trước (tức là không có tên miền hoặc ký tự đại diện)
	- 4. Dòng thứ 4 :	chỉ định rằng thư mục gốc cho máy chủ web là /usr/share/nginx/html/.
	- 5. Dòng 'include /etc/nginx/default.d/*.conf;' sử dụng include directive để tải các tệp cấu hình trong thư mục /etc/nginx/default.d/ vào trong khối máy chủ này.
	- 6. Dòng 'error_page 404 /404.html;' chỉ định rằng khi xảy ra lỗi 404 (không tìm thấy), Nginx sẽ hiển thị trang lỗi được chỉ định trong tệp /usr/share/nginx/html/404.html.
- 7. Dòng 'location = /404.html {}' chỉ định rằng trang lỗi 404 được định nghĩa ở trên là một location block (khối vị trí) tại đường dẫn /404.html.
- 8. Dòng 'error_page 500 502 503 504 /50x.html;' chỉ định rằng khi xảy ra lỗi 500, 502, 503 hoặc 504 (lỗi phía máy chủ), Nginx sẽ hiển thị trang lỗi được chỉ định trong tệp /usr/share/nginx/html/50x.html.
- 9. Dòng 'location = /50x.html {}' chỉ định rằng trang lỗi 50x được định nghĩa ở trên là một location block (khối vị trí) tại đường dẫn /50x.html.

