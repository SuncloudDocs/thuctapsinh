>KVM
# Chapter 3: Tạo các máy ảo trong KVM
# 1. Sử dụng virsh
## 1.1. Tạo máy ảo với lệnh virt-install
- `virt-install` là công cụ command-line dùng cho việc tạo máy ảo sử dụng thư viện quản lí "libvirt".
- Hầu hết các option của `virt-install` đều không bắt buộc , chỉ yêu cầu một số thông số tối thiểu sau:
    - `--name` hoặc `-n`: Tên của máy ảo
    - `--memory`: chỉ ra dung lượng RAM cho máy ảo (tính bằng MB)
    - Lưu trữ: `--disk` hoặc `filesystem` chỉ ra vị trí lưu trữ của máy ảo với `size` chỉ ra dung lượng của `disk` (tính bằng GB)
- Ngoài ra còn một số option đưa ra thông số khác như 
    - `--vcpus`: là tổng số CPU định tạo cho máy ảo
    - `--description` : Mô tả cho máy ảo
    - Các tuỳ chọn cài đặt
        - `--cdrom` hoặc `-c`: chỉ ra đường dẫn đến file ISO.
        - `--locaion` hoặc `-l`: đường dẫn đến file cài đặt (có thể là đường dẫn trên internet).
    - `--os-variant`: chỉ ra kiểu của HĐH của máy ảo đang tạo. (nên có để cải thiện hiệu năng của máy ảo), có thể tìm kiếm thông thi hệ điều hành bằng lệnh `osinfo-query os`
    - `--graphics`: chọn kiểu màn hình tương tác. Có thể chọn "vnc" hoặc "sdl", "spice" và "none"
    - `--network`hoặc `-w`: chỉ ra card kết nối mạng của máy ảo.
- Một số tuỳ chọn Network:
    - `nonenetworks` : Không sử dụng card mạng
    - `-b` hoặc `--bridge`: sử dụng bridge
    
Ví dụ:
```bash
virt-install \
--name=newVM \
--vcpus=1 \
--memory=512 \
--cdrom=/var/lib/libvirt/images/CentOS-7-x86_64-Minimal-2009.iso \
--disk=/var/lib/libvirt/images/newvm.img,size=8 \
--os-variant=rhel7 \
```
Nếu gặp lỗi `virt-install: Command Not Found` hãy cài đặt `virt-install`
```bash
# CentOS
yum install virt-install

#Ubuntu
apt-get install virtinst
```
Kết quả
```bash
WARNING  Unable to connect to graphical console: virt-viewer not installed. Please install the 'virt-viewer' package.
WARNING  No console to launch for the guest, defaulting to --wait -1

Starting install...
Domain installation still in progress. Waiting for installation to complete.
```
## 1.2. Quản lí máy ảo với virsh
- Hiển thị danh sách máy ảo
```bash
$ virsh list --all
 Id    Name                           State
----------------------------------------------------
 2     newVM                          running
```
- Bật/Tắt, Khởi động lại, tạm dừng máy ảo
```bash
$ virsh shutdown VM1
Domain VM1 is being shutdown
$ virsh list --all
 Id    Name                           State
----------------------------------------------------
 -     VM1                            shut off
$ virsh start VM1
Domain VM1 started

$ virsh list --all
 Id    Name                           State
----------------------------------------------------
 5     VM1                            running

$ virsh reboot VM1
Domain VM1 is being rebooted

```
- Xoá máy ảo, để xoá một máy ảo trước hết bạn cần tắt máy ảo đó.
```bash
$ virsh undefine VM1
Domain VM1 has been undefined

$ 
```
# 2. Live migrate trên KVM
## 2.1. Tổng quan về Live migrate
Live mirgrate là cơ chế di chuyển VM trong khi VM vẫn đang hoạt động, quá trình trao đổi diễn ra nhanh và người sử dụng VM không thể cảm nhận được bất cứ gián đoạn nào, quá trình Live migrate diễn ra như sau:
- Đầu tiên, một phiên bản snapshot của host nguồn sẽ được chuyển đến máy đích
- Nếu người dùng đang truy cập trên máy nguồn, những hoạt động đó sẽ được diễn ra bình thường
- Những thay đổi trên host nguồn sẽ được đồng bộ đến host đích.
- Sau khi đã đồng bộ xong, VM trên host nguồn sẽ được tắt, tất cả các phiên truy cập sẽ được chuyển sang VM trên host đích
## 2.2. Chuẩn bị
Để triển khai live migrate, cần chuẩn bị ba máy ảo, bao gồm:
- Máy chủ NFS
- 2 KVM host, trong đó một máy có chứa VM cần chuyển đổi.
Ba máy này cần có thể kết nối với nhau
## 2.3. Triển khai
- Cấu hình dải tên miền: Để có thể live mỉgrate thì hai host KVM cần biết được tên miền của nhau, có thể cấu hình DNS server. Nếu không có DNS, có thể cấu hình tại file `/etc/host`, Ví dụ tại KVM1, thực hiện tương tự tại KVM2
```bash
$ echo "kvm01" > /etc/hostname
$ echo "10.10.1.20 kvm02.local kvm02" >> /etc/hosts
$ reboot
```
- Cài đặt NFS server: 
    - Cài đặt các gói của NFS:
    ```bash
    $ sudo yum install -y nfs-utils nfs-utils-lib
    ```
    - Tạo thư mục để làm Share Folder giữa hai KVM host
    ```bash
    mkdir /root/storage
    ```
    - Chia sẻ thư mục với các KVM host bằng cách ghi các thông tin sau vào file `/etc/export`
    ```bash
    /root/storage 10.10.34.162/24(rw,sync,no_root_squash)
    /root/storage 10.10.34.163/24(rw,sync,no_root_squash)
    ```
    - Cập nhật lại file và khởi động lại NFS
    ```bash
    $ exportfs -a
    $ service nfs start
    ```
- Cài đặt NFS trên KVM host
    - Cài đặt các gói của NFS
    ```bash
    $ sudo yum install -y nfs-utils nfs-utils-lib
    ```
    - Sử dụng thư mục mới để chứa file disk, có thể tạo thư mục mới
    ```bash
    $ mkdir storage
    ```
    - mount các thư mục chứa máy ảo với các thư mục đã share
    ```bash
    $ mount 10.10.1.2:/root/storage/ /root/storage/
    $ mount /var/lib/libvirt/images/ /root/storage/
    ```
    > Lưu ý rằng khi reboot lại máy, cần mount lại các thư mục này. Nếu không muốn, hãy sửa file `/etc/fstab`, xem thêm tại [Mount & fstab](../Month2Week2/MountandFstab.md)
    
- Cài đặt KVM trên hai KVM host: nếu chưa cài đặt KVM hãy cài KVM trên cả hai host và có máy ảo Vm cần chuyển dổi. Sau đó, sử dụng lệnh `virsh edit [VM_name]` để chỉnh sửa VM và thêm thông tin về disk `cache='none'` vào khối dưới đây và reboot lại VM:
```xml
<disk type='file' device='disk'>
    <driver name='qemu' type='qcow2'cache='none'/>
    <source file='/var/lib/libvirt/images/newVM.qcow2'/>
    <target dev='vda' bus='virtio'/>
    <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
</disk>
```
- Kết nối qemu giữa hai KVM host: để có thể live migrate thì hai KVM host cần được kết nối với nhau, hãy thực hiện bước sau trên cả hai KVM host:
```bash
$ sed -i 's/#listen_tls = 0/listen_tls = 0/g' /etc/libvirt/libvirtd.conf 
$ sed -i 's/#listen_tcp = 1/listen_tcp = 1/g' /etc/libvirt/libvirtd.conf
$ sed -i 's/#tcp_port = "16509"/tcp_port = "16509"/g' /etc/libvirt/libvirtd.conf
$ sed -i 's/#listen_addr = "10.10.34.1"/listen_addr = "0.0.0.0"/g' /etc/libvirt/libvirtd.conf
$ sed -i 's/#auth_tcp = "sasl"/auth_tcp = "none"/g' /etc/libvirt/libvirtd.conf
$ sed -i 's/#LIBVIRTD_ARGS="--listen"/LIBVIRTD_ARGS="--listen"/g' /etc/sysconfig/libvirtd
$ sudo systemctl restart libvirtd
```
- Migrate:
    - Kiểm tra máy ảo trên KVM1 và KVM2(KVM1 có một máy ảo VM đang chạy, còn KVM2 không có máy ảo nào)
    - Thực hiện lệnh ping trên VM
    - Tiến hành migrate bằng lệnh 
    ```bash
    virsh migrate --live --unsafe vm162 qemu+tcp://10.10.34.163/system
    ```
    - Sau khi quá trình live migrate hoàn thành, lệnh ping vẫn đang chạy và các file trên VM vẫn được giữ nguyên trên KVM2