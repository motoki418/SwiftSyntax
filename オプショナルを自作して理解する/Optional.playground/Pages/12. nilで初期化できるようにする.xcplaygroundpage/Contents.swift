//: [Previous](@previous)

import Foundation

// 12. nilで初期化できるようにする



let a: Optional<Int> = nil
// @frozen public enum Optional<Wrapped> : ExpressibleByNilLiteral {

enum あるかも<T> {
    case ない
    case ある(T)
}

let b: あるかも<Int> = .ない
//let c: あるかも<Int> = nil


extension あるかも: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self = .ない
    }
}

let d: あるかも<Int> = nil
print(d)

//: [Next](@next)
