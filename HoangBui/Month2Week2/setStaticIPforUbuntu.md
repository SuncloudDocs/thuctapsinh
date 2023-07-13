# Đặt địa chỉ IP tĩnh và IP động cho Ubuntu
1. Xác định interface mạng sử dụng lệnh `ip a` hoặc `ip addr show` để liệt kê tất cả các interface đang kết nối.
```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc fq_codel state UP group default qlen 1000
    link/ether 06:3c:80:1d:53:21 brd ff:ff:ff:ff:ff:ff
    inet 172.31.44.213/20 metric 100 brd 172.31.47.255 scope global dynamic eth0
       valid_lft 2967sec preferred_lft 2967sec
    inet6 fe80::43c:80ff:fe1d:5321/64 scope link 
       valid_lft forever preferred_lft forever
```
2. Xác định inerface muốn cấu hình IP tĩnh(VD: eth0, enp3s0, wlan0,...).
3. Chỉnh sửa tệp cấu hình mạng: Tệp cấu hình mạng được lưu trữ tại **/etc/netplan/01-netcfg.yaml** (tệp cấu hình có thể khác nhau tuỳ vào phiên bản Ubuntu):
```yaml
network:
    ethernets:
        eth0:
            dhcp4: true
            dhcp6: false
            match:
                macaddress: 06:3c:80:1d:53:21
            set-name: eth0
    version: 2
```
- Để cài địa chỉ ip tĩnh, thay đổi **"dhcp4: true"** thành **"dhcp4: no"** đồng thời thêm các dòng lệnh sau để cài đặt địa chỉ IP, subnetmask và địa chỉ DNS server:
```yaml
      addresses: [192.168.0.100/24]
      gateway4: 192.168.0.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
```
4. Lưu tệp cấu hình và chạy lại cấu hình mạng bằng lệnh:
```bash
sudo netplan apply
```
5. Kiểm tra cấu hình mạng bằng lệnh `ip addr show <interface>` thay thế `<interface>` bằng tên interface vừa cấu hình
6. Để cấu hình địa chỉ IP về IP động, ta chỉ cần đổi lại dòng **"dhcp4: no"** thành **"dhcp4: true"** tại file cấu hình và áp dụng.