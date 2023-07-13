# Tìm hiểu về NGinX
## 1. NGinX là gì?
### 1.1. Định nghĩa
- NGINX là một máy chủ web mã nguồn mở mạnh mẽ và máy chủ reverse proxy 
- NGINX đã trở nên phổ biến rộng rãi nhờ hiệu suất cao, khả năng mở rộng và tính linh hoạt của nó. 
- NGINX hoạt động như một máy chủ web, phục vụ nội dung tĩnh như tệp HTML, CSS và JavaScript cho máy khách.
- Nó vượt trội trong việc xử lý các kết nối đồng thời và phân phối hiệu quả nội dung tĩnh với mức sử dụng tài nguyên tối thiểu.
- NGINX có khả năng mở rộng cao thông qua các modules và hỗ trợ nhiều giao thức khác nhau như HTTP, HTTPS, SMTP, WebSocket, v.v. 
- NGINX có thể xử lý kết thúc SSL/TLS, cho phép nó xử lý các kết nối an toàn và giảm tải quá trình mã hóa từ các máy chủ phụ trợ.
### 1.2 Các cấu hình NGINX cơ bản
- Để cài đặt NGINX:
```bash
sudo apt-get install nginx
```
- File cấu hình của NGINX sẽ được truy cập từ `/etc/nginx/nginx.conf`
```bash
sudo nano /etc/nginx/nginx.conf
```
- Trong file `nginx.conf sẽ có 3 phần cơ bản:
    - Cài đặt chung(Global setting):

    Các cài đặt này được xác định bên ngoài bất kỳ khối nào và áp dụng chung cho NGINX. Các ví dụ bao gồm `user`, `worker_processes`, `error_log` và `pid`.
    ```conf
    # Global settings
    user nginx;
    worker_processes auto;

    error_log /var/log/nginx/error.log;
    pid /var/run/nginx.pid;
    ```
    - Trong đó: 
        - `user` đưa ra tên của người dùng
        - `worker_processes` là cấu hình chính của dịch vụ xử lý , Giá trị này càng lớn thì có thể xử lỹ hỗ trợ càng nhiều
        - `error_log` định nghĩa file mà NGINX sẽ lưu log những lỗi trong quá trình hoạt động
        - `pid` định nghĩa file mà NGINX sẽ lưu trữ ID tiến trình (PID) của tiến trình NGINX chính.

    - Khối sự kiện(Event blocks):
    Khối này chỉ định cài đặt liên quan đến xử lý sự kiện, chẳng hạn như số lượng kết nối tối đa được phép bởi mỗi tiến trình làm việc (trong ví dụ dưới đây, số kết nối tối đa cho một tiến trình làm việc là 768)
    ```conf
    # Events block
    events {
        worker_connections 768;
    }
    ```
    - Khối bối cảnh(Context block): bao gồm 3 phần chính
        - Khối HTTP:
        Khối này chứa các cấu hình dành riêng cho giao thức HTTP. Nó bao gồm các cài đặt cho các loại MIME, ghi nhật ký, cân bằng tải, ủy quyền, v.v.
        ```conf
        # HTTP block
        http {
            # MIME types and default type
            include /etc/nginx/mime.types;
            default_type application/octet-stream;

            # Logging
            log_format  main  $remote_addr - $remote_user [$time_local] "$request" 
                     $status $body_bytes_sent "$http_referer" 
                     "$http_user_agent" "$http_x_forwarded_for";
            access_log /var/log/nginx/access.log;

            # Load balancing and proxy settings
            upstream backend {
                server backend1.example.com;
                server backend2.example.com;
            }
        }
        ```
        - Trong đó :
            - `/etc/nginx/mime.types` chứa danh sách các tệp được hỗ trợ bởi NGINX
            - `log_fomat` định dạng các thông tin được ghi log lại, các thông tin này sẽ được lưu tại `/var/log/nginx/access.log`
            - `upstream backend` là một khối xác định một nhóm máy chủ phụ trợ mà NGINX sẽ ủy quyền các yêu cầu(sẽ giải thích ở phần dưới)
        - Khối server: Khối server được đặt trong khối http, xác định một hoặc nhiều khối máy chủ. Mỗi khối máy chủ đại diện cho một máy chủ hoặc máy chủ ảo. Nó xác định listen port, server_name (miền hoặc IP) và cài đặt bổ sung cho máy chủ cụ thể đó.
        ```conf
        # Server block
        server {
            listen 80;
            listen [::]:80;
            server_name example.com;
            
            root /usr/share/nginx/html;


            include /etc/nginx/default.d/*.conf;

            error_page 404 /404.html;
            location = /404.html {
            }

            error_page 500 502 503 504 /50x.html;
            location = /50x.html {
            }
        }
        ```
        - Trong đó :
            - `listen` định nghĩa cổng mà máy chủ sẽ chờ kết nối từ client. `listen 80` chỉ ra rằng máy chủ sẽ lắng nghe kết nối tới cổng 80 từ các interface mặc định còn `listen [::]:80;` chỉ ra rằng máy chủ sẽ lắng nghe các kết nối từ các inteface IPv6.
            - `server_name` chỉ ra rằng máy chủ sẽ sử lí tất cả các yêu cầu đến tên miền được định nghĩa (VD: `example.com`)
            - `error_page` chỉ định một khối vị trí trả về nếu gặp một lỗi được định nghĩa (VD:404, 500, 502,...)
            - `include` dùng để chèn tất cả cấu hình từ một file cấu hình khác vào cấu hình hiện tại
        - Khối location: Khối location được đặt bên trong khối server, có thể có một hoặc nhiều khối vị trí. Các khối này xác định cách NGINX xử lý các yêu cầu cho các URL hoặc đường dẫn cụ thể. Chúng bao gồm các lệnh như proxy_pass (reverse proxy), root (để cung cấp các tệp tĩnh), v.v.
        ```conf
        # Location block
        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
        ```

## 2. Reverse Proxy & caching
### 2.1. Reverse Proxy
NGINX nằm giữa máy khách và backends server, thay mặt máy chủ chấp nhận các yêu cầu của máy khách. Khi một máy khách gửi yêu cầu tới reverse proxy NGINX, nó sẽ chuyển tiếp yêu cầu tới backends server thích hợp dựa trên các quy tắc được xác định trước và thuật toán cân bằng tải(load balancing). Điều này cho phép NGINX phân phối lưu lượng đến trên nhiều máy chủ, cân bằng tải và ngăn không cho bất kỳ máy chủ đơn lẻ nào bị quá tải. Bằng cách đó, NGINX giúp cải thiện hiệu suất tổng thể và tính khả dụng của ứng dụng.
- Để cấu hình một máy chủ làm reverse proxy server sử dụng NGINX, cần có một máy chủ làm máy chủ backend và một máy chủ làm máy chủ proxy server:
    - Máy chủ backend chạy CentOS, sử dụng apache2 để cấu hình một web server:
    - Máy chủ reverse proxy server chạy Ubuntu, sử dụng NGINX cấu hình một reverse proxy server

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/topo.png)
- Tại máy chủ backend: Cài đặt Apache2, cấu hình một trang web tuỳ ý

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/backendserver.png)
- Tại reverse proxy server: Cài đặt NGINX, cấu hình file `/etc/nginx/nginx.conf` để chuyển hướng đến backend server:
```bash
sudo nano /etc/nginx/nginx.conf 
```
```conf
location / {
    proxy_pass http://192.168.68.214;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}
```
- Trong đó `192.168.68.214` là địa chỉ ip của backend server.
- Kiểm tra cấu hình của reverse proxy server và khởi động lại NGINX
```bash
$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
$ sudo service nginx restart
```
- Truy cập địa chỉ của reverse proxy server, nó sẽ tự động chuyển hướng đến backend server.
![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/proxyserver.png)
### 2.2. Caching
Ngoài ra, NGINX có thể hoạt động như một máy chủ bộ đệm (caching server), lưu trữ nội dung được truy cập thường xuyên trong bộ nhớ của nó. Khi một khách hàng yêu cầu một tài nguyên, NGINX sẽ kiểm tra bộ đệm của nó trước để xem liệu nó có bản sao của nội dung được yêu cầu hay không. Nếu nội dung được tìm thấy trong bộ đệm, NGINX sẽ gửi trực tiếp nội dung đó đến máy khách mà không chuyển tiếp yêu cầu đến máy chủ phụ trợ. Cơ chế lưu vào bộ nhớ đệm này giúp giảm đáng kể thời gian phản hồi và giúp máy chủ phụ trợ không phải xử lý các yêu cầu dư thừa, giúp cải thiện hiệu suất và giảm tải cho máy chủ.

Nhìn chung, các chức năng bộ nhớ đệm và reverse proxy của NGINX góp phần phân phối lưu lượng hiệu quả, cân bằng tải và phân phối nội dung được tăng tốc, cuối cùng là nâng cao hiệu suất, khả năng mở rộng và trải nghiệm người dùng của các ứng dụng web.
## 4. Load Balancing
NGINX cũng cung cấp các khả năng cân bằng tải nâng cao, chẳng hạn như round-robin, least connections, IP hash,... Các thuật toán này phân phối yêu cầu một cách thông minh, xem xét các yếu tố như tình trạng máy chủ và thời gian phản hồi, để đảm bảo sử dụng tài nguyên hiệu quả và trải nghiệm người dùng tối ưu.
Dưới đây là một số thuật toán cân bằng tải thường được sử dụng được NGINX hỗ trợ:
1. Round Robin (mặc định): Các yêu cầu được phân phối đồng đều theo cách tuần tự giữa các máy chủ phụ trợ. Mỗi yêu cầu tiếp theo được chuyển tiếp đến máy chủ tiếp theo trong nhóm. 
2. Least Connections: Yêu cầu được chuyển đến máy chủ có ít kết nối hoạt động nhất vào thời điểm đó. Thuật toán này giúp phân phối tải dựa trên dung lượng máy chủ hiện tại. 
3. IP Hash: Địa chỉ IP của máy khách được sử dụng để xác định máy chủ phụ trợ nào sẽ xử lý yêu cầu. Điều này đảm bảo rằng các yêu cầu từ cùng một máy khách được định tuyến nhất quán đến cùng một máy chủ, điều này có thể hữu ích cho tính bền vững của phiên. 
4. Generic Hash: Khóa tùy chỉnh do người dùng xác định được sử dụng để xác định máy chủ phụ trợ. Điều này cho phép kiểm soát nhiều hơn hành vi cân bằng tải vì bất kỳ dữ liệu liên quan nào cũng có thể được sử dụng để đưa ra quyết định định tuyến. 
5. Least Time: NGINX đo thời gian phản hồi từ các máy chủ phụ trợ và hướng yêu cầu đến máy chủ có thời gian phản hồi nhanh nhất. Thuật toán này rất hữu ích khi thời gian phản hồi là một yếu tố quan trọng. 
6. Ngẫu nhiên: Các yêu cầu được phân phối ngẫu nhiên giữa các máy chủ phụ trợ, điều này có thể hiệu quả đối với một số tình huống nhất định khi không cần thiết phải phân phối đồng đều.

- Để cấu hình một máy chủ sử dụng NGINX làm load balancer, phân chia tải đến các máy khác ta thực hiện theo các bước sau:
    - Chuẩn bị máy chủ NGINX làm load balancer, các máy chủ backend:

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/topo2.png)
    - Cấu hình các máy chủ backend:
    - Cấu hình load balancer: Truy cập vào file `/etc/nginx/nginx.conf` để cấu hình load balancer
    ```bash
    sudo nano /etc/nginx/nginx.conf
    ```
    - Đặt các server backends: các backend server được đặt tại khối `http` và chỉ định thuật toán hỗ trợ phân chia tải 
        - Round Robin (Mặc định):
        ```conf
        upstream backend {
            #Round Robin
            server 192.168.68.214;
            server 192.168.68.232;
        }
        ```
        - Least Connection:
        ```conf
        upstream backend {
            server 192.168.68.214;
            server 192.168.68.232;

            # Least Connection
            least_conn;
        }
        ```
        - IP hash:
        ```conf
        upstream backend {
            server 192.168.68.214;
            server 192.168.68.232;

            # IP Hash
            ip_hash;
        }
        ```
        - Least Time(yêu cầu NGINX plus):
        ```conf
        upstream backend {
            server 192.168.68.214;
            server 192.168.68.232;

            # Least Time (NGINX Plus required)
            least_time header upstream_response_time;
        }
        ```
        - Phân chia theo trọng số:
        ```conf
        upstream backend {
            server 192.168.68.214 weight=6;
            server 192.168.68.232 weight=4;
        }
        ```
        Việc phân chia trên có ngĩa là 60% kết nối sẽ truy cập vào backend server đầu tiên và 40% kết nối sẽ truy cập vào backend server thứ 2
        - Ngẫu nhiên:
        ```conf
        upstream backend {
            server 192.168.68.214;
            server 192.168.68.232;

            # Random
            random;
        }
        ```
    - Thêm khối `location` để chuyển hướng đến các backend server
    ```conf
    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
    }
    ```
    - Sau khi cấu hình kết thúc, ta có thể truy cập vào địa chỉ ip của load balancer để truy cập vào các server backend.

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/p1.png)
    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/nginximg/p2.png)