# Chapter 4: Biến và mảng

# 1. Biến
## 1.1. Khai báo biến
- Biến trong Bash scripting được khai báo bằng cú pháp `variable_name=value`.
- Tên biến phân biệt chữ hoa chữ thường và có thể bao gồm các chữ cái **(a-z, A-Z)**, chữ số **(0-9)** và dấu gạch dưới **(_)**. Tuy nhiên, ký tự đầu tiên của tên biến không được là một chữ số.
```bash
name="Hoang"
age=21
```
## 1.2 Kiểu dữ liệu của biến
- Kiểu chuỗi: Biến chuỗi chứa các chuỗi ký tự. Bạn có thể sử dụng dấu ngoặc đơn **(')** hoặc dấu ngoặc kép **(")** để xác định chuỗi. Dấu ngoặc đơn bảo toàn giá trị bằng chữ của mỗi ký tự, trong khi dấu ngoặc kép cho phép mở rộng biến và một số ký tự đặc biệt được diễn giải
```bash
name='Hoang'
```
- Kiểu số: Bash hỗ trợ các biến số để lưu trữ các giá trị số nguyên. Không cần khai báo rõ ràng cho các biến số
```bash
age=21
```
- Kiểu mảng: Mảng cho phép bạn lưu trữ nhiều giá trị trong một biến. Bạn có thể khai báo một biến mảng bằng cách gán nhiều giá trị cho nó bằng cách sử dụng dấu ngoặc đơn và phân tách các giá trị bằng dấu cách.
```bash
fruits=("apple" "banana" "orange")
```
## 1.3. Truy cập biến
Để truy cập giá trị được lưu trữ trong một biến, bạn cần thêm ký hiệu `$` vào trước tên biến. Điều này cho phép bạn truy xuất giá trị và sử dụng nó trong các ngữ cảnh khác nhau.
```bash
echo "Name: $name"
```
## 1.4. Biến hằng
Một biến hằng trong bash được khai báo một lần duy nhất và không thể thay đổi trong suốt quá trình thực thi.
```bash
# Constants
readonly PI=3.14159

# Attempt to modify a constant (will result in an error)
PI=3.14

# Display the constants
echo "PI: $PI"
```
Kết quả:
```bash
-bash: PI: readonly variable
PI: 3.14159
```
## 1.5. Biến toàn cục và biến cục bộ
- Biến toàn cục: Các biến toàn cục được xác định bên ngoài bất kỳ chức năng hoặc khối nào trong tập lệnh của bạn, giúp chúng có thể truy cập được từ bất kỳ đâu trong tập lệnh. Khi một biến toàn cục được khai báo, nó có thể được truy cập và sửa đổi bởi bất kỳ phần nào của tập lệnh.

- Biến cục bộ được khai báo và chỉ có thể truy cập trong một hàm hoặc khối cụ thể. Chúng không thể truy cập được bên ngoài chức năng hoặc khối đó. Biến cục bộ hữu ích khi bạn muốn giới hạn phạm vi của biến trong một phần cụ thể trong tập lệnh của mình. Việc đặt một biến là biến cục bộ chỉ cần thêm `local` vào trước khai báo biến
```bash
function greet {
    local name="Hoang"
    echo "Hello, $name!"
}
```
# 2. Mảng
## 2.1. Khai báo mảng
 Một mảng trong Bash là một biến có thể chứa nhiều giá trị. Nó cho phép bạn lưu trữ và thao tác một tập hợp các phần tử dưới một tên biến duy nhất. Các mảng Bash không có chỉ mục, có nghĩa là chỉ mục của phần tử đầu tiên là 0, phần tử thứ hai là 1, v.v.
```bash
fruits=("apple" "banana" "orange")
```
## 2.2. Truy cập mảng
- Để truy cập các phần tử của mảng, bạn có thể sử dụng cú pháp `${array_name[index]}`, trong đó `array_name` là tên của mảng và `index` là vị trí của phần tử mà bạn muốn truy cập.
```bash
echo "${fruits[0]}"  # Output: apple
echo "${fruits[1]}"  # Output: banana
echo "${fruits[2]}"  # Output: orange
```
- Bạn cũng có thể truy cập tất cả các phần tử của một mảng bằng cách sử dụng `${array_name[@]}`:
```bash
echo "${fruits[@]}" 
```
Kết quả:
```bash
apple banana orange
```
- Để xác định độ dài của một mảng (nghĩa là số lượng phần tử mà nó chứa), bạn có thể sử dụng cú pháp `${#array_name[@]}`:
```bash
echo "${#fruits[@]}"  # Output: 3
```
## 2.3. Các thao tác với mảng
- Thêm các phần tử:
    - Việc thêm các phần tử vào một mảng có thể được thực hiện bằng cách sử dụng toán tử gán:
    ```bash
    fruits[3]="grape"
    fruits[4]="mango"
    ```
    - Bạn cũng có thể nối các phần tử vào một mảng bằng cách sử dụng toán tử `+=`:
    ```bash
    fruits+=("kiwi" "pineapple")
    ```
- Xoá phần tử trong mảng 
```bash
unset fruits[1]
```
- Chia mảng thành mảng con
```bash
sliced_fruits=("${fruits[@]:1:3}")
```
- Nối hai mảng
```bash
concatenated_fruits=("${fruits1[@]}" "${fruits2[@]}")
```
- Xắp xếp các phần tử
```bash
sorted_fruits=($(printf '%s\n' "${fruits[@]}" | sort))
```