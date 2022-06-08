//: [Previous](@previous)

import Foundation

// 空の配列の作成(Creating an Empty Array)
// イニシャライザの構文を使用して、ある型の空の配列を作成できます。
var someInts = [Int]()
var someInt: [Int] = []
print("someInts is of type [Int] with \(someInts.count) items.")
// someInts is of type [Int] with 0 items.
someInts.append(3)
// someInts Int 型の 3 を含んでいます
someInts = []
// someInts は空の配列だけど [Int] 型

// デフォルト値を使った配列の作成
// このイニシャライザに適切な型のデフォルト値(repeating)と、
// その値の繰り返し回数(count)を渡します。
var threeDoubles = Array(repeating: 0.0, count: 3)
var threeStrings = Array(repeating: "aaa", count: 3)
// threeDoubles は [Double] 型で、 [0.0, 0.0, 0.0] と等しい

// 2つの配列の結合
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles は [Double] 型で [2.5, 2.5, 2.5] と等しい

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles は [Double] と推論され、 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5] と等しい

// 配列リテラルを使った配列の作成
var shoppingList = ["Eggs", "Milk"]
// shoppingList は 2 つの 初期値で初期化されている

// 配列へのアクセスと変更
print("The shopping list contains \(shoppingList.count) items")
// Bool 型の isEmpty プロパティは、count プロパティが 0 かどうかをチェックする簡略記法です。
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list isn't empty.")
}
// append(_:) メソッドを使用して、配列の末尾に新しいアイテムを追加することができます。
shoppingList.append("Flour")
// 加算代入演算子(+=)を使用して 1 つ以上の互換性のある型のアイテムを追加することもできます。

shoppingList += ["Baking Powder"]
// shoppingList 4 つのアイテムを含んでいます
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList 7 つのアイテムを含んでいます

// subscript 構文を使用すると、配列から値を取得します。
var firstItem = shoppingList[0]
// ある一定範囲の値を一度に変更する場合にも、subscript 構文を使用することができます。
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList
// shoppingList は 6 つのアイテムを含んでいます

// 配列の特定のインデックスにアイテムを挿入したい場合、insert(_:at:) メソッドを使います。
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList は 7 つのアイテムを含んでいます
// "Maple Syrup" は最初のアイテムです

let mapleSyrup = shoppingList.remove(at: 0)
shoppingList
mapleSyrup
// アイテムが削除された時、配列内の隙間は埋められ、
// インデックス 0 の値は再び"Eggs"になります。
firstItem = shoppingList[0]

// 配列の繰り返し処理
for item in shoppingList {
    print(item)
}

// 各アイテムのインデックスが必要な場合は、enumerated() を代わりに使いましょう。
// enumerated() は数値のインデックスとアイテムを組み合わせたタプルを返します。
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

// Sets(セット)
// セットはコレクション内に、同じ型の値を、決まった順序と値の重複なしに保持します。
// アイテムの順序が重要でない場合や、アイテムに重複がないことを保証したい場合に、
// 配列の変わりにセットを使用することができます。
// セット型構文(Set Type Syntax)
// セット型は Set<Element> と書きます。
// Element はセットが保持できる型です。
// セットには、配列のような簡略記法([Element])はありません。

// 空のセットの作成と初期化(Creating and Initializing an Empty Set)
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

// 配列リテラルを使ったセットの作成
// 配列リテラルの値は全て同じ型なので、favoriteGenres変数は Set<String>が正しい型だと推論できます。
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
// favoriteGenres は 3 つ の初期値で初期化されている

// セットへのアクセスと変更
//insert(_:) メソッドを使用して、セットに新しいアイテムを追加することができます。
favoriteGenres.insert("Jazz")
favoriteGenres
print(type(of: favoriteGenres))

//remove(_:) を使用してセットからアイテムを削除できます。
// セットにアイテムが存在した場合は削除し、削除したアイテムを返します。もし存在しなけば nil を返します
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
    removedGenre
} else {
    print("I never much cared for that.")
}
favoriteGenres
// 特定のアイテムが含まれているかどうかを調べるには、contains(_:) メソッドを使用することができます。

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// It's too funky in here.

// セットの繰り返し処理
// Swift の Set 型は決まった順序がありません。
// 特定の順番で値を繰り返し処理したい場合、sorted() メソッドを使用すると、
// < 演算子を使用してソートされた配列として要素を返します。
for genre in favoriteGenres.sorted(){
    print(genre)
}

// 基本的なセットの操作
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
// union(_:) は、両方のセットに含まれている全ての要素を含めた新しいセットを作成します
oddDigits.union(evenDigits).sorted()
//intersection(_:) は、2 つのセットの共通要素を含めた新しいセットを作成します
oddDigits.intersection(evenDigits).sorted()
// subtracting(_:) は、特定のセットには含まれていない要素を含めた新しいセットを作成します
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// symmetricDifference(_:) は、どちらかのセットにあるものの、両方には含まれていない要素を含めた新しいセットを作成します
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

// 辞書(Dictionaries)
// 空の辞書型の作成
var namesOfIntegers = [Int: String]()
type(of: namesOfIntegers)
// namesOfIntegers は空の [Int: String] 辞書
namesOfIntegers[16] = "sixteen"
// namesOfIntegers は 1 つのキーバリューペアを含んでいます
namesOfIntegers
namesOfIntegers = [:]
// namesOfIntegers は再び [Int: String] の空の辞書

// 辞書リテラルを使った辞書の作成
// 下記の例では、国際空港の名前を保持する辞書を作成します。
// この辞書は、3 文字の国際空港コードをキーに、空港名をバリューにしています。
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
// subscript 構文を使用して、新しいアイテムを追加することができます。
airports["LHR"] = "London"
airports
// subscript 構文を使用すると、特定のキーのバリューを変更することもできます。
airports["LHR"] = "London Heathrow"
// "LHR"の値は "London Heathrow" へ変更
// 別の方法として、updateValue(_:forKey:) メソッドを使用して、特定のキーのバリューの設定/更新ができます。
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
airports
// The old value for DUB was Dublin.

// subscript 構文を使用して特定のキーのバリューを取得することもできます。
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport isn't in the airports dictionary.")
}
// The name of the airport is Dublin Airport.

// 辞書の繰り返し処理
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// keys と values プロパティを使用して、キーとバリューそれぞれのリストを取得することもできます:
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

//: [Next](@next)
