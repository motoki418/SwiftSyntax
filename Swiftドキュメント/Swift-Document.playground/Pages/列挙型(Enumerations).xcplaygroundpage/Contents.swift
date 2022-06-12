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
// このコードは次のように読むことができます。

// 「directionToHead の値を検証してください。.north に等しい場合は、「多くの惑星は北にあります」と出力します。
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
//: [Next](@next)
