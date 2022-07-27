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
// スーパークラスのプロパティやメソッドの上書きができる機能

// メソッドのオーバーライド
class Train: Vehicle {
    // スーパークラスVehicleのmakeNoise()の処理を上書き
    override func makeNoise() {
        print("Choo Choo")
    }
}
let vehicle = Vehicle()
vehicle.makeNoise()// 処理を記述していないので何も行われない
let train = Train()
train.makeNoise()

// プロパティのオーバーライド
class Car: Vehicle {
    var gear = 1
    override var description: String {
        // super.descriptionでスーパークラスのdescriptionを呼び出す
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3
/*
 出力されたCar: traveling at 25.0 miles per
 hourはスーパークラスVehicleで定義されているdescriptionに書かれている処理、
 in gear 3はサブクラスCarで定義されているdescriptionに書かれている処理
*/

/*
 AutomaticCarクラスは、現在の速度に基づいて使用する適切なギアを、
 自動的に選択するオートマ車を表す
*/
 class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            // gearはCarクラスのgearプロパティを指している
            gear = Int(currentSpeed / 10) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")// ギアを4に入れる
automatic.currentSpeed = 51.0
print("AutomaticCar: \(automatic.description)")// ギアを6に入れる

/*
 final修飾子をメソッド、プロパティ、またはsubscriptのキーワードの前に
 記述することで、オーバーライドを禁止する事ができる。
 また、classキーワードの前にfinal修飾子を記述することでfinalクラスをサブクラス化することを禁止する事ができる。
*/
