import UIKit
import os
import Darwin

var greeting = "Hello, playground"
// 関数　名前を持ったひとまとまりの処理
// Int型の引数を1つ取り、それを2倍にしたInt型の戻り値を返す、
// (Int) -> Int型のdouble(_:)関数を定義して実行する。
func double(_ x: Int) -> Int {
    return x * 2
}
double(2)// double(2)全体が戻り値

// 戻り値が不要な場合は、_への代入によって明示的に戻り値を無視することで、
// 警告を抑制できる。
func functionWithDiscardableResult() -> String {
    return "Discardable"
}
_ = functionWithDiscardableResult()
// もしくは、戻り値の使用が必須でない関数にdiscardableResult属性を、
// 付与することでも警告を抑制できる。
@discardableResult
func functionWithDiscardableResult1() -> String {
    return "Discardable"
}
functionWithDiscardableResult1()

// 引数　関数への入力を表す
// 仮引数と実引数
func printInt(_ int: Int) {// intが仮引数 = 定義時に宣言する引数
    print(int)
}
printInt(1)// 1が実引数 = 関数呼び出し時に指定する引数

// 外部引数名と内部引数名
// 分けるには、外部引数名　内部引数名: 型という形式で引数を定義する
// 第2引数のtoが外部引数名、groupが外部引数名
func invite(user: String, to group: String) {
    // 関数の中では、内部引数名(group)を使用する
    print("\(user) is invited to \(group)")
}
// 関数呼出時には、外部引数名(to)を使用する
invite(user: "Ishikawa", to: "Soccer Club")

// 外部引数名の省略
func sum(_ int: Int, _ int2: Int) -> Int {
    return int + int2
}
sum(3, 4)

// デフォルト引数　引数のデフォルト値
// 引数宣言の後に、= とデフォルト値を追加する
func greet(user: String = "Anonymous") {
    print("Hello, \(user)!")
}
greet()// 引数を省略できる。
// デフォルト値引数が用意されていても、引数を渡すこともできる。
greet(user: "Nakamura")
func number(int: Int = 1, int2: Int = 3) {
    print("\(int + int2)")
}
number()// 引数を省略できる。
// デフォルト値引数が用意されていても、引数を渡すこともできる。
number(int: 1, int2: 3)
// 検索ワードをだけを引数に渡すことで関数を使える。
func search(byQuery: String, sortKey: String = "id", ascending: Bool = false) -> [Int] {
    return [1, 2, 3]
}
// 非数でない引数には、値を設定しなくとも呼び出すことができる。
search(byQuery: "query")

// インアウト関数　関数外に変更を共有する引数
func greet1(user: inout String) {
    if user.isEmpty {
        // 変数userに代入
        user = "Anonymous"
    }
    print("Hello: \(user)")
}
var user: String = ""// この時点では殻文字が代入されている。
// inout引数を使用しているので、関数実行後には変数userに"Anonymous"が代入される。
greet1(user: &user)

// 可変長引数　任意の個数の値を受け取る引数
// 可変長引数を定義するには、引数定義の末尾に...を加える。
func print(strings: String...) {
    if strings.count == 0 {
        return
    }

    // 可変長引数として受け取った引数stringsは、関数内部では[String]型として扱われる。
    // 最初の要素
    print("first: \(strings[0])")
    // strings配列の要素に順次アクセス。
    for string in strings {
        print("element: \(string)")
    }
}
// 可変長引数を定義した関数には、複数の引数を渡すことができる。
print(strings: "abc", "def", "ghi")

// コンパイラによる引数チェック
func string(from: Int) -> String {
    return "\(int)"
}
let int = 1
let double = 1.0
let string1 = string(from: int)// 引数fromの型と一致するのでOK
//let string2 = string(from: double)// 引数fromの型と一致しないのでエラー
// Double型の定数doubleをInt型に変換し、引数fromの方と一致するのでOK
let string2 = string(from: Int(double))

// 戻り値　関数の出力を表す値のこと
// 戻り値の型の定義を省略した関数
func greet2(user: String) {
    print("Hello: \(user)!")
}
greet2(user: "Nakamura")
// 戻り値の型の定義を省略した場合、戻り値はVoid型となるため、
// 関数greet2(user: String)を定義した場合と同様になる。
func greet3(user: String) -> Void {
    print("Hello: \(user)!")
}
greet2(user: "Nakamura")

// 暗黙的なreturn
func makeMessage(toUser user: String) -> String {
    // 暗黙的なreturnが有効となるのは、関数の実装が戻り値の返却のみの場合。
    "Hello: \(user)"
}
//makeMessage(toUser: "Nakamura")
//func makeMessage1(toUser user: String) -> String {
//     print(user)
//     "Hello: \(user)"// 戻り値を返却する式として認識されなくなる。returnが必要
//}

// クロージャ　スコープ内の変数や定数を保持したひとまとまりの処理
// Int型の引数を1つ取り、それを2倍にしたInt型の戻り値を返す、
// (Int) -> Int型のクロージャを定義して実行。
let double1 = { (x: Int) -> Int in// (Int) -> Int型
    return x * 2
}
double1(2)
type(of: double1)
// クロージャの方は通常の方と同じように扱えるので、
// 変数や関数の引数の型として利用することもできる。
let closure: (Int) -> Int
func someFunction4(x: (Int) -> Int) {}

// 型推論
//  (String) -> Int型の変数
// 変数closure1の型は(String) -> Intと明確に決まっているため、
// 変数に代入するクロージャの型も(String) -> Int型であると推論できるため、
// 変数closure1に代入する引数と戻り値の型は省略することが出来る。
var closure1: (String) -> Int

// 引数と戻り値の型を明示した場合
closure1 = { (string: String) -> Int in// (String) -> Int型
    return string.count
}
closure1("abc")

// 引数と戻り値の方を省略した場合
closure1 = { string in
    return string.count * 2
}
closure1("abc")
type(of: closure1)

// 実行方法
// 関数と同じでクロージャが代入されている変数名や定数名の末尾に()をつけ、
// ()内に引数を,区切りで並べる。
// (string(引数名): String(型)) -> Int(戻り値の型)
// in キーワードの後ろが実行される文
let lengthOfString = { (string: String) -> Int in // (String) -> Int型
    return string.count// 要素をカウントする
}
// 定数lengthOfStringは型推論で(String) -> Int型と推論される。
lengthOfString("I contain 23 characters")
type(of: lengthOfString)

// 引数
// 引数名を省略して(2, 3)のように呼び出す。
// クロージャ式では、内部引数名のみ指定でき、外部引数名は指定できない。
// なので関数で外部引数名を_に指定しているのと同じ状態になる。
let add = { (x: Int, y: Int) -> Int in// (Int, Int) -> Int型
    return x + y
}
add(2, 3)// 引数名を省略している。

// クロージャ式の定義ではデフォルト引数を指定できない
//let greet = { (user: String = "Anonymous") -> Void in
//    print("Hello, \(user)")
//}

// 簡略引数名　引数名の省略
// 2つのInt型の引数をとってBool型の値を返すクロージャの引数に、簡略引数名を使用してアクセス
// 簡略引数名は、$に引数のインデックスをつけた$0や$1となる。
let isEqual: (Int, Int) -> Bool = {
    return $0 == $1//$0が1つ目のInt型の引数、$1が2つ目のInt型の引数を表す。
}
isEqual(1, 1)

// isEqual1の型が決まらないためエラーになる。
//let isEqual1 = {
//    return $0 == $1
//}
//isEqual1(1, 1)

// 2つのInt型の引数をとってInt型の値を返すクロージャの引数に、簡略引数名を使用してアクセス
let sum1: (Int, Int) -> Int = {
    return $0 + $1//$0が1つ目のInt型の引数、$1が2つ目のInt型の引数を表す。
}
sum1(1, 4)

let string3: (String, String) -> String = {
    return $0 + $1
}
string3("Hello, ", "Nakamura!")

// 条件を満たす要素だけを含む配列を返すfilter(_:)メソッドを使用して要素を抽出
// filterメソッドの引数には条件をクロージャとして与える。
// ここでは、$0が元の配列の要素を示していることが明らかである。
let numbers = [10, 20, 30, 40]
// $0がnumbers配列の10を表している。
let moreThanTwenty = numbers.filter { $0 > 20 }
moreThanTwenty

// 戻り値
// 関数と同様に戻り値がないクロージャを定義することもできる。
let emptyReturnValueClosure: () -> Void = {}

// １つの戻り値を持つクロージャ
let singleReturnValueClosure: () -> Int  = {
    return 1
}
singleReturnValueClosure()

// クロージャによる変数と定数のキャプチャ
// クロージャが自身が定義されたスコープの変数や定数への参照を保持する機能をキャプチャという。
let greeting1: (String) -> String
// doキーワードを用いて、新たなローカルスコープを作成。
// 新しいスコープを作成するという用途で単独で使用することもできる
do {
    let symbol = "!"
    greeting1 = { user in
        return "Hello,\(user)\(symbol)"
    }
}
greeting1("Nakamura")
// symbol// 別のスコープ(do{}内)で定義されているためエラー

// 定数counterに代入されたクロージャは、実行するたびにcountの値を1増やす
let counter: () -> Int
do {
    var count = 0
    counter = {
        count += 1
        return count
    }
}
counter()// 実行するたびにcountの値を1増やす
counter()

// 引数としてのクロージャ
// クロージャを関数や別のクロージャの引数として利用する場合にのみ有効な仕様として、
// 属性 = クロージャに対して指定する追加情報と
// トレイリングクロージャ = クロージャを引数に取る関数の可読性を高めるための仕様がある。

// 属性の指定方法
// 属性は、クロージャの型の前に@ 属性名を追加して指定する。
// 属性にはescaping属性とautoclousure属性の2つがある。
//func 関数名(引数名: @属性名 クロージャの型名) {
//    関数呼び出し時に実行される文
//}
// 第二引数の型は、autoclosure属性が指定されたクロージャになっている。
func or(_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        return true
    } else {
        return rhs()
    }
}
or(false, false)

// escaping属性　非同期的に実行されるクロージャ
// escaping属性は、関数に引数として渡されたクロージャが、
// 関数のスコープ外で保持される可能性があることを示す属性。

// 引数として与えられたクロージャを配列queueに追加する。つまり、この引数のクロージャは、
// 関数のスコープ外で保持されるため、引数にはescaping属性を指定する必要がある。
var queue = [() -> Void]()

func enqueue(operation: @escaping () -> Void) {
    queue.append(operation)// 配列queueに追加
}
enqueue { print("executed") }
enqueue { print("executed") }
queue.forEach { $0() }
// 関数のスコープ内のみで、実行されるクロージャにはescaping属性はしてしなくても良い。
func executeTwice(operation: () -> Void) {
    operation()// クロージャを実行
    operation()// クロージャを実行
}
executeTwice { print("excuted") }

// autoclosure属性　クロージャを用いた遅延評価
// autoclosure属性は引数をクロージャで包むことで、遅延評価を実現するための属性。

// Bool型の引数を2つ取り、その論理話を返すor1(_:_:)関数
// 論理和を求める||演算子と同じ挙動をする関数
func or1(_ lhs: Bool, _ rhs: Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        print(rhs)
        return rhs
    }
}
or(false, true)

// Bool型の引数を2つ取り、その論理話を返すor2(_:_:)関数
// 論理和を求める||演算子と同じ挙動をする関数
// 第一引数のlhsにはlhs()関数の戻り値を、第二引数のrhsにはrhs()関数の戻り値を渡す。
func or2(_ lhs: Bool, _ rhs: Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        print(rhs)
        return rhs
    }
}
func lhs() -> Bool {
    print("lhs()関数が実行されました")
    return true
}
func rhs() -> Bool {
    print("rhs()関数が実行されました")
    return false
}
// lhs()関数とrhs()関数の両方が実行されている事が分かる。
or2(lhs(), rhs())

// Bool型の引数を2つ取り、その論理話を返すor3(_:_:)関数
// 論理和を求める||演算子と同じ挙動をする関数
// or2()関数では、第2引数は実行される必要がない
// 第1関数がtrueであると分かった時点で第2引数を実行する事なく、trueと決定できるから。
// or3()関数の第2引数をクロージャにする事で、必要になるまで評価を遅らせ第2引数を実行しない。
func or3(_ lhs: Bool, _ rhs: () -> Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        let rhs = rhs()
        print(rhs)
        return rhs
    }
}
func lhs3() -> Bool {
    print("lhs()関数が実行されました")
    return true
}
func rhs3() -> Bool {// 必要になるまで実行されない。
    print("rhs()関数が実行されました")
    return false
}
or3(lhs3(), { return rhs3() })

// Bool型の引数を2つ取り、その論理話を返すor4(_:_:)関数
// 論理和を求める||演算子と同じ挙動をする関数
// or3()関数のように書くと遅延評価ができるが、呼出側が複雑になるというデメリットがある。
// autoclosure属性は、引数をクロージャで包むという処理を暗黙的に行うため、
// 関数外からは簡単に利用でき、関数内では、or3()関数のように遅延評価を行える。
func or4(_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        let rhs = rhs()
        print(rhs)
        return rhs
    }
}
func lhs4() -> Bool {
    print("lhs()関数が実行されました")
    return true
}
func rhs4() -> Bool {// 必要になるまで実行されない。
    print("rhs()関数が実行されました")
    return false
}
or4(lhs4(), rhs4())// autoclosure属性を利用すれば遅延評価を簡単に実現できる。

//トレイリングクロージャ　引数のクロージャを()の外に記述する記法
// 関数の最後の引数がクロージャの場合に、クロージャを()の外に書く事ができる記法。

func execute(parameter: Int, handler: (String) -> Void) {
    handler("parameter is \(parameter)")
}
// トレイリングクロージャを使用しない場合
// 関数呼び出しの()がクロージャのあとまで広がるため、読みづらくなる。
execute(parameter: 1, handler: { string in
    print(string)
})

// トレイリングクロージャを使用した場合
// 関数呼び出しの()がクロージャの定義の前で閉じるため読みやすい。
execute(parameter: 2) { string in
    print(string)
}
// 引数が1つのクロージャのみの関数に対してもトレイリングクロージャを使用する場合、
// 関数呼び出しの()も省略出来る。
func execute1(handler: (String) -> Void) {
    handler("executed.")
}
execute1{ string in
    print(string)
}

// クロージャとしての関数
// 関数はクロージャの一種であるため、クロージャとして扱える。
// (Int) -> Int型の関数double(_:)を定数functionに代入する。
// 代入された定数functionの型は、(Int) -> Int型と推論される。
func double1(_ x: Int) -> Int {
    return x * 2
}
let function = double1// (Int) -> Int型
function(3)

// 関数の引数となるクロージャを関数として定義しない場合には、map(_:)メソッドの引数として、
// { $0 * 2 }という重複したクロージャを2回使用している。
let array1 = [1, 2, 3]
let doubledArray1 = array1.map { $0 * 2 }//$0はarray1内の1を表している。
doubledArray1

let array2 = [4, 5, 6]
let doubledArray2 = array2.map { $0 * 2 }
doubledArray2

// 関数をクロージャとして扱う事で、上記の例で重複していた{ $0 * 2 }というクロージャを、
// 一箇所にまとめる事ができる。
func double2(_ x: Int) -> Int {
    return x * 2
}

let array3 = [1, 2, 3]
let doubledArray3 = array3.map(double2)//double2という関数を呼び出せる

let array4 = [4, 5, 6]
let doubledArray4 = array4.map(double2)

// クロージャ式を利用した変数や定数の初期化
// 3 x 3のマス目を表現する方を実装するとする。
// 2次元配列でマスをモデル化し、各マスの値をリテラルで直接定義している。
var board = [[1, 1, 1],[1, 1, 1],[1, 1, 1]]
board

// 1が3つ入った行を3つ生成する事で、3 X 3のマス目を生成する。
// しかし、これでは変数の初期化の式を1つにまとめるために、Array<Element>型の精製の式を、
// 入れ子にしたため、構造を把握するのが難しくなった。
var board1 = Array(repeating: Array(repeating: 1, count: 3), count: 3)
board1

// クロージャ式を用いると一連の初期化の手続の実装を1つの式とする事ができる。
// このようにクロージャ式を利用すると、変数や定位数の初期化処理が複雑であっても、
// その初期値がどのように生成されるのかが把握しやすくなる。
var board2: [[Int]] = {
    // 1辺のマス目の数
    let sideLength = 3
    // 行数
    let row = Array(repeating: 1, count: sideLength)
    // 3 X 3のマス目を生成
    let board = Array(repeating: row, count: sideLength)
    return board
}()
board2
