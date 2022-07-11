# Thay đổi tên card mạng

### Mục lục
[1. Kiểm tra tên card mạng hiện tại](#CardHienTai)

[2. Tiến hành thay đổi tên card mạng](#ThayTenCard)

<a name="CardHienTai"></a>
## 1. Kiểm tra tên card mạng hiện tại
- Sử dụng lệnh `ip a` để xem tên card mạng hiện tại

![ip a](https://user-images.githubusercontent.com/84270045/142417185-7862a848-6b44-40be-af29-6ebdf3cdeb76.png)

 Hiện tại ta thấy tên card mạng đang là `enss33`
 
 <a name="ThayTenCard"></a>
## 2. Tiến hành thay đổi tên card mạng.
  
  ### B1: Chỉnh sửa tham số Kernel boot.
    
    - Truy cập file `/etc/default/grub` với lệnh `vi` để chỉnh sửa
    - Tìm đến dòng `GRUB_CMDLINE_LINUX` và thêm đoạn `net.ifname=0 biosdevname=0`. Sau khi sửa xong file sẽ có dạng:
    
    ![name](https://user-images.githubusercontent.com/84270045/142418373-7b95c333-44d2-410a-8c29-53bd0ecdac29.png)
    
    - Sinh lại tệp `Grub` và ghi đè len tệp hiện có ta sử dụng lệnh `grub2-mkconfig -o /boot/grub2/grub.cfg`
    
    ![grub](https://user-images.githubusercontent.com/84270045/142418981-fac2712d-2269-4fdd-9635-c5ddc492a1d3.png)

### B2: Chỉnh sửa file cấu hình mạng
- Ta truy cập vào file theo đường dẫn `/etc/sysconfig/network-scripts/ifcfg-ens33` và sử dụng `vi` để chỉnh sửa

```
[root@client ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens33
```

- Chỉnh sửa file cấu hình mạng ban đầu là `ens33`. Tại mục **NAME** và **DEVICE**, ta đổi từ `ens33` thành `eth0`.

![eth0](https://user-images.githubusercontent.com/84270045/142419787-83c70370-872a-4a3c-8db6-3277e78d8b62.png)

- Sau đó sửa tên file cấu hình mạng: `ifcfg-ens33` thành `ifcfg-eth0`

```
[root@client ~]# mv /etc/sysconfig/network-scripts/ifcfg-ens33 /etc/sysconfig/network-scripts/ifcfg-eth0
```

### B3. Tắt NetworkManager
- Đảm bảo rằng NetworkManager không hoàn nguyên các thay đổi khi khởi động lại máy hay khởi động lại mạng.

```
[root@client ~]# systemctl disable NetworkManager
```

### B4. REBOOT máy

```
[root@client ~]# reboot
```

## 3. Kiểm tra 
- Sử dụng lệnh `ip a` để kiểm tra
