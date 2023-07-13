# Chapter 12: Thực thi lệnh trong bash
# 1. Trình thực thi tệp
## 1.1. Tệp .profile
`~/.bash_profile` là một tập lệnh được thực thi khi bạn khởi động shell. Nó cho phép bạn tùy chỉnh môi trường Bash của mình bằng cách đặt các [biến môi trường](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap10.md#3-các-biến-nội-bộ-trong-bash), xác định bí danh và chạy các tập lệnh hoặc lệnh khác.
```bash
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
```
## 1.2. .profile và .bash_profile(và .bash_login)
Trong Bash, các tệp `.bash_profile` và `.bash_login` phục vụ các mục đích tương tự và được sử dụng để khởi tạo login shell. Tuy nhiên, chúng thường không được sử dụng cùng nhau.
- Nếu `.bash_profile` tồn tại, nó được thực thi.
- Nếu `.bash_profile` không tồn tại, nhưng `.bash_login`tồn tại, nó được thực thi.
- Nếu `.bash_profile` hoặc `.bash_login` không tồn tại, nhưng `.profile` tồn tại, nó được thực thi.
# 2. Tách tệp
## 2.1. Sử dụng split
Lệnh `split` dùng để chia một tệp ra thành nhiều tệp nhỏ hơn dựa trên các tiêu chí được chỉ định
- Chạy lệnh `split` mà không có tuỳ chọn nào sẽ chia tệp thành một hoặc nhiều tệp với mỗi tệp là 1000 dòng.
```bash
$ split file
```
- chạy lệnh với các tuỳ chọn `-l` (lines) hoặc `-b`(bytes) sẽ chia file thành các file nhỏ hơn có kích thước tương ứng
```bash
$ split -l 100 file
```
- Có thể sửa đối tiền tố của các file được chia ra bằng cách thêm chúng ngay sau tên file cần chia
```bash
split [options] input_file [prefix]
```
Ví dụ:
```bash
$ split -l 5 file1.txt prefix 
$ ls
file1.txt  prefixab  prefixad  prefixaf  prefixah  prefixaj  prefixal  prefixan  prefixap prefixaa   prefixac  prefixae  prefixag  prefixai  prefixak  prefixam  prefixao
```
lệnh trên đã chia file `file1.txt` thành nhiều file nhỏ, mỗi file có 5 dòng, các file đầu ra có tên là `prefixab`, `prefixad`, `prefixaf`,...etc.
## 2.2. Sử dụng head và tail
có thể sử dụng lệnh `head` và `tail` kết hợp với chuyển hướng để phân chia tệp dựa trên số lượng dòng.

Ví dụ:
```bash
# Split file into first 100 lines
head -n 100 input.txt > output1.txt

# Split file into remaining lines
tail -n +101 input.txt > output2.txt
```
Lệnh `head` trích xuất 100 dòng đầu tiên từ `input.txt` và chuyển hướng đầu ra sang `output1.txt`. Lệnh `tail` trích xuất các dòng còn lại bắt đầu từ dòng 101 và chuyển hướng đầu ra sang `output2.txt`.
## 2.3. Sử dụng csplit
Lệnh `csplit` là một tùy chọn khác để chia nhỏ tệp dựa trên các mẫu hoặc số dòng. Nó cho phép bạn chia các tệp thành các phần riêng biệt dựa trên các mẫu được chỉ định.
```bash
csplit [options] input_file pattern
```

Ví dụ:
- Với một file như sau:
```bash
Line 1
Line 2
Line 3
Pattern
Line 4
Line 5
Pattern
Line 6
Patternabc
```
- Sử dụng lệnh `csplit` để chia file trên thành các file dựa trên mẫu `Pattern`:
```bash
$ csplit file.txt '/^Pattern$/' '{*}'
21
22
26
$ ls
file.txt  xx00  xx01  xx02
$ cat xx00
Line 1
Line 2
Line 3
$ cat xx01
Pattern
Line 4
Line 5
$ cat xx02
Pattern
Line 6
Patternabc

```
# 3. Tách từ
Theo mặc định, trình bao phân tách một chuỗi thành các từ dựa trên một tập hợp các ký tự được gọi là Dấu tách trường bên trong (IFS - Internal Field Separator). Biến IFS xác định ký tự nào được coi là dấu tách từ.
- Tách từ theo mặc định: Theo mặc định, biến IFS được đặt để chứa các ký tự khoảng trắng: dấu cách, tab và dòng mới.
```bash
string="Hello, world! Welcome to Bash"
for word in $string; do
    echo "$word"
done
```
Kết quả:
```bash
$ ./sc.sh
Hello,
world!
Welcome
to
Bash
```
- Để ngăn chặn việc tách từ, ta chỉ cần đặt biến chứa chuỗi trong dấu `" "`:
```bash
string="Hello, world! Welcome to Bash"
for word in "$string"; do
    echo "$word"
done
```
Kết quả:
```bash
$ ./sc.sh
Hello, world! Welcome to Bash
```
- Tuỳ chỉnh IFS:
```bash
IFS=','
string="Apple,Orange,Banana"
for word in $string; do
    echo "$word"
done
```
Kết quả:
```bash
$ ./sc.sh
Apple
Orange
Banana
```
Có thể dùng IFS để đọc một chuỗi và lấy giá trị vào mảng mà không ảnh hưởng đến bên ngoài:
```bash
string="Apple,Orange,Banana"
IFS=',' read -ra words <<< "$string"
for word in "${words[@]}"; do
    echo "$word"
done
for word in $string; do
    echo "$word"
done
```
Kết quả:
```bash
$ ./sc.sh
Apple
Orange
Banana
Apple,Orange,Banana
```
# 3. Chuỗi lệnh
- Chuỗi lệnh trình tự: Các lệnh phân tách nhau bởi dấu chấm phảy `;` sẽ được thực hiện theo tuần tự:
```bash
$ command1 ; command2 ; command3
```
Ví dụ:
```bash
$ echo "Hello" ; ls ; date
Hello
sc.sh
Thứ tư, 12 Tháng 7 năm 2023 09:05:30 +07
```
- Chuỗi lệnh Pipe: Cho phép đầu ra của một lệnh làm đầu vào cho một lệnh khác:
```bash
$ command1 | command2 | command3
```
Ví dụ:
```bash
$ ls -l | grep ".sh" | wc -l
5
```
Trong ví dụ này, lệnh `ls -l` liệt kê các tệp ở định dạng dài, sau đó được chuyển đến `grep` để lọc ra các tệp chứa `".txt"`. Cuối cùng, đầu ra được đưa vào `wc -l` để đếm số dòng.
- Thay thế lệnh: Cho phép bạn nắm bắt đầu ra của một lệnh và sử dụng nó như một phần của lệnh khác hoặc gán nó cho một biến. Thay thế lệnh có cú pháp: `$(command)
`
Ví dụ:
```bash
$ echo "Today is $(date)"
Today is Thứ tư, 12 Tháng 7 năm 2023 09:10:38 +07
```
- Lệnh có điều kiện: `&&` cho phép lệnh thứ hai thực hiện nếu lệnh thứ nhất thành công(trả về exit code 0) và `||` cho phép lệnh thực hiện nếu lệnh thứ nhất không thành công. Ví dụ:
```bash
$ [ -f file.txt ] && echo "File exists" || echo "File does not exist"
```
Ví dụ trên kiểm tra tính tồn tại của file, nếu file tồn tại(Biểu thức `[ -f file.txt ]` đúng) sẽ thực hiện lệnh `echo "File exists"` ngược lại sẽ thực hiện lệnh `echo "File does not exist"`
# 4. Thực hiện job tại thời điểm
## 4.1. Sử dụng trình `cron`: 
Cho phép bạn lên lịch các nhiệm vụ định kỳ hoặc các công việc một lần vào những thời điểm cụ thể, bao gồm lịch trình hàng ngày, hàng tuần, hàng tháng và tùy chỉnh.

Để lên lịch công việc bằng cách sử dụng cron, bạn cần sửa đổi tệp `crontab` chứa danh sách các công việc đã lên lịch cho người dùng:
- Mở tệp `crontab` để chỉnh sửa(có thể chọn trình chỉnh sửa của bạn):
```bash
$ crontab -e
no crontab for hoangbuii - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.tiny
  3. /bin/ed

Choose 1-3 [1]:
```
- Thêm một dòng mới để chỉ định lịch trình và lệnh chạy. Các mốc thời gian được xắp xếp theo trình tự phút(m), giờ(h), ngày trong tháng (dom), tháng (mon), thứ (dow), hoặc sử dụng `*` cho các trường trên(for 'any')

Ví dụ: để chạy tập lệnh `/path/to/script.sh` hàng ngày lúc 10:00 sáng, bạn có thể sử dụng mục nhập sau:
```bash
0 10 * * * bash /path/to/script.sh
```
4.2. Sử dụng lệnh `at`
- Sử dụng lệnh `at` theo sau là thời gian mong muốn để chạy công việc.
- Lệnh `at` sẽ mở một dấu nhắc tương tác nơi bạn có thể nhập lệnh sẽ được thực thi. Nhập lệnh và nhấn `Ctrl+D` để lưu và lên lịch công việc.
- Lệnh atsẽ thực hiện lệnh được chỉ định tại thời điểm được chỉ định.
```bash
$ at 10:00 AM
warning: commands will be executed using /bin/sh
at Wed Jul 12 10:00:00 2023
at> echo "hello world"<EOT>
job 1 at Wed Jul 12 10:00:00 2023
```
# 5. Key word
Key word dề cập đến việc dùng để lấy đầu vào từ người dùng thông qua một menu:
```bash
select choice in "choice" "another_choice"
do
    echo "Your choice is: ${choice}"
    break
done
```
Kết quả:
```bash
$ ./sc.sh
1) choice
2) another_choice
#? 1
Your choice is: choice
```
# 6. Eval
Lệnh `eval` được sử dụng để đánh giá và thực thi một chuỗi dưới dạng lệnh shell.
```bash
$ eval string
```
Ví dụ:
```bash
$ command="ls -l"
$ eval $command
```
Lệnh trên khai báo biến `$command` với giá trị là chuỗi "ls -l" và lệnh `eval` thực thi chuỗi đó.
- Có thể dùng eval để thực hiện một lệnh sử dụng kết quả của lệnh khác:
```bash
x=15
y=5
s1="`expr $x + $y`"
s2="echo"
eval $s2 $s1
```