//: [Previous](@previous)

import Foundation

// For-Inループ
// 辞書のキーバリューペアにアクセスするためにもループ処理を使用することができます。
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4 ]
// 下記のコードは、辞書のキーはanimalName定数に、バリューはlegCount定数に展開されています。
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// 時計の分針をfor文で再現
let minutes = 60
for tickMark in 0..<minutes {
    print(tickMark)
}
// 5 分ごとに 1 目盛にしてみましょう。
// stride(from:to:by:) 関数を使用すると不要な目盛をスキップすることができます。
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print(tickMark)
    // 5 分ごと (0, 5, 10, 15 ... 45, 50, 55) に目盛を描きます
}
// 閉範囲も利用可能で、その場合は stride(from:through:by:) を使います:
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    print(tickMark)
    // 3 時間ごと (3, 6, 9, 12) に目盛を描きます
}


// switch文
// 明示的にパターンに合致しないあらゆる値をカバーするデフォルトを定義することができます。
// このデフォルトケースは、defaultキーワードで示され、必ず最後に書かなければなりません。
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "b":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

// 暗黙的にfallthroughしない
// swiftでは暗黙的に次のケースに行くことはない。
// a" と "A" の両方に合致させたい場合は、カンマ区切り(,)で値を区切って、
// 2 つの値を 1 つのケースに合成します。
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
    // 意図的にその下の評価も行いたい場合は fallthroughを実行すると、
    // 直下のcaseの処理を実行することができます。
    fallthrough
default:
    print("Not the letter A")
}

// 範囲マッチング
let approximateCount = 100
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hunderes of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")


// タプル(Tuples)
// タプルを使用して同じ switch 文の中で、複数の値を検証することができます。
// タプルの個々の要素は、異なる値や範囲に対して検証できます。
// アンダースコア(_)を使用すると、ワイルドカードとしてどんな値にも合致させることができます。
// 下記の例では、(Int, Int) 型のタプルとして (x, y) 座標を受け取り、グラフに分布しています。
let somePoint = (0, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside of the box")
default:
    print("\(somePoint) is outside of the box")
}
// この例では (0、0) は全ての 4 つのケースに当てはまります。
// 複数に合致する場合は、常に最初に合致したケースが使われます。
// (0、0) は最初に case (0, 0) に合致するので、他のケースは無視します。

// この3つのswitchケースは、anotherPointから1 つまたは両方のタプルの値を、
// プレースホルダ定数 x と y として宣言しています。
// 最初の case (let x, 0) は、y は 0 で、座標 x の値を定数 x に代入した任意の値に合致します
// 。同様に、2 番目の case (0, let y) は、x は 0 で、座標 y の値を定数 y に代入した任意の値に合致します。
let anotherPoint = (0, 1)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// この 3 つの switch ケースは、yetAnotherPoint から 1 つまたは両方のタプルの値を、
// プレースホルダ定数 x と y として宣言しています。
// これらの定数は where 句の一部で使われており、動的なフィルターを作成しています。
// switch ケースには、point の現在値が where の条件で true になった場合のみ合致します。

// 最後のケースは、先の 2 つのケース以外の全ての値に合致するため、
// switch 文で全ての値を網羅するための default ケースは不要です。


let yetAnotherPoint = (3, 2)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

let stillAnotherPoint = (0, 9)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}


// Continue
// continue 文は、各ループ内の実行を止めて、次のループの最初から処理を開始します。
// つまり、ループを抜けることなく「今のループ処理を完了します」と伝えます。
// 次の例は、全ての母音とスペースを小文字の文字列から除いて、暗号パズルフレーズを作成しています:
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)
// grtmndsthnklk

// Break
// break 文は、即座に全体の制御フローの実行を終了させます。
//breakは、switch文かループ文の内部で、他のケースよりも早期に処理の実行を終了させたいときに使います。
// Switch内でBreak
let numberSymbol: Character = "三"  // 中国語の数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}
// The integer value of 三 is 3.

// Fallthrough
// Swift の switch 文は、各ケースの底から次のケースに通り抜けることはしません。
// 通り抜けが必要な場合は、fallthrough キーワードを使用してケースごとに設定することができます。
let integerToDescribe = 1
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer"
}
print(description)
// NOTE
// fallthrough キーワードは、前のケースから通り抜けて実行されたケースの条件をチェックしません。
// fallthrough キーワードは次のケース(または default ケース)のブロック内の文に直接移動し、コードを実行します。
// これは C 言語と同じ挙動です。

// 早期リターン(Early Exit)
// guard 文は、guard の後のコードを実行するために、guard の条件が true でなければならない場合に使います。
// if 文と異なり、guard文は常にelse句が必要で、条件がfalseの場合にelse内が実行されます。
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    // 条件の一部としてオプショナルバインディングに使われている変数や定数は、guard の後のコードで利用できるようになります。
    print("Hello \(name)!")

    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])

greet(person: ["name": "jane", "location": "Cupertino"])
//: [Next](@next)


