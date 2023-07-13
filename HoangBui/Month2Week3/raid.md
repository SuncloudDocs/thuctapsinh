# RAID Technology
# 1. Giới thiệu RAID
## 1.1. RAID là gi?
RAID là viết tắt của Redundant Array of Independent Disks. Đây là một công nghệ lưu trữ dữ liệu kết hợp nhiều ổ đĩa vật lý thành một đơn vị logic duy nhất. Mục đích của RAID là cải thiện độ tin cậy của dữ liệu, hiệu suất hoặc cả hai, tùy thuộc vào cấp độ RAID được sử dụng.
## 1.2. RAID hoạt động như thế nào?
RAID hoạt động bằng cách đặt dữ liệu trên nhiều đĩa và cho phép các I/O operation chồng lên nhau một cách cân bằng, giúp cải thiện hiệu suất. Vì việc sử dụng nhiều đĩa làm tăng thời gian trung bình giữa các lần thất thoát nên việc lưu trữ dữ liệu dư thừa cũng làm tăng khả năng chịu lỗi.

Các RAID array xuất hiện với hệ điều hành (OS) dưới dạng một ổ đĩa logic duy nhất.

RAID sử dụng các kỹ thuật **sao chép đĩa** (disk mirroring) hoặc **phân chia đĩa** (disk striping). Sao chiếu sẽ sao chép dữ liệu giống hệt nhau vào nhiều ổ đĩa. Phân chia giúp trải rộng dữ liệu trên nhiều ổ đĩa. Không gian lưu trữ của mỗi ổ đĩa được chia thành các đơn vị khác nhau, từ một khối 512 byte cho đến vài megabyte. Các khối của tất cả các đĩa được xen kẽ và xử lý theo thứ tự. Sao chép đĩa và phân chia đĩa cũng có thể được kết hợp trong một RAID array.
# 2. Các loại RAID
RAID được phân chia theo các mức RAID có ba loại RAID là RAID tiêu chuẩn, RAID lồng nhau và RAID không chuẩn
- RAID tiêu chuẩn bao gồm: RAID 0, RAID 1, RAID 2, RAID 3, RAID 4, RAID 5, RAID 6
- RAID lồng nhau bao gồm: RAID 10, RAID 01, RAID 03, RAID 50, RAID 60
- RAID không tiêu chuẩn bao gồm RAID 7
# 3. RAID 0
Dữ liệu được phân phối trên nhiều ổ đĩa, cải thiện hiệu suất bằng cách cho phép các thao tác đọc/ghi song song. Tuy nhiên, không có dự phòng, vì vậy nếu một ổ đĩa bị lỗi, tất cả dữ liệu có thể bị mất.

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_00.png)
# 4. RAID 1
RAID 1 (Mirroring): Dữ liệu được sao chép trên hai ổ đĩa, tạo ra một bản sao chính xác của nhau. Điều này cung cấp khả năng dự phòng, vì vậy nếu một ổ đĩa bị lỗi, ổ đĩa kia vẫn có thể tiếp tục hoạt động. Hiệu suất đọc có thể được cải thiện, nhưng hiệu suất ghi thường giống như một ổ đĩa đơn.

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_01.png)
# 5. RAID 2, RAID 3, RAID 4
Dữ liệu phân chia trên các đĩa, với một (hoặc) số đĩa lưu trữ thông tin kiểm tra và sửa lỗi (ECC - error checking and correcting).

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_02.png)
![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_03.png)
![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_04.png)

# 6. RAID 5
Dữ liệu được phân phối trên nhiều ổ đĩa và thông tin chẵn lẻ (parity blocks) cũng được phân phối trên các ổ đĩa. Parity cho phép khôi phục dữ liệu nếu một ổ đĩa bị lỗi. RAID 5 yêu cầu tối thiểu ba ổ đĩa và cung cấp sự cân bằng tốt giữa hiệu suất và khả năng dự phòng.

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_05.png)
# 7. RAID 6
Tương tự như RAID 5, nhưng có hai bộ thông tin chẵn lẻ. RAID 6 có thể chịu được sự cố của hai ổ đĩa đồng thời và cung cấp khả năng bảo vệ dữ liệu tốt hơn so với RAID 5. Nó yêu cầu tối thiểu bốn ổ đĩa.

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_06.png)
# 8. RAID 10
Kết hợp các lợi ích của RAID 1 và RAID 0. Dữ liệu được phân bổ theo dải trên nhiều cặp ổ đĩa được phản chiếu, mang lại hiệu suất dự phòng và cải thiện. RAID 10 yêu cầu tối thiểu bốn ổ đĩa.

![noimg](https://github.com/hoangbuii/helloCloud/blob/main/Month2Week3/raid/storage_raid_10.png)
# 9. RAID 50 và RAID 60
Kết hợp của RAID 5 hoặc RAID 6 với RAID 0 tương ứng. Chúng cung cấp hiệu suất nâng cao và khả năng dự phòng bằng cách phân chia dữ liệu trên nhiều mảng RAID 5 hoặc RAID 6.
# 8. RAID 7
Cấp độ RAID không chuẩn dựa trên RAID 3 và RAID 4 có thêm bộ nhớ đệm. Nó bao gồm một hệ điều hành nhúng thời gian thực dưới dạng bộ điều khiển, bộ nhớ đệm thông qua bus tốc độ caovà các đặc điểm khác của một máy tính độc lập