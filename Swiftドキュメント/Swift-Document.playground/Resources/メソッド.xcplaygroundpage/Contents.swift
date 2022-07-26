//: [Previous](@previous)

import Foundation
import Darwin

// インスタンスメソッド
// 3つのインスタンスメソッドを定義するクラス
class Counter {
    var count = 0
    // カウンタを1ずつインクリメントします
    func increment() {
        count += 1
    }
    // 指定された整数分だけカウンタをインクリメントします
    func increment(by amount: Int) {
        count += amount
    }
    
    // カウンタを 0 にリセットします
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.count// counter の初期値は 0
counter.increment()
counter.count// counter の値は 1
counter.increment(by: 5)
counter.count// counter の値は 6
counter.reset()
counter.count// counter の値は 0

// selfプロパティ
// 型の全てのインスタンスには、インスタンスそれ自体を表す self と呼ばれる暗黙のプロパティがある
struct Point {
    var x = 0.0
    var y = 0.0
    // インスタンスメソッドのパラメータ名と、
    // そのインスタンスのプロパティが同じ名前の場合は、区別するために、
    // selfプロパティを使用する必要がある。
    func isToTheRightOf(x: Double) -> Bool {
        // self.xはプロパティxを
        // xはインスタンスメソッドのパラメータ名を指している。
        // 下記のインスタンスを作成する際にプロパティxには4.0を代入し、
        // パラメータxには1.0を代入しているのtrueが返る
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}


// インスタンスメソッド内からの値型の変更
// 構造体と列挙型は値型なので、デフォルトでは、
// 値型のプロパティはそのインスタンスメソッド内から変更出来ない。
// ただし、mutatingキーワードをインスタンスメソッドに付与する事で、
// プロパティの変更ができるようになる。
struct Point1 {
    var x = 0.0
    var y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint1 = Point1(x: 1.0, y: 2.0)
somePoint1.x
somePoint1.y
somePoint1.moveBy(x: 2.0, y: 3.0)
somePoint1.x
somePoint1.y
print("The point is now at (\(somePoint1.x), \(somePoint1.y))")


// mutating メソッド内からselfへの値の割り当て
struct Point2 {
    var x = 0.0
    var y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX , y: y + deltaY)
    }
}
// この例では、スイッチの3つの状態を列挙型で定義している。
// スイッチは、next()メソッドが呼び出されるたびに、3つの異なる電源状態(off、low と high)を切り替える。
enum TriStateSwitch {
    case off, low, high
    
    mutating func next() {
        switch self {// selfはTriStateSwitchを指している。
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()
ovenLight.next()

// 型メソッド
class SomeClass {
    class func someTypeMethod() {
        // 型メソッドの実装はここに記述する
        print("型メソッドの実装")
    }
}
// 型メソッドはインスタンスではなく、型に対して型メソッドを呼び出す。
// SomeClassというクラスで型メソッドを呼び出す方法
SomeClass.someTypeMethod()
