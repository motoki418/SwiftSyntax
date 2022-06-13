//: [Previous](@previous)

import Foundation

// 列挙型構文(Enumeration Syntax)
// コンパスの 4 つの主要な方向の例を次に示します
enum CompassPoint {
    case north
    case south
    case east
    case west
}
// directionToHead の型は、CompassPoint のある値の 1 つで初期化された場合、型が推論されます。
var directionToHead = CompassPoint.west
directionToHead
type(of: directionToHead)
// 一度 directionToHead が CompassPoint として宣言されたら、
// 次からは短いドット構文(.)を使用して別の CompassPoint 値を設定できます。
directionToHead = .east

// switch 文を使った列挙値のパターンマッチング
// 下記のコードは次のように読むことができます。
// 「directionToHead の値を検証してください。
// .north に等しい場合は、「多くの惑星は北にあります」と出力します。
// .southに等しい場合は、「ペンギンに気をつけて」と出力してください」
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

enum Planet {
case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
// 全ての列挙ケースの case を並べることが適切でない場合は、
// 明示的に対処されていないケースをカバーするdefaultのケースを提供できます。
let somePlanet = Planet.jupiter
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

// 列挙ケースの繰り返し処理
// 一部の列挙型では、その列挙型の全てのケースのコレクションがあると便利です。
// これを有効にするには、列挙型の名前の後に :CaseIterable を記述します。
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
// 下記の例では、Beverage.allCases を記述して、列挙型 Beverage の全てのケースを含むコレクションにアクセスします。
// allCases は、他のコレクションと同じように使用できます。
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// 上記の例では、ケースの数をカウントし、下記の例では、
// for ループを使用して全てのケースを繰り返し処理しています。
for beverage in Beverage.allCases {
    print(beverage)
}

// 関連値(Associated Values)
// 下記のコードは次のように読むことができます：

// 「Barcode と呼ばれる列挙型を定義します。
// これは、upc の値と (Int、Int、Int、Int) 型の関連値、
// または qrCode の値と String型の関連値、のいずれかを取ることができます」
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
// この例では、関連付けられたタプル値 (8,85909, 51226, 3) を持つ Barcode.upc の値を代入して、
// productBarcode という新しい変数を作成します。
var qroductBarcode = Barcode.upc(8, 85909, 51226, 3)
qroductBarcode = .qrCode("ABCDEFGHIJKLMNOP")
("ABCDEFGHIJKLMNOP")

switch qroductBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// 上記のswitch文は、下記のswitch文に書き換えられます。
// 列挙ケースの全ての関連値が定数として抽出される場合、または全てが変数として抽出される場合は、
// 簡潔にするために、ケース名の前に 1 つの var または let を付けるだけで問題ありません:
switch qroductBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}

// Raw Values
// 列挙型の列挙値には、Raw Value（デフォルト値）を設定することができます。
// Raw Valueの値は、すべて同じデータ型で指定します。

// RawValueには、String型、Character型、Int型、Double型のいずれかを指定することが出来ます。
// その他の型を指定することはできません。
// 列挙値に設定できる値は、その列挙宣言の中で一意（重複なし）で、かつ同じデータ型である必要があります。
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
let a = ASCIIControlCharacter.carriageReturn
// RawValueは"\r"
print(a.rawValue)

// 暗黙的に割り当てられたRawValue
// また下記は、データ型だけの指定で、case値にRaw Valuesを設定しない例です。
// 暗黙的に、Raw Valuesが割り当てられます。
// Int型の場合は、上から順番にcase値に対して「0」から整数が割り当てられています。
// 下記の例では、Planet.mercuryの明示的なRawValueは1で、
// Planet.venusの暗黙的なRawValueは2です。
enum Planet1: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
var earthsOrder: Planet1 = .mercury
print(earthsOrder.rawValue)
earthsOrder = .venus
print(earthsOrder.rawValue)
// 文字列が Raw Value に使用される場合、各ケースの暗黙的な値は、そのケースの名前のテキストです。
enum CompassPoint1: String {
    case north, south, east, west
}
var sunsetDirection = CompassPoint1.west.rawValue
print(sunsetDirection)

// Raw Valueからの初期化
// この例では、Raw Value7 から天王星を識別します。
// possiblePlanet の型は Planet? で Planet.uranus と等しい
let possiblePlanet = Planet1(rawValue: 7)
print(possiblePlanet)
type(of: possiblePlanet)

// 位置が 11 の惑星を見つけようとすると、Raw Value のイニシャライザによって返されるオプショナルの Planet は nil になります。
// earthの場合(.earth)、それ以外の場合(default)、
// それ以外の場合(enum Planet1にない番号)の処理を記述
let positionToFind = 8
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't planet at position \(positionToFind)")
}

// 再帰的列挙型
enum ArithmeticExpression {
    case number(Int)
    indirect case addtion(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
// 下記のコードは、(5 + 4) * 2 に対する ArithmeticExpression の再帰的列挙を作成する方法を示しています。
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addtion(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addtion(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))
let number = evaluate(.number(4))
let addtion = evaluate(.addtion(ArithmeticExpression.number(5), ArithmeticExpression.number(5)))

// [Next](@next)
