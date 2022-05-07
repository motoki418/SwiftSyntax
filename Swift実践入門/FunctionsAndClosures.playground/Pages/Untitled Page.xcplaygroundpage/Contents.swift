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
let add = { (x: Int, y: Int) -> Int in// (Int, Int) -> Int型
    return x + y
}
add(2, 3)
