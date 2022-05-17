//: [Previous](@previous)

import Foundation

// 10. switchを楽に書く

// 省略した書き方
let opt1: Int? = 10
// 正式な書き方
let opt2: Optional<Int> = .some(10)

// opt1の値の有無で判定
switch opt1 {
case .some(let value):
    print("値は\(value)です")
case .none:
    break
}
// ↑ これだと処理が長いので...

// switch opt1 {}を省略したif文

if case .some(let value) = opt1 {
    print("値は\(value)です")
}
// ↑ ただ、これでもまだ処理が長いので...

// if let文を使用したオプショナル型のアンラップ
if let value = opt1{
    print("値は\(value)です")
}



//: [Next](@next)
