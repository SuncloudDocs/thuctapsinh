# Chapter 9: Biểu thức có điều kiện
# 1. [ ] và [[ ]]
- `[]` là một lệnh tương đương với lệnh `test` dùng để đánh giá biểu thức có điều kiện trong bash. `[]` yêu cầu dấu cách giữa các toán tử và toán hạng
- `[[ ]]` là một biểu thức điều kiện mở rộng. không yêu cầu khoảng trắng xung quanh dấu ngoặc hoặc giữa toán tử và toán hạng, đông thời không cần `"` giữa các biến.
- `[[ ]]` hỗ trợ nhiều toán tử bổ sung so với `[]` như `==`, `!=`, `<`, `>`, `<=`, `>=`, `&&`, `||` và kết hợp biểu thức chính quy bằng cách sử dụng `=~`.
- `[[ ]]` cho phép các điều kiện linh hoạt và phức tạp hơn mà không cần các lệnh hoặc cấu trúc bổ sung.
- `[[ ]]` hỗ trợ khớp mẫu và toàn cầu hóa tệp với toán tử `==`, làm cho nó hữu ích cho việc khớp tên tệp, ví dụ: `[[ "value" == val* ]]`.
# 2. Một số toán tử bổ sung
Ngoài những [toán tử so sánh](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap5.md#12-toan-tu-so-sanh), [toán tử logic](https://github.com/hoangbuii/helloCloud/blob/main/bash/Chap5.md#13-toan-tu-logic). Biểu thức có điều kiện hỗ trợ một số những toán tử bổ sung như:
- Pattern Matching: `=~` trong Bash được sử dụng để khớp mẫu với các chuỗi bằng cách sử dụng các biểu thức chính quy.
    - `^`: So khớp với phần đầu của một dòng hoặc chuỗi.
    - `$`: Khớp với phần cuối của một dòng hoặc chuỗi.
    - `.`: So khớp với bất kỳ ký tự đơn nào.
    - `*`: Khớp với 0 hoặc nhiều lần xuất hiện của ký tự hoặc nhóm trước đó.
    - `+`: So khớp một hoặc nhiều lần xuất hiện của ký tự hoặc nhóm trước đó.
    - `?`: Khớp với 0 hoặc 1 lần xuất hiện của ký tự hoặc nhóm trước đó.
    - `[]`: So khớp với bất kỳ ký tự nào trong dấu ngoặc.
    - `|`: So khớp với mẫu bên trái hoặc mẫu bên phải.
```bash
[[ string =~ pattern ]]
```
Toán tử `=~` hỗ trợ các toán tử và cú pháp khớp khác nhau trong mẫu biểu thức chính quy ví dụ:
```
string="Hello, World!"

if [[ $string =~ ^Hello ]]; then
    echo "String starts with 'Hello'"
fi
```
# 3. Biểu thức có điều kiện
Các biểu thức điều kiện trong Bash được sử dụng để đánh giá các điều kiện và đưa ra quyết định dựa trên kết quả. Bash cung cấp các toán tử và cấu trúc khác nhau để tạo biểu thức điều kiện
Ví dụ:
```bash
if [ $x -gt 0 ] && [ $x -lt 10 ]; then
    echo "x is between 0 and 10"
elif [ $x -gt 10 ]; then
    echo "x is greater than 10"
else
    echo "x is less than or equal to 0"
fi
```
- Các điều kiện trong biểu thức điều kiện có thể là lệnh và cấu trúc sẽ kiểm tra điều kiện đó có sảy ra lỗi hay không
```bash
if command; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
```
Ví dụ
```bash
if ls "$1"; then
    echo "Listing succeeded"
else
    echo "Listing failed"
fi
```
Kết quả:
```bash
$ ./list.sh listex
Listing succeeded
$ ./list.sh listex1
ls: cannot access 'listex1': No such file or directory
Listing failed

```