import UIKit
import Darwin

var greeting = "Hello, playground"
// 制御構文
// 条件分岐
// if文　条件の成否による分岐
let value = 2
if value <= 3 {
    print("\(value)は3以下です")
}

// else節　条件不成立時の処理
//if 条件式 {
//    条件式がtrueの時に実行される文
//} else {
//    条件式がfalseの時に実行される文
//}
let value1 = 4
if value <= 3 {
    print("\(value)は3以下です")
} else {
    print("\(value)は3より大きいです")
}
// if else-if else文
//if 条件式1 {
//    条件式1がtrueの時に実行される文
//} else if 条件式2 {
//    条件式1がfalseかつ、条件式2がtrueの時に実行される文
//} else {
//    条件式1と条件式2の両方がfalseの時に実行される文
//}
let value2 = 2
if value2 < 0 {
    print("value2は0未満です")
} else if value2 <= 3 {
    print("value2は0以上3以下です")
} else {
    print("value2は3より大きいです")
}

// if-let文 値の有無による分岐
// Int?型の定数OptionalAに値が存在すれば、Int型の定数aに値が代入され、
// 続く{}内の文が実行される。
let optionalA = Optional(1)// let optionalA: Int? = 1と同じ
if let a = optionalA {
    print("値は\(a)です")
} else {
    print("値が存在しません。")
}

// 2つのString?型の定数optionalBとoptionalCのどちらにも値があった場合に、
// 続く{}内の文が実行される。
// ,で区切って複数のOptional<Wrapped>型の値を同時に取り出せる。
let optionalB = Optional("b")// let optionalB: String? = "b"と同じ
let optionalC = Optional("c")// let optionalC: String? = "c"と同じ
if let b = optionalB, let c = optionalC {
    print("値は\(b)と\(c)です")
} else {
    print("どちらかの値が存在しません")
}

// if-let文とas?演算子を組み合わせることで、型による条件分家を安全に行える。
// Any型の定数dのInt型へのダウンキャストが成功するため{}内の文が実行される。
// if-let文で宣言された定数は、{}内でのみ使用できる。
let d: Any = 1
if let int = d as? Int {
    print("値はInt型の\(int)です")
}
// 定数intはスコープ街では使用不可能なためエラー
// print(int)


// guard文　条件不成立時に早期退出する分岐
// guard　条件式 else {
//     条件式がfalseの場合に実行される文
//     条件式がtrueの場合は、{}内の実行をスキップする。
//     guard文が記述されているスコープの外に退出する必要がある。
//}
// Int型の定数valueは0未満となっているため、guard分の条件式が成立せず、
// else節内の文が実行される。
func someFunction() {
    let value = -1
    // 条件式value >= 0が不成立(false)のため、else節内の文が実行される。
    guard value >= 0 else {
        print("0未満の値です")
        return
    }
}
someFunction()

// guard文のスコープ外への退出の矯正
//func printIfPositive(_ a: Int) {
//    // Int型の引数aが0よりも大きくなければprintIfPositive関数から退出する。
//    // return = なにもしない。
//    guard a > 0 else {
//        return
//    }
//
//    // guard文以降では、a > 0が成り立つことが保証される。
//    print(a)
//}
//printIfPositive(-1)

//func printIfPositive1(_ a: Int) {
//    guard a > 0 else {
// else節でprintIfPositive1関数から退出していないためエラー
//    }
//
//    // guard文以降では、a > 0が成り立つことが保証される。
//    print(a)
//}
//printIfPositive1(1)

// guard文で宣言された変数や定数へのアクセス
// if-let文との違いは、guard-let文で宣言された変数や定数は、
// guard-let文以降でも利用可能という点。
// これは、条件式が満たされなかった場合には、スコープから退出するため、
// guard文以降では、変数や定数の存在が保証されているため。
func someFunction2() {
    let a: Any = 1

    guard let int = a as? Int else {
        print("aはInt型ではありません。")
        return
    }
    // ↑　guard文
    //　定数intはguard文以降でも使用可能
    print("値はInt型の\(int)です")
}
someFunction2()

// if文との使い分け
// 比較例として2つのInt?型の引数を受け取り、両方とも値を持っていればその和を返し、
// どちらが値を持っていなければnilを返すと同時に、
// print()で値を持っていない引数を出力するプログラムを実装する。
func add(_ optionalA: Int?, _ optionalB: Int?) -> Int? {
    // if文で実装する場合は、if-let文で宣言した定数は、{}外で使用できないため、
    // if-let文の外にInt型の定数aを宣言しておく必要がある。
    let a: Int
    if let unwrappedA = optionalA {
        // 引数を受け取り定数aに代入
        a = unwrappedA
    } else {
        // どちらが値を持っていなければnilを返すと同時に、
        // print()で値を持っていない引数を出力する
        print("第1引数に値が入っていません")
        return nil
    }

    let b: Int
    if let unwrappedB = optionalB {
        // 引数を受け取り定数bに代入
        b = unwrappedB
    } else {
        // どちらが値を持っていなければnilを返すと同時に、
        // print()で値を持っていない引数を出力する
        print("第2引数に値が入っていません")
        return nil
    }
    // 両方とも値を持っていればその和を返す
    return a + b
}

// guard文で実装する場合は、guard-let文で宣言した定数は、{}外でも使用できるため、
// guard-let文の外にInt型の定数を宣言しておく必要はない。
// 条件に応じて早期退出するコードは、guard文を使用して実装した方がシンプルになる。
add(Optional(1), Optional(2))
func add1(_ optionalA: Int?, _ optionalB: Int?) -> Int? {
    guard let a = optionalA else {
        print("第1引数に値が入っていません")
        return nil
    }

    guard let b = optionalB else {
        print("第2引数に値が入っていません")
        return nil
    }
    // 両方とも値を持っていればその和を返す
    return a + b
}
add(Optional(1), nil)

// switch文　複数のパターンマッチによる分岐
// 定数eに格納されているInt型の値が、負・0・正の場合のいずれかによって、3つに分岐する
let e = 1
switch e {
case Int.min..<0:
    print("eは負の値です")
case 1..<Int.max:
    print("eは正の値です")
default:
    print("eは0です")
}

// ケースの網羅性チェック
enum SomeEnum {
    case foo
    case bar
    case baz
}
//
let foo = SomeEnum.foo
// 制御式fooはSomeEnum型なので、取り得る値は、.foo,.bar.baz。
// swithc文の3つのケースのうちお、1つでも削除してしまうと、
// switch文が網羅的ではなくなり、 エラーとなる。
switch foo {
case .foo:
    print(".foo")
case .bar:
    print(".bar")
case .baz:
    print(".baz")
}
// Bool型の場合は、次のようにtrueとfalseの両方を記述する必要がある。
// どちらかを削除してしまうと、網羅的ではなくなりエラーとなる。
let g = true
switch g {
case true:
    print("true")
case false:
    print("false")
}

// defaultキーワード　デフォルトケースによる網羅性の保証
// .bazにマッチした場合の処理は記述されていないため、デフォールとケースが実行される。
enum SomeEnum1 {
    case foo
    case bar
    case baz
}
//
let baz = SomeEnum1.baz
switch baz {
case .foo:
    print(".foo")
case .bar:
    print(".bar")
default:
    // .bazの場合は、このケースに入るため網羅的となる。
    print("Default")
}

// whereキーワード　ケースにマッチする条件の追加
//switch 制御式 {
//case パターン where 条件式:
//    制御式がパターンにマッチし、かつ、条件式を満たす場合に実行される文
//default:
//    制御式がいずれのパターンにもマッチしなかった場合に実行される文
//}
// 定数optionalDは値を持っているため、.some(let a)の部分はマッチするが、
// where a > 10という条件は満たさないので、デフォルトケースの処理が実行される。
let optionalD: Int? = 1

switch optionalD {
case .some(let a) where a > 10 :
    print("10より大きい値\(a)が存在します")
default:
    print("値が存在しない、もしくは10以下です")
}

// break文　ケースの実行の中断
// マッチするケースcase 1:ないに2つのprint関数が書かれているが、
// 2つ目のprint関数の前にbreak文が書かれているので、2つ目のprint関数は実行されない。
let h = 1
switch h {
case 1:
    print("実行される")
    break
    print("実行されない")
default:
    break
}

// ラベル　break文の制御対象の指定
// 定数value3のAny型の値が1~10までの値であれば、その値が奇数か偶数かを出力するプログラム。
let value3 = 0 as Any
outerSwitch: switch value3{
case let int as Int :
    let description: String
    switch int {
    case 1, 3, 5, 7, 9:
        description = "奇数"
    case 2, 4, 6, 8, 10:
        description = "偶数"
    default:
        print("対象外の値です")
        break outerSwitch
    }// switch int{}
    print("値は\(description)です")
default:
    print("対象外の型の値です")
}

// fallthrough文　switch文の次のケースへの制御の移動
// マッチするケースcase 1: の末尾にあるfallthrough文によって、
// 実行が次のケースcase 2:に移る。つまり、case 1:とcase 2:の2つが実行される。
// fallthrough文を記述しないと、このような挙動にはならない。
let i = 1
switch i {
case 1:
    print("case 1")
    fallthrough// case 2も実行する
case 2:
    print("case 2")
default:
    print("default")
}


// 繰り返し
// for-in文　シーケンスの要素の列挙
// Array<Element>型の要素をfor-in文で列挙
let array = [1, 2, 3]
for element in array {
    print(element)
}

// Dictionary<Key, Value>型の要素をfor-in文で列挙
let dictionary = ["a": 1, "b": 2]
//(key, value) = (String, Int)型
for (key, value) in dictionary {
    print("Key: \(key), Value: \(value)")
}

// while文　継続条件による繰り返し
// while文の場合は実行前に条件式を評価するため、一度も処理が行われない可能性がある。
var j = 1
while j < 4 {
    // 条件式j < 4が成立しなくなると繰り返しが止まるので、1,2,3が出力される
    print(j)
    j += 1
}

// repeat-while文　初回実行を保証する繰り返し
// while文の場合は実行前に条件式k < 1を評価するため、一度も処理が行われない
var k = 1
while k < 1 {
    print(k)
    k += 1
}

// repeat-while文の場合は実行後に条件式l < 1を評価するため、一度だけ処理が行われる
var l = 1
repeat {
    print(l)
    l += 1
} while l < 1// 条件式l < 1は最初から成り立っていない。

//　実行後の中断
// break文　繰り返しの終了　実行文を中断し、繰り返し文全体を終了させる。
// 配列array1の中に2が含まれているかを検査するプログラム。
// 2が見つかった時点で後続の繰り返しを行う必要はないので、break文で繰り返し文全体を終了。
var containsTwo = false
let array1 = [1, 2, 3]
for element in array1 {
    if element == 2 {
        containsTwo = true
        break// 2が見つかった時点で処理を中断
    }
    print("element: \(element)")
}
print("containsTwo: \(containsTwo)")

// continue文　繰り返しの継続
// 配列の要素をあたいが奇数の場合は、変数oddsに追加し、
// 偶数の場合は、標準出力に出力する。
// break文とは異なり、中断したとしても、後続の繰り返しは継続され、
// 全ての要素に対して、処理が行われている。
var odds = [Int]()
let array2 = [1, 2, 3, 4, 5, 6]
for element in array2 {
    if element % 2 == 1 {
        // 変数oddsに追加し、continue文で処理を中断するため、奇数の要素は出力されない。
        odds.append(element)
        continue
    }
    print("even: \(element)")// 偶数を出力
}
print("odds: \(odds)")// 奇数を出力

// ラベル　break文やcontinue文の制御対象の指定
// 初回の実行で外側の繰り返し分が終了するプログラム
label: for element in [1, 2, 3] {
    for nestedElement in [1, 2, 3] {
        print("element: \(element), nestedElement: \(nestedElement)")
        break label// 繰り返し全体を終了
    }
}

// 遅延実行 特定の文をそれが記述されている箇所よりも後で実行することを指す。
// defer文　スコープ退出時の処理
var count = 0
func someFunction3() -> Int {
    defer {
        count += 1
    }
    return count
}
// 値の更新は関数の実行の終了後に行われるため、関数呼び出しの時点では変数countの値は0のまま
someFunction3()
// 関数実行後に変数countにアクセスすると、値の更新が確認できる。
count


// パターンマッチ　値の構造や性質による評価
// 式パターン　~=演算子による評価
// 6~= integerがfalseを返し、5...10~= integerがtrueを返すため、
// 式パターン5...10にマッチしている
let integer = 1
switch integer {
case 6:
    print("mathc: 6")
case 5...10:
    print("match: 5...10")
default:
    print("default")
}

// バリューバインディングパターン　値の代入を伴う評価
// 識別子パターンとバリューバインディングパターンを組み合わせて、
// マッチした値4をmathedValueに代入している。
let value4 = 4
switch value4 {
case let mathedValue:
    print(mathedValue)
}

// オプショナルパターン　Optional<Wrapped>型の値の有無を評価
// オプショナルパターンとバリューバインディングパターンを組み合わせることにより、
// Int?型の評価式からInt型の値を取り出し、定数mに値を代入する。
let optionalE = Optional(4)
switch optionalE {
case let a?:
    print(a)
    type(of: a)
default:
    print("nil")
}

// 列挙型ケースパターン　ケースとの一致の評価
// 半休を表すHemisphere型を定義し、北半球はnorthern、南半球はsouthernとして表現。
// 定数hemisphereの値は、northernであるためcase .southern:にマッチしている。
enum Hemisphere {
    case northern
    case southern
}

let hemisphere = Hemisphere.northern

switch hemisphere {
case .northern:
    print("match: .northern")
case .southern:
    print("match: .southern")
}

// is演算子による型キャスティングパターン　型の判定による評価
// is演算子による型キャスティングパターンは
// is 型名と書き、is演算子による評価結果がtrueであればマッチする。

let any: Any = "1"
switch any {
case is String:
    print("match: String")
    //fallthrough// fallthrough文を書くと、case is Intもまっちするようにできる。
case is Int:// 定数anyはInt型にダウンキャスト可能なため、パターンis Intにマッチする。
    print("match: Int")
default:
    print("default")
}

// as演算子による型キャスティングパターン　型の判定による評価
// as演算子による型キャスティングパターンは
// as 型名と書き、パターンの式が、ダウンキャストに成功した場合にマッチする。
let any1: Any = 1
switch any1 {
case let string as String:
    print("match: String(\(string))")
// 定数any1はInt型にダウンキャスト可能なため、パターンlet int as Intにマッチする。
case let int as Int:
    // 定数intはInt型へのダウンキャスト後の値であるため、実行文ではInt型として扱える。
    print("match: Int(\(int))")
default:
    print("default")
}


// パターンマッチが使える場所
// if文
// 書式
//if case パターン = 制御式 {
//    制御式がパターンにマッチした場合に実行される文
//}
// Int型の値が1以上10以下のであれば処理を実行する
let value5 = 9
if case 1...10 = value5 {
    print("1以上10以下の値です")
}

// gurad文
// 書式
//guard case パターン = 制御式 {
//    パターンにマッチしなかった場合に実行される文
//    guard文が記述されているスコープの外に退出する必要がある。
//}

func someFunction4(int: Int) {
    guard case 1...10 = int else {
        return//パターンにマッチしなかった場合には何もしない。
    }
    print("1以上10以下の値です")// 1...10の値の場合に出力する。
}
someFunction4(int: 9)

// for-in文
// 書式
//for case パターン in 値の連続 {
//    要素がパターンにマッチした場合にのみ実行される文
//}
// パターン2...3で評価し、要素が2以上3以下の値の場合にのみ{}内の文を実行。
let array3 = [1, 2, 3, 4]
for case 2..<3 in array3 {
    print("2以上3以下の値です")
}

// while文
// 書式
// while case パターン = 制御式{
//    制御式がパターンにマッチする間は繰り返し実行される文
//}
// Int?型の値nextValueをオプショナルパターンで評価し、
// 定数nextValueがnilにならない間は処理を繰り返す。
var nextValue = Optional(1)
while case let value? = nextValue {
    print("value: \(value)")
    // valueが3以上になった場合に、nextValueをnilにして、処理を終了
    if value >= 3 {
        nextValue = nil
    } else {
        // valueが3以下の間、nextValueに1を足して処理を繰り返す。
        nextValue = value + 1
    }
}
