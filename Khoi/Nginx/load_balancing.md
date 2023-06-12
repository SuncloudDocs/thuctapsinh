## Cấu hình và định nghĩa của nginx load balacing 

### 1. Định nghĩa 
- Cân bằng tải là một kỹ thuật thường dùng để tối ưu hóa việc sử dụng tài nguyên , tối đa hóa thông lượng ,giảm độ trễ và đảm bảo chịu lỗi
- Có thể sử dụng nginx như là một bộ cân bằng tải để phân phối lưu lượng truy cập đến các máy chủ nhằm mục đích cải thiện hiệu năng , khả năng mở rộng và độ tin cậy của các ứng dụng web với nginx.
- Có rất nhiều thuật toán được xây dựng cho việc cân bằng tải , những thuật toán có những ưu nhược điểm khác nhau , có tác dụng trong những trường hợp cụ thể . Tùy vào hệ thống để chọn thuật toán phù hợp

### 2. Ưu nhược điểm của load balacing gồm : 

#### 2.1 Ưu điểm
- Tăng tính sẵn sàng: Khi sử dụng cân bằng tải, khi một máy chủ gặp sự cố hoặc quá tải, các yêu cầu sẽ được chuyển sang máy chủ khác trong hệ thống. Do đó, tính sẵn sàng và khả năng phục hồi của hệ thống được cải thiện đáng kể.

- Cải thiện hiệu suất: Cân bằng tải giúp phân phối tải công việc đều và tránh tình trạng tải quá mức cho một máy chủ. Điều này giúp tăng hiệu suất của hệ thống và giảm thời gian xử lý yêu cầu.

- Dễ dàng mở rộng: Cân bằng tải giúp hệ thống dễ dàng mở rộng bằng cách thêm máy chủ mới vào hệ thống.

 #### Nhược điểm như:

- Phức tạp: Cấu hình và quản lý cân bằng tải nginx có thể phức tạp đối với những người không có kinh nghiệm hoặc kiến thức về hệ thống máy chủ.

- Chi phí cao: Sử dụng cân bằng tải nginx có thể yêu cầu chi phí cao hơn cho phần cứng và khả năng xử lý tốt hơn của hệ thống.

- Độ trễ: Trong quá trình phân phối công việc cho các máy chủ, đôi khi có thể xảy ra độ trễ trong việc xử lý các yêu cầu.

### 3. Một số thuật toán được sử dụng trong việc cân bằng tải 

- 3.1 `Round-robin:` Đây là thuật toán đơn giản nhất, nó phân phối yêu cầu đến các máy chủ theo cách tuần tự, mỗi máy chủ nhận một yêu cầu lần lượt.
- 3.2 `Least Connection`: Thuật toán này phân phối yêu cầu đến máy chủ có số kết nối ít nhất. Với thuật toán này, khi một máy chủ có quá nhiều kết nối, yêu cầu sẽ được chuyển sang máy chủ khác có số kết nối ít hơn.
- 3.3 `Health check.`:
    Thuật toán này xác định máy chủ sẵn sàng xử lý request để gửi request đến server , điều này tránh được việc phải loại bỏ thủ công một máy chủ không sẵn sàng xử lý.

    Các hoạt động của thuật toán này là nó sẽ gửi một kết nối TCP đến máy chủ , nếu như máy chủ đó lắng nghe trên địa chỉ và port đã cấu hình thì nó mới gửi request đến cho server xử lý.

    Tuy nhiên health check vẫn có lúc kiể tra xem máy chủ có sẵn sàng hay không, đối với các máy chủ cơ sở dữ liệu thì health check không thể làm điều này.

- 3.4 `Weighted load balancing.` : Thuật toán này sử dụng trọng số để phân phối công việc cho các máy chủ. Mỗi máy chủ được gán một trọng số riêng, và yêu cầu sẽ được phân phối đến các máy chủ theo tỷ lệ trọng số.
    Ví dụ chúng ta có 2 server dùng để load balancing muốn cứ 5 request đến thì 4 dành cho server 1, 1 dành cho server 2 hay các trường hợp tương tự thì weighted load balancing là sự lựa chọn hợp lý.

- 3.5 Kết hợp thuật toán :Các thuật toán không bao giờ có thể hữu dụng trong tất cả các trường hợp,việc lựa chọn thuật toán dựa trên cơ sở hạ tầng chúng ta có cũng như mục đích sử dụng, để có thể tối ưu hóa hơn trong việc cân bằng tải thông thường chúng ta sẽ kết hợp các thuật toán lại với nhau để có thể đưa ra được giải pháp cân bằng tải hợp lý nhất cho hệ thống. Sau đây là một số giải pháp kết hợp.

 #### 4. Mô hình bài lab demo những thuật toán trên 
 
 ![Imgur](https://i.imgur.com/aO34q9g.png)

 - Chuẩn bị 
![Imgur](https://i.imgur.com/JqD5C5P.png)
 - Yêu cầu cần cấu hình nginx theo các thuật toán trên 
 - Sau khi cấu hình xong cần show thông tin và hiểu rõ cách cấu hình các thuật toán

##### 4.1  Weighted load balancing.

- Trên các web cấu hình `apache `
`yum install httpd httpd-devel`

- Sau khi cài đặt xong thì khởi động `apache` 
`systemctl start httpd`

- Thay đổi fort_end của htttp bằng cách vào thư mục 
`vi /var/www/html/index.html`

- Thêm nội dung vào file `index.html`
 ![Imgur](https://i.imgur.com/FtFkPoR.png)  
- Sau khi sửa file thì restart lại `httpd`
`systemctl restart httpd`

- Thêm các repo của nginx 
`yum install epel-release`
- Cài đặt nginx
`yum install -y nginx`
- Sau khi tải về muốn khởi động nginx
- `systemctl start nginx`

- Cấu hình firewall và restart lại dịch vụ:
`sudo firewall-cmd --permanent --zone=public --add-service=http `
`sudo firewall-cmd --permanent --zone=public --add-service=https`
`sudo firewall-cmd --reload`

- Dùng trình soạn thảo vi sửa file cấu hình của nginx

` vi /etc/nginx/nginx.conf`

Sửa tại file cấu hình như sau 

- Tại block http thêm các cấu hình : 
    http {

    upstream backends {
        server 192.168.202.137:80 weight=9;
        server 192.168.202.40:80 weight=2;
    }
Cấu hình trên có nghĩa là cứ 11 request gửi tới server sẽ có 9 request vào web 1 và 2 request vào web 2.
![Imgur](https://i.imgur.com/A3yeVDN.png)
- Tại block server thêm hoặc sửa các cấu hình thành như sau :
 server {

        listen      80 default_server;
        listen      [::]:80 default_server;
        server_name _;

        proxy_redirect           off;
        proxy_set_header         X-Real-IP $remote_addr;
        proxy_set_header         X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header         Host $http_host;

        location / {
            proxy_pass http://backends;
        }
Ý nghĩa của câu lệnh trên :
- `  listen      [::]:80 default_server;` : Dòng đầu tiên khai báo rằng máy chủ sẽ lắng nghe kết nối đến cổng 80, trên cả IPv4 và IPv6.
- Dòng `"server_name _;" `Tên miền hoặc địa chỉ IP của máy chủ, trong trường hợp này là _ (dấu gạch dưới), cho phép máy chủ xử lý tất cả các yêu cầu đến địa chỉ IP mặc định của máy chủ.
- Các dòng tiếp theo cấu hình các thông số proxy cho Nginx. Điều này cho phép máy chủ Nginx chuyển tiếp các yêu cầu tới một back-end server được cấu hình bên trong hệ thống.
- `Location / `được sử dụng để chỉ định rằng Nginx sẽ chuyển tiếp bất kỳ yêu cầu nào tới back-end server với tên gọi "backends". Điều này có nghĩa là Nginx sẽ chuyển tiếp tất cả các yêu cầu đến URL `http://backends.`

![Imgur](https://i.imgur.com/cCqOCnM.png)

- Sau khi cấu hình xong thì `restart` lại nginx
`nginx -s reload` hoặc `systemctl restart nginx`

- Kiểm tra bằng cách vào địa chỉ ip 
`http://192.168.202.101/`

![Imgur](https://i.imgur.com/WsXw0gW.png)
![Imgur](https://i.imgur.com/SAA0HZL.png)

###### Bài học rút ra cứ trong 11 request từ client gửi về server thì sẽ có 9 request gửi về web 1 . 2 request gửi về web 2 và nó sẽ không gửi theo tuần tự random ngẫu nhiên trong 11 request để gửi về server.

##### 4.2 Round Robin.

- Tại blook http sửa lại như sau : 
    http {

    upstream backends {
        server 192.168.202.137:80;
        server 192.168.202.40:80;
    }

![Imgur](https://i.imgur.com/gIM6CBF.png)

 - Tại block server ta vẫn cấu hình như thuật toán weighted load balancing
 - Sau khi cấu hình xong thì `restart` lại nginx
`nginx -s reload` hoặc `systemctl restart nginx`

- Kiểm tra bằng cách vào địa chỉ ip 
`http://192.168.202.101/`

![Imgur](https://i.imgur.com/WsXw0gW.png)
![Imgur](https://i.imgur.com/SAA0HZL.png)

###### Bài học rút ra cứ trong 12 request từ client gửi về server thì sẽ có 6 request gửi về web 1 . 6 request gửi về web 2 và nó sẽ không gửi theo tuần tự trong 12 request để gửi về server


##### 4.3 Least connection
- Đây là thuật toán nâng cấp của round robin và weighted load balancing, thuật toán này sẽ giúp tối ưu hóa cân bằng tải cho hệ thống.

- Đặc điểm của thuật toán này là sẽ chuyển request đến cho server đang xử lý it hơn làm việc, thích hợp đối với các hệ thống mà có các session duy trì trong thời gian dài, tránh được trường hợp các session duy trì quá lâu mà các request được chuyển luân phiên theo quy tắc định sẵn , dễ bị down 1 server nào đó do xr lý qúa khả năng của nó.

- Cấu hình .
`vi /etc/nginx/nginx.conf`

- Tại block `http` sửa lại như sau
http {

    upstream backends {
        least_conn;
        server 192.168.202.137:80;
        server 192.168.202.40:80;
    }
![Imgur](https://i.imgur.com/lApMXOS.png)
- Tại block server giữ nguyên 
- Sau khi cấu hình xong thì `restart` lại nginx
`nginx -s reload` hoặc `systemctl restart nginx`
- Kiểm tra bằng cách vào địa chỉ ip 
`http://192.168.202.101/`

![Imgur](https://i.imgur.com/WsXw0gW.png)
![Imgur](https://i.imgur.com/SAA0HZL.png)

###### Tối ưu hóa hiệu suất hệ thống: Cấu hình thuật toán LC giúp phân phối tải hiệu quả và giảm thiểu tình trạng quá tải, từ đó tối ưu hóa hiệu suất hệ thống.
###### Đảm bảo tính khả dụng: Với việc phân phối tải đồng đều trên các máy chủ, thuật toán LC giúp đảm bảo tính khả dụng của hệ thống, tránh tình trạng các máy chủ bị quá tải và gây ra sự cố.
###### Tăng tính linh hoạt: LC cho phép thêm hoặc xóa các máy chủ trong nhóm một cách dễ dàng, giúp tăng tính linh hoạt của hệ thống.

##### 4.4 Health check.
- Cấu hình .
`vi /etc/nginx/nginx.conf`

- Tại block `http` sửa lại như sau
http {

    upstream backends {
        server 192.168.202.137:80;
        server 192.168.202.40:80 max_fails=3 fail_timeout=5s;
       
    }

Giải thích : 
- server `192.168.202.137:80`: Đây là server đầu tiên trong danh sách và được định nghĩa để xử lý các yêu cầu đến từ Nginx.
server `192.168.202.40:80 max_fails=3 fail_timeout=5s`: Server thứ hai trong danh sách với địa chỉ IP và cổng là 80. Tuy nhiên, nó có thêm hai thuộc tính:` max_fails` và `fail_timeout` đều được sử dụng để quản lý việc định tuyến các yêu cầu đến server này. Theo đó, nếu server này không phản hồi sau 3 yêu cầu liên tiếp, thì Nginx sẽ coi nó là lỗi và không đưa yêu cầu đến server này trong 5 giây.

- Tại block server thì vẫn giữ nguyên như cũ 

- Sau khi cấu hình xong thì `restart` lại nginx
`nginx -s reload` hoặc `systemctl restart nginx`

##### 4.5 Kết hợp các thuật toán
######  Kết hợp least balancing và weight load balancing.
Least balancing được sử dụng để giảm thiểu số lượng truy cập mà một máy chủ nhận được so với các máy chủ khác trong hệ thống. Nó hoạt động bằng cách định tuyến yêu cầu đến máy chủ ít bận hơn, do đó giảm thiểu tải trên các máy chủ quá tải.

Weight load balancing sử dụng trọng số để xác định định tuyến yêu cầu đến máy chủ. Máy chủ với trọng số cao hơn sẽ được định tuyến nhiều yêu cầu hơn, trong khi máy chủ có trọng số thấp hơn sẽ nhận được ít yêu cầu hơn. Điều này cho phép tùy chỉnh phân phối tải theo ý muốn 
- Tại block http sửa lại như sau : 
http {

    upstream backends {
        least_conn;
        server 192.168.202.137:80 weight=2;
        server 192.168.202.40:80 weight=1;
    }


- Tại block server thì cấu hình như cũ 
- Sau khi cấu hình xong thì `restart` lại nginx
`nginx -s reload` hoặc `systemctl restart nginx`




