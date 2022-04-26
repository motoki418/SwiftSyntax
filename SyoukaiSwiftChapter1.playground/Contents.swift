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


