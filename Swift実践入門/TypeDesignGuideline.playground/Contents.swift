import UIKit
import Foundation

var greeting = "Hello, playground"

// 型の設計指針

// クラスに対する構造体の優位性
// 参照型のクラスがもたらすバグ
// クラスは様々な箇所で共有され、それぞれの箇所で値が更新されるため、
// そのインスタンスがどのような経路を辿ってきたかによって実行結果が変わってしまう。
// それにより、コードの一部を見ただけでは結果を推論することは困難になってしまう。
class Temperature {
    var celsius: Double = 0
}

class Country {
    var temperature: Temperature

    init(temperature: Temperature) {
        self.temperature = temperature
    }
}
let temperature = Temperature()
// 日本の気温を25度に設定
temperature.celsius = 25
// 参照型では、インスタンスが引数として渡されたときにその参照が渡される。
let Japan = Country(temperature: temperature)
// エジプトの気温を40度に設定
temperature.celsius = 40
let Egypt = Country(temperature: temperature)
// クラスは参照型なので、日本とエジプトの気温が両方とも40度になってしまう
// 同じインスタンスを参照しているので、片方の値を変更するともう片方の値も変わってしまう。
Japan.temperature.celsius
Egypt.temperature.celsius

// 値型の構造体がもたらす安全性
// 値型では、インスタンスが引数として渡されるときに、その参照ではなく値そのものが渡される。
// つまり、インスタンスのコピーが渡される。
struct Temperature1 {
    var celsius: Double = 0
}

struct Country1 {
    var temperature: Temperature1
}

var temperature1 = Temperature1()
temperature1.celsius = 25
// Japan1とEgypt1は別々のインスタンを保持している。
let Japan1 = Country1(temperature: temperature1)
temperature1.celsius = 40
let Egypt1 = Country1(temperature: temperature1)
Japan1.temperature.celsius
Egypt1.temperature.celsius

// コピーオンライト　構造体の不要なコピーを発生させない最適化
var array1 = [1, 2, 3]
var array2 = array1
array1
array2
// array1.append(4)が実行されてarray1とarray2に違いが生じるときに初めてコピーが発生する
// array1の変更はarray2には影響しない。
array1.append(4)
array1
array2

// クラスを利用するべきとき
// 参照を共有する必要がある・インスタンスのライフサイクルに合わせて処理を実行する

// 参照を共有する必要がある
// ある箇所での操作を他の箇所へ旧友させちケースにはクラスが適している。

protocol Target {
    var idntifier: String { get set }
    var count: Int { get set }
    mutating func action()
}

extension Target {
    mutating func action() {
        count += 1
        print("id: \(idntifier), count: \(count)")
    }
}

struct ValueTypeTarget: Target {
    var idntifier: String = "Value Type"
    // イベントが何回発行された火が記録される。
    var count: Int = 0

    init() {}
}

class ReferenceTypeTarget: Target {
    var idntifier: String = "Reference Type"
    var count: Int = 0
}

struct Timer {
    var target: Target

    // start()メソッドの呼び出し後、action()メソッドを5回連続で実行
    mutating func start() {
        for _ in 0..<5 {
            target.action()
        }
    }
}

// 構造体のターゲットを登録してタイマーを実行
let valueTypeTarget: Target = ValueTypeTarget()
var timer1 = Timer(target: valueTypeTarget)
timer1.start()
// countプロパティを参照しても0のまま。
valueTypeTarget.count

// クラスのターゲットを登録してタイマーを実行
let referenceTypeTarget: Target = ReferenceTypeTarget()
var timer2 = Timer(target: referenceTypeTarget)
timer2.start()
// クラスの場合は、countプロパティを通じて、正しい実行回数を取得できる
referenceTypeTarget.count

// インスタンスのライフサイクルに合わせて処理を実行する
var temporaryData: String?

class SomeClass {
    // イニシャライザ
    // 初期化時に一時ファイルを作成
    init() {
        print("Create a temporary data")
        temporaryData = "a temporary data"
    }

    // デイニシャライザ　クラスのインスタンスが解放された時点で即座に実行される
    deinit {
        print("Clean up the temporary data")
        temporaryData = nil
    }
}

var someClass: SomeClass? = SomeClass()
temporaryData
// nilを代入する事で、SomeClass型のインスタンスが破棄され、
// その結果デイニシャライザが実行され、一時ファイルも破棄される。
someClass = nil
temporaryData

// クラスの継承に対するプロトコルの優位性
// クラスの継承がもたらす期待しない挙動
// クラスの継承では不要なイニシャライザやプロパティが追加されてしまうため、
// 誤用を招く可能性がある。
// 動物という抽象的な概念を表すAnimalクラス
class Animal {
    // 飼い主を表すプロパティ
    var owner: String?
    // 動物に共通した行動である睡眠を表すsleep()メソッド
    func sleep() {
        print("Sleeping")
    }
    // 動物に共通した行動を表すmove()メソッド
    func move() {}
}

class Dog: Animal {

    override func move() {
        print("running")
    }
}
class Cat: Animal {
    override func move() {
        print("prancing")
    }
}

class WildEagle: Animal {
    override func move() {
        print("Flying")
    }
}

// プロトコルによるクラスの継承の問題点の克服
// 動物の行動を表す2つのメソッドを含むAnimal1プロトコルと、
// 飼う事ができることを表すownerプロパティを含むOwnableプロトコルを分割

// 飼う事ができることを表すownerプロパティを含むOwnableプロトコル
protocol Ownable {
    var owner: String { get set }
}
// 動物の行動を表す2つのメソッドを含むAnimal1プロトコル
protocol Animal1 {
    func sleep()
    func move()
}

extension Animal1 {
    func sleep() {
        print("Sleeping")
    }
}

struct Dog1: Animal1, Ownable {
    var owner: String
    func move() {
        print("Running")
    }
}

struct Cat1: Animal1, Ownable {
    var owner: String
    func move() {
        print("Prancing")
    }
}
// 型に必要なプロトコルのみ準拠すれば良い
struct WildEagel1: Animal1 {
    func move() {
        print("Flying")
    }
}

let dog1 = Dog1(owner: "Motoki")
dog1.owner
dog1.move()
dog1.sleep()

let cat1 = Cat1(owner: "Miki")
cat1.owner
cat1.move()
cat1.sleep()

let wildEagle1 = WildEagel1()
wildEagle1.move()
wildEagle1.sleep()

// クラスの継承を利用するべきとき

// 複数の型の間でストアドプロパティの実装を共有できる
// ストアドプロパティの共有はプロトコルでは実現できないため、クラスの継承を用いる
class Animal2 {
    var owner: String? {
        // プロパティオブザーバ　didSetは変更後
        didSet {
            guard let owner = owner else { return }
            print("\(owner) was assigned as the owner")
        }
    }
}

class Dog2: Animal2 {}
class Cat2: Animal2 {}
class WildEagle2: Animal2 {}
let dog2 = Dog2()
dog2.owner = "Motoki Nakamura"

// 上記の処理の挙動をプロトコルで実現しようとすると次のように同じ実装が複数箇所に現れ、
// 大変冗長になってしまう。
protocol Ownable1 {
    var owner: String { get set}
}
struct Dog3: Ownable1 {
    var owner: String {
        didSet {
            print("\(owner) was assigned as the owner")
        }
    }
}
struct Cat3: Ownable1 {
    var owner: String {
        didSet {
            print("\(owner) was assigned as the owner")
        }
    }
}
struct WildEagle3 {}
var dog3 = Dog3(owner: "Motoki Nakamura")
dog3.owner
dog3.owner = "Yusei Nishiyama"
dog3.owner

// オプショナル型の利用指針

// Optional<Wrapped>型を利用するべきとき
// 値の不在が想定される場合にのみ使用する
// ただし、必然性のないOptional<Wrapped>型のプロパティは排除する
// ユーザー名は必須、アプリケーションが一意のIDを割り当て
// メースアドレスは必須ではないUser型
struct User {
    // idとnameの値は使用通りに必須とする
    var id: Int
    var name: String
    var mailAddress: String?
    // JSONの検証をイニシャライザ内で行う為、
    // User型の初期化後にid,nameプロパティがnilであることを考慮する必要はない。
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String else {
        // idやnameを初期化できなかった場合は、インスタンスの初期化が失敗する
        return nil
        }

        self.id = id
        self.name = name
        // as?演算子によるダウンキャストでは、型がOptional<Wrapped>型となる。
        self.mailAddress = json["email"] as? String
    }
}

let json: [String : Any] = [
    "id": 123456,
    "name": "Motoki Nakamura"
]
// インスタンスを生成と同時にアンラップ
if let user = User(json: json) {
    print("id: \(user.id), name: \(user.name)")
    type(of: user.id)
    type(of: user.name)
    type(of: user.mailAddress)
} else {
    // 不正なインスタンは初期化の時点で検証される
    print("invalid JSON")
}
