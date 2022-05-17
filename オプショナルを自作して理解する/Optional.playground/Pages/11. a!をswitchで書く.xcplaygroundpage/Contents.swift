//: [Previous](@previous)

import Foundation

// 11. a!をswitchで書く


let a: Int? = nil

// forced unwrapping
// 強制アンラップ
//print(a! + 10)
// オプショナル値のアンラップ中に予期せずnilが見つかった

// a!は下の式と同じ　危険度の高いコードの書き方
// aの値の有無で判定
//switch a {
//case .some(let value):
//    print(value + 10)
//case .none:
//    // fetalErrorはアプリをクラッシュさせるメソッド
//    fetalError("a is nil")
//}

switch a {
case .some(let value):
    print(value + 10)
case .none:
    print("a is nil")
    break
}
// ↑ 上記のswitch文を、swiftの文法でもっと簡潔に書くとこうなる。
if let value = a {
    print(value + 10)
}
//: [Next](@next)
