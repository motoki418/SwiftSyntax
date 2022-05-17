//: [Previous](@previous)

import Foundation

// 9. Optionalのコードを見てみる

// ジェネリクス 任意の型Tを扱う
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//let a: あるかも<Int> = .ある(10)

//
// Optional<Int>型　省略記法
//let b: Int? = 10
//
// Optional<Int>型　正式記法
//let c: Optional<Int> = 10


// あるかも型とOptional<Wrapped>型は構造が同じ
enum あるかも<T> {
    case ない
    case ある(T)
}

enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}
あるかも<Int>.ある(10)
Optional<Int>.some(10)

あるかも<Float>.ある(3.14)
Optional<Float>.some(3.14)

あるかも<String>.ある("Hello")
Optional<String>.some("Hello")

//: [Next](@next)
