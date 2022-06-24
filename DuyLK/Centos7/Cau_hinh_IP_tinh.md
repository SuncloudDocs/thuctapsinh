## Cấu hình ip tĩnh
### Mục lục
[1. Mô hình](#Mohinh)

[2. TOPO LAB](#TopoLab)

[3. Tiến hành cấu hình IP tĩnh](#Cauhinhiptinh)
- [3.1. Cấu hình IP tĩnh trên Centos 7](#Centos7)
- [3.2. Cấu hình IP tĩnh trên Ubuntu 20](#Ubuntu20)

<a name="Mohinh"></a>
# 1. Mô hình
![ip tĩnh](https://user-images.githubusercontent.com/84270045/141457434-0ba23097-3f35-4412-b98d-cbbdb86c0b92.png)
<a name="TopoLab"></a>
# 2. TOPO LAB
- Giả lập trên VMware Workstation.
- Centos7 và Ubuntu20.
- Cần có ít nhất 2 máy để ping IP qua lại: máy vật lí, Client, Ubuntu, ...

<a name="Cauhinhiptinh"></a>
# 3. Tiến hành cấu hình IP tĩnh
<a name="Centos7"></a>
### 3.1. Cấu hình IP trên Centos 7.
- Kiểm tra card mạng tương ứng: Ta sử dụng lệnh `ip a`.

![ip link show](https://user-images.githubusercontent.com/84270045/141282521-13359b2b-d0b8-4e70-8a35-3bb9c606d9a3.png)
- Giờ ta có card mạng `ens33` thì ta cần tạo 1 file cấu hình có tên tiền tố là `ifcfg-<tên card mạng>` trong thư mục `/etc/sysconfig/network-scripts/`. Ví dụ dưới đây thì ta sẽ tạo file `ifcfg-ens33`.
```
[root@client ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens33
```
![image](https://user-images.githubusercontent.com/84270045/165949285-b7e24145-155f-44b0-a24d-7dd323a202ff.png)
- Sau khi đã hoàn tất cấu hình IP tĩnh như trên thì ta sẽ khởi động lại dịch vụ network trên CentOS 7.
```
[root@client ~]# systemctl restart network
```
 
 <a name="Ubuntu20"></a>
 ### 3.2 Cấu hình ip tĩnh trên Ubuntu20.
 - Kiểm tra IP hiện tại của máy bằng lệnh `networkctl status`
 
 ![ip tĩnh mới](https://user-images.githubusercontent.com/84270045/141717231-6ae5cea8-a25a-460d-8569-18804ad4e2f4.png)
 - Ở trên ta thấy card `ens33` đang được sử dụng
 - Tiếp theo ta truy cập vào tệp `netplan` bằng lệnh `cd /etc/netplan`. Tại đây ta dùng lệnh `ls` để xem các tệp hiện có trong thư mục `netplan`. Ta thấy có duy nhất 1 tệp `00-installer-config.yaml`, tiến hành truy cập và chỉnh sửa tệp này.
 
 ![truy cập netplan](https://user-images.githubusercontent.com/84270045/141717409-1d4bf0c5-f99f-4faa-9245-7775e1ce3baf.png)
 
 - Khi truy cập thành công, ta tiến hành chỉnh sửa như hình dưới đây ( ấn phím `i` để chỉnh sửa tệp ):
 
 ![giao diện netplan](https://user-images.githubusercontent.com/84270045/141717805-9a3be0a3-e08a-4cc3-a5ea-ffa2fdc653c7.png)
 
 - Sau khi chỉnh sửa xong, ta thoát chế độ `INSERT` ( ấn `esc` ) và gõ `:wq` để lưu và thoát file.
 - Dùng lệnh `sudo netplan apply` để cập nhật IP mới:
 
 ![checck lại ip](https://user-images.githubusercontent.com/84270045/141718036-4f033473-fae7-4197-905e-1860aec9f7dc.png)
 
  ## Vậy là đã hoàn thành công việc đặt địa chỉ IP tĩnh.
