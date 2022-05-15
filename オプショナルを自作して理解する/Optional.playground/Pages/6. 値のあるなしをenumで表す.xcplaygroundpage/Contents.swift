//: [Previous](@previous)

import Foundation

// 6. 値のあるなしをenumで表す

// 以下を表現できる型をenumで作る
// - 値がない
// - 値がある(値はInt型)

enum あるかも {
    case ない
    case ある(Int)
}

// maybe: もしかすると、たぶん、おそらく
let maybe1: あるかも = .ない
// 10という値がある
let maybe2: あるかも = .ある(10)
// 20という値がある
let maybe3: あるかも = .ある(20)

func printNumber(maybe: あるかも) {
    switch maybe {
    case .ない:
        print("値はありません")
    case .ある(let number):
        print("値は\(number)です")
    }
}
// case .ないにマッチえ
printNumber(maybe: .ない)
// case .ある(let number)にマッチ
printNumber(maybe: .ある(10))
// case .ある(let number)にマッチ
printNumber(maybe: .ある(20))
//: [Next](@next)
