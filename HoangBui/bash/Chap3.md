# Chapter III: Bash Script, tiến trình và Luồng
# 1. Quản lí job và tiến trình
## 1.1. Thực thi tiền cảnh
Theo mặc định, khi bạn thực thi một lệnh trong Bash, nó sẽ chạy ở tiền cảnh, nghĩa là lệnh chiếm thiết bị đầu cuối và bạn phải đợi nó hoàn thành trước khi thực hiện lệnh khác.
## 1.2. Thực thi trong nền
Bạn có thể thực thi lệnh trong nền bằng cách thêm dấu và (&) vào cuối lệnh. Điều này cho phép lệnh chạy độc lập, giải phóng thiết bị đầu cuối cho các lệnh tiếp theo.
```bash
$ command &
```
## 1.3. Quản lí các job chạy nền
- `jobs`: Lệnh hiển thị danh sách các công việc đang chạy trong phiên shell hiện tại.
- `fg`: Lệnh đưa một công việc nền lên nền trước, cho phép bạn tương tác với nó.
- `bg`: Lệnh tiếp tục công việc nền bị treo hoặc đã dừng ở chế độ nền.
## 1.4 Quản lí tiến trình
- `ps`: Lệnh hiển thị thông tin về các tiến trình đang chạy.
```bash
$ ps
    PID TTY          TIME CMD
   1222 pts/1    00:00:00 bash
   2290 pts/1    00:00:00 ps
```
- `kill`: dùng để gửi tín hiệu đến các tiến trình. Tín hiệu mặc định là `SIGTERM`, tín hiệu này sẽ kết thúc quá trình. Ví dụ, `kill <process_id>` hoặc `kill -<signal> <process_id>`.
# 2. Bash Script
Bash scripting cho phép bạn viết các script tự động hóa các tác vụ bằng cách kết hợp nhiều lệnh, cấu trúc điều khiển và biến.
Bash scripting có phần đuôi mở rộng là `.sh` và được thực thi bằng lệnh
```bash
$ ./my-scrpit.sh
```
## 2.1. Shebang
Các tập lệnh Bash thường bắt đầu bằng một dòng shebang ở đầu, dòng này chỉ định trình thông dịch sẽ được sử dụng. Đối với các tập lệnh Bash, dòng Shebang thường là `#!/bin/bash`.
## 2.2. Comment
Comment trong tập lệnh Bash bắt đầu bằng kí tự `#` và được sử dụng để cung cấp giải thích hoặc thêm ghi chú vào tập lệnh. Chúng bị bỏ qua bởi trình thông dịch.
## 2.3. Biến (Variable)
Các biến trong Bash được sử dụng để lưu trữ và thao tác dữ liệu. Chúng có thể chứa nhiều loại giá trị khác nhau, chẳng hạn như chuỗi, số hoặc mảng

Xem thêm tại [Chapter 4: Variable and Array](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap4.md)
## 2.4. Nhập và xuất
Bash cung cấp các cơ chế để đọc đầu vào từ người dùng hoặc từ tệp, cũng như ghi đầu ra vào thiết bị đầu cuối hoặc tệp. Lệnh `read` thường được sử dụng để đọc đầu vào và `echo` được sử dụng cho đầu ra.
```bash
echo "Enter your name:"
read name
echo "Hello, $name!"
```
## 2.5 Cấu trúc điều kiển và hàm
Bash hỗ trợ các cấu trúc điều khiển khác nhau, bao gồm câu lệnh if, vòng lặp for, vòng lặp while và câu lệnh case. Các cấu trúc này cho phép phân nhánh và lặp lại có điều kiện trong tập lệnh. Đồng thời, các tập lệnh Bash có thể định nghĩa các hàm, được đặt tên theo các khối mã có thể được gọi và thực thi nhiều lần trong tập lệnh. Các chức năng cho phép sử dụng lại mã và module hóa.

Xem thêm tại [Chapter 5: Control Struct and Function](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap5.md)
# 3. Luồng điều hướng
## 3.1. Toán tử điều hướng
- `>` (output redirection) huyển hướng đầu ra tiêu chuẩn của một lệnh tới một tệp và ghi đè lên tệp nếu nó đã tồn tại.
- `>>` (output redirection - append) chuyển hướng và nối thêm đầu ra tiêu chuẩn của một lệnh vào một tệp. Nếu tệp không tồn tại, nó sẽ được tạo
- `<` (input redirection) chuyển hướng nội dung của tệp làm đầu vào cho một lệnh
- `2>` và `2>>` được sử dụng để chuyển hướng đầu ra lỗi tiêu chuẩn (stderr) của một lệnh sang một tệp hoặc một luồng
## 3.2. Đầu vào tiêu chuẩn (stdin)
Theo mặc định, một lệnh đọc đầu vào từ bàn phím (stdin). Tuy nhiên, bạn có thể chuyển hướng đầu vào từ một tệp bằng toán tử `<`.
```bash
$ command < input.txt

#example 
$ cat < text.txt
```
## 3.3. Đầu ra tiêu chuẩn (stdout)
Theo mặc định, một lệnh sẽ gửi đầu ra tới thiết bị đầu cuối (thiết bị xuất chuẩn). Bạn có thể chuyển hướng đầu ra tới một tệp bằng `>` toán tử ghi đè lên tệp hoặc `>>` toán tử nối đầu ra vào tệp.
```bash
$ command > output.txt
$ command >> output.txt
```
## 3.4. Lỗi tiêu chuẩn(stderr)
Thông báo lỗi và thông tin chẩn đoán thường được gửi đến lỗi tiêu chuẩn (stderr). Bạn có thể chuyển hướng thiết bị xuất chuẩn riêng bằng cách sử dụng `2>` hoặc kết hợp chuyển hướng thiết bị xuất chuẩn và thiết bị xuất chuẩn bằng cách sử dụng `2>&1`
```bash
$ command 2> error.txt
$ command > output_and_error.txt 2>&1
```
## 3.5. Pipes
Pipes cho phép bạn chuyển hướng đầu ra của một lệnh sang một lệnh khác làm đầu vào, tạo ra một đường dẫn.
```bash
$ command1 | command2
```
Đầu ra của `command1` trở thành đầu vào cho `command2`.