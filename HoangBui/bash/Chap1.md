# Chapter I: Bash và Bash Script
# 1. Các chương trình shell phổ biến
## 1.1. Các chức năng chung của lệnh shell
Chương trình **shell UNIX** diễn giải các lệnh của người dùng, được người dùng nhập trực tiếp hoặc có thể được đọc từ một tệp gọi là **tập lệnh shell** hoặc **chương trình shell**. Các tập lệnh Shell được **thông dịch**, không được biên dịch. Shell đọc các lệnh từ dòng tập lệnh trên mỗi dòng và tìm kiếm các lệnh đó trên hệ thống. Ngoài việc chuyển các lệnh tới kernel, nhiệm vụ chính của shell là cung cấp môi trường người dùng, môi trường này có thể được cấu hình riêng lẻ bằng cách sử dụng các tệp cấu hình tài nguyên shell
## 1.2. Các loại lệnh shell
- **sh** - *Bourne Shell*: Shell cơ bản, ít tính năng. Nhưng vẫn được sử dụng trên các hệ thống UNIX và trong các môi trường liên quan đến UNIX, đồng thời có sẵn trên các hệ thống Linux để tương thích với các chương trình UNIX
- **bash** - *Bourne Again shell*: shell tiêu chuẩn, trực quan và linh hoạt. Được khuyến khích nhất cho người dùng mới bắt đầu đồng thời là một công cụ mạnh mẽ cho người dùng chuyên nghiệp và nâng cao
- **csh** - *C shell* - cú pháp của shell này giống với cú pháp của ngôn ngữ lập trình C. 
- **tcsh** - *TENEX C shell*: một siêu bộ của **csh** phổ biến, nâng cao tốc độ và sự thân thiện với người dùng.
- **ksh** - *Korn shell*: đi khi được đánh giá cao bởi những người có nền tảng UNIX. Một siêu bộ của **sh**

Có thể xem lệnh shell được Linux hỗ trợ bằng các đọc file `/etc/shells`:
```bash
$ cat /etc/shells
# /etc/shells: valid login shells
/bin/sh
/bin/bash
/bin/rbash
/bin/dash
``` 
# 2. Bash - Bourne Again shell
## 2.1. Tổng quan về Bash 
**Bash** là một trình bao tương thích với **sh**, được thiết kế để tuân theo tiêu chuẩn Công cụ và Shell của IEEE POSIX P1003.2/ISO 9945.2. 

Cung cấp các cải tiến về chức năng so với sh cho cả lập trình và sử dụng tương tác; chúng bao gồm chỉnh sửa dòng lệnh, lịch sử lệnh kích thước không giới hạn, kiểm soát công việc, hàm shell và bí danh, mảng được lập chỉ mục có kích thước không giới hạn và số học số nguyên trong bất kỳ cơ số nào từ 2 đến 64. Bash có thể chạy hầu hết các tập lệnh sh mà không cần sửa đổi.

## 2.2. Các đặc trưng của Bash
### 2.2.1. Lệnh gọi.
Lệnh gọi đề cập đến quá trình thực thi tập lệnh shell hoặc lệnh shell. Nó liên quan đến việc gọi hoặc chạy shell script hoặc lệnh để thực hiện một tác vụ hoặc tập hợp các tác vụ cụ thể.
Ví dụ: khi bạn chạy lệnh tập lệnh có tên là `myscript.sh`
```bash
$ ./myscript.sh
```
hoặc khỉ bạn chạy từng lệnh cụ thể:
```bash
$ ls
```
Các lệnh Shell có thể bao gồm các tùy chọn, đối số và tham số khác nhau để tùy chỉnh hành vi của chúng. Chúng có thể được chỉ định cùng với tên tập lệnh hoặc lệnh. Ví dụ:
```bash
$ ./myscript.sh -a argument1 argument2
$ ls -l /path/to/directory
```
### 2.2.2.  Tệp khởi động Bash
Các tệp khởi động là các tập lệnh được Bash đọc và thực thi khi nó khởi động. Các phần phụ sau đây mô tả các cách khác nhau để khởi động trình bao và các tệp khởi động được đọc theo đó.
- Lệnh tương tác đăng nhập
- Lệnh tương tác không đăng nhập
- Lệnh không tương tác
- Lệnh sh
- Lệnh từ xa
### 2.2.3. Tương tác Shell
Shell tương tác thường đọc và ghi vào thiết bị đầu cuối của người dùng:
- Đầu vào và đầu ra được kết nối với thiết bị đầu cuối. 
- Hành vi tương tác Bash được bắt đầu khi lệnh bash được gọi mà không có đối số không phải tùy chọn, ngoại trừ khi tùy chọn là một chuỗi để đọc hoặc khi trình bao được gọi để đọc từ đầu vào tiêu chuẩn, cho phép đặt các tham số vị trí
### 2.2.4. Điều kiện
Các biểu thức điều kiện được sử dụng bởi `[[` lệnh ghép và bởi lệnh `test` và `[`.

Các biểu thức có thể là đơn nguyên hoặc nhị phân. Biểu thức đơn nguyên thường được sử dụng để kiểm tra trạng thái của tệp. Bạn chỉ cần một đối tượng, chẳng hạn như tệp, để thực hiện thao tác trên.
### 2.2.5. Biểu diễn số học
Shell cho phép đánh giá các biểu thức số học, dưới dạng một trong các phần mở rộng của shell hoặc bằng `let` tích hợp sẵn.
### 2.2.6. Kí danh
Kí danh cho phép một chuỗi được thay thế cho một từ khi nó được sử dụng làm từ đầu tiên của một lệnh đơn giản. Shell duy trì một danh sách các bí danh có thể được đặt và bỏ đặt bằng các lệnh `alias` và `unalias` .
### 2.2.7. Mảng
- Bash cung cấp các biến mảng một chiều.
- Bất kỳ biến nào cũng có thể được sử dụng như một mảng; khai báo tích hợp sẽ khai báo rõ ràng một mảng.
- Không có giới hạn tối đa về kích thước của một mảng, cũng như không có bất kỳ yêu cầu nào về việc các thành viên phải được lập chỉ mục hoặc chỉ định liên tục.
- Mảng bắt đầu từ 0.
### 2.2.8. Ngăn xếp thư mục
Ngăn xếp thư mục là danh sách các thư mục được truy cập gần đây. Tích hợp sẵn `pushd` thêm các thư mục vào ngăn xếp khi nó thay đổi thư mục hiện tại và tích hợp sẵn `popd` sẽ xóa các thư mục đã chỉ định khỏi ngăn xếp và thay đổi thư mục hiện tại thành thư mục đã xóa.
Nội dung có thể được hiển thị bằng lệnh `dirs` hoặc bằng cách kiểm tra nội dung của biến DIRSTACK .
### 2.2.9. The prompt
Mỗi lệnh shell do người dùng nhập sẽ được nhập tiếp sau một dấu nhắc lệnh
# 3. Thực thi lệnh
## 3.1. Tổng quan 
Bash xác định loại chương trình sẽ được thực thi. Các chương trình bình thường là các lệnh hệ thống tồn tại ở dạng được biên dịch trên hệ thống của bạn. Khi một chương trình như vậy được thực thi, một tiến trình mới được tạo ra bởi vì Bash tạo một bản sao chính xác của chính nó. Tiến trình con này có cùng môi trường với tiến trình cha của nó, chỉ khác số ID của tiến trình. Thủ tục này được gọi là *forking*.
## 3.2. Các lệnh tích hợp Shell
Bash hỗ trợ 3 loại lệnh tích hợp:
- Bourne Shell tích hợp sẵn:

`:` , `.` , `break` , `cd` , `continue` , `eval` , `exec` , `exit` , `export` , `getopts` , `hash` , `pwd` , `readonly` , `return` , `set` , `shift` , `test` , `[` , `times` , `trap` , `umask` và `unset` .

- Các lệnh tích hợp Bash:

`alias`, `bind`, `builtin`, `command`, `declare`, `echo`, `enable`, `help`, `let`, `local`, `logout`, `printf`, `read`, `shopt`, `type`, `typeset`, `ulimit` và `unalias`.

- Các lệnh tích hợp đặc biệt: Khi Bash đang thực thi ở chế độ **POSIX**, các lệnh tích hợp sẵn đặc biệt khác với các lệnh tích hợp sẵn khác ở ba khía cạnh:

    - Các phần dựng sẵn đặc biệt được tìm thấy trước các hàm shell trong quá trình tra cứu lệnh.

    - Nếu một phần mềm tích hợp sẵn đặc biệt trả về trạng thái lỗi, thì hệ vỏ không tương tác sẽ thoát ra.

    - Các câu lệnh gán trước lệnh vẫn có hiệu lực trong môi trường shell sau khi lệnh hoàn thành.

    - Các tích hợp đặc biệt POSIX là `:` , `.` , `break` , `continue` , `eval` , `exec` , `exit` , `export` , `readonly` , `return` , `set` , `shift` , `trap` và `unset` .
## 3.3. Thực thi các chương trình từ một tập lệnh(shell script)
Khi chương trình đang được thực thi là tập lệnh shell, bash sẽ tạo một quy trình bash mới bằng cách sử dụng *fork* . Subshell này đọc các dòng từ shell script mỗi lần một dòng. Các lệnh trên mỗi dòng được đọc, diễn giải và thực thi như thể chúng đến trực tiếp từ bàn phím.
Trong khi subshell xử lý từng dòng của tập lệnh, shell mẹ đợi quá trình con của nó kết thúc. Khi không còn dòng nào trong shell script để đọc, subshell sẽ kết thúc. Shell mẹ hoạt động và hiển thị lời nhắc lệnh mới.
# 4. Khối lệnh Shell
## 4.1. Cú pháp lệnh
Sau khi nhập lệnh, Shell chia nó thành các từ và toán tử, sử dụng các quy tắc trích dẫn để xác định ý nghĩa của từng ký tự đầu vào. Sau đó, những từ và toán tử này được dịch thành lệnh và các cấu trúc khác, trả về trạng thái thoát có sẵn để kiểm tra hoặc xử lý.
## 4.2. Lệnh Shell
Một lệnh shell cơ bản như `touch file1 file2` sẽ bao gồm lệnh và các đối số của nó, cách nhau bởi dấu cách.
Một lệnh shell phức tạp hơn bao gồm các lệnh đơn giản được sắp xếp cùng nhau theo nhiều cách khác nhau Ví dụ:
```bash
$ gunzip file.tar.gz | tar xvf 
```
## 4.3. Hàm shell
Các hàm Shell là một cách để nhóm các lệnh để thực hiện sau này bằng cách sử dụng một tên duy nhất cho nhóm. Chúng được thực hiện giống như một lệnh cơ bản . Khi tên của hàm hệ vỏ được sử dụng làm tên lệnh đơn giản, danh sách các lệnh được liên kết với tên hàm đó sẽ được thực thi.
## 4.4. Tham số shell
- Một tham số là một thực thể lưu trữ các giá trị. Nó có thể là tên, số hoặc giá trị đặc biệt
- Một biến có một giá trị và không hoặc nhiều thuộc tính.
- Nếu không có giá trị nào được đưa ra, một biến được gán chuỗi rỗng.
## 4.5. Shell mở rộng
Việc mở rộng Shell được thực hiện sau khi mỗi dòng lệnh đã được chia thành các mã thông báo. Đây là những mở rộng được thực hiện:
- Mở rộng Brace
- Mở rộng dấu ngã
- Mở rộng tham số và biến
- Thay thế lệnh
- Khai triển số học
- Tách từ
- Mở rộng tên tệp
## 4.6. Chuyển hướng
Trước khi một lệnh được thực thi, đầu vào và đầu ra của nó có thể được chuyển hướng bằng cách sử dụng ký hiệu đặc biệt được giải thích bởi lệnh shell. Chuyển hướng cũng có thể được sử dụng để mở và đóng tệp cho môi trường thực thi trình bao hiện tại.