import UIKit

var greeting = "Hello, playground"

var total = 0
// Int型の引数と1つとり、呼び出す度に変数totalに足していく関数
// Int型の引数・Int型の戻り値あり
func count(n: Int) -> Int {
    total += n// 1を足す
    return total
}
// 変数totlaの値を0に戻すだけの関数
// 引数なし・戻り値なし
func reset() {
    total = 0
    print(total)
}
reset()
let a = 10
let b = count(n: a - 5)// 実引数の値は5
print(b)
print(count(n: a))// 関数の返り値として15を表示
reset()
print(count(n: -2))

// returnの省略
// 関数本体が式だけからなる場合、その式の値がreturnで返されるとみなされるので省略できる
//messageA()とmessageB()は同じ定義
func messageA() -> String {
    return "現在の値は\(total)です"
}
func messageB() -> String {
    "現在の値は\(total)です"
}
print(messageA())
print(type(of: messageA()))
print(messageB())
print(type(of: messageB()))

// 引数ラベル
// 引数ラベルを持つ関数定義の例
// 引数は、カタログ番号・値段・個数の三つ
func buy(product: Int, price: Int, quantity: Int) {
    print("Product:\(product), amount = \(price * quantity)")
}
buy(product: 19090, price: 180000, quantity: 1)

// 引数ラベルの指定と省略
// 長方形の縦と横の長さから面積を計算する関数
// area()とarea1()は同じ定義、違いは引数ラベルが指定されているかどうか
func area(h: Double, w: Double) -> Double {
     h * w// 関数の処理が1行の場合は「return」は省略できる
}
let ar = area(h: 10.0, w: 12.5)
print(ar)
print(type(of: ar))
// heightとwidthが引数ラベル(呼び出し元で使用する)
// wとhが入力パラメータ(仮引数)(関数内で使用する)
// この機能は、呼び出し元では分かりやすいように略語のない引数名にしておいて、
// 関数内では、簡潔に書くために引数ラベルとは違う短い名前を利用したい時に便利
func area1(height h: Double, width w: Double) -> Double {
    h * w// 関数の処理が1行の場合は「return」は省略できる
}
let ar1 = area1(height: 10.0, width: 12.5)
print(ar1)

// エラー：引数の順序は変えられない
// let ar2 = area1(width: 12.5, height: 10.0)

// 引数ラベルが必要ない場合は、引数ラベルの代わりに下線「_」を記述する
func area3(_ h: Double, _ w: Double) -> Double {
    h * w
}
let ar3 = area3(10.0, 12.5)
print(ar3)

// 仮引数の省略
// 引数を設定しているものの、関数の処理ではその値を全く使わない事がある
// その場合は、仮引数リストで引数名の代わりに下線「_」を指定する
// 下記のメソッドだと第三引数を関数の処理で利用しない事がはっきり表現できる
func compare(_ a: Int, _ b: Int, _: Bool) {
    // この場合は、引数ラベルも設定されない
}
func compare1(_ a: Int, _ b: Int, option _: Bool) {
    print("\(a), \(b)")
}
let co = compare1(10, 8, option: true)

// 関数定義におけるさまざまな設定
// inout引数
// inout引数を使ったmySwap関数
func mySwap(_ a: inout Int, _ b: inout Int) {
    let t = a; a = b; b = t
}
var x = 100
var y = 0
mySwap(&x, &y)
// 引数に規定値が指定された関数
let fontSize: Float = 12.0
func setFont(name: String, size: Float = fontSize, bold: Bool = false) {
    print("\(name) \(size)" + (bold ? " [B]" : ""))
}

func setGray(level: Int = 255, _ alpha: Float = 1.0) {
    print("Gray=\(level), Alpha = \(alpha)")
}
// 関数setFontは第1引数以外を省略できます
setFont(name: "RaglanPunch")
setFont(name: "Xourier", bold: true)
setFont(name: "Times", size: 16.0, bold: true)
// 関数setGrayは2つの引数を省略できるが、引数の順番は固定されている
setGray()
setGray(level: 240)
setGray(level: 128, 0.5)

