# Chapter 11: Gỡ lỗi
# 1. Kiểm tra lỗi cú pháp
Tuỳ chọn `-n` cho phép kiểm tra lỗi cú pháp mà không cần thực thi lệnh:
```bash
 $ bash -n testscript.sh
testscript.sh: line 128: unexpected EOF while looking for matching `"'
testscript.sh: line 130: syntax error: unexpected end of file
```
# 2. Debugging mode
chế độ gỡ lỗi sẽ hiển thị từng lệnh đang được thực thi cùng với đầu ra của chúng và các thông tin liên quan khác.
```bash
#!/bin/bash
echo "Welcome to the script!"
```
Sử dụng debugging mode:
```bash
$ bash -x exdebug.sh
+ echo 'Welcome to the script!'
Welcome to the script!
```
# 3. Sử dụng lệnh set
Thêm `set -x` và `set +x` trong tập lệnh có thể bật hoặc tắt có chọn lọc chế độ gỡ lỗi trong tập lệnh.
```bash
#!/bin/bash
set -x # Enable debugging
# some code here
set +x # Disable debugging output.
```
Ví dụ:
```bash
#!/bin/bash

# Define variables
name="Hoang"
age=21

echo "Welcome to the script!"

set -x # Enable debugging mode

# Print variable values
echo "Name: $name"
echo "Age: $age"

# Perform some calculations
result=$((age * 2))
echo "Result: $result"

# Simulate an error
echo "Trying to access an undefined file"
ls undefined_file.txt

set +x  # Disable debugging mode

echo "Script execution complete."
```
Kết quả
```bash
$ ./exdebug1.sh
Welcome to the script!
+ echo 'Name: Hoang'
Name: Hoang
+ echo 'Age: 21'
Age: 21
+ result=42
+ echo 'Result: 42'
Result: 42
+ echo 'Trying to access an undefined file'
Trying to access an undefined file
+ ls undefined_file.txt
ls: cannot access 'undefined_file.txt': No such file or directory
+ set +x
Script execution complete.
```
# 4. Sử dụng lệnh trap
Lệnh `trap` cho phép bạn thiết lập trình xử lý để bắt lỗi và thực hiện các hành động cụ thể. Ví dụ: bạn có thể sử dụng `trap 'echo "An error occurred"; exit 1' ERR` để hiển thị thông báo lỗi và thoát khỏi tập lệnh bất cứ khi nào xảy ra lỗi.

Ví dụ:
```bash
#!/bin/bash

# Define the error handler function
handle_error() {
  echo "An error occurred in the script."
  exit 1
}

# Set the error handler function to be triggered on error
trap handle_error ERR

# Perform some operations
echo "Welcome to the script!"

# Simulate an error
echo "Trying to access an undefined file"
ls undefined_file.txt

echo "This line will not be reached due to the error."

echo "Script execution complete."
```
Kết quả:
```bash
$ ./exdebug2.sh
Welcome to the script!
Trying to access an undefined file
ls: cannot access 'undefined_file.txt': No such file or directory
An error occurred in the script.
```
# 5. Kiểm tra mã trả về
Sau khi thực hiện một lệnh hoặc chức năng, bạn có thể kiểm tra mã trả về ( `$?`) để xác định xem nó thành công hay gặp lỗi.
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
Kết quả
```bash
$ ./exdebug3.sh
ls: cannot access 'non_existent_file.txt': No such file or directory
Command failed with exit status: 2
```
# 6. Ghi log
Chuyển hướng đầu ra của tập lệnh của bạn sang tệp nhật ký bằng toán tử `>` hoặc `>>` hoặc `2>`. Bằng cách này, bạn có thể xem lại tệp nhật ký để kiểm tra quá trình thực thi của tập lệnh và xác định bất kỳ vấn đề nào.(Xem thêm tại: [Đầu ra tiêu chuẩn](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap3.md#33-đầu-ra-tiêu-chuẩn-stdout), [Lỗi tiêu chuẩn](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap3.md#34-lỗi-tiêu-chuẩnstderr))
