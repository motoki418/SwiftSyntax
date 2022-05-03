import UIKit

var greeting = "Hello, playground"

// スコープ(名前の有効範囲)
// ローカルスコープ(局所的に定義されるスコープ)
func someFunction() {
    let a = "a"
    print(a)// OK
}
// print(a)// エラー
someFunction()

let grobalA = "a"

func someFunction1() {
    print(grobalA)// OK
}
print(grobalA)// OK
someFunction1()

// スコープの優先順位
let a1 = 1// グローバルスコープ
func someFunctin2() {
    let a1 = 2// ローカルスコープ
    print("local a:", a1)
}
// ローカルスコープでは同一スコープ内で宣言された定数a1を参照
someFunctin2()
// グローバルスコープではグローバルスコープで宣言された定数a1を参照している事がわかる
print("global a:", a1)

// 式の組み立て
// 値の返却のみを行う式
// 変数や定数の値を返却する式
let a3 = 1
let b = a3 + 1

// リテラル式
let a4 = 123
type(of: a4)
let b1 = "abc"
type(of: b1)

// メンバー式
// 式.メンバー名
let a5 = "Hello World!"
// 文字数を表す
a5.count
// 指定した文字ではじまるかを判定
a5.starts(with: "Hello")

// クロージャ式
// 配列の要素を変換するmap(_:)メソッドに、各要素を2枚するクロージャ式を渡している
let original = [1,2,3]
// valueが引数名　inキーワードの後に戻り値を返す式を書く
let doubled = original.map({ value in value * 2})
doubled

// 演算を行う式
