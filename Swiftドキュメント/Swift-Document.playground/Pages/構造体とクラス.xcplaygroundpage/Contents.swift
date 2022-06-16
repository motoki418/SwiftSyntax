//: [Previous](@previous)

import Foundation

// 定義構文(Definition Syntax)
// ピクセルベースのディスプレイ解像度を記述
struct  Resoution {
    var width = 0
    var height = 0
}
// ビデオ表示用の特定のビデオモードを記述するために、VideoMode と呼ばれる新しいクラスも定義
class VideoMode {
    var resolution = Resoution()
    var interlaced = false
    var frameRate = 0.0
    // デフォルトで nil が自動的に設定されます。
    var name: String?
}


// struct と class のインスタンス
let someResolution = Resoution()
let someVideoMode = VideoMode()

//プロパティへのアクセス
// someResolution.width は someResolution の width プロパティを参照し、デフォルトの初期値 0 を返します。
print("The width of someResolution is \(someResolution.width)")
someVideoMode.resolution.width = 1200
print("The width of someResolution is \(someResolution.width)")

// 構造体のメンバワイズイニシャライザ
// 全ての構造体には、メンバ全てに値を設定して初期化するイニシャライザ(メンバワイズイニシャライザ)が自動的に生成されます。
let vga = Resoution(width: 640, height: 480)

// 構造体と列挙型は値型
// hdとcinemaは個別のインスタンスなので、
// 片方のプロパティの値を変更しても、もう片方には影響しない。
let hd = Resoution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
// cinema is now 2048 pixels wide
print("hd is still \(hd.width) pixels wide")
// hd is still 1920 pixels wide
// 列挙型でも同じように動きます。
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
// RememberedDirection に currentDirection の値が割り当てられると、実際にはその値のコピーが設定されます。
// その後、currentDirection の値を変更しても、rememberedDirection に保存されていた元の値には影響しません。


var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// The current direction is north
// The remembered direction is west

// クラスは参照型
// 値型とは異なり、参照型は、変数または定数に割り当てられたとき、または関数に渡されたときにコピーされません。
// コピーではなく、同じ既存のインスタンスへの参照が使用されます。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
// クラスは参照型のため、tenEighty と alsoTenEighty は両方とも同じ VideoMode インスタンスを参照しています。
// これらは同じインスタンスに 2 つの異なる名前を付けているだけです:
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// The frameRate property of tenEighty is now 30.0
// tenEighty と alsoTenEighty 自体は、VideoMode インスタンスを「格納」しません。
// 代わりに、どちらも内部で同じ VideoMode インスタンスを参照します。
// 変更されるのは、基になる VideoMode の frameRate プロパティで、
// その VideoMode への参照を持つ定数ではありません。

// 恒等作用素(Identity Operators)
/// 2 つの定数または変数が同じインスタンスを参照しているかどうかを確認すると便利な場合があります。これを可能にするために、Swift は 2 つの恒等作用素を提供します:

// 同一(===)
// 同一ではない(!==)
// これらの演算子を使用して、2つの定数または変数が同じインスタンスを参照しているかどうかを確認します。
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// tenEighty and alsoTenEighty refer to the same VideoMode instance.

//: [Next](@next)

