## Contents
- [1. Navigating directories](#1-navigating-directories)
    - [1.1. pwd](#11-pwd)
    - [1.2. cd](#12-cd)
    - [1.3. ls](#13-ls)
        - [1.3.1. tree](#131-tree)
    - [1.4. mkdir](#14-mkdir)
    - [1.5. rmdir](#15-rmdir)
    - [1.6. rm](#16-rm)
- [2. Thao tác với tệp](#2-thao-tác-với-tệp)
    - [2.1. cat và tac](#21-cat-và-tac)
    - [2.2. less và more](#22-less-và-more)
    - [2.3. grep](#23-grep)
    - [2.4. tr](#24-tr)
    - [2.5. alias](#25-alias)
    - [2.6. gzip và gunzip](#26-gzip-và-gunzip)
# Chapter II: Làm việc với file và thư mục
# 1. Navigating directories
## 1.1. pwd
`pwd` - *print working directory* dùng để in ra màn hình thư mục hiện tại đang hoạt động:
```bash
$ pwd
/home/ubuntu/Documents
```
## 1.2. cd
`cd` - *change directory* cho phép truy cập đến một thư mục khá
```bash
$ cd /path/to/directory
```
Bạn có thể truy cập đến thư mục thông qua đường dẫn tuyệt đối (bắt đầu bằng dấu `/`) hoặc đường dấn tương đối (liên quan đến thư mục hiện tại). Ví dụ:
- Di chuyển đến một thư mục trong thư mục hiện tại:
```bash
$ cd subdirectory
```
- Di chuyển đến thư mục mẹ:
```bash
$ cd ..
```
- Di chuyển đến thư mục chính:
```bash
$ cd
```
- Di chuyển đến thư mục trước đó:
```bash
$ cd -
```
## 1.3. ls
Lệnh `ls` dùng để liệt kê toàn bộ nội dung (bao gồm các thư mục và tệp tin) của thư mục hiện tại.
```bash
$ ls
file1.txt file2.txt directory1
```
`ls` cũng bao gồm một số tuỳ chọn khác nhau như:
- `-l`  *(long format)* hiển thị thông tin chi tiết về tệp và thư mục, bao gồm quyền, chủ sở hữu, nhóm, kích thước và dấu thời gian sửa đổi.
```bash
$ ls -l
-rw-r--r--  1 user  group  4096 Jun 27 10:00 file1.txt
drwxr-xr-x  2 user  group  4096 Jun 27 10:00 directory1
-rw-r--r--  1 user  group  2048 Jun 27 09:30 file2.txt
```
- `-a` *(all)* liệt kê tất cả các tệp, bao gồm các tệp ẩn bắt đầu bằng dấu chấm (.), thường không được hiển thị.
```bash
$ ls -a
.  ..  file1.txt  .hiddenfile  directory1
```
- `-h` *(human-readable)* hiển thị kích thước tệp ở định dạng human-readable, chẳng hạn như sử dụng "K" cho kilobyte, "M" cho megabyte và "G" cho gigabyte.
```bash
$ ls -lh
-rw-r--r--  1 user  group  4.0K Jun 27 10:00 file1.txt
drwxr-xr-x  2 user  group  4.0K Jun 27 10:00 directory1
-rw-r--r--  1 user  group  2.0K Jun 27 09:30 file2.txt
```
- `-t` *(time)* sắp xếp đầu ra theo thời gian sửa đổi, trước tiên hiển thị các tệp hoặc thư mục được sửa đổi gần đây nhất
```bash
$ ls -lt
drwxr-xr-x  2 user  group  4096 Jun 27 10:00 directory1
-rw-r--r--  1 user  group  4096 Jun 27 10:00 file1.txt
-rw-r--r--  1 user  group  2048 Jun 27 09:30 file2.txt
```
- `-R` *(recursive)* liệt kê các tệp và thư mục theo cách đệ quy, bao gồm cả các thư mục con.
```bash
$ ls -R
.:
file1.txt  directory1

./directory1:
file3.txt  subdirectory

./directory1/subdirectory:
file4.txt
```
### 1.3.1 tree
Trong Bash, bạn có thể sử dụng `tree` để hiển thị biểu diễn đồ họa của cấu trúc thư mục trên hệ thống của mình. Tuy nhiên, lệnh này không có sẵn theo mặc định trên tất cả các hệ thống, vì vậy bạn có thể cần phải cài đặt nó trước:
- Đối với Ubuntu
```bash
$ sudo apt-get install tree
```
- Đối với CentOS
```bash
$ sudo yum install tree
```
Sau khi cài đặt, bạn có thể hiển thị các thư mục và file của thư mục hiện tại:
```bash
$ tree
.
└── example
    ├── animals.txt
    └── dogs.txt.gz

1 directory, 2 files
```
tree cung cấp các tùy chọn khác nhau để tùy chỉnh đầu ra. Một số tùy chọn thường được sử dụng bao gồm:
- `-L` (level): Giới hạn độ sâu của cây ở mức quy định.
- `-a`: Hiển thị các tập tin và thư mục ẩn.
- `-d`: Chỉ hiển thị các thư mục, bỏ qua các tập tin.
- `-f`: In tiền tố đường dẫn đầy đủ cho mỗi tệp.
- `-I` (pattern): Loại trừ các tệp và thư mục khớp với mẫu.

## 1.4. mkdir
`mkdir` dùng để tạo một thư mục mới tại thư mục hiện tại
```bash
$ mkdir new_directory
```
## 1.5. rmdir
`rmdir` Lệnh xóa một thư mục trống.
```bash
$ rmdir empty_directory
```
Một số tuỳ chọn của `rmdir`:
- `-p` `--parent` Tuỳ chọn này giúp bạn xoá thư mục mẹ của thư mục đã xoá nếu thư mục đó trống
```bash
$ rmdir -p path/to/empty/directory
```
- `--ignore-fail-on-non-empty` Giúp bỏ qua các thư mục không phải là thư mục trống và tiếp tục xoá các thư mục trống
```bash
$ rmdir --ignore-fail-on-non-empty path/to/non-empty/directory
```
## 1.6. rm
`rm` dùng để xoá một tệp hoặc một thư mục
```bash
$ rm file.txt
```
Để xóa các thư mục chứa nội dung của chúng, bạn có thể sử dụng `rm` với tuỳ chọn `-r`
```bash
$ rm -r directory
```
# 2. Thao tác với tệp
## 2.1. cat và tac
- `cat` được sử dụng để nối và hiển thị nội dung của một hoặc nhiều tệp. Nó cũng thường được sử dụng để tạo các tệp mới hoặc nối thêm vào các tệp hiện có.
```bash
# Display content
$ cat file1.txt
This is the content of file1.

$ cat file1.txt file2.txt
This is the content of file1.
This is the content of file2.
# Append content
$ cat file3.txt >> file1.txt
Appending the content of file3 to file1.

$ cat >> file1.txt
Append the content to file
Press Ctrl + D to exit.
```
- `tac` Lệnh ngược lại với `cat`. Nó đọc một tệp hoặc đầu vào tiêu chuẩn và hiển thị các dòng theo thứ tự ngược lại.
```bash
$ tac file.txt
Line 3
Line 2
Line 1
```
## 2.2. less và more
- Lệnh `less` cho phép bạn xem nội dung của tệp theo cách được phân trang. Nó cung cấp nhiều tính năng nâng cao hơn so với `cat` , chẳng hạn như cuộn, tìm kiếm và điều hướng trong tệp.
    - Sử dụng các phím mũi tên hoặc `pgup` `pgdn` để cuộn
    - Gõ `/` để tìm kiếm và nhập từ cần tìm kiếm
    - Gõ `n` để chuyến đến kết quả tìm kiếm tiếp theo
    - Gõ `N` (Shift + N) để chuyển đến kết quả tìm kiếm trước đó
    - Gõ `q` để thoát ra
```bash
$ less large_file.txt
This
is 
a
large
file
END
```
- `more` tương tự như `less` và cho phép bạn xem nội dung của tệp theo từng trang. Tuy nhiên, nó có chức năng hạn chế hơn so với less.
    - Sử dụng `Enter` để xem trang tiếp theo
    - Gõ `Q` để thoát ra 
```bash
$ more large_file.txt
This
is 
a
large
file
--More--(83%)
```
## 2.3. grep
- `grep` được sử dụng để tìm kiếm các mẫu trong tệp hoặc đầu vào tiêu chuẩn. Nó có thể khớp văn bản cụ thể hoặc cụm từ thông dụng và hiển thị các dòng khớp.
```bash
$ grep "error" log.txt
Error occurred on line 5: ...

$ grep -i "apple" fruits.txt
Apple
apple
```
Một số tuỳ chọn của grep:
- `-i` *(ignore-case)* cho phép tìm kiếm không phân biệt chữ hoa chữ thường. Nó phù hợp với các mẫu bất kể trường hợp chữ cái.
```bash
$ grep -i "apple" fruits.txt
Apple
apple
aPpLe
```
- `-r` *(recursive)* cho phép tìm kiếm đệ quy trong các thư mục và thư mục con của chúng.
```bash
$ grep -r "error" logs/
logs/log1.txt:Error occurred on line 15: ...
logs/log2.txt:Error occurred on line 4: ...
logs/log3.txt:Error occurred on line 7: ...
```
- `-v` *(invert-match)* hiển thị các dòng không khớp với mẫu đã cho.
```bash
$ grep -v "apple" fruits.txt
Banana
Orange
```
- `-n` *(line-number)* hiển thị số dòng cùng với các dòng phù hợp.
```bash
$ grep -n "error" logs.txt
5:Error occurred on line 5: ...
10:Another error on line 10: ...
```
- `-w` *(word-regexp)* chỉ khớp với toàn bộ từ. Nó đảm bảo rằng mẫu không phải là một phần của từ lớn hơn.
```bash
$ grep -w "apple" fruits.txt
Apple
```
- `-l` *(files-with-matches)* chỉ hiển thị tên của các tệp chứa các dòng phù hợp, thay vì các dòng phù hợp.
```bash
$ grep -l "error" logs/*.txt
logs/log1.txt
logs/log2.txt
```
## 2.4. tr
- `tr` được sử dụng để dịch hoặc xóa ký tự. Nó thường được sử dụng để thay thế hoặc loại bỏ các ký tự cụ thể trong tệp hoặc đầu vào tiêu chuẩn.
```bash
$ echo "Hello, World!" | tr 'o' '0'
Hell0, W0rld!
```
Một số tuỳ chọn của tr:
- `-d`  xóa các ký tự được chỉ định trong tập hợp khỏi đầu vào.
```bash
$ echo "Hello, World!" | tr -d 'o'
Hell, Wrld!
```
- `-s` thay thế các ký tự lặp lại trong đầu vào bằng một lần xuất hiện duy nhất.
```bash
$ echo "Hellooo, Worlddd!" | tr -s 'o'
Hello, Worlddd!
```
- `-c` đảo ngược bộ ký tự được chỉ định. Nó thay thế các ký tự không có trong tập hợp bằng ký tự thay thế đã cho.
```bash
$ echo "Hello, World!" | tr -c 'a-zA-Z' '-'
Hello--World--
```
- `-t` cắt ngắn set1 thành độ dài của set2. Nó loại bỏ bất kỳ ký tự thừa nào khỏi set1 mà không có ký tự thay thế tương ứng trong set2.
```bash
$ echo "Hello, World!" | tr -t 'aeiou' '12345'
H2ll4, W4rld!
```
- In hoa, in thường: chuyển đổi các ký tự chữ thường trong đầu vào thành chữ hoa và ngược lại
```bash
$ echo "Hello, World!" | tr '[:lower:]' '[:upper:]'
HELLO, WORLD!

$ echo "Hello, World!" | tr '[:upper:]' '[:lower:]'
hello, world!

```
## 2.5. alias
Lệnh ``alias` cho phép bạn tạo lối tắt hoặc bí danh cho các lệnh hoặc tổ hợp lệnh được sử dụng thường xuyên.
```bash
$ alias ll='ls -al'

$ ll
```
## 2.6 gzip và gunzip
`gzip` là một tiện ích nén được sử dụng để nén các tệp. Nó thay thế tệp gốc bằng phiên bản nén có phần mở rộng là ".gz". `gunzip` được sử dụng để giải nén các tệp nén này.
```bash
$ gzip file.txt

$ gunzip file.txt.gz
```