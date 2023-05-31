## Cách cài đặt IP tĩnh trên ubuntu ##
1. Yêu cầu
- Cài đặt ip + dns + gateway + show cấu hình 
Địa chỉ IP là 192.168.69.136
gateway 192.168.69.1
netmask : 255.255.255.0
dns 8.8.8.8

2. Các bước cài đặt ip tĩnh trên ubuntu 20.04

- Khi ở 1 máy vừa cài đặt xong thì sẽ hiện lên như sau : 
![Imgur](https://i.imgur.com/xI5skyq.png)

- Vào `vi /etc/netplan/00-installer-config.yaml`

![Imgur](https://i.imgur.com/nzqNCBi.png)

- Sau khi vào ta thực hiện chỉnh sửa file như sau 
![Imgur](https://i.imgur.com/cZUbXWB.png)
- Sau khi chỉnh xong file thì lưu lại 
`wq!`
- Sau cùng sử dụng câu lệnh 

`netplan apply` 

