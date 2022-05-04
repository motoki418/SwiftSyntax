import UIKit

var greeting = "Hello, playground"

// String型
let a = "1\n2\n3"
print(a)

// 文字列リテラル内での値の展開
let result = 7 + 9
let output = "結果: \(result)"

let result1 = "優勝"
let output1 = "結果: \(result1)"

// 複数行の文字列リテラル
let haiku = """
五月雨を
あつめて早し
最上川
"""
print(haiku)

let haiku1 = """
五月雨を
 あつめて早し
最上川
"""
print(haiku1)

//数値型との相互変換
//Int型をString型に変換する場合は、String型のイニシャライザを使用する
let i = 123
let s = String(i)

//String型をInt型に変換する場合は、String型のイニシャライザを使用する
//変換できない場合は、nilが返される
let s1 = "123"
let i1 = Int(s1)

let s2 = "abc"
let i2 = Int(s2)//Optional<Int>型の値になる
print(type(of: i2))

// String型の操作
// 比較
let string1 = "abc"
let string2 = "def"
string1 == string2
// 結合
var string3 = "abc"
let string4 = "def"
let string5 = string3 + string4
string3.append( string4)
// Foundationによる高度な操作
import Foundation
// 2つの文字列間の順序の比較
let options = String.CompareOptions.caseInsensitive
let order = "abc".compare("ABC", options: options)
order == ComparisonResult.orderedSame
// 文字列の探索
"abc".range(of: "bc")// 1から2の範囲を示す値を返す

// Optional<Wrapped>型　値があるか空のいずれかを表す型
