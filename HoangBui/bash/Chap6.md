# Chapter VI: Tham số trong bash
# 1. Tham số trong Bash
## 1.1. Tham số vị trí
Đây là các đối số được truyền cho tập lệnh hoặc hàm khi nó được gọi. Chúng được truy cập bằng cách sử dụng các biến `$1`, `$2`, `$3`...Biến `$0` giữ tên của chính tập lệnh hoặc chức năng.
```bash
$ ./script.sh arg1 arg2
```
## 1.2. Tham số đặc biệt
Bash cung cấp các biến đặc biệt chứa thông tin hoặc hành vi bổ sung. Một số thông số đặc biệt thường được sử dụng bao gồm:
- `$#` giữ số lượng tham số vị trí.
- `$*` mở rộng đến tất cả các tham số vị trí dưới dạng một phần tử.
- `$@` mở rộng đến các tham số vị trí dưới dạng các mảng riêng biệt.
- `$?` giữ trạng thái thoát của lệnh được thực hiện cuối cùng.
- `$$` giữ ID tiến trình (PID) của tập lệnh hiện tại.
- `$!` giữ PID của lệnh nền cuối cùng.

## 1.3. Biến môi trường
Biến môi trường là các biến được xác định trước chứa thông tin về môi trường mà tập lệnh đang chạy. Chúng có thể truy cập bằng cú pháp `$variable_name`. Một số biến môi trường phổ biến bao gồm:
- `$HOME` giữ đường dẫn đến thư mục chính của người dùng hiện tại.
- `$PATH` giữ các đường dẫn tìm kiếm cho các lệnh thực thi.
- `$USER` giữ tên người dùng của người dùng hiện tại.
- `$PWD` giữ thư mục làm việc hiện tại.
- `$SHELL` giữ đường dẫn đến trình thông dịch shell mặc định của người dùng hiện tại.
## 1.4. Biến cục bộ
Biến cục bộ là các biến được xác định trong một hàm hoặc một tập lệnh. Chúng có phạm vi giới hạn và không thể truy cập được bên ngoài phạm vi đã xác định của chúng. Các biến cục bộ thường được tạo bằng cách sử dụng `local` bên trong một hàm.
```bash
function my_function() {
    local local_variable="Local Value"
    echo $local_variable
}
```
Trong ví dụ này, `local_variable` là một biến cục bộ chỉ có thể được truy cập trong hàm `my_function`.
# 2. Mở rông tham số trong Bash (Bash Parameter Expansion)
Mở rộng tham số cung cấp một cách thuận tiện để thực hiện các thao tác khác nhau trên các chuỗi hoặc giá trị được lưu trữ trong các biến. Dưới đây là một số hình thức mở rộng tham số bash phổ biến:
## 2.1. Mở rông biến
Để truy cập giá trị của một biến, bạn chỉ cần tham chiếu nó bằng ký hiệu `$`.
```bash
$ variable="Hello, World!"
$ echo $variable
Hello, World!
```
Bạn có thể gán tham số này bằng giá trị của tham số khác:
```bash
$ variable="Hello, World!"
$ param=variable
$ echo "${!param}"
Hello, World!
```
## 2.2. Thay thế giá trị tham số
Bạn có thể thay thế giá trị của biến bằng giá trị mặc định nếu biến đó không được đặt hoặc để trống bằng cú pháp `${parameter:-default}`.
```bash
$ variable=""
$ echo ${variable:-"Default Value"}
Default Value
```
## 2.3. Dộ dài tham số
Để lấy độ dài của giá trị của biến, bạn có thể sử dụng `${#variable}`.
```bash
$ variable="Hello"
$ echo ${#variable}
5
```
## 2.4. Trích xuất chuỗi con(Substring and subarray)
Bạn có thể trích xuất một chuỗi con từ một biến bằng các cú pháp:
- `${parameter:start}` Trích xuất từ vị trí `start` cho đến hết chuỗi.
- `${parameter:start:length}`. Trích xuất từ vị trí `start` một chuỗi con có độ dài `length`
- `${parameter:start:-length}`. Trích xuất từ vị trí `start`tới vị trí cuỗi, bỏ đi `length` phần tử
- `${parameter: -length}` (Cần có dấu cách ở giữa) Trích xuất `length` phần tử tính từ cuối chuỗi.
```bash
$ variable="Hello, World!"
$ echo ${variable:7:5}
World
``` 
## 2.5. Xoá chuỗi con
Bạn có thể xóa một chuỗi con khỏi một biến bằng cách sử dụng `${parameter#substring}`(xóa tiền tố khớp ngắn nhất) hoặc `${parameter##substring}`(xóa tiền tố khớp dài nhất).
```bash
$ variable="Hello, World!"
$ echo ${variable#Hello, }
World!
$ echo ${variable##*, }
World!
```
## 2.6. Thay thế chuỗi con
Bạn có thể thay thế một chuỗi con trong một biến bằng cách sử dụng `${parameter/pattern/replacement}`(thay thế lần xuất hiện đầu tiên) hoặc `${parameter//pattern/replacement}`(thay thế tất cả các lần xuất hiện).
```bash
$ variable="Hello, World!"
$ echo ${variable/World/Universe}
Hello, Universe!
$ echo ${variable//o/O}
HellO, WOrld!
```
## 2.7. Gán giá trị mặc định nếu là null hoặc unset
Để sử dụng giá trị mặc định nếu một biến không được đặt hoặc trống, bạn có thể sử dụng `${parameter:=default}`.
```bash
$ echo ${unset_variable:=Default Value}
Default Value
```
# 3. Viết bash script với các tham số
## 3.1. Truy cập ham số vị trí
Các tham số vị trí được truyền vào một bash script sẽ là được truyền theo thứ tự `$1` `$2` `$3` ... Các tham số bị thiếu sẽ nhận giá trị `null`. Vì thế, cần kiểm tra sự tồn tại của các tham số trên:
- Script không nhận tham số
```bash
if [ -z "$1" ]; then
    echo "Usage: No argument!"
    exit 1
fi
```
- Kiểm tra đủ số lượng tham số
```bash
if [ $# -lt 2 ]; then
    echo "Usage: ./script.sh [parameter1] [parameter2]"
    exit 1
fi
```
- Các tham số sau khi truyền vào có thể truy cập thông qua các tham số `$1` `$2` hoặc các [tham số đặc biệt](#12-tham-số-đặc-biệt), Nếu có nhiều tham số có thể sử dụng vòng lặp để truy cập các tham số:
```bash
for word in "$@"
do
    echo $word
done
```
Kết quả:
```bash
$ ./script.sh Hello , World !
Hello
,
World
!
```
- Ngoài ra, cũng có thể sử dụng lệnh `shift` để di chuyển tham số đầu tiên (`$1`) đến các tham số tiếp theo (`$2`) (Kết quả tương tự cách trên):
```bash
while [[ $# > 0 ]]
do
    echo "$1"
    shift
done
```
## 3.2. Cú pháp của các tham số tuỳ chọn
Các tham số tuỳ chọn có thể do người lập trình đặt và phải được xử lí khi các tham số đó được truyền vào.
### 3.2.1. Tuỳ chọn ngắn
Các tùy chọn ngắn thường được biểu thị bằng một chữ cái trước dấu gạch ngang (`-`). Chúng có thể được sử dụng riêng lẻ hoặc kết hợp với nhau khi không yêu cầu giá trị đối số.
```bash
$ ./script.sh -v -f file.txt
```
Trong ví dụ này, `-v` đại diện cho một tùy chọn hiển thị phiên bản và `-f` được theo sau bởi đối số `file.txt` để chỉ định tên tệp.
### 3.2.2. Tuỳ chọn dài
Tùy chọn dài được biểu thị bằng nhiều ký tự trước hai dấu gạch ngang (--). Chúng mang tính mô tả hơn và có thể dễ đọc và dễ hiểu hơn.
```bash
$ ./script.sh --help --file file.txt
```
Trong ví dụ này, --help dùng để hiển thị hướng dẫn và `--file` theo sau là đối số `file.txt` để chỉ định tên tệp.
### 3.2.3. Tuỳ chọn có đối số
Một số tùy chọn yêu cầu cung cấp đối số.
```bash
$ ./script.sh -f file.txt
```
### 3.2.4. Cờ Boolean 
Cờ Boolean là các tùy chọn không yêu cầu đối số. Chúng thường được sử dụng để bật hoặc tắt một tính năng hoặc hành vi cụ thể.
```bash
./script.sh -v
```
Trong ví dụ này, `-v` là cờ boolean dùng để hiển thị phiên bản.
## 3.3. Ví dụ
```bash
#!/bin/bash

# Function to display usage message
usage() {
    echo "Usage: ./script.sh [-v] [-h] [-f filename] [parameter1] [parameter2]"
}

# Function to display version
getver() {
    echo "Version: 1.1.1"
}

help() {
    getver
    usage
    echo "-v --version: display version"
    echo "-h --help: display help"
    echo "-f [filename]: display file"
    echo "parameter1 parameter2: it will be add"
}


# Default values for optional parameters
filename=""
version=false
help=false

#Get parameter
while [[ $# > 0 ]]
do
    case "$1" in
    -v|--version)
    version=true
    ;;
    -h|--help)
    help=true
    ;;
    -f|--file)
    filename="$2"
    shift
    ;;
    -*)
    usage
    exit 1
    ;;
    *)
    if [ $# -lt 2 ]; then
        usage
        exit 1
    fi
    param1=$1
    param2=$2
    shift
    ;;
    esac
    shift
done

# Check if the flags are set
if $help; then
    help
    exit 0
fi

if $version; then
    getver
    exit 0
fi

# Check file and display file

if [ -n "$filename" ]; then
    cat "$filename"
fi

# Perform some operations with the parameters
result=$((param1 + param2))
echo "Result: $result"
```

Tài liệu tham khảo:
- [Shell Parameter](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html)
- [Shell Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)
- [Shell Script](https://www.gnu.org/software/bash/manual/html_node/Shell-Scripts.html)
