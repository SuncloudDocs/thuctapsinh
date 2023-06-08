## Log file HTTP + nginx
### 1. Định nghĩa 
- File log HTTP là một tệp ghi lại hoạt động của máy chủ web khi nó xử lý các yêu cầu HTTP từ các trình duyệt hoặc ứng dụng khác. Những thông tin này có thể bao gồm:
```
Địa chỉ IP của người dùng
Thời gian và ngày yêu cầu được thực hiện
URL được yêu cầu
Trình duyệt được sử dụng để thực hiện yêu cầu
Mã trả về của yêu cầu (ví dụ: 404 Not Found)
Kích thước file được truyền về cho yêu cầu (nếu có)```
```
### Error_log
- Trong máy chủ web (web server), file error_log là một tệp nhật ký (log file) được sử dụng để ghi lại các thông báo lỗi (error messages) và cảnh báo (warning messages) của máy chủ web. Các thông báo này thường xảy ra khi máy chủ web gặp các vấn đề về phần mềm, phần cứng hoặc mạng.

- File error_log được sử dụng cho nhiều loại máy chủ web, bao gồm Apache, Nginx, IIS và nhiều hơn nữa. Nó cung cấp thông tin quan trọng cho việc theo dõi và khắc phục sự cố, giúp người quản trị hệ thống có thể xác định chính xác lỗi và cải thiện hiệu suất của máy chủ web.

``[Thu Jun 08 13:46:30.385923 2023] [autoindex:error] [pid 9659] [client 23.111.114.116:52210] AH01276: Cannot serve directory /var/www/html/: No matching DirectoryIndex (index.html) found, and server-generated directory index forbidden by Options directive
``

**Định nghĩa**
1. `[Thu Jun 08 13:46:30.385923 2023]` Ngày giờ xảy ra lỗi
2. ` autoindex:error `Mức độ quan trọng của lỗi (như cảnh báo hoặc lỗi nghiêm trọng)
3. `[pid 9659]:` Process ID
4. ` AH01276: Cannot serve directory ...` Thông tin chi tiết về lỗi, bao gồm tên tập tin và số dòng mã lỗi được thực thi

### Access log
- Là nơi ghi lại tất cả các yêu cầu được xử lý bởi máy chủ. Mỗi lần có một yêu cầu được gửi đến máy chủ, thông tin về yêu cầu đó sẽ được thêm vào access log, bao gồm thông tin như địa chỉ IP của người dùng, URL được truy cập, phương thức HTTP, mã trạng thái HTTP và thời gian truy cập. Access log rất hữu ích cho việc phân tích lưu lượng truy cập đến máy chủ web, kiểm tra lỗi và giúp quản trị viên hiểu rõ hơn về cách người dùng truy cập vào trang web của họ.

``14.177.64.37 - - [08/Jun/2023:14:23:32 +0700] "GET /favicon.ico HTTP/1.1" 404 209 "http://khoiht.click/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"``
**Định nghĩa**
1. ``14.177.64.37`` : Địa chỉ ip được gửi đến máy chủ
2. ``[08/Jun/2023:14:23:32 +0700]`` : Thời gian cụ thể + múi giờ 
3. Phương thức GET hoặc POST thuộc Giao thức Http

    Yêu cầu tài nguyên từ đâu :/GET /favicon.ico HTTP
    Sử dụng giao thức Http nào: HTTP/1.1
4. `404 ` Mã trạng thái máy chủ gửi cho khách
5. ` 209` : Cho biết kích thước của đối tượng được trả về máy khách
6. `http://khoiht.click/` :  Tiêu đề giới thiệu. Cung cấp trang trước của khách khi vào đây .
7. `Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.` : Tác nhân của người dùng, thông tin nhận dạng mà máy client báo cáo về nó

### Thống kê số lần truy cập của các IP vào web apache

**1.Thống kê theo bằng câu lệnh `GREP`**
- Câu lệnh dưới , hiển thị ngẫu nhiên không có thứ tự sắp xếp
`grep -o "[0-9]\+\.[0-9]\+\.[0-255]\+\.[0-9]" /var/log/httpd/access_log | sort | uniq`

```
grep -o "[0-9]\+\.[0-9]\+\.[0-255]\+\.[0-9]" /var/log/httpd/access_log: Lệnh grep được sử dụng để tìm kiếm các dòng trong tệp tin /var/log/httpd/access_log có khớp với biểu thức chính quy "[0-9]\+\.[0-9]\+\.[0-255]\+\.[0-9]". Biểu thức chính quy này tìm kiếm các chuỗi có định dạng giống địa chỉ IP, tức là một chuỗi các con số từ 0 đến 9, được phân cách bởi dấu chấm. Ví dụ: 192.168.0.1.

|: Ký tự | được gọi là pipe và nó cho phép đầu ra của một lệnh trở thành đầu vào cho lệnh tiếp theo. Trong trường hợp này, đầu ra của lệnh grep sẽ được chuyển cho lệnh sort.

sort: Lệnh sort được sử dụng để sắp xếp dòng đầu vào theo thứ tự từ điển.

uniq: Lệnh uniq được sử dụng để loại bỏ các dòng trùng lặp từ đầu vào. Trong trường hợp này, nó loại bỏ các địa chỉ IP trùng lặp từ kết quả của lệnh sort.
```
![Imgur](https://i.imgur.com/1iF7ady.png)
- Câu lệnh dưới , hiển thị theo thứ tự tăng dần 
`grep -o "[0-9]\+\.[0-9]\+\.[0-255]\+\.[0-9]" /var/log/httpd/access_log | sort | uniq -c|sort -n`
```uniq -c: Lệnh uniq được sử dụng để loại bỏ các dòng trùng lặp từ đầu vào, và -c được sử dụng để đếm số lần xuất hiện của mỗi dòng. Kết quả sẽ bao gồm số lần xuất hiện của mỗi địa chỉ IP.
sort -n: Lệnh sort -n được sử dụng để sắp xếp dòng đầu vào theo thứ tự số tăng dần. Trong trường hợp này, nó được sử dụng để sắp xếp các địa chỉ IP theo số lần xuất hiện tăng dần
```
![Imgur](https://i.imgur.com/MJhbrlk.png)

- Câu lệnh dưới , hiển thị theo thứ tự giảm dần 
``grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" /var/log/httpd/access_log | sort | uniq -c | sort -nr``

`uniq -c`: Lệnh uniq được sử dụng để loại bỏ các dòng trùng lặp từ đầu vào, và -c được sử dụng để đếm số lần xuất hiện của mỗi dòng. Kết quả sẽ bao gồm số lần xuất hiện của mỗi địa chỉ IP.
`sort -`n: Lệnh` sort -n` được sử dụng để sắp xếp dòng đầu vào theo thứ tự số tăng dần. Trong trường hợp này, nó được sử dụng để sắp xếp các địa chỉ IP theo số lần xuất hiện tăng dần

**2.Thống kê theo bằng câu lệnh `awk`**
Còn đối với cách này sẽ chỉ hiển thị những địa chỉ IP có ở phần đầu của access log (X-FORWARDED_FOR)
`awk '{print $1}' /var/log/httpd/access_log | sort | uniq -c | sort -nr`
![Imgur](https://i.imgur.com/5CAPiG4.png)




### Thống kê số lần truy cập của các IP vào web nginx
**1.Thống kê theo bằng câu lệnh `GREP`**
- Câu lệnh dưới , hiển thị ngẫu nhiên không có thứ tự sắp xếp
`grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" /var/log/nginx/access.log | sort | uniq`
![Imgur](https://i.imgur.com/MWH9rMb.png)
- Câu lệnh dưới , hiển thị theo thứ tự tăng dần 
`grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" /var/log/nginx/access.log | sort | uniq -c | sort -n`
![Imgur](https://i.imgur.com/5J8HNSq.png)
- Sắp xếp các địa chỉ theo thứ tự giảm dần
`grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" /var/log/nginx/access.log | sort | uniq -c | sort -nr`
![Imgur](https://i.imgur.com/D1oF2yC.png)
**2.Thống kê theo bằng câu lệnh `awk`**
Còn đối với cách này sẽ chỉ hiển thị những địa chỉ IP có ở phần đầu của access log (X-FORWARDED_FOR)
`awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr`
![Imgur](https://i.imgur.com/xNExYzr.png)


## Cách tạo sbdomain , tạo file chứa s domain riêng

 ### Yêu cầu chuẩn bị 
 1. Cấu hình domain và 2 subdomain 
 domain chính : khoiht.click
 sbdomain : cv.khoiht.click
            ca.khoiht.click

**B1:Chuẩn bị cài đặt**
- Cần tạo có 1 domain chính khoiht.click
- Cần Tạo chuẩn bị 3 thư mục :
`/var/www/html/khoht/`và `/var/www/html/my_resume/` và `/var/www/html/my_ca/`
![Imgur](https://i.imgur.com/sIMRhjv.png)

**B2:Thực hiện cấu hình domain**

- Tạo 3 thư mục mới trong `/etc/nginx/conf.d/` 
```
ca.khoiht.click.conf
cv.khoiht.click.conf
khoiht.click.conf
```
- Cấu hình file config ` khoiht.click.conf` như sau : 
```
server {
        ## Your website name goes here.
        server_name khoiht.click;
        ## Your only path reference.
        root /var/www/html/khoiht/ ;

        ## This should be in your http block and if it is, it's not needed here.
        index index.html index.php;


        location / {
                # This is cool because no php is touched for static content.
                # include the "?$args" part so non-default permalinks doesn't break when using query string
                try_files $uri $uri/ /index.php?$args;
        }


        location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
                expires max;
                log_not_found off;
        }
}
```

![Imgur](https://i.imgur.com/BnK9KJk.png)


**B3:Thực hiện cấu hình sbdomain**
- Thực hiện cấu hình `cv.khoiht.click.conf`
```
server {
        listen       80;
        server_name  cv.khoiht.click;

        location / {
            root /var/www/html/my_resume;
            index  index.php index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
             root   html;
        }
}
```
![Imgur](https://i.imgur.com/JGoNvPi.png)
- Thực hiện cấu hình `ca.khoiht.click.conf`
```
server {
        listen       80;
        server_name  ca.khoiht.click;

        location / {
            root /var/www/html/my_ca;
            index  index.php index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
             root   html;
        }
}
```
![Imgur](https://i.imgur.com/QZPnxdH.png)

**B4:Thực hiện chỉnh tạo file index.html để kiểm tra**
- Để kiểm tra sbdomain `ca.khoiht.click` thì vào `vi /var/www/html/my_ca/index.html` tạo một file index với nội dung sau 

`<h1> ca.khoiht.click </h1>`\

- - Để kiểm tra sbdomain `cv.khoiht.click` thì vào `vi /var/www/html/my_resume/index.html` tạo một file index với nội dung sau 
`<h1> cv.khoiht.click </h1>`
- - Để kiểm tra tên miền chính `khoiht.click` thì vào `vi /var/www/html/khoiht/index.html` tạo một file index với nội dung sau 

`<h1> khoiht.click </h1>`

***Lưu ý: vì lúc config phía trên mình chọn đường dẫn này để trỏ về nên mình vào file này để cấu hình(đường dẫn có thể tùy chọn)***

**B5:Thực hiện kiểm tra nginx và restart nginx**
- Kiểm tra nginx , dùng câu lệnh 
`nginx -t`
Hiển thị như phía dưới là không lỗi 
![Imgur](https://i.imgur.com/sL8sGpt.png)

- Cuối cùng restart nginx 
`nginx -s reload`\

- Xem kết quả mình tìm kiếm 
![Imgur](https://i.imgur.com/LPJoBVu.png)
![Imgur](https://i.imgur.com/YlrRxsL.png)
![Imgur](https://i.imgur.com/rloXOOs.png)