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

// オプショナルのタプルの戻り値の型(Optional Tuple Return Types)
// 空の配列を安全に処理するには、オプショナルのタプルの戻り値の型を指定して、
// 配列が空の場合は nil を返します。
func optinalMinMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
// オプショナルバインディングを使用して、optinalMinMax(array:) 関数が、実際のタプル値を返すかnilを返すかを確認できます。
if let bounds = optinalMinMax(array:  [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// NOTE
// (Int, Int)? などの オプショナルのタプル型は (Int?, Int?)などの オプショナルの型を含むタプルとは異なります。
// オプショナルの型を使用すると、タプル内の個々の値だけでなく、タプル全体が オプショナルになります。


// 暗黙的な戻り値がある関数(Functions With an Implicit Return)
// 関数の本文全体が、単一式の場合は、関数は暗黙的にその式の結果を返します。
// 下記のgreeting関数とanotherGreeting関数の動作は同じです
func greeting(for person: String) -> String {
    "Hello," + person + "!"
}
greeting(for: "Dave")

func anotherGreeting(for person: String) -> String {
    return "Hello," + person + "!"
}
anotherGreeting(for: "Dave")

// 引数ラベルとパラメータ名
func someFunction(firtsParamaterName: Int, secondParamaterName: Int) {
    //関数の本文では、`firstParameterName`と`secondParameterName`は
    // 最初と 2 番目のパラメータの値を参照します。
    print("\(firtsParamaterName) \(secondParamaterName)")
}

someFunction(firtsParamaterName: 1, secondParamaterName: 3)

// 引数ラベルの特定
// 引数名の前に、スペースで区切って引数ラベルを記述します。
// 引数名を実行時に利用する「引数ラベル」と
// 関数内で利用する「入力パラメータ」の2つに分けて設定できる。
// argumentLabelが引数ラベル、parameterNameが入力パラメータ
func someFunction1(argumentLabel parameterName: Int) {
    // 関数の本文では、`parameterName` でパラメータの値を参照します
}

// 人の名前と出身地を受け取って挨拶を返す greet(person:) 関数
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)."
}
greet(person: "Bill", from: "Cupertino")

// 引数ラベルの省略(Omitting Argument Labels)
// 引数ラベルが必要ない場合は、その引数ラベルの代わりにアンダースコア(_)を記述します。
func someFunction2(_ firstParamaterName: Int, secondParameterName: Int) {
    firstParamaterName + secondParameterName
}
someFunction2(1, secondParameterName: 4)

// デフォルトパラメータ値(Default Parameter Values)
// パラメータの型の後に値を代入することで、関数内の任意のパラメータのデフォルト値を定義できます。
// デフォルト値が定義されている場合は、関数を呼び出すときにそのパラメータを省略できます。
func defaultParameterFunction(parameterWithoutDefault: Int, parameterWithDeafault: Int = 12) {
    // 関数を呼び出すときに 2 番目のパラメータを省略した場合、
    // parameterWithDefault` の値は 12 になります。
    print(parameterWithoutDefault + parameterWithDeafault)
}
// `parameterWithDefault` は 6
defaultParameterFunction(parameterWithoutDefault: 3, parameterWithDeafault: 6)
// `parameterWithDefault` は 12
defaultParameterFunction(parameterWithoutDefault: 3)

// 可変長パラメータ(Variadic Parameters)
// 。可変長パラメータを使用すると、関数が呼び出されたときに、パラメータに様々な数の入力値を渡すことができます。
// パラメータの型名の後に3つのピリオド文字(...)を挿入して、可変長パラメータを記述します。
// 可変長パラメータに渡された値は、適切な型の配列として関数の本文内で使用できるようになります。
// 例えば、numbers という Double... 型を持つ可変長パラメータは、
// numbers という [Double] 型の定数配列として関数の本文内で使用できます。
// 任意の長さの数値のリストの算術平均(いわゆる平均)を計算しています。
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
// // 5 つの数値の平均の 3.0 を返します
arithmeticMean(1, 2, 3, 4, 5)
// 3 つの数値の平均の 10.0 を返します
arithmeticMean(3, 8,23, 18,75)

// In-Out パラメータ(In-Out Parameters)
// 関数のパラメータはデフォルトで定数です。
//関数でパラメータの値を変更する必要があり、関数呼び出しが終了した後もそれらの変更を保持したい場合は、
// 代わりに in-out パラメータとして定義します。
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    // someIntに代入されている3を一時的な定数temporaryAに代入
    let temporaryA = a
    // anotherIntに代入されている107をsomeIntに代入
    a = b
    // temporaryAに代入されている3をanotherIntに代入
    b = temporaryA
    // 最終的にsomeIntとanotherIntにだ隠喩されている値が逆になる
}

var someInt = 3
var anotherInt = 107
// 変数を in-out パラメータとして渡すときは、変数名の直前にアンパサンド(&)を付けて、
// 関数で値が変更される可能性があることを示します。
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), ane anotherInt is now \(anotherInt)")

// 関数型(Function Types)
// 全ての関数には特定の関数型があり、パラメータの型と戻り値の型で構成されています。
//これらの関数の両方の型は、(Int, Int) -> Int で、
// 「両方ともInt型の2つの値を受け取り、Int型の値を返す関数です」と読む事ができます。


func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

// 関数型の使用(Using Function Types)
// 「2つのInt値を取り、Int値を返す関数の型を持つmathFunction という変数を定義します。この新しい変数が、addTwoInts という関数を参照するように設定します」
var mathFunction: (Int, Int) -> Int  =  addTwoInts
// 代入した関数addTwoIntsをmathFunction という変数名で呼び出すことができます。
print("Result:\(mathFunction(2, 3))")
// 代入した関数multiplyTwoIntsをmathFunction という変数名で呼び出すことができます。
mathFunction = multiplyTwoInts
print("Result:\(mathFunction(2, 3))")
// 他の型と同様に、定数または変数に関数を代入するときに、関数型を推論することができます。
let anotherMathFunction = addTwoInts
type(of: anotherMathFunction)
print("Result:\(mathFunction(10, 5))")

// パラメータの型としての関数型(Function Types as Parameter Types)
func printMathResult(_ mathFunction: (Int, Int) -> Int,  _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

// ネスト関数(Nested Functions)
// currentValue という変数を徐々にゼロに近づけるために正または負のステップが必要かどうかを判断します。
// currentValue の初期値は -4 です。これは、currentValue > 0 が true を返し、
// chooseStepFunction(backward:) が stepBackward(_:) 関数を返すことを意味します。
// 返された関数への参照は、moveNearerToZero という定数に格納されます。

// moveNearerToZeroが適切な関数を参照しているので、ゼロまでカウントできます
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1}
    func stepBackward(input: Int) -> Int { return input - 1}
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
//: [Next](@next)
