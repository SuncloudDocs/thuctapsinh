# Chapter 5: Cấu trúc điều khiển, Hàm

# 1. Toán tử trong bash
## 1.1. Toán tử đại số và chuổi
### 1.1.1 Toán tử đại số
Các toán tử đại số bao gồm cộng, trừ, nhân, chia và chia lấy dư. sử dụng cú pháp `$(( ))` hoặc lệnh `expr` để thực hiện các toán tử

**Ví dụ:**
```bash
# Addition
result=$((5 + 3))
echo "Addition: $result"

# Subtraction
result=$(expr 10 - 3)
echo "Subtraction: $result"

# Multiplication
result=$((4 * 5))
echo "Multiplication: $result"

# Division
result=$(expr 20 / 4)
echo "Division: $result"

# Modulus
result=$((15 % 4))
echo "Modulus: $result"
```
### 1.1.2 Toán tử chuỗi
Dùng để nối chuỗi, cắt chuỗi, lấy chiều dài chuỗi, so sánh hai chuỗi.

**Ví dụ:**
```bash
# String Concatenation
string1="Hello"
string2="World"
result="$string1 $string2"
echo "Concatenation: $result"

# Substring Extraction
string="Hello World"
substring="${string:6:5}"
echo "Substring: $substring"

# String Length
length=${#string}
echo "Length: $length"

# String Comparison
string1="Hello"
string2="World"
if [ "$string1" == "$string2" ]; then
  echo "Strings are equal."
else
  echo "Strings are not equal."
fi
```
## 1.2. Toán tử so sánh
### 1.2.1 Toán tử so sánh đại số
- Equal to: `-eq` (bằng)
- Not equal to: `-ne` (khác)
- Greater than: `-gt` (lớn hơn)
- Greater than or equal to: `-ge` (lớn hơn hoặc bằng)
- Less than: `-lt` (nhỏ hơn)
- Less than or equal to: `-le` (nhỏ hơn hoặc bằng)

**Ví dụ:**
```bash
num1=10
num2=20

if [ $num1 -eq $num2 ]; then
  echo "Numbers are equal."
else
  echo "Numbers are not equal."
fi
```
### 1.2.2. Toán tử so sánh chuỗi
- Equal to: `==` (giống nhau)
- Not equal to: `!=` (khác nhau)
- Greater than: `>` (lớn hơn theo thứ tự bảng chữ cái)
- Less than: `<` (nhỏ hơn)

**Ví dụ:**
```bash
string1="Hello"
string2="World"

if [ "$string1" == "$string2" ]; then
  echo "Strings are equal."
else
  echo "Strings are not equal."
fi
```
### 1.2.3. Toán tử kiểm tra file
- `-e` hoặc `-f`: Kiểm tra tính tồn tại của file
- `-d`: Kiểm tra file có phải là thư mục hay không
- `-r`: Kiểm tra file có thể đọc hay không
- `-w`: Kiểm tra file có thể ghi hay không
- `-x`: Kiểm tra file có thể thực thi hay không

**Ví dụ:**
```bash
filename="myfile.txt"

if [ -e "$filename" ]; then
  echo "File exists."
else
  echo "File does not exist."
fi
```
## 1.3. Toán tử logic
- AND: `-a` hoặc `&&` (Sảy ra khi cả hai biểu thức điều kiện đều đúng)
- OR: `-o` hoặc `||` (Sảy ra khi một trong hai biểu thức điều kiện đúng)
- NOT: `!` (Sảy ra khi biểu thức điều kiện không đúng)

**Ví dụ:**
```bash
age=25

if [ $age -gt 18 -a $age -lt 30 ]; then
  echo "Age is between 18 and 30."
else
  echo "Age is not between 18 and 30."
fi
```
# 2. Cấu trúc điều khiển
## 2.1 Cấu trúc rẽ nhánh
### 2.1.1 Cấu trúc if-else
Đưa ra một điều kiện trong lệnh `if`, nếu điều kiện đúng sẽ thực thi câu lệnh trong khối tiếp theo. Nếu không, có thể kiểm tra tiếp các điều kiện trong `elif` hoặc `else` để kết thúc

**Cú pháp cấu trúc:**
```bash
if condition1
then
    # Code to execute if the condition1 is true
elif condition2
then
    # Code to execute if the condition2 is true
else
    # Code to execute if condition1 and condition2 are false
fi
```
**Ví dụ:**
```bash
num=5

if [ $num -eq 0 ]; then
  echo "Number is zero."
elif [ $num -gt 0 ]; then
  echo "Number is positive."
elif [ $num -lt 0 ]; then
  echo "Number is negative."
else
  echo "Number is invalid."
fi
```
### 2.1.2. Cấu trúc Case
So sánh giá trị của biến với các trường hợp, nếu trường hợp nào đúng sẽ thực thi câu lệnh trong trường hợp đó

**Cú pháp của cấu trúc:**
```bash
case value in
  pattern1)
    # Code to execute for pattern1
    ;;
  pattern2)
    # Code to execute for pattern2
    ;;
  pattern3)
    # Code to execute for pattern3
    ;;
  *)
    # Code to execute for other patterns
    ;;
esac
```
**Ví dụ:**
```bash
fruit="apple"

case $fruit in
  "apple")
    echo "It's an apple."
    ;;
  "banana" | "orange")
    echo "It's a banana or an orange."
    ;;
  *)
    echo "It's something else."
    ;;
esac
```
## 2.2. Cấu trúc lặp
### 2.2.1. Vòng lặp For
Vòng lặp for dùng để duyệt các phần tử trong một tập hợp; với mỗi phần tử, nó sẽ thực hiện các câu lệnh trong khối của nó

**Cú pháp cấu trúc:**
```bash
for variable in list
do
  # Code to execute for each item in the list
done
```
**Ví dụ:**
```bash
fruits=("apple" "banana" "orange")

for fruit in "${fruits[@]}"
do
  echo "I like $fruit"
done
```
### 2.2.2. Vòng lặp While
Vòng lặp while cho phép bạn thực hiện lặp đi lặp lại một khối lệnh miễn là điều kiện đã cho vẫn đúng

**Cú pháp cấu trúc:**
```bash
while condition
do
  # Code to execute while the condition is true
done
```
**Ví dụ:**
```bash
count=1

while [ $count -le 5 ]
do
  echo "Count: $count"
  count=$((count + 1))
done
```
# 3. Hàm
Hàm cho phép bạn nhóm một số câu lệnh với nhau và thực thi chúng với một lệnh gọi. Cấu trúc của hàm:
```bash
function_name() {
  # Commands to be executed
}

# Call the function
function_name
```
**Ví dụ:**
```bash
greet() {
  echo "Hello, welcome to Bash scripting!"
}

# Call the function
greet
```
Bạn cũng có thể thêm các giá trị tham số cho hàm bằng cách thêm đối số như `$1` `$2` `$3` `$4` ... tương ứng với thứ tự các tham số trong lời gọi hàm
**Ví dụ:**
```bash
greet() {
  echo "Hello, $1! Welcome to Bash scripting."
}

# Call the function and pass a parameter
greet "Hoang"
```
Đồng thời bạn cũng có thể nhận giá trị trả về của hàm bằng lệnh `return`:
```bash
multiply() {
  local result=$(( $1 * $2 ))
  return $result
}

# Call the function and capture the return value
multiply 5 3
product=$?

echo "Product: $product"
```
Ở ví dụ trên hàm `multiply()` nhận giá trị của hai tham số `$1` và `$2` và trả về giá trị là tích của chúng, lời gọi hàm truyền vào hai giá trị `multiply 5 3` và trả về giá trị cho biến `product=$?`. Từ khoá `local` được đùng để khai báo biến cục bộ, đảm bảo rằng giá trị của biến không làm ảnh hưởng đến các giá trị khác bên ngoài hàm.