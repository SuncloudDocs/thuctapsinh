# Tìm hiểu cơ bản về địa chỉ IP và Máy chủ(host)
## 1. Địa chỉ IP 
### 1.1. PublicIP
Địa chỉ IP Public là địa chỉ IP duy nhất trên toàn cầu và có thể định tuyến trên internet. Nó được Nhà cung cấp dịch vụ Internet (ISP) gán cho một thiết bị, chẳng hạn như máy tính, router hoặc máy chủ. Địa chỉ IP Public được sử dụng để xác định và giao tiếp với các thiết bị trên các mạng khác nhau trên internet.
- Một số đặc điểm của IP Public:
    - **Định danh duy nhất:** Địa chỉ IP Public đóng vai trò là định danh duy nhất cho một thiết bị trên internet. Nó cho phép các thiết bị và dịch vụ khác định vị và thiết lập kết nối với thiết bị.
    - **Khả năng truy cập Internet:** Các thiết bị có địa chỉ IP Public có thể giao tiếp với các thiết bị và dịch vụ khác trên internet. Có thể gửi và nhận các gói dữ liệu đến và đi từ các thiết bị trên các mạng khác nhau.
    - **Hiển thị công khai:** Địa chỉ IP Public được hiển thị công khai và có thể được truy cập bởi bất kỳ ai trên internet. Điều này có nghĩa là các dịch vụ được lưu trữ trên thiết bị có địa chỉ IP công cộng, chẳng hạn như trang web, máy chủ hoặc ứng dụng, có thể được người dùng trên toàn thế giới truy cập.
    - **NAT (Network Address Translation):** Do địa chỉ IPv4 có sẵn hạn chế, nhiều thiết bị trong mạng riêng sử dụng địa chỉ IP riêng không thể định tuyến trực tiếp trên internet. Để cho phép các thiết bị này truy cập internet, một kỹ thuật có tên là Network Address Translation (NAT) được sử dụng. NAT cho phép các địa chỉ IP riêng được dịch thành một địa chỉ IP công cộng duy nhất khi giao tiếp với các thiết bị trên internet.
    - **IP động và tĩnh:** Địa chỉ IP Public có thể là động hoặc tĩnh. Địa chỉ IP động được ISP chỉ định từ nhóm địa chỉ có sẵn và có thể thay đổi theo thời gian. Mặt khác, địa chỉ IP tĩnh được gán thủ công cho thiết bị và không thay đổi. IP tĩnh thường được sử dụng cho các dịch vụ yêu cầu khả năng truy cập nhất quán, chẳng hạn như máy chủ web hoặc ứng dụng truy cập từ xa.
### 1.2. IP cục bộ (IP local)
Địa chỉ IP cục bộ đề cập đến địa chỉ IP được gán cho một thiết bị trong mạng riêng, còn được gọi là mạng cục bộ (LAN). Không giống như địa chỉ IP công cộng, là duy nhất trên toàn cầu và có thể định tuyến trên internet, địa chỉ IP cục bộ được sử dụng để liên lạc nội bộ trong một mạng cụ thể.
- IP local có những đặc điểm sau

    - **Không gian địa chỉ riêng:** Địa chỉ IP cục bộ là một phần của không gian địa chỉ riêng. Các dải địa chỉ này được dành riêng để sử dụng trong các mạng riêng và không phải là duy nhất trên toàn cầu hoặc có thể định tuyến trên internet. Các dải địa chỉ IP riêng được sử dụng phổ biến nhất là:
        - Địa chỉ  IPv4 Private:
            - 10.0.0.0 đến 10.255.255.255 (10.0.0.0/8)
            - 172.16.0.0 đến 172.31.255.255 (172.16.0.0/12)
            - 192.168.0.0 đến 192.168.255.255 (192.168.0.0/16)
        - Địa chỉ cục bộ duy nhất của IPv6 (ULA):
            - fc00::/7 (tiền tố fd00::/8 được dành riêng cho ULA)
    - **Giao tiếp mạng nội bộ:** Địa chỉ IP cục bộ được sử dụng cho các thiết bị trong mạng riêng để giao tiếp với nhau. Chúng cho phép các thiết bị như máy tính, điện thoại thông minh, máy in và máy chủ trao đổi dữ liệu và thông tin trong ranh giới của mạng cục bộ.
    - **Subnnetting(mạng con):** Địa chỉ IP cục bộ thường được chia thành các mạng con nhỏ hơn để chứa các mạng lớn hơn. Mạng con cho phép quản trị viên mạng tổ chức và quản lý địa chỉ IP hiệu quả hơn trong mạng cục bộ bằng cách nhóm các thiết bị thành các mạng con hợp lý.
    - **Phạm vi mạng cục bộ:** Địa chỉ IP cục bộ chỉ hợp lệ trong mạng riêng cụ thể mà chúng được chỉ định. Chúng không thể truy cập hoặc định tuyến được từ bên ngoài mạng cục bộ. Điều này cung cấp một mức độ bảo mật và cách ly cho các thiết bị trong mạng riêng, vì chúng được bảo vệ khỏi việc tiếp xúc trực tiếp với internet.
 
![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/public-ip-address-vs-private-ip-address.jpg)
### 1.3. IP ảo (Virtual IP)
Trong mạng máy tính, IP ảo (VIP) đề cập đến một địa chỉ IP không được liên kết với một thiết bị hoặc interface vật lý cụ thể. Thay vào đó, nó thường được gán cho một tài nguyên ảo, chẳng hạn như máy ảo (VM), bộ cân bằng tải hoặc cụm có tính sẵn sàng cao.
- Một số đặc điểm của IP ảo
    - **Dự phòng và tính sẵn sàng cao:** IP ảo thường được sử dụng trong các thiết lập có tính sẵn sàng cao để đảm bảo tính liên tục của dịch vụ và giảm thiểu thời gian ngừng hoạt động. Trong cấu hình cân bằng tải hoặc cụm, nhiều thiết bị vật lý hoạt động cùng nhau để cung cấp khả năng dự phòng và chuyển đổi dự phòng. IP ảo đóng vai trò là điểm cuối duy nhất, nhất quán để khách hàng truy cập các dịch vụ do cụm lưu trữ. Nếu một thiết bị vật lý bị lỗi, một thiết bị khác có thể tiếp quản và phản hồi các yêu cầu sử dụng cùng một IP ảo.
    - **Cân bằng tải:** IP ảo thường được sử dụng trong các tình huống cân bằng tải. Trong bối cảnh này, nhiều máy chủ hoặc phiên bản phân phối lưu lượng mạng đến trên chúng để tối ưu hóa hiệu suất và khả năng mở rộng. IP ảo đóng vai trò là điểm vào cho các yêu cầu của máy khách và bộ cân bằng tải sẽ phân phối các yêu cầu đó đến các máy chủ phụ trợ thích hợp dựa trên các thuật toán và yếu tố khác nhau, chẳng hạn như tính khả dụng của máy chủ, thời gian phản hồi hoặc khối lượng công việc.
    - **Di chuyển dịch vụ linh hoạt:** IP ảo cung cấp tính linh hoạt khi di chuyển dịch vụ hoặc tài nguyên trên các thiết bị vật lý. Nếu một tài nguyên ảo cần được di chuyển hoặc định vị lại sang một thiết bị hoặc máy chủ vật lý khác, thì IP ảo được liên kết với tài nguyên đó vẫn giữ nguyên. Khách hàng có thể tiếp tục truy cập dịch vụ mà không cần cập nhật cấu hình hoặc bản ghi DNS.
    - **Tính linh hoạt trong môi trường ảo hóa:** Trong môi trường ảo hóa, chẳng hạn như nền tảng điện toán đám mây, IP ảo đóng vai trò quan trọng trong việc quản lý kết nối mạng và phân bổ tài nguyên. Máy ảo hoặc vùng chứa có thể được gán IP ảo độc lập với cơ sở hạ tầng vật lý bên dưới. Việc tách rời này cho phép quản lý dễ dàng hơn, tính di động và khả năng mở rộng của tài nguyên ảo.
    - **Lớp trừu tượng:** IP ảo cung cấp một lớp trừu tượng giữa máy khách và cơ sở hạ tầng vật lý bên dưới. Sự trừu tượng hóa này đơn giản hóa cấu hình mạng và cho phép linh hoạt hơn trong việc quản lý tài nguyên mạng. Khách hàng chỉ cần biết về IP ảo và không yêu cầu kiến ​​thức về các thiết bị vật lý cụ thể hoặc cấu hình mạng của chúng.

## 2. Hosting
### 2.1. Máy chủ ảo(Virtual Host)
Máy chủ ảo(Virtual Host), còn được gọi là Virtual Server, là một phương thức lưu trữ nhiều trang web hoặc tên miền trên một máy chủ vật lý hoặc một cụm máy chủ. Với lưu trữ ảo, mỗi trang web dường như có máy chủ chuyên dụng của riêng mình, mặc dù nhiều trang web đang chia sẻ cùng một tài nguyên vật lý.
- Virtual Host có một số đặc điểm dưới đây:
    - **Dựa trên tên miền hoặc dựa trên IP:** Lưu trữ ảo có thể được triển khai dựa trên tên miền hoặc địa chỉ IP. Trong lưu trữ ảo dựa trên tên miền, nhiều trang web chia sẻ cùng một địa chỉ IP và máy chủ phân biệt chúng dựa trên tên miền mà khách hàng yêu cầu. Trong lưu trữ ảo dựa trên IP, mỗi trang web có một địa chỉ IP duy nhất được gán cho nó, cho phép truy cập trực tiếp vào trang web cụ thể mà không cần dựa vào tên miền được yêu cầu.
    - **Tài nguyên dùng chung:** Tài nguyên máy chủ vật lý, chẳng hạn như CPU, bộ nhớ và ổ đĩa, được chia sẻ giữa các máy chủ ảo. Hệ điều hành của máy chủ và phần mềm máy chủ web phân bổ và quản lý hiệu quả các tài nguyên này giữa các trang web được lưu trữ. Mỗi máy chủ ảo hoạt động độc lập, không biết các máy chủ ảo khác đang chia sẻ cùng một máy chủ.
    - **Cấu hình và Tùy chỉnh:** Mỗi máy chủ ảo có các tệp cấu hình riêng, chẳng hạn như cấu hình máy chủ web (ví dụ: tệp httpd.conf của Apache), nơi xác định các cài đặt cụ thể cho máy chủ ảo. Điều này bao gồm các tùy chọn như thư mục gốc của tài liệu, quy tắc truy cập, tệp nhật ký, chứng chỉ SSL, v.v. Các cấu hình này cho phép tùy chỉnh và điều chỉnh môi trường lưu trữ để đáp ứng nhu cầu cụ thể của từng trang web.
    - **Khả năng mở rộng và giảm thiểu chi phí:** Lưu trữ ảo cung cấp giải pháp có thể mở rộng để lưu trữ nhiều trang web. Khi yêu cầu về lưu lượng và tài nguyên tăng lên, các máy chủ ảo bổ sung có thể được thêm vào máy chủ hoặc cụm để đáp ứng nhu cầu ngày càng tăng. Điều này làm cho lưu trữ ảo trở thành một tùy chọn tiết kiệm chi phí, vì nó cho phép sử dụng hiệu quả tài nguyên máy chủ bằng cách lưu trữ nhiều trang web trên một máy vật lý.
### 2.2. Máy chủ file (File host)
- Lưu trữ tệp: Dịch vụ lưu trữ tệp cung cấp cho người dùng một cách an toàn và thuận tiện để lưu trữ tệp của họ trực tuyến. Người dùng có thể tải lên các loại tệp khác nhau, chẳng hạn như tài liệu, hình ảnh, video, tệp âm thanh, v.v. Các tệp này được lưu trữ trên các máy chủ do dịch vụ lưu trữ tệp cung cấp.
- Chia sẻ và phân phối tệp: Khi các tệp được tải lên dịch vụ lưu trữ tệp, người dùng có thể chia sẻ chúng với những người khác bằng cách cung cấp một URL hoặc liên kết duy nhất. Người nhận liên kết có thể truy cập và tải xuống các tệp được chia sẻ từ bất kỳ vị trí nào có truy cập internet. Điều này giúp dễ dàng chia sẻ các tệp lớn có thể khó gửi qua email hoặc các phương thức truyền thống khác.
- Khả năng truy cập và tính khả dụng: Dịch vụ lưu trữ tệp đảm bảo rằng tệp có thể truy cập và có sẵn cho người dùng bất kỳ lúc nào và từ bất kỳ thiết bị nào có kết nối internet. Người dùng có thể truy cập các tệp của họ từ các thiết bị khác nhau, chẳng hạn như máy tính, điện thoại thông minh và máy tính bảng mà không cần thiết bị lưu trữ vật lý như ổ USB hoặc ổ cứng ngoài.
- Cộng tác và quản lý tệp: Các dịch vụ lưu trữ tệp thường cung cấp các tính năng hỗ trợ cộng tác giữa những người dùng. Nhiều người dùng có thể được cấp quyền truy cập vào các tệp hoặc thư mục cụ thể, cho phép họ xem, chỉnh sửa hoặc nhận xét về các tệp được chia sẻ. Điều này thúc đẩy tinh thần đồng đội và đơn giản hóa việc quản lý tệp vì người dùng có thể làm việc đồng thời trên các tệp được chia sẻ và theo dõi các thay đổi.
- Bảo mật và quyền riêng tư: Dịch vụ lưu trữ tệp ưu tiên bảo mật và quyền riêng tư của tệp người dùng. Họ sử dụng nhiều biện pháp khác nhau để bảo vệ tệp khỏi bị truy cập trái phép hoặc mất dữ liệu, chẳng hạn như mã hóa, kiểm soát truy cập và hệ thống sao lưu. Người dùng có thể đặt cài đặt quyền riêng tư để kiểm soát ai có thể truy cập tệp của họ, đảm bảo rằng thông tin nhạy cảm hoặc bí mật vẫn được bảo vệ.
- Các tính năng bổ sung: Dịch vụ lưu trữ tệp có thể cung cấp các tính năng bổ sung như lập phiên bản tệp, đồng bộ hóa tệp trên các thiết bị, xem trước tệp và tích hợp với các ứng dụng hoặc dịch vụ khác. Các tính năng này nâng cao trải nghiệm người dùng và năng suất khi làm việc với các tệp được lưu trữ trên nền tảng lưu trữ.

### 2.3. File .htaccess
Tập tin .htaccess (hypertext access) là một file có ở thư mục gốc của các hostting và do apache quản lý, cấp quyền. File .htaccess có thể điều khiển, cấu hình được nhiều thứ với đa dạng các thông số, nó có thể thay đổi được các giá trị được cài đặt mặc định của apache.
- Một số tính năng của file .htaccess
    - Bỏ hoặc thêm WWW vào tên miền:
    ```htaccess
    // add WWW to URL

    RewriteEngine On

    RewriteBase /

    RewriteCond %{HTTP_HOST} !^www.domain.com$ [NC]

    RewriteRule ^(.*)$ http://www.domain.com/$1 [L,R=301]

    // Remove WWW from URL

    RewriteEngine On

    RewriteBase /

    RewriteCond %{HTTP_HOST} !^domain.com$ [NC]

    RewriteRule ^(.*)$ http://domain.com/$1 [L,R=301]
    ```
    - Chuyển hướng đến trang thông báo lỗi riêng:
    ```htaccess
    ErrorDocument 401 /error/401.php

    ErrorDocument 403 /error/403.php

    ErrorDocument 404 /error/404.php

    ErrorDocument 500 /error/500.php
    ```
    - Đặt 301 Redirect
    ```htaccess
    // page 1

    Redirect 301 /old/old.htm http://domain.com/new.htm

    // domain redirect

    RewriteEngine On

    RewriteRule ^(.*)$ http://domain.com/$1 [R=301,L]
    ```
    - Chặn hotlink
    ```htaccess
    Options +FollowSymlinks

    #No hotlink

    RewriteEngine On

    RewriteCond %{HTTP_REFERER}!^$

    RewriteCond %{HTTP_REFERER}!^http://(www.)?domain.com/[nc]

    RewriteRule .*.(gif|jpg|png)$ http://domain.com/images/nohotlink.gif[nc]
    ```
    - Sửa đổi URL hiển thị
        - Bỏ đuôi mở rộng của URL
        - Thay đổi đuôi mở rộng của URL
        - Thêm `/` vào URL
        - Thay đổi kí tự trong URL
    - Cài đặt giới hạn file
        - Bảo vệ file
        - Đặt password cho thư mục và file
        - Giới hạn file Upload
    - Cấm IP truy cập
    ```htaccess
    allow from all

    deny from 192.168.1.123

    deny from 192.168
    ```
    - Chuyển đổi tên miền cũ sang tên miền mới
    ```htaccess
    <IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^olddomain.com$ [OR]
    RewriteCond %{HTTP_HOST} ^www.olddomain.com$
    RewriteRule (.*)$ http://www.newdomain.com/$1 [R=301,L]
    </IfModule>
    ```
    - Chuyển hướng http qua https
    ```htaccess
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
    ```
