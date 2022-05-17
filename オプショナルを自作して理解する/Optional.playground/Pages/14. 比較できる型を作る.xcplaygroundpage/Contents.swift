//: [Previous](@previous)

import Foundation
import Darwin

// 14. 比較できる型を作る



struct Point {
    var x: Int
    var y: Int
}
// 何をもって比較するのか定義していないため、エラーになる。
//Point(x: 0, y: 0) == Point(x: 0, y: 0)
//Point(x: 0, y: 0) == Point(x: 99, y: 99)

// 比較するための定義　比較できる型を作成
extension Point {
    // ==の左側がlhs, ==の右側がrhs
    // lhs: Left Hand Side
    // rhs: RIght Hand SIde
    static func == (lhs: Point, rhs: Point) -> Bool{
        // 左側のxと右側のxを比較し、かつ、左側のyと右側のyを比較して
        // 同じであればtrueを返す。同じ値
        if lhs.x == rhs.x && lhs.y == rhs.y {
            return true
        } else {
            return false
        }
    }
}
// extension Pointで比較する定義を書いているので、比較できる型ｆ
Point(x: 0, y: 0) == Point(x: 0, y: 0)
Point(x: 0, y: 0) == Point(x: 99, y: 99)

//: [Next](@next)
