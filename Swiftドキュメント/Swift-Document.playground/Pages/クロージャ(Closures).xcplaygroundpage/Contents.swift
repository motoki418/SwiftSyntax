//: [Previous](@previous)

import Foundation
import CoreFoundation
import Darwin

// ソートメソッド(The Sorted Method)
// このメソッドは、指定した並べ替えクロージャの結果に基づいて、
// その型の値の配列を並べ替えます。
// アルファベットが大きい = Zが一番最初にAが一番最後に来るように並び替え
let names = ["Chris", "Alex", "Ewa", "Barry","Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    // 文字列内の文字の場合、「より大きい」は「アルファベットの後半に現れる」を意味します。
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)

// クロージャ式構文(Closure Expression Syntax)
// 上記の backward(_:_:) 関数のクロージャ式バージョンです。
reversedNames = names.sorted(by: { ( s1: String, s2: String) -> Bool in
    return s1 < s2
})
print(reversedNames)

// コンテキストから型の推論(Inferring Type From Context)
// sorted(by:) メソッドは、文字列の配列から呼び出されるため、その引数は (String, String) -> Bool 型の関数だと推論できます。
// つまり、(String, String) 型と Bool 型は、クロージャ式に記述する必要はありません。
// 全ての型を推論できるため、戻り矢印(->)とパラメータ名を囲む括弧も省略できます。
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })
print("コンテキストから型の推論\(reversedNames)")

// 単一式のクロージャの暗黙的リターン(Implicit Returns from Single-Expression Closures)
// 上記の例のように、単一式のクロージャは、宣言から return キーワードを省略して結果を暗黙的に返すことができます。
// クロージャの本文は、Bool 値を返す単一式(s1 > s2)のため、
// あいまいさはなく、return キーワードは省略できます。
reversedNames = names.sorted(by: { s1, s2 in s1 > s2})
print("単一式のクロージャの暗黙的リターン\(reversedNames)")

// 省略引数名(Shorthand Argument Names)
// クロージャの引数の値を $0、$1、$2 などの名前で参照できます。
reversedNames = names.sorted(by: { $0 > $1 } )


// 末尾クロージャ(Trailing Closures)
// 末尾クロージャは、クロージャが長く、1 行にインラインで書き込むことができない場合に特に役に立ちます。
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 関数本文
    print("a")
}
someFunctionThatTakesAClosure(closure: {

})
someFunctionThatTakesAClosure() {

}

reversedNames = names.sorted() { $0 > $1 }

// 下記のコードは整数値と英語バージョンの名前をマッピングした辞書を定義しています。
// また、文字列に変換できる整数の配列も定義しています。
let digitNames = [
    0: "Zero",  1: "One",  2: "Two",
    3: "Three", 4: "Four",  5: "Five",
    6: "Six",  7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16]
// `strings` は [String] 型に推論されます
//末尾クロージャで map(_:) メソッドを使用して、Int の配列を String の配列に変換する方法は次のとおりです。
// 配列 [16, 58, 510] から、新しい配列 ["OneSix", "FiveEight", "FiveOneZero"] を作成しています。
// マッピングされる型は配列の値から推論できるため、
// クロージャの入力パラメータ number の型を指定する必要はありません。
let strings = numbers.map { (number) -> String in
    var number = number
    print("number \(number)")
    var output = ""
    print("output \(output)")
    repeat {
        // 辞書の subscript は、キーが存在しない場合に辞書の検索が失敗する可能性があることを示す
        // オプショナルの値を返すため、digitNames 辞書の subscript の呼び出しの後に感嘆符(!)を付けています。
        output = digitNames[number % 10]! + output
        print("output \(output)")
        number /= 10
        print("number \(number)")
    } while number > 0
    return output
}
type(of: strings)
print(strings)

// 値のキャプチャ(Capturing Values)
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
// この例では、incrementByTen という定数を設定して、呼び出されるたびに
// runningTotal変数に10を追加するincrementer関数を参照します。
incrementByTen()
incrementByTen()
// 2 つ目の incrementer 関数を新しく作成すると、別の runningTotal 変数への参照を格納します。

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// 7 を返します
// 元の incrementer(incrementByTen)を再度呼び出すと、それ自体の runningTotal 変数が引き続きインクリメントされ
// incrementBySeven によってキャプチャされた変数には影響しません。
incrementByTen()

// クロージャは参照型(Closures Are Reference Types)
// 下記の例は、alsoIncrementByTen を呼び出すことは incrementByTen を呼び出すことと同じだということを示しています。
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
incrementByTen()

// エスケープクロージャ(Escaping Closures)
// 関数の引数として渡されたクロージャが、関数本文が終了した後に呼び出される場合、関数をエスケープすると呼ばれています。
var completionHandlers = [() -> Void]()
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}


func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
class SomeClass {
    var x = 10
    func doSomething() {
        // someFunctionWithEscapingClosure(_:) に渡されたクロージャは self を明示的に参照しています。
        someFunctionWithEscapingClosure { self.x = 100 }
        // 対照的に、someFunctionWithNonescapingClosure(_:) に渡されるクロージャは、エスケープなしのクロージャです。
        // つまり、暗黙的にselfを参照できます。
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
type(of: completionHandlers)
print(instance.x)

// 自動クロージャ(Autoclosures)
// 自動クロージャを使用すると、クロージャを呼び出すまで内部のコードが実行されないため、評価を遅らせることができます。
// 遅延評価は、コードがいつ評価されるかを制御できるため、副作用があるコードや計算コストが高いコードを書くときに役に立ちます。
// 下記のコードは、クロージャが評価をどのように遅らせるかを示しています。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniel"]
print(customersInLine.count)

// customersInLine 配列の最初の要素はクロージャ内のコードによって削除されますが、
// 配列要素はクロージャが実際に呼び出されるまで削除されません。
// customerProvider の型は String ではなく、() -> String で、文字列を返すパラメータのない関数だということに注意してください。
let cusomerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

let cusomerProvider1 = { customersInLine.append("Evan") }
print(customersInLine.count)
// クロージャを呼び出して初めて配列要素が削除される。
print("Now serving \(cusomerProvider())!")
print(customersInLine.count)

// // クロージャを呼び出して初めて配列要素に新たな要素が追加される。
print("Now serving \(cusomerProvider1())!")
print(customersInLine)
print(customersInLine.count)


// 関数の引数としてクロージャを渡すと、遅延評価と同じ動作が得られます。
func serve(customer customerProvider: () -> String) {
    print("Now serving \(cusomerProvider())!")
}
serve(customer: { customersInLine.remove(at: 1) } )
print(customersInLine.count)
print(customersInLine)
//: [Next](@next)


