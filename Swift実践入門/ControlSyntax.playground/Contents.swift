import UIKit

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
// Any型の定数aのInt型へのダウンキャストが成功するため{}内の文が実行される。
// if-let文で宣言された定数は、{}内でのみ使用できる。
let a: Any = 1
if let int = a as? Int {
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
// 定数a2に格納されているInt型の値が、負・0・正の場合のいずれかによって、3つに分岐する
let a2 = 1
switch a2 {
case Int.min..<0:
    print("aは負の値です")
case 1..<Int.max:
    print("aは正の値です")
default:
    print("aは0です")
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
let a3 = true
switch a3 {
case true:
    print("true")
case false:
    print("false")
}

// defaultキーワード　デフォルトケースによる網羅性の保証
// .bazにマッチした場合の処理は記述されていないため、でフォールとケースが実行される。
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
