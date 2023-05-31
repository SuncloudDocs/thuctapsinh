## Sao lưu dữ liệu##
1. Rsync - Remote Sync :Đồng bộ hóa dữ liệu từ xa.
- Là một công cụ hữu hiệu để sao lưu dữ liệu và đồng bộ hóa dữ liệu trên Linux.
- Nó sẽ chỉ đồng bộ hóa hoặc sao chép các thay đổi từ nguồn đến dích thay vì sao chép toàn bộ dữ liệu, giúp giảm dữ liệu được gửi qua mạng.
2. Cách cài đặt 
- cài đặt rsync 
`yum install rsync -y `
- Cú pháp câu lệnh 
- rsync [option] [Thư mục nguồn] [Thư mục đích]
Option:
+ v: Hiện thị các tệp tin mới được cập nhật.
+ a: nhóm và người dùng.Chế độ lưu trữ, cho phép sao chép đệ quy và nó cũng giữ các liên kết tượng trưng, quyền tệp, quyền sở hữu 
+ r: Nói cho rsync biết để copy mọi thứ bao gồm thư mục con và files từ thưu mục gốc. Copy 2 chiều
+ b: tạo bản sao lưu
+ e: Chỉ định shell từ xa để sử dụng
+ z: Nén dữ liệu
+ h: Hiển thị các file và định dạng lên màn hình
3. sao chép đồng bộ hóa các tệp từ máy client sang máy server 
vd 
` rsync -av /home/localhost home root@192.168.202.137:/home    `
![Imgur](https://i.imgur.com/obZ0mCP.png)
![Imgur](https://i.imgur.com/rrwUCRu.png)
Vào thư mục trên máy server 
![Imgur](https://i.imgur.com/pIOgOuu.png)


4. Xóa các tệp khỏi nguồn sau khi đồng bộ hóa
`rsync --remove-source-files -zvh tên file  root@192.168.20.3:/root/sync`
