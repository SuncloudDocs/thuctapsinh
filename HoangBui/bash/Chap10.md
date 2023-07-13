# Chapter 10: Tham số trong bash (tiếp)
# 1. Mở rông bằng kí hiệu {}
- Tạo danh sách giá trị
```bash
$ echo {apple,banana,cherry}
apple banana cherry
```
bạn có thể dùng lệnh này để đổi phần mở rộng của tên tệp, ví dụ:(nó tương đương với `mv file.txt file.zip`)
```bash
$ mv file.{txt,zip}
```
- Tạo chuỗi số (hoặc chuỗi kí tự)
```bash
$ echo {1..5}
1 2 3 4 5
$ echo {0..10..2}
0 2 4 6 8 10
```
- Kết hợp mẫu giá trị và chuỗi số
```bash
$ echo file{1..3}.txt
file1.txt file2.txt file3.txt
```
- Mở rộng lồng nhau
```bash
$ echo {red,blue}{1..3}
red1 red2 red3 blue1 blue2 blue3
```
- Tạo thư mục với các thư mục con 
```bash
$ mkdir -p {parent/{child1,child2,child3},another_parent/{sub1,sub2}}
$ tree
.
├── another_parent
│   ├── sub1
│   └── sub2
└── parent
    ├── child1
    ├── child2
    └── child3
```
# 2. Getops
Lệnh `getopts` trong Bash được sử dụng để phân tích cú pháp các tùy chọn và đối số dòng lệnh. Nó cho phép bạn xử lý và xử lý các tùy chọn và đối số dòng lệnh được truyền cho tập lệnh hoặc hàm shell.
Cú pháp:
```bash
while getopts options_string variable
do
    case $variable in
        option1)
            # Code to handle option1
            ;;
        option2)
            # Code to handle option2
            ;;
        ...
    esac
done
```
- Lệnh `getopts` thường được sử dụng trong một vòng lặp `while` để lặp qua các tùy chọn và đối số dòng lệnh.

- `options_string` chỉ định các tùy chọn hợp lệ mà tập lệnh hoặc chức năng của bạn có thể chấp nhận. Mỗi tùy chọn là một ký tự đơn và có thể được theo sau bởi dấu hai chấm (`:`) nếu nó yêu cầu một đối số.
- `variable` là tên của biến chứa tùy chọn hiện đang được xử lý.
- Bên trong vòng lặp `while`, một câu lệnh `case` được sử dụng để xử lý từng tùy chọn dựa trên giá trị của nó được lưu trữ trong biến `variable`.
- Câu lệnh `case` kiểm tra giá trị của `variable` đối với các tùy chọn đã xác định bằng cách sử dụng `option1`, `option2`, v.v. Bạn có thể thêm nhiều trường hợp hơn để xử lý các tùy chọn bổ sung.
- Trong mỗi case, bạn viết mã để xử lý tùy chọn tương ứng. Điều này có thể bao gồm thực hiện các hành động cụ thể, đặt biến hoặc gọi hàm dựa trên tùy chọn. Nếu tuỳ chọn của bạn có đối số, bạn có thể lấy đối số truyền vào thông qua biến `OPTAGR`
Ví dụ:
```bash
#!/bin/bash
while getopts "a:b:c:" option
do
    case $option in
        a)
            echo "Option -a is specified with argument: $OPTARG"
            ;;
        b)
            echo "Option -b is specified with argument: $OPTARG"
            ;;
        c)
            echo "Option -c is specified with argument: $OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
    esac
done
```
Kết quả
```bash
$ ./script.sh -a argumentA -b argumentB -c argumentC
Option -a is specified with argument: argumentA
Option -b is specified with argument: argumentB
Option -c is specified with argument: argumentC
```
# 3. Các biến nội bộ trong bash
- `$HOME` Đại diện cho thư mục chính của người dùng.
- `$PWD` Chứa thư mục làm việc hiện tại.
- `$USER`  Lưu trữ tên người dùng của người dùng hiện đang đăng nhập.
- `$PATH` Chứa danh sách các thư mục nơi shell tìm kiếm các tệp thực thi (Thường sẽ bao gồm `/usr/local/bin` và `/usr/bin`)
```bash
$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```
- `$HOSTNAME` Giữ tên máy chủ của hệ thống.
- `$PS1` Xác định chuỗi dấu nhắc chính xuất hiện trong shell.
- `$PS2` Chỉ định chuỗi nhắc phụ, được hiển thị khi đầu vào được tiếp tục ở dòng tiếp theo.
- `$FUNCNAME` Chứa tên của hàm hiện tại
```bash
#!/bin/bash 
function_1() {
    echo "This is $FUNCNAME"
}

function_2() {
    echo "This is $FUNCNAME"
}

function_1
function_2
```
Kết quả:
```bash
This is function_1
This is function_2
```
- `$?` Giữ trạng thái thoát của lệnh được thực thi cuối cùng. Ví dụ:
```bash
#!/bin/bash 
ls non_existent_file.txt
exit_status=$?
if [ $exit_status -eq 0 ]; then
    echo "Command executed successfully"
else
    echo "Command failed with exit status: $exit_status"
fi
```
Tệp tin `non_existent_file.txt` không tồn tại, vì thế nên trạng thái thoát của tập lệnh trên sẽ khác `0`
```bash
ls: cannot access 'non_existent_file.txt': No such file or directory
Command failed with exit status: 2
```
- `$0` Đại diện cho tên của tập lệnh đang được thực thi.
- `$1..2..3` Các biến này giữ các tham số vị trí được truyền cho tập lệnh hoặc hàm. `$1` đại diện cho đối số đầu tiên, `$2` đại diện cho đối số thứ hai, v.v.
- `$@`Đại diện cho tất cả các tham số vị trí được chuyển đến tập lệnh dưới dạng một mảng.
- `$#` Cho biết số lượng tham số vị trí được truyền cho tập lệnh.
- `$IFS` Viết tắt của Internal Field Separator và xác định cách Bash tách các từ thành các trường. Theo mặc định, nó được đặt thành các ký tự khoảng trắng. (Xem thêm tại [Đọc tệp theo từng dòng hoặc trường](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap7.md#5-đọc-tệp-theo-từ-dònghoặc-trường))
- `$RANDOM` Lưu trữ một giá trị số nguyên ngẫu nhiên trong khoảng từ 0 đến 32767.
```bash
$ echo $RANDOM
19518
$ echo $RANDOM
1475
$ echo $RANDOM
20515
```