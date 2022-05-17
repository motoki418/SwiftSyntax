//: [Previous](@previous)

import Foundation

// 7. 任意の型を扱える型

// 2次元上の座標を表すPointInt型
struct PointInt {
    var x: Int
    var y: Int
}

// PointInt型のインスタンスを作成
// イニシャライザの引数に10と20を渡す
let p1: PointInt = PointInt(x: 10, y: 20)

// PointInt型の問題点: Intしか扱えない
// xとyをFloatで扱えるようにするにはどうしたら良い？

// 解決策： x,yをFloatにした別の型を作る
struct PointFloat {
    var x: Float
    var y: Float
}

// PointFloat型のインスタンスを作成
// イニシャライザの引数に10と20を渡す
let p2: PointFloat = PointFloat(x: 10.0, y: 20.0)

// PointFloat型の問題点: IntとFloatしか扱えない
// xとyをDoubleで扱えるようにするにはどうしたら良い？

// 解決策： x,yをDoubleにした別の型を作る
struct PointDouble {
    var x: Double
    var y: Double
}

// PointFloat型のインスタンスを作成
// イニシャライザの引数に10と20を渡す
let p3: PointDouble = PointDouble(x: 10.0, y: 20.0)

// 問題点: 扱う型ごとに専用の型を作らなければならない。面倒。
// 扱う型ごとに専用の型を作らなくても良い方法が欲しい。

// 解決策: ジェネリクス(Generics)を使う。
// Tは汎用的な型
struct Point<T> {
    var x: T// インスタンス作成時に型を決定
    var y: T// インスタンス作成時に型を決定
}

let p4: Point<Int> = Point(x: Int(10), y: Int(20))
p4.x
p4.y

let p5: Point<Float> = Point(x: Float(10), y: Float(20))
p5.x
p5.y

let p6: Point<Double> = Point(x: Double(10), y: Double(20))
p6.x
p6.y
// 型推論
let p7 = Point(x: (10), y: (20))
p7.x
p7.y

//: [Next](@next)
