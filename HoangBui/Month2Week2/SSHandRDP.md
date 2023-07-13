# SSH(linux) và RDP(windows)
## 1. Tổng quan
SSH và RDP đều là các giao thức được sử dụng để thiết lập kết nối từ xa với máy tính. Chúng cung cấp khả năng truy cập và điều khiển hệ thống máy tính từ xa qua mạng. Tuy nhiên, chúng được sử dụng cho các hệ điều hành khác nhau:
- **SSH (Secure Shell):** SSH là một giao thức mạng được sử dụng để truy cập từ xa an toàn vào các hệ thống tương tự Linux và Unix. Nó cung cấp một kết nối được mã hóa an toàn giữa máy khách và máy chủ. SSH cho phép người dùng đăng nhập từ xa vào máy chủ và thực thi các lệnh, truyền tệp và tạo đường hầm(tunnel) cho các dịch vụ mạng khác một cách an toàn. Nó được sử dụng rộng rãi để quản trị từ xa, truyền tệp và liên lạc an toàn giữa các máy tính.

Khi sử dụng SSH, máy khách sẽ bắt đầu kết nối với máy chủ và cung cấp thông tin đăng nhập xác thực (chẳng hạn như tên người dùng và mật khẩu hoặc khóa SSH) để thiết lập phiên bảo mật. Sau khi kết nối, người dùng có thể thực hiện các lệnh trên máy chủ từ xa như thể họ đang ngồi trước nó.

- **RDP (Remote Desktop Protocol):** RDP là một giao thức độc quyền do Microsoft phát triển để truy cập từ xa vào các hệ thống dựa trên Windows. Nó cho phép người dùng kết nối với một máy tính Windows từ xa và điều khiển nó như thể họ đang có mặt trên máy. RDP cung cấp giao diện đồ họa cho phiên máy tính từ xa, cho phép người dùng tương tác với hệ thống từ xa, chạy ứng dụng, truy cập tệp và thực hiện các tác vụ khác nhau.

Để sử dụng RDP, hệ thống Windows từ xa phải bật máy chủ RDP và hệ thống máy khách phải cài đặt phần mềm máy khách RDP. Máy khách thiết lập kết nối với máy chủ bằng giao thức RDP và cung cấp thông tin đăng nhập xác thực để truy cập phiên máy tính từ xa. Sau khi kết nối, máy khách có thể xem và kiểm soát môi trường máy tính để bàn của hệ thống từ xa.
## 2. Thiết lập SSH và RDP
### 2.1. SSH trên Linux
- Kiểm tra trạng thái của máy chủ SSH:
```bash
sudo service ssh status
```
- Nếu SSH chưa được cài đặt, hãy cài dặt openSSH bằng lệnh:
```bash
sudo apt-get install openssh-server
```
- Sau đó, khởi chạy SSH server(nếu SSH server chưa tự khởi động):
```bash
sudo service ssh start
```
- Nếu tường lửa của Linux đang chạy, cần phải mở cổng SSH(cổng mặc định là 22) để chấp nhận các kết nối SSH, có 2 công cụ quản lí tường lửa phổ biến là UFW và iptable:

    - Đối với UFW(Uncomplicated Firewall):

        - Kiểm tra trạng thái UFW bằng lệnh:
        ```bash
        sudo ufw status
        ```
        - Nếu UFW không hoạt động hãy bật nó bằng lệnh:
        ```bash
        sudo ufw enable
        ```
        - Cho phép các kết nối SSH qua UFW:
        ```bash
        sudo ufw allow ssh
        ```
    - Đối với iptables:

        - Cho phép các kết nối SSH đến bằng lệnh:
        ```bash
        sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
        ```
        - Lưu lại các iptables rule để duy trì trong các lần khởi động lại tiếp theo(lệnh dưới đây thực hiện cho Ubuntu):
        ```bash
        sudo iptables-save | sudo tee /etc/iptables/rules.v4
        sudo ip6tables-save | sudo tee /etc/iptables/rules.v6
        ```
### 2.2. RDP trên Windows
- Cho phép RDP trên Window:

    - Nhấn tổ hợp **Win + X** và chọn **System** ở hộp thoại hiện lên. Cửa sổ **System Setting** sẽ hiện lên.
    - Chọn **Advanced system setting** để vào cửa sổ **System Properties**
    - Tích vào ô **Allow remote connections to this computer**

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/rdp.png)

- Cho phép kết nối RDP qua Firewall bằng lệnh dưới đây (Áp dụng cho Windows Defender Firewall):

    - Nhấn **Win + X** và chọn **"Windows PowerShell (Admin)"** hoặc **"Dấu nhắc lệnh (Admin)"** để dòng lệnh với quyền admin.
    - Mở cổng RDP(cổng mặc định là 3389):
    ```bash
    netsh advfirewall firewall add rule name="RDP" dir=in action=allow protocol=TCP localport=3389
    ```
## 3. Kết nối đến SSH và RDP
### 3.1 SSH
- Lấy thông tin về SSH server cần kết nối, các thông tin này bao gồm:

    - Địa chỉ IP hoặc hostname của máy chủ
    - Số cổng SSH (mặc định là 22)
    - Tên người dùng và mật khẩu hoặc khóa SSH để xác thực

- Sử dụng lệnh sau để kết nối với SSH server:
```bash
ssh [options] [username]@[ip_address_or_hostname] -p [port_number]
```
Ví dụ:
```bash
ssh hoangbuii@192.168.92.101 -p 22
```
- Nếu kêt nối yêu cầu xác thực bằng mật khẩu, hãy nhập mật khẩu khi được nhắc:
- Nếu kết nối yêu cầu khoá, hãy kết nối bằng lệnh sau:
```bash
ssh -i ~/.ssh/id_rsa [username]@[server_address]
```
Hãy thay thế **"~/.ssh/id_rsa"** bằng đường dẫn đến khoá của bạn.
### 3.2. RDP
- Lấy thông tin về RDP server cần kết nối, các thông tin này bao gồm:

    - Địa chỉ IP hoặc hostname của máy chủ
    - Số cổng RDP (mặc định là 3389)
    - Tên người dùng và mật khẩu để xác thực
- Mở phần mềm máy khách RDP của bạn.
- Nhập địa chỉ IP hoặc tên máy chủ của máy chủ vào trường thích hợp.
- Chỉ định số cổng RDP nếu nó khác với mặc định (cổng 3389).
- Nhập tên người dùng và mật khẩu của bạn vào các trường thích hợp.
- Nhấp vào "Kết nối" hoặc "Kết nối/OK" để bắt đầu kết nối RDP.

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/rdpc.png)
## 4. Thay đổi port remote trên Linux, Windows
### 4.1. Linux
- Truy cập vào tệp cấu hình của SSH tại đường dẫn **"/etc/ssh/sshd_config"**
- Tìm dòng chỉ định số cổng. Theo mặc định, nó được đặt thành Port 22.
```conf
Include /etc/ssh/sshd_config.d/*.conf

#Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key
```
- Sửa đổi số cổng thành giá trị mong muốn. Chọn một số cổng không được sử dụng và không bị chặn bởi tường lửa.
- Lưu tệp và thoát khỏi trình soạn thảo văn bản.
- Khởi động lại dịch vụ SSH để áp dụng các thay đổi. Lệnh khởi động lại dịch vụ SSH khác nhau tùy thuộc vào bản phân phối Linux.
```bash
sudo service ssh restart
```
hoặc:
```bash
sudo systemctl restart sshd.
```
### 4.2. Windows
- Nhấn **Win + R** trên bàn phím để mở hộp thoại **Run**.
- Nhập **regedit** và nhấn Enter để mở **Registry Editor**.
- Điều hướng đến registry key sau:
```arduino
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
```
- Tìm giá trị **registry key** có tên **PortNumber** và nhấn đúp vào giá trị đó
- Chọn tuỳ chọn **Decimal** và nhập giá trị mong muốn (mặc định là 3389) sau đó lưu lại: 

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/chpo.png)
- Khởi động lại máy tính hoặc dịch vụ Remote Desktop để các thay đổi có hiệu lực.

## 5. SSH đến một server sử dụng MobaXterm
Trong ví dụ này, chúng ta sẽ thực hiện SSH đến một SSH server sử dụng MobaXterm:
### 5.1. Chuẩn bị
- SSH server: ở đây chúng ta sử dụng một instance EC2 được cung cấp bởi AWS, instance được cài đặt sẵn SSH server và mở sẵn sàng kết nối:
```bash
ubuntu@ip-172-31-7-151:~$ sudo service ssh status
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/ssh.service.d
             └─ec2-instance-connect.conf
     Active: active (running) since Thu 2023-06-15 02:22:38 UTC; 15min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 656 (sshd)
      Tasks: 1 (limit: 1141)
     Memory: 8.7M
        CPU: 91ms
     CGroup: /system.slice/ssh.service
             └─656 "sshd: /usr/sbin/sshd -D -o AuthorizedKeysCommand /usr/share/ec2-instance-connect/eic_run_authorized_keys %u %f -o AuthorizedKeysCommandUser ec2-instance-connect [listener] 0 of 10-100 s>
```
- Khi tạo instance EC2, ta tạo sẵn keypair và lưu vào SSH client
- Cài MobaXterm trên SSH client và sẵn sàng kết nối đến server

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/mthome.png)

### 5.2. Thực hiện kết nối
- Lấy thông tin về SSH server: các thông tin bao gồm hostname, username và keypair:
![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/infec2.png)
- Thực hiện kết nối:

    - Mở MobaXterm, Chọn **Sessions/New Session**
    - Điền các thông tin về hostname và username
    - Tích vào ô **Use private key** và chọn keypair đã lưu

    ![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/esco.png)

- Sau khi kết nối thành công, bạn có thể truy cập vào SSH server

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week2/enco.png)