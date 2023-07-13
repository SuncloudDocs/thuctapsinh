# Chapter 8: Luồng dữ liệu (tiếp)
# 1. Here Document, Here String và Quoting
## 1.1. Here Document
Here Document là một cách để chuyển hướng đầu vào tới một lệnh hoặc tập lệnh từ bên trong chính tập lệnh đó.
```bash
$ command << DELIMITER
    input
DELIMITER
```
phần `input` chính là here document được định nghĩa kết thúc bằng `DELIMITER` 
```bash
$ cat > input.txt << END
This is line 1.
This is line 2.
END
```
Trong đó, `END` là `DELIMTTER` và phần văn bản giữa `END` là here document
## 1.2. Here String
Here string là một khái niệm tương tự, nhưng nó được sử dụng để chuyển đầu vào cho một lệnh dưới dạng một chuỗi chứ không phải là một khối văn bản
```bash
$ command <<< "input"
```
`command` lệnh chấp nhận đầu vào là here string được đặt trong dấu ngoặc kép `"` sau toán tử `<<<`
```bash
$ grep "error" <<< "An error occurrd on..."
```
## 1.3. Quoting(Dấu nháy)
- Dấu nháy đơn `''`: tất cả các ký tự trong dấu ngoặc kép được xử lý theo nghĩa đen. Không có mở rộng biến, thay thế lệnh hoặc mở rộng ký tự đại diện.
```bash
$ echo 'Hello $USER'
Hello $USER
```
- Dấu nháy kép `""`:cho phép mở rộng biến, thay thế lệnh và một số ký tự thoát nhất định ( `$`, `\`, `!`, và `"`). Tuy nhiên, chúng không bảo toàn giá trị theo nghĩa đen của các ký tự như dấu nháy đơn.
```bash
greeting="Hello"
echo "The greeting is: $greeting"
```
Kết quả:
```bash
The greeting is: Hello
```
- Dấu gạch chéo ngược `\`: được sử dụng để thoát khỏi các ký tự đặc biệt và xử lý chúng theo nghĩa đen.
```bash
$ echo "This is a \"quoted\" word."
This is a "quoted" word.
```
# 2. Thay thế quy trình
- Thay thế quy trình cho phép đầu vào hoặc đầu ra của quy trình được tham chiếu bằng tên tệp
```bash
<(command)

#Or
>(command)
```
- Khi sử dụng `<(command)`, Bash tạo một đối tượng giống như tệp tạm thời chứa đầu ra của lệnh đã chỉ định. Đối tượng này có thể được coi là một tệp và được sử dụng làm đầu vào cho một lệnh hoặc thao tác khác. Ví dụ
```bash
$ diff <(curl http://www.example.com/page1) <(curl http://www.example.com/page2)
```
Trong ví dụ trên 2 lệnh tải file từ web được thay thế bằng các tệp tạm thời chứa nội dung của 2 file đó và được so sánh với nhau thông qua lệnh `diff`.

- Tương tự, `>(command)` được sử dụng cho đầu ra. Nó cho phép bạn chuyển hướng đầu ra của một lệnh sang một lệnh khác hoặc một tệp. Ví dụ
```bash
$ echo "Hello, World!" > >(gzip > output.gz)
$ ls
output.gz
$ gunzip output.gz
$ cat output
Hello, World!
```
Trong ví dụ trên, lệnh echo sẽ chuyển đầu ra của lệnh `echo` làm đầu vào cho lệnh `gzip`, thao tác này sẽ lưu dữ liệu vào tệp `output` và nén lại thành tệp `output.gz`