//: [Previous](@previous)

import Foundation

//関数の定義と呼び出し
// 定義は、関数が何をするか、何を受け取ることを期待するか、
// そしてそれが行われたときに何を返すかを説明します。
// こうすることで、コード内の他の場所から誤解を生むことなく関数を呼び出すことができます。
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    // return greetingという行で関数は実行を終了し、greeting
    // の現在の値を返します。
    return greeting
}
greet(person: "John")
type(of: greet(person: "John"))

// 本文を短くするために、挨拶の作成と return 文を 1 行にまとめることができます。
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
greetAgain(person: "Anna")

// 関数のパラメータと戻り値(Function Parameters and Return Values)
// 名前のない単一のパラメータを持つシンプルなユーティリティ関数から、読みやすいように表現できるパラメータ名と、
// 様々なパラメータオプションを持つ複雑な関数まで、あらゆるものを定義できます。

// パラメータなし関数(Functions Without Parameters)
// 入力パラメータは関数に必須ではありません。
func sayHelloWorld() -> String {
    return "Hello, world"
}
sayHelloWorld()

// 複数のパラメータがある関数(Functions With Multiple Parameters)
// 関数は、カンマ(,)区切りで複数のパラメータを持つことができます。
func greet(person: String, alreadyGreeted: Bool) -> String {
    // trueの場合greetAgain()関数を呼び出す
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {// falseの場合にgreet()関数を呼び出す
        return greet(person: person)
    }
}
greet(person: "Tim", alreadyGreeted: true)
greet(person: "Tim", alreadyGreeted: false)

// 戻り値なし関数(Functions Without Return Values)
// 戻り値の型を定義することも必須ではありません。
func greet1(person: String) {
    print("Hello, \(person)!")
}
greet1(person: "Dave")

// 最初の関数 printAndCount(string:) は文字列を出力し、その文字数を Int として返します
func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
// 2 番目の関数 printWithoutCounting(string:) は、
// 最初の関数を呼び出しますが、その戻り値を無視します。
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
// 文字列を出力し、文字数をカウントする
printAndCount(string: "hello, world")
// 文字列を出力するが、文字数はカウントしない
printWithoutCounting(string: "hello, world")

// 複数の戻り値がある関数(Functions with Multiple Return Values)
// この関数は、Int 値の配列内の最小値と最大値を検索します。
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    // 配列内の残りの値を繰り返し処理し、各値をチェックして、
    // それぞれ currentMin と currentMax の値よりも小さいか大きいかを確認します。
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    // 全体の最小値と最大値が2つのInt値のタプルとして返されます。
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
// タプルのそれぞれの値は、関数の戻り値の型の一部として名前が付けられているため、
// ドット(.)構文でアクセスして、見つかった最小値と最大値を取得できます。
print("min is \(bounds.min) and max is \(bounds.max)")

//: [Next](@next)
