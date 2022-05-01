import UIKit

var greeting = "Hello, playground"
// 配列
var g = 1.2
var f = [g/2.0, g/0.3, g/0.04]// 配列には、式を代入することも可能
print(f)

let digits = ["00", "01", "02", "03"]
print(digits[2])
print(digits.count)
// 配列も値型のデータなので、コピーすると複製が作成される
var nums = digits// numsにはdigits配列の複製が作られる。
nums[2] = "Two"// 変数には代入可能
// digits[2] = "Two"// エラー：定数 let digitsには代入できない
print(digits[2])// 02を出力(コピー元の配列には影響がない)
print(digits)//コピー元(let digits)の配列には影響がない
print(nums)

var roman = ["Ⅰ", "II", "III"]
// appendメソッドで配列の末尾に要素を追加
roman.append("IV")
print(roman)
let m = roman + ["5", "6"]
print(m)
roman += ["V", "VI"]
print(roman)

// 演算子
// 値を次々に代入する記法は利用出来ない
// a = b = 1 許されない
// if a = 1 { 許されない

// 演算子の記述に関する注意
var a = 1
var b = 2
// 演算子の両側に空白があるか、どちらにも空白がない場合は、二項演算子として解釈される
a + b// 二項演算子
a+b// 二項演算子
// b /(a +1) // 演算子/と+の前後に空白を入れるか、あるいは取り除く

// 識別子
// 単語の先頭を全て大文字開始のアッパーキャメルケースは、型名、クラス名などに使用する
//Int Void AnyObject CustomStringConvertible

// 先頭の文字だけを小文字にするローアーキャメルケースは、メソッド名、変数名などに使用する
//message totalCount nextPartialResult

// fallthroughはSwiftの予約語だが、バククォート「`」で囲むと変数名として利用できる
var `fallthrough` = 10

// 型パラメータ
