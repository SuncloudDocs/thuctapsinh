# Tổng quan về mô hình OSI và TCP/IP

# 1. Tổng quan về các mô hình giao thức mạng
Mô hình TCP/IP và mô hình OSI đều là các mô hình giao thức mạng. Các mô hình này định nghĩa các tầng giao thức đối với các thực thể giao tiếp khác nhau. Dữ liệu được giữa các tầng được truyền qua cơ chế đóng gói(encapsulation) và giải đóng gói(de-encapsulaion).
# 2. Mô hình OSI
Mô hình OSI(viết tẳt của *Open System Interconnection*) là một mô hình giao tiếp trong mạng máy tính được định nghĩa bởi 7 tầng (layer).
|Tầng|Mục đích|
|----|---|
|Tầng ứng dụng (Application)|Truyền dữ liệu giữa các ứng dụng|
|Tầng trình bày (Presentation)|Biểu diễn dữ liệu của người dùng|
|Tầng phiên (Sesion)|Thiết lập, duy trì giao tiếp giữa các thiết bị|
|Tầng giao vận (Transport)|Trao đổi dữ liệu giữa các nút trong mạng|
|Tầng mạng (Network)|Lựa chọn đường đi tới các thiết bị hoặc các mạng khác nhau|
|Tầng liên kết dữ liệu (Data link)| Thiết lập hoặc huỷ bỏ các liên kết trong mạng|
|Tầng vật lý (Physical)| Đảm bảo truyền nhận các tín hiệu điện tử|

## 2.1. Tầng ứng dụng (Application)
* **Tầng ứng dung** là tầng cao nhất trong mô hình OSI. Tầng ứng dụng bao gồm nhiều giao thức cung cấp các phương tiện cho người dùng truy cập vào môi trường mạng 
* Người dùng sẽ tương tác với các ứng dụng mạng(VD trình duyệt) trên thiết bị của họ và dữ liệu tương tác(VD: tin nhắn, file,...) sẽ được đóng gói và gửi đến các người dùng đích.
* Các giao thức phổ biến tại tầng ứng dụng là: HTTP, SMTP, SSH, FTP,...

## 2.2.  Tầng trình bày (Presentation)
**Tầng trình bày** thiết lập định dạng của dữ liệu và biểu diễn các dữ liệu của tầng ứng dụng vào các định dạng đó.

Tầng trình bày có thể xử lí các tác vụ như:
* Chuyển đổi giao thức
* Mã hoá và Giải mã dữ liệu
* Nén và giải nén dữ liệu
* Xử lí các dữ liệu không đồng bộ giữa các hệ điều hành/ứng dụng khác nhau

## 2.3. Tầng phiên (Session)
**Tầng phiên** có vai trò thiết lập, điều khiển kết nối giữa các thiết bị giao tiếp. Chức năng cơ bản của tầng này bao gốm Thiết lập(establishment), Quản lí(managerment), Kết thúc(termination), đồng thời hỗ trợ nhiều loại kênh truyề khác nhau như song công hoàn toàn(full-duplex), bán song công(half-duplex), đơn công(simplex).

Tầng phiên sử dụng token để thực hiện truyền dữ liệu cũng như đồng bộ hoá hay kết thúc các liên kết trong phiên hội thoại. Giúp đảm bảo việc truyền tin cậy và khả năng đồng bộ khi sảy ra sự cố.

## 2.4. Tầng giao vận (Transport Layer)
**Tầng Giao vận** cung cấp các công cụ và chức năng giúp truyền các dữ liệu giữa các thiết bị cuối trong mạng (VD client đến serer).

Tầng giao vận thực hiện việc phân chia các các gói tin lớn thành các gói tin nhỏ hơn (gọi là các segment). Các segment được đánh số để đảm bảo rằng nó được truyền đi đúng thứ tự. Đồng thời, bên nhận có thể cài đặt cơ chế biên nhận (Acknowledment) để đảm bảo độ tin cậy trong việc truyền dữ liệu.

## 2.5. Tầng mạng (Network Layer)
**Tầng mạng** thực hiện việc chuyển tiếp (forwarding) và định tuyến (routing) các dữ liệu trong mạng(datagram).

Đồng thời, lớp mạng cũng thực hiện chức năng điều khiển tắc nghẽn(Congestion Control). Khi sảy ra tắc nghẽn các router sẽ định tuyến gói tin đi con đường khác đảm bảo gói tin được truyền đến điểm dích.
## 2.6. Tầng liên kết dữ liệu (Data link)
Chức năng của **Tầng liên kết dữ liệu** là quản lí các thiết bị host và router, đông thời thiết lập các liên kết, duy trì và huỷ bỏ chúng.
Các thông tin sẽ được chia thành các khung tin(frame), các khung tin sẽ được truyền tuần tự và đồng thời xử lí các thông điệp biên nhận từ bên nhận.
IEEE 802 chia lớp liên kết dữ liệu thành 2 lớp con:
* *Lớp kiểm soát truy cập phương tiện (MAC)* - kiểm soát các thiết bị trong mạng
* *Lớp kiểm soát liên kết logic(LLC)* - xác định và đóng gói các giao thức tầng mạng, đồng thời kiểm soát lỗi và đồng bộ
## 2.7. Tầng vật lí (Physical Layer)
* **Tầng vật lý** sử dụng các tính chất của điện, điện từ, quang để thực hiện việc truyền các dữ liệu trong môi trường.
* Các môi trường truyền thông bao gồm: Tín hiệu điện(Cáp đồng, cáp xoắn,...) , tín hiệu điện từ, tín hiệu quang
* Có hai giao thức truyền bao gồm: truyền dị bộ(Asynchronous) và truyền đồng bộ(Synchronous).

# 3. Mô hình TCP/IP
Đơn giản hơn mô hình OSI, mô hình TCP/IP được định nghĩa bao gồm 4 tầng:

|Mô hình OSI|Mô hình TCP/IP|
|----|---|
|Tầng ứng dụng (Application), Tầng trình bày (Presentation), Tầng phiên (Sesion)|Tầng ứng dụng (Application)|
|Tầng giao vận (Transport)|Tầng giao vận (Transport)|
|Tầng mạng (Network)|Tầng mạng (Network)|
|Tầng liên kết dữ liệu (Data link), Tầng vật lý (Physical)| Tầng truy cập mạng(Network Access)|
## 3.1. Tầng ứng dụng
Tầng ứng dụng cung cấp các dịch vụ và giao diện tới ứng dụng trên mạng. Tầng ứng dụng giao tiếp với người dùng thông qua các ứng dụng kết nối mạng, đồng thời định dạng dữ liệu của người dùng, thiết lập phiên làm việc giữa các người dùng với nhau và đóng gói dữ liệu xuống tầng giao vận.
## 3.2. Tầng giao vận
Tầng giao vẫn đảm bảo duy trì kết nối và truyền thông giữa các thiết bị cuối-cuối trong mạng. Các giao thức của tâng giao vận cũng đảm nhiệm việc chia thông tin từ tầng ứng dụng thành các đoạn tin, cũng như nối các đoạn tin thành một chỗi thông tin.
## 3.3.  Tầng mạng
Tầng mạng thực hiện nhiệm vụ kiểm soát các lưu lượng dữ liệu được truyền thông qua mạng. Nhiệm vụ này bao gồm xử lí địa chỉ, định tuyến, phân mảnh gói tin truyền đi.
## 3.4. Tầng truy cập mạng
Tầng truy cập mạng xử lí phần truyền dữ liệu thông qua các môi trường truyền dẫn(như cáp đồng, cáp quang, truyền dẫn không dây,...). Tầng truy cập mạng duy trì việc truyền các dữ liệu bit tức là tín hiệu nhị phân được truyền qua các giao diện mạng(interface) (VD Ethernet hoặc WiFi)

