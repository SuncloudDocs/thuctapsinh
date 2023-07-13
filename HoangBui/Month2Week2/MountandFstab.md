# Mount và Fstab
## 1. Mount
Trong Linux, **Mount** được sử dụng để gán một tệp hệ thống vào một thư mục cụ thể, điều này cho phép người dùng truy cập các tệp hệ thống thông qua thư mục đó. Mount cho phép cung cấp các thiết bị bên ngoài(VD: ổ đĩa rời, USB, các thiết bị ngoại vi,.. ) hoặc hệ thống từ tệp từ xa trong môi trường Linux.
- Cách sử dụng Mount trên Linux:
    - **Xác định thiết bị hoặc hệ thống tệp:** có thể là một phân vùng trên ổ cứng hay thiết bị lưu trữ USB,...
    - **Tạo một mount point:** Tạo một thư mục trên hệ thống của bạn(có thể sử dụng lệnh `mkdir` đối với Ubuntu).
    - **Kết nối tệp hệ thống**:
    ```bash
    sudo mount <device> <mount_point>
    ```
    > Trong đó: `<device>` là  tệp hệ thống mà bạn muốn gán, `<mount-point>` là vị trí tệp mà bạn muốn gán đến.
    - Nếu tệp hệ thống thuộc một loại cụ thể(VD: một phân vùng NTFS), bạn có thể chỉ định loại tệp hệ thống này bằng tuỳ chọn `-t`. Ví dụ
    ```bash
    sudo mount -t ntfs /dev/sdb1 /mnt/data
    ```
    - Ngoài ra, bạn có thể chỉ định các tuỳ chọn gắn kết khác như quyền đọc, viết,... của người dùng bằng tuỳ chọn `-o`. Ví dụ về tuỳ chọn chỉ đọc:
    ```bash
    sudo mount -o ro /dev/sdb1 /mnt/data
    ```
    - **Ngắt kết nối tệp:** cần ngắt kết nối hệ thống tệp trước khi ngắt kết nối thiết bị hoặc tắt hệ thống, để ngắt kết nối tệp hệ thống, sử dụng lệnh `unmount`
    ```bash
    sudo umount <mount_point>
    ```
- Ví dụ về mount: Kết nối một thiết bị lưu trữ USB
    - **Xác định thiết bị USB:** Sử dụng lệnh `lsblk` để hiển thị các thiết bị có sẵn bao gồm cả các ổ đĩa và phân vùng
    ```bash
    ~$ lsblk
    NAME     MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0      7:0    0  24.4M  1 loop /snap/amazon-ssm-agent/6312
    loop1      7:1    0  24.8M  1 loop /snap/amazon-ssm-agent/6563
    loop2      7:2    0  55.6M  1 loop /snap/core18/2745
    loop3      7:3    0  55.6M  1 loop /snap/core18/2751
    loop4      7:4    0  63.3M  1 loop /snap/core20/1879
    loop5      7:5    0  63.5M  1 loop /snap/core20/1891
    loop6      7:6    0 111.9M  1 loop /snap/lxd/24322
    loop7      7:7    0  53.2M  1 loop /snap/snapd/19122
    loop8      7:8    0  53.3M  1 loop /snap/snapd/19361
    sda      8:0    0    50G  0 disk 
    ├─sda1   8:1    0     1M  0 part 
    ├─sda2   8:2    0   513M  0 part /boot/efi
    └─sda3   8:3    0  49.5G  0 part /var/snap/firefox/common/host-hunspell
                                    /
    sdb      8:16   1  14.6G  0 disk 
    ├─sdb1   8:17   1   4.5G  0 part 
    └─sdb2   8:18   1    10G  0 part /media/hoangbuii/USB-DATA
    sr0     11:0    1  1024M  0 rom
    ```
    Phân vùng mà chúng ta sẽ dùng để gắn kết ở đây sẽ là `dev/sdb1`
    - **Tạo mount point:** Tạo một mount point trên ổ hệ thống ubuntu của bạn:
    ```bash
    sudo mkdir 
    ```
    - **Gán phân vùng USB vào thư mục hệ thống:**
    ```bash
    sudo mount /dev/sdb1 /mnt/usb
    ```
    Nếu phân cùng của USB là loại tệp khác (VD:NTFS), bạn có thể cần chỉ định loại tệp hệ thống sử dụng `-t`:
    ```bash
    sudo mount -t ntfs /dev/sdb1 /mnt/usb
    ```
    - Sau khi đã gán bạn có thể kiểm tra nó bằng lện `lsblk`, thư mục được gán sẽ xuất hiện ở phần `MOUNTPOINTS`
    ```bash
    ~$ lsblk
    NAME     MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0      7:0    0  24.4M  1 loop /snap/amazon-ssm-agent/6312
    loop1      7:1    0  24.8M  1 loop /snap/amazon-ssm-agent/6563
    loop2      7:2    0  55.6M  1 loop /snap/core18/2745
    loop3      7:3    0  55.6M  1 loop /snap/core18/2751
    loop4      7:4    0  63.3M  1 loop /snap/core20/1879
    loop5      7:5    0  63.5M  1 loop /snap/core20/1891
    loop6      7:6    0 111.9M  1 loop /snap/lxd/24322
    loop7      7:7    0  53.2M  1 loop /snap/snapd/19122
    loop8      7:8    0  53.3M  1 loop /snap/snapd/19361
    sda      8:0    0    50G  0 disk 
    ├─sda1   8:1    0     1M  0 part 
    ├─sda2   8:2    0   513M  0 part /boot/efi
    └─sda3   8:3    0  49.5G  0 part /var/snap/firefox/common/host-hunspell
                                    /
    sdb      8:16   1  14.6G  0 disk 
    ├─sdb1   8:17   1   4.5G  0 part /home/mnt/usb
    └─sdb2   8:18   1    10G  0 part /media/hoangbuii/USB-DATA
    sr0     11:0    1  1024M  0 rom
    ```
    - **Truy cập vào ổ USB đã gán:** Sau khi gán tệp hệ thống, bạn có thể truy cập các file và thư mục có trong USB thông qua thư mục `mnt/usb`
    - **Ngắt kết nối phân vùng USB:**
    ```bash
    sudo umount mnt/usb
    ```
## 2. fstab 
- Trong Linux, file **fstab** được dùng để cấu hình việc tự động mount các tệp hệ thống trong quá trình khởi động thiết bị, file fstab được lưu trữ tại `/etc/fstab`
- Định dạng file fstab: Mỗi dòng của file fstab đại diện cho một tệp hệ thống riêng biệt, định dạng chung của một mục fstab như sau:
```bash
<device>      <filesystem_type>   <options>   <dump>   <pass>
```
- Trong đó:
    - `<device>` chỉ định thiết bị hoặc tệp hệ thống được gán kết, nó có thể là tên thiết bị, tệp hoặc Mã nhận dạng duy nhất (UUID) hoặc số nhận dạng LABEL
    - `<mount_point>` Chỉ định thư mục được gán. 
    - `<options>` Chỉ định các tuỳ chọn gán như `defaults`, `ro`(chỉ đọc), `noauto`(không tự động gán)
    - `<dump>` Chỉ định xem tệp hệ thống có nên được sao lưu hay không ( thường là `0` với các tệp hệ thống thường).
    - `<pass>` Chỉ định thứ tự thực hiện kiểm tra hệ thống tệp khi khởi động (thường được đặt thành `1` cho hệ thống tệp gốc và `2` cho các hệ thống khác).
- Ví dụ về một mục fstab:
```bash
/dev/sdb1   /mnt/data   ext4   defaults   0   2
```
- Việc thêm các mục stab vào file fstab phải tuân thủ định dạng trên, file fstab sẽ được kiểm tra trong quá trình boot OS, khi điều chỉnh file fstab trực tiếp xảy ra lỗi chính tả (syntax), trong lần boot tiếp theo sẽ được đưa vào chế độ recovery vì không thể thực hiện quá trình mount partition được định nghĩa trong file này.
- Sau khi thêm các mục vào file fstab, bạn có thể lưu tệp và kiểm tra các mục fstab bằng lệnh:
```bash
sudo mount -a
```
Nếu có bất kỳ lỗi nào trong các fstab mục nhập, lệnh này sẽ hiển thị (các) thông báo lỗi liên quan đến việc gắn kết không thành công.
