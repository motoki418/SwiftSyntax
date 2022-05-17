//: [Previous](@previous)

import Foundation

// 13. Tで初期化出来るようにする

// 本物のOptional型
let opt1 = Int?(10)
//: [Next](@next)

enum あるかも<T> {
    case ない
    case ある(T)
}

//let a = あるかも<Int>(10)

let b = あるかも<Int>.ある(10)


// Optionalの定義を見てみる
let opt2 = Optional<Int>(20)

// Creates an instance that stores the given value.
//public init(_ some: Wrapped)

extension あるかも {
    init(_ value: T) {
        self = .ある(value)
    }
}

let c = あるかも<Int>(10)
