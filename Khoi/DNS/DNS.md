 ## DNS là gì?
 ### 1.Định nghĩa
 ![Imgur](https://i.imgur.com/R3rWbzH.png)
 - DNS(Domain name system) là một hệ thống cho phép thiết lập tương ứng giữa địa chỉ IP và tên miền trên Internet.
 - Khi bạn nhập một tên miền vào trình duyệt web, ví dụ như "www.example.com", trình duyệt sẽ gửi yêu cầu đến máy chủ DNS để tìm địa chỉ IP tương ứng của tên miền đó. Máy chủ DNS sẽ trả về địa chỉ IP cho trình duyệt, cho phép nó kết nối đến tài nguyên trên máy chủ đích.
 - DNS hoạt động theo cấu trúc cây, với các máy chủ DNS phân cấp theo các tên miền cụ thể. Có ba loại máy chủ DNS chính: máy chủ DNS gốc (root DNS server), máy chủ DNS cấp cao nhất (top-level domain DNS server) và máy chủ DNS miền (domain DNS server). Khi một yêu cầu DNS được gửi đi, nó sẽ được truyền qua các máy chủ DNS từ gốc đến miền, cho đến khi tìm được địa chỉ IP mong muốn.
  ### 2.Cách thức hoạt động của DNS
- Khi nhập một tên miền vào trình duyệt web, ví dụ như "www.example.com", trình duyệt sẽ gửi yêu cầu đến máy chủ DNS (DNS resolver) để tìm địa chỉ IP tương ứng của tên miền đó. Máy chủ DNS resolver sẽ thực hiện quá trình tìm kiếm theo các bước sau:

- Local DNS Cache: Đầu tiên, máy chủ DNS resolver sẽ kiểm tra trong bộ nhớ cache của mình xem có thông tin về tên miền được yêu cầu không. Nếu có, nó trả về địa chỉ IP từ cache và quá trình kết thúc.

- Recursive Query: Nếu không có thông tin trong cache, máy chủ DNS resolver sẽ thực hiện một truy vấn đệ quy (recursive query). Nó sẽ gửi yêu cầu đến các máy chủ DNS khác nhau, bắt đầu từ máy chủ DNS gốc (root DNS server), sau đó đi qua máy chủ DNS cấp cao nhất (top-level domain DNS server) và tiếp tục tới máy chủ DNS miền (domain DNS server).

- Caching và Trả lời: Khi máy chủ DNS resolver nhận được câu trả lời từ máy chủ DNS, nó sẽ lưu thông tin đó vào bộ nhớ cache để sử dụng cho các truy vấn tương lai và trả về địa chỉ IP cho trình duyệt web của người dùng.

  ### 3.Trong DNS, ta cần chú ý về:

- `Name Space`: Tên được gán cho máy phải là duy nhất vì địa chỉ là duy nhất. Một không gian tên mà mapping với mỗi địa chỉ phải là một tên duy nhất và có thể được tổ chức theo hai cách: cùng cấp hoặc theo cấp bậc.
- `Domain Name Space` có thứ bậc trong thiết kế. Tên được định nghĩa trong một cấu trúc cây ngược với gốc ở trên cùng. Cây có thể có 128 cấp độ: cấp 0 (gốc) đến cấp 127

  ### 4.Thế nào là DNS Record, một số loại record phổ biến
  **4.1 Bản ghi loại A**
- `Address Mapping records:` Sử dụng để chuyển đổi một domain name thành một địa chỉ IPv4.

  **4.2 Bản ghi loại AAAA**
-` IP Version 6 Address records`: Sử dụng để chuyển đổi một domain name thành một địa chỉ IPv6.
  
  **4.3 Bản ghi loại NS**
- `Name Server records`: Lưu thông tin về Name Server. Nó định danh cho một máy chủ có thẩm quyền về một zone nào đó.

**4.4 Bản ghi loại CNAME**
- `Canonical Name records`: Bản ghi CNAME chỉ định một tên miền cần phải được truy vấn để giải quyết truy vấn DNS ban đầu. Vì vậy các bản ghi CNAME được sử dụng để tạo các bí danh tên miền. Bản ghi CNAME thực sự hữu ích khi chúng ta muốn bí danh tên miền của chúng ta tới miền bên ngoài. Trong các trường hợp khác, chúng ta có thể xóa các bản ghi CNAME và thay thế chúng bằng các bản ghi A.
**4.5 Bản ghi loại PTR**
- `Reverse-lookup Pointer records`: bản ghi PTR được sử dụng để tra cứu tên miền dựa trên địa chỉ IP.
 **4.6 Bản ghi loại MX**
- `Mail exchanger record`: MX chỉ định một máy chủ trao đổi thư cho một tên miền DNS. Thông tin được sử dụng bởi Giao thức truyền thư đơn giản (SMTP) để định tuyến email đến máy chủ thích hợp. Thông thường, có nhiều hơn một máy chủ trao đổi thư cho một miền DNS và mỗi DNS trong số chúng đã đặt ưu tiên.

