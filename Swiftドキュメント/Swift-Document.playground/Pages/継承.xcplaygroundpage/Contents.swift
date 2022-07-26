//: [Previous](@previous)

import Foundation

// 基本クラスの定義
// 別のクラスから継承しないクラスは、基本クラスと呼ばれます。

class Vehicle {
    var currentSpeed = 0.0
    // 読み取り専用の String 型の計算プロパティ
    var description: String {
         "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // 何もしない - 乗り物は必ずしも騒音を出しません
    }
}

var someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")
// Vehicle クラスは、任意の乗り物に共通の特性を定義しますが、
// そのまま使用されることはあまりありません。
// より有用にするには、より具体的な種類の乗り物を記述する必要があります。


// サブクラス化
// サブクラス化は、既存のクラスに基づいて新しいクラスを作成することを指す
// スーパークラスVehicleを継承するサブクラスBicycleを定義
// スーパークラスを継承する事で、スーパークラスに定義されているプロパティやメソッドを自動的に継承する
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
print(bicycle.hasBasket)
bicycle.hasBasket = true
print(bicycle.hasBasket)

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

// サブクラス自体をサブクラス化出来る。
// 次の例では、タンデムと呼ばれる2人乗り自転車のサブクラスを作成している
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
print(tandem.hasBasket)
tandem.hasBasket = true
print(tandem.hasBasket)
tandem.currentNumberOfPassengers = 2
print(tandem.currentNumberOfPassengers)
print("Tandem: \(tandem.description)")
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")


// オーバーライド

