//: [Previous](@previous)

import Foundation

// 8. 「あるかも」を任意の型で表す

enum あるかもInt {
    case ない
    case ある(Int)
}

あるかもInt.ない
あるかもInt.ある(10)

enum あるかもFloat {
    case ない
    case ある(Float)
}

あるかもFloat.ない
あるかもFloat.ある(3.14)

enum あるかもString {
    case ない
    case ある(String)
}

あるかもString.ない
あるかもString.ある("ある")

// ジェネリクス
enum あるかも<T> {
    case ない
    case ある(T)
}

あるかも<Int>.ない

あるかも<Int>.ある(10)
type(of: あるかも<Int>.ある(10))

あるかも<Float>.ある(3.14)
type(of: あるかも<Float>.ある(3.14))

あるかも<String>.ある("Hello")
type(of: あるかも<String>.ある("Hello"))

//: [Next](@next)
