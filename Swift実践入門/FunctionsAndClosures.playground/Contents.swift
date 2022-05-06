import UIKit

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

// コンパイラによる戻り値チェック
