//: [Previous](@previous)

import Foundation

// 格納プロパティ(Stored Properties)
// 下記の例では、FixedLengthRange という構造体を定義しています。
// これは、作成後に範囲の長さを変更できない整数の範囲を表します。
struct FixedLenghtRange {
    var firstValue: Int
    let length: Int
}
// FixedLengthRange のインスタンスには、firstValue と呼ばれる変数格納プロパティと length という定数格納プロパティがあります。
// 下記の例では、定数のため、長さは新しい範囲が作成されたときに初期化され、それ以降は変更できません。
var rangeOfThreeItems = FixedLenghtRange(firstValue: 0, length: 3)
print(rangeOfThreeItems)
// 0, 1, 2 の整数の範囲を表しています
rangeOfThreeItems.firstValue = 6
// 6, 7, 8 の整数の範囲を表しています

let rangeOfFourItems = FixedLenghtRange(firstValue: 0, length: 4)
// 0, 1, 2 の整数の範囲を表しています
//rangeOfFourItems.firstValue = 6
// firstValue は変数ですがエラーになります
// この挙動は、構造体が値型のためです。
// 値型のインスタンスが定数としてマークされている場合、その全てのプロパティも同様です。

// 参照型のクラスには同じことが当てはまりません。
// 参照型のインスタンスを定数に割り当てた場合でも、そのインスタンスの変数を変更できます。

// 遅延格納プロパティ(Lazy Stored Properties)
// 遅延格納プロパティは、最初に使用されるまで初期値が計算されないプロパティです。
// 宣言の前に lazy 修飾子を記述して、遅延格納プロパティを示します。
class DataImporter {
       var filename = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // DataManager クラスはここでデータの管理機能を提供します
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// importer プロパティの DataImporter インスタンスはまだ作成されていません
// lazy 修飾子でマークされているため、importer プロパティの DataImporter インスタンスは、
// importer プロパティが最初にアクセスされたとき(filename プロパティが照会されたときなど)にのみ作成されます。
print(manager.importer.filename)

// 計算プロパティ(Computed Properties)
// 関数に似ている？
struct Point {
    var x = 0.0
    var y = 0.0
}
struct Size {
    var width = 0.0
    var height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        // プロパティにアクセスするとgetが動く
        get {// getter
            // 処理
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y * (size.height / 2)
            // 戻り値
            return Point(x: centerX, y: centerY)
        }
        // プロパティに値を代入すると動く
        set(newCenter){// setter
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
            
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
// 計算プロパティcenterのgetが呼び出される。
let initialQquareCneter = square.center
print(initialQquareCneter)
// 計算プロパティcenterのsetが呼び出される。
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")


// 省略プロパティ　set宣言
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        /* 引数名を指定しない場合は、デフォルト名のnewValueが使用できる。
         上記のRect構造体のcenterプロパティのsetのnewCenterと同じ扱いになる。*/
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


// 省略プロパティ　get宣言
// get の本文全体が単一式の場合、暗黙的にその式を返す。
// 関数の本文が単一式の場合にreturnを省略できるのと同じ意味
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
            // 上記のRect構造体のcenterプロパティのgetの
            // return Point(x: centerX, y: centerY)を省略できる。
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 読み取り専用計算プロパティ
struct Cuboid {
    var width = 0.0
    var height = 0.0
    var depth = 0.0
    // get キーワードとその中括弧({})を削除することで、
    // 読み取り専用計算プロパティの宣言ができる。
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")


// プロパティオブザーバ
// プロパティの値の変化を監視し、それに応じたアクションをすることが出来る
// willSet は、値が格納される直前に呼び出されます
// didSet は、新しい値が格納された直後に呼び出されます

class StepCouter {
    var totalSteps: Int = 0 {
        // 変更前の値
        willSet(newTotalSteps) {
            print("About to set totlaSteps to \(newTotalSteps)")
        }
        // 変更後の値
        didSet {
            // パラメータに名前をつけない場合は、
            // デフォルトパラメータ名としてoldValueが使用できる
            // 変更前の歩数と変更後の歩数の差を出力する
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCouter = StepCouter()
stepCouter.totalSteps = 200
// プロパティオブザーバは、新しい値がプロパティの現在の値と同じ場合でも、
// プロパティの値が設定されるたびに呼び出される。
stepCouter.totalSteps = 200
stepCouter.totalSteps = 500
stepCouter.totalSteps = 400
stepCouter.totalSteps = 1060

// プロパティラッパ
@propertyWrapper
// 12以上の値を代入出来ないようにする構造体
struct TweleveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
struct SmallRectangle {
    @TweleveOrLess var height: Int
    @TweleveOrLess var width: Int
}
var rectangle = SmallRectangle()
print(rectangle.height)// 0
print(rectangle.width)// 0

rectangle.width = 4
print(rectangle.width)// 4
rectangle.height = 12
print(rectangle.height)// 12
rectangle.height = 13
print(rectangle.height)// 12以上は代入出来ないので値が12になる
//: [Next](@next)
