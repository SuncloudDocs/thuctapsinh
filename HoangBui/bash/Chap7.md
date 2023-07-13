# Chapter 7: Làm việc với file và thư mục (tiếp)
# 1. Copy, Find, Sort
## 1.1. Copy
- Copy một file đến một vị trí cụ thể
```bash
$ cp file.txt /path/to/destination/
```
- Copy một file và tất cả thông tin của file đó (quyền, thời gian,...)
```bash
$ cp -p file.txt /path/to/destination/
```
- Copy một thư mục
```bash
$ cp -r directory/ /path/to/destination/
```
## 1.2. Find
- Tìm kiếm một file cụ thể
```bash
$ find /path/to/search -name "file.txt"
```
- Tìm kiểm một file theo phần mở rộng
```bash
# For one type
$ find /path/to/search -name "*.txt"

# For more type
$ find /path/to/search -name "*.txt" -o -name "*.sh"
```
- Các tuỳ chọn tìm kiếm nâng cao
    - Thực thi lệnh với các tệp được tìm thấy sử dụng lệnh `xargs`
    ```bash
    $ find . -name "*.sh" | xargs cat
    ```
    - Tìm kiếm theo thời gian sửa đổi
    Sử dụng lệnh tuỳ chọn `-nmin` (thời gian tính theo phút) và `-ntime` (thời gian tính theo ngày) để tìm kiếm các thư mục và file theo thời gian.
    ```bash
    # Files modified within the last 7 days
    $ find /path/to/search -mtime -7
    
    # Files are not modified within the last 7 days
    $ find /path/to/search -mtime +7
    ``` 
    - Tìm kiếm theo kich thước
    ```bash
    # Size less than 50kb
    $ find /path/to/search -size -50

    # Size greater than 15kb
    $ find /path/to/search -size +15
    ```
    - Tìm kiếm theo đường dẫn
    ```bash
    $ find . -path "*/sh/*"
    ./sh/output.txt
    ./sh/sc.sh
    ./sh/sc3.sh
    ./sh/new_sh.sh
    ./sh/sc1.sh
    ./sh/input.txt
    ```
    - Tìm kiếm theo loại: sử dụng tuỳ chọn `-type` với các giá trị
        - Regular file: `-type f`
        - Directory: `-type d`
        - Symbolic link: `-type l`
        - Character device: `-type c`
        - Block device: `-type b`
        - Socket: `-type s`
        - Named pipe (FIFO): `-type p`
    ```bash
    $ find . -type f
    ./example/animals.txt
    ./example/dogs.txt.gz
    ./test/script.sh
    ./test/file.txt
    ./test/dogs.txt
    ./test/file1.txt
    ./sh/output.txt
    ./sh/sc.sh
    ./sh/sc3.sh
    ./sh/new_sh.sh
    ./sh/sc1.sh
    ./sh/input.txt
    ```
## 1.3. Sort
Có thể cung cấp đầu vào cho lệnh `sort` là đầu ra của một lệnh khác sử dụng toán tử `|` ví dụ:
```bash
$ echo -e "c\nb\na" | sort
a
b
c
```
Hoặc có thể sắp xếp một tệp:
```bash
sort myfile.txt
ab
abs
cd
```
`sort` có một số tuỳ chọn như:
- `-r` hoặc `--reverse`: Sắp xếp các dòng theo thứ tự ngược lại (giảm dần).
- `-n` hoặc `--numeric-sort`: Sắp xếp các dòng theo số thay vì theo bảng chữ cái.
- `-f` hoặc `--ignore-case`: Bỏ qua phân biệt chữ hoa chữ thường khi sắp xếp.
- `-u` hoặc `--unique`: Loại bỏ các dòng trùng lặp, chỉ hiển thị các dòng duy nhất.
- `-k <start>,<end>` hoặc `--key=<start>,<end>`: Chỉ định một phạm vi khóa để sắp xếp dựa trên các trường cụ thể trong mỗi dòng.   
Có thể chỉ định đầu ra của `sort` bằng một file
```bash
sort myfile.txt > sorted.txt
```  
Lệnh trên sẽ xắp xếp `myfile.txt` và lưu kết quả vào `sorted.txt`
# 2. Sourcing
- Khi Sourcing một file bash script, tất cả các biến, alias, hàm sẽ của script đó sẽ tồn tại trong suốt phiên của shell. Sử dụng lênh `source` hoặc `.`
```bash
$ source script.sh

$ . script.sh
```
- Sử dụng `source` để kích hoạt một môi trường ảo
Môi trường ảo đề cập đến một môi trường biệt lập, nơi bạn có thể cài đặt và quản lý các phiên bản gói phần mềm cụ thể mà không ảnh hưởng đến quá trình cài đặt trên toàn hệ thống.
Công cụ phổ biến nhất để quản lý môi trường ảo trong Bash được gọi là **virtualenv**.  Để sử dụng **virtualenv**, bạn cần cài đặt Python trên hệ thống của mình.
```bash
# Install virtualenv
$ pip install virtualenv

# Navigate to the directory where create virtual environment
$ cd ~/myenv

# Create virtual environment with specify Python version
$ virtualenv venv -p python3

# Active virtual environment
$ source venv/bin/activate

# Install pakage using pip
$ pip install package_name

# Return to system-wide Python environment
$ deactivate
```
# 3. Thay thế lịch sử bash
- Lịch sử trong bash
```bash
# Display history
$ history

# Clear history
$ history -c
```
- Thực thi sự kiện
    - Thực thi lệnh gần nhất `!!`
    - Thực thi lệnh tại dòng n `!n`
    - Thực lệnh các lệnh hiện tại n dòng `!-n`
- Chỉ định từ: Chỉ định các từ trong một lệnh sẽ đi kèm với lệnh đó phía trước dấu `:` 
    - Chỉ định đối số thứ n của lệnh gần nhất `:n`
    - Chỉ định đối số thứ n tính từ cuối của lệnh gần nhất `:n$` 
    - Chỉ định các đối số từ m đến n của lệnh gần nhất `:m-n`
    - Chỉ định tất cả đối số `:*`
    - Chỉ định đối số cuối cùng `:$`
    - Chỉ định đối số đầu tiên của lệnh `:^`
# 4. Tuỳ chỉnh PS1
Sử dụng biến môi trường `PS1` để tuỳ chỉnh dấu nhắc lệnh PS1 Ví dụ:
```bash
PS1="\u@\h:\w\$ "
```
Trong đó:
- `\u`: Đại diện cho tên người dùng hiện tại.
- `\h`: Đại diện cho tên máy chủ của máy.
- `\w`: Đại diện cho thư mục làm việc hiện tại.
- `\$`: Hiển thị biểu tượng `$` cho người dùng thông thường và biểu tượng `#` cho người dùng root.
- Ngoài ra, có thể thêm một số thông tin bổ sung khác ví dụ: `\d` để hiển thị ngày và `t` để hiển thị thời gian.
Sau khi đặt giá trị mong muốn cho `PS1`, có thể xuất biến ra tệp cấu hình của mình hoặc đặt trực tiếp trong phiên hiện tại
```bash
ubuntu@ip-172-31-7-151:~$ echo 'export PS1="[\t]\u@\h:\w\$ "' >> ~/.bashrc
ubuntu@ip-172-31-7-151:~$ source ~/.bashrc
[04:09:08]ubuntu@ip-172-31-7-151:~$
```
# 5. Đọc tệp theo từ dòng(hoặc trường)
Ví dụ về tệp có các dòng và các trường như sau:
```mathematica
John Doe,25,Male
Jane Smith,32,Female
Alex Johnson,42,Male
Emily Brown,28,Female
```
Ta cần in ra màn hình tên tuổi và giới tính theo từng dòng trong tệp:
```bash
#!/bin/bash

file_path="data.txt"

while IFS= read -r line; do
    # Extract name and age (assuming fields are separated by comma)
    IFS=',' read -ra fields <<< "$line"
    name="${fields[0]}"
    age="${fields[1]}"
    gender="${fields[2]}"

    echo "Name: $name"
    echo "Age: $age"
    echo "Gender: $gender"
    echo "---"

done < "$file_path"
```
Sau khi thực thi lệnh sẽ được kết quả:
```bash
$ ./script.sh
Name: John Doe
Age: 25
Gender: Male
---
Name: Jane Smith
Age: 32
Gender: Female
---
Name: Alex Johnson
Age: 42
Gender: Male
---
Name: Emily Brown
Age: 28
Gender: Female
---
```