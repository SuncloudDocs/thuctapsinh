## Giới hạn số lượng request trong một trong một khoảng thời gian
### 1.Định nghĩa 
- Giới hạn số lượng request trong một khoảng thời gian là một kỹ thuật được sử dụng để kiểm soát số lượng yêu cầu (request) được gửi đến một ứng dụng hoặc API trong một khoảng thời gian nhất định. Bằng cách giới hạn số lượng request,có thể kiểm soát và quản lý tài nguyên của hệ thống, từ đó giúp cải thiện hiệu suất và tránh các vấn đề liên quan đến quá tải. Các phương pháp thường được sử dụng để giới hạn số lượng request bao gồm sử dụng bộ đếm và thiết lập giới hạn, sử dụng HTTP header "Rate Limit" hoặc sử dụng các dịch vụ quản lý API.
- Việc giới hạn số lượng request của một client trong một khoảng thời gian sẽ giảm được rủi to server bị tấn công DDoS. Bạn tính toán với trang web của mình một người dùng bình thường sẽ không thực hiện quá 1 request trong vòng 2 giây, còn nếu quá thì chắc chắn người dùng này đang có hành động bất thường. Như vậy ta sẽ giới hạn số lượng request cho một client trong 1 phút chỉ có thể thực hiện tối đa 30 request.

### 2.Ưu nhược điểm 
#### 2.1 Ưu điểm 
- Kiểm soát tài nguyên: Kỹ thuật này giúp cho người phát triển kiểm soát tài nguyên của hệ thống, đặc biệt là trong trường hợp có nhiều yêu cầu được gửi đến đồng thời.

- Ngăn chặn quá tải: Bằng cách giới hạn số lượng request được gửi đến ứng dụng hoặc API, kỹ thuật này giúp tránh tình trạng quá tải và giữ cho hệ thống hoạt động một cách ổn định.

- Bảo vệ an ninh: Giới hạn số lượng request cũng giúp bảo vệ hệ thống khỏi các cuộc tấn công DDoS hoặc các yêu cầu độc hại khác.

- Tăng hiệu suất: Kỹ thuật này giúp tăng hiệu suất hệ thống bằng cách sử dụng tài nguyên một cách hiệu quả hơn
#### 2.2 Nhược điểm 
- Khó tính toán: Việc thiết lập giới hạn số lượng request phù hợp là một vấn đề khó tính toán và cần phải được thực hiện cẩn thận để tránh ảnh hưởng đến trải nghiệm người dùng.

- Có thể làm giảm trải nghiệm của người dùng: Nếu giới hạn số lượng request được thiết lập quá thấp, điều này có thể làm giảm trải nghiệm của người dùng hoặc gây khó chịu cho họ.

- Không thể tránh được tất cả các cuộc tấn công: Mặc dù giới hạn số lượng request có thể giúp giảm thiểu các cuộc tấn công, nhưng không phải là một giải pháp hoàn hảo và không thể tránh được tất cả các cuộc tấn công.

### 3.Bài lab cấu hình 

- Cấu hình tại file` nginx.conf`
- Mở file config 
`vi /etc/nginx/nginx.conf`
- Thêm dòng sau vào` block http{}`

`limit_req_zone  $binary_remote_addr  zone=one:10m   rate=40r/m;`
```
zone=one:10mb Tạo ra một vùng nhớ làm mục đính gắn với các trong web khác nhau với các bảo mật khắc nhau. Ở đây sẽ tạo ra một vùng nhớ có tên one có dung lượng 10MB để lưu trữ trạng thái của của request theo kiểu key-value(trong trường hợp này là địa chỉ client).

rate=40r/m Để chỉ ra số request giới hạn là 40 request trong vòng 1 phút.
```
![Imgur](https://i.imgur.com/QhjBarT.png)

**Cấu hình tại block**
- Bây giờ bạn muốn giới hạn request có hiệu lực ở đâu thì bạn đặt limit_reg zone=one; trong các block đó.
- Nếu bạn muốn nó áp dụng cho tất cả các trang web trên nginx này thì bạn đặt trong block http{}.
![Imgur](https://i.imgur.com/xQfA01F.png)
```
Cụ thể, limit_req zone=one burst=5; 

limit_req: Tạo một giới hạn yêu cầu truy cập.
zone=one: Xác định tên và kích thước của vùng (zone) được sử dụng để lưu trữ thông tin về các yêu cầu truy cập.
burst=5: Thiết lập số lượng yêu cầu tối đa được phép trong một chu kỳ thời gian (tính bằng giây) trước khi bị hạn chế. Nếu số lượng yêu cầu vượt quá giới hạn này, các yêu cầu sẽ bị từ chối hoặc bị giới hạn tốc độ.
```
- Nếu muốn áp dụng cho một trang web riêng biệt thì đặt vào trong block server {}.
![Imgur](https://i.imgur.com/HmMjhkh.png)

***Sau khi cấu hình xong thực hiện kiểm tra bằng cách thực hiện câu lệnh dưới và hiển thị kq như sau***
`nginx -t`
![Imgur](https://i.imgur.com/uuV9I0D.png)

Sau đó khởi động lại Nginx:

`nginx -s reload`

hoặc

`systemctl restart nginx`

Sau khi nhấn f5 nhiều lần sẽ hiển thị như sau:
![Imgur](https://i.imgur.com/kZ2P3f7.png)
![Imgur](https://i.imgur.com/6Oi1fSV.png)
![Imgur](https://i.imgur.com/eH0h3gY.png)

### 4.Bài học rút ra cho bản thân sau khi cấu hình 
- Giao tiếp và tương tác tốt hơn: Khi giới hạn số lượng request, việc giao tiếp và tương tác sẽ được cải thiện hơn, giúp đáp ứng yêu cầu của người dùng một cách nhanh chóng và hiệu quả hơn.
- Bảo vệ hệ thống