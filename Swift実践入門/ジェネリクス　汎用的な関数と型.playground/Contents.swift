import UIKit
import Foundation 

var greeting = "Hello, playground"

// ジェネリクス　汎用的な関数と型
// Generic = 汎用

// 汎用的なプログラム
// 「1 == 1の結果を返す関数」が行なっているのは特定の値同士の比較
func isEqual() -> Bool {
    return 1 == 1
}
// 「xとyという任意の引数を取り、x==yを返す関数」は任意の整数同士を比較する汎用的な関数
func isEqual1(_ x: Int, _ y: Int) -> Bool {
    return x == y
}
isEqual()
isEqual1(1, 1)
// isEqual()とisEqual1()関数が汎用的であるのは、あくまで整数同士の比較においてのみ。
// 他の方同士の比較を行うには、型ごとに同様の関数をオーバーロードする必要がある。
func isEqual1(_ x: Float, _ y: Float) -> Bool {
    return x == y
}
isEqual1(1.1, 1.1)

// ジェネリクスを利用すれば、複数の型の間においても汎用的な処理を実装できる。
// <T: Equatable>は「Equatableプロトコルに準拠したあらゆる型」という意味がある。
// String,Int,Float,Double,Boolといった方は全てEquatableプロトコルに準拠している
func isEqual2<T: Equatable>(_ x: T, _ y: T) -> Bool {
    return x == y
}
isEqual2("abc", "def")// String型の比較
isEqual2(1, 1)// Int型の比較
isEqual2(Double(1.1), Double(1.1))// Double型の比較
isEqual2(Float(11.1), Float(10.2))// Float型の比較
isEqual2(false, false)// Bool型の比較

// ジェネリクスの基本
// 定義方法
// func　関数名<型引数>(引数名: 型低数) -> 戻り値の型
func someFunction<T, U>(x: T, y: U) -> U {
    // 関数呼び出し時に実行される文
    let _: T = x// 型アノテーションとして使用
    let _ = x// 型推論に対応
    let _ = 1 as? T// 型のキャストに使用
    return y
}

// 特殊化方法
// ジェネリクスを使用して汎用的に定義されたものに対して、
// 具体的な型引数を与えて型を確定させることを「特殊化」と言う。具体的な型を決めること。
// 例: Container<Content> -> Container<String>, Container<Int>
// Contentは型引数 抽象的な型
struct Container<Content> {
    let content: Content
}

// 型引数<Content>がString型であることを明示して特殊化する
let stringContainer = Container<String>(content: "abc")
type(of: stringContainer)

// 型引数<Content>を型推論して特殊化する
let intContainer = Container(content: 1)
type(of: intContainer)

// 汎用性と型安全性の両立
// 引数をそのまま戻り値とするidentiry(_:)関数
// 引数の型を型引数Tとして受け取り、戻り値を同じT型で返す。
// 同じT型として表現された引数の型と、戻り値の型が同じである事が保証されている。
func identity<T>(_ argment: T) -> T {
    return argment
}
// 引数をInt型で渡せばInt型が戻り値となる。
let int = identity(1)
// 引数をString型で渡せばString型が戻り値となる。
let string = identity("abc")

// Any型との比較
// ジェネリクスを使った関数
func identiryWithGenericValue<T>(_ argment: T) -> T {
    return argment
}
let genericInt = identiryWithGenericValue(1)
type(of: genericInt)
let genericString = identiryWithGenericValue("abc")
type(of: genericString)

// Anyを使った関数
func identityWithAnyValue(_ argment: Any) -> Any {
    return argment
}
// Any型を使った関数の戻り値は常にAny型になる。実際の型の情報は失われることになる。
let anyInt = identityWithAnyValue(1)// Int型を引数として渡してもAny型になる。
type(of: anyInt)
// String型を引数として渡してもAny型になる。
let anyString = identityWithAnyValue("abc")
type(of: anyString)

if let castInt = anyInt as? Int {
    // ここでようやくInt型として扱えるようになる
    print("anyInt is \(castInt)")
} else {
    // Int型へのダウンキャストが失敗した場合を考慮する必要がある
    print("The type of anyInt is not Int")
}

// ジェネリック関数　汎用的な関数
// ジェネリック関数は、型引数<>を持つ関数のこと。
// identiry1()関数では、引数と戻り値に型引数<T>を使用している。
func identity1<T>(_ x: T) -> T {
    return x
}

identity(1)// 特殊化　<T> -> Int型
identity("abc")// <T> -> String型

// 特殊化方法
// ジェネリクスを使用して汎用的に定義されたものに対して、
// 具体的な型引数を与えて型を確定させることを「特殊化」と言う。具体的な型を決めること。

// 引数からの型推論による特殊化
func someFunction1<T>(_ argmnet: T) -> T {
    return argmnet
}
let int1 = someFunction1(1)// 引数の型と戻り値の型がInt型になる
let string1 = someFunction1("a")// 引数の型と戻り値の型がString型になる

// 引数からの型推論による特殊化
// 型引数が複数の引数や戻り値で使用される場合は、実際の型は一致する必要がある。
func someFunction2<T>(_ argmnet1: T, _ argment2: T) {}
// 2つの引数の型がInt型で一致しているためOK
someFunction2(1, 2)
// 2つの引数の型がString型で一致しているためOK
someFunction2("abc", "def")// OK
// 2つの引数の型が異なっているためエラー
// エラーメッセージ
//「Conflicting arguments to generic parameter 'T' ('String' vs. 'Int')」
// 汎用パラメータ 'T' の引数の衝突（'String' と 'Int' の比較）
//someFunction2(1, "abc")

// 戻り値からの型推論による特殊化
func someFunction3<T>(_ any: Any) -> T? {
    return any as? T
}
// String?型の定数に戻り値を代入するので、T型をString型と決定できる。
let string2: String? = someFunction3("abc")
// Int?型の定数に戻り値を代入するので、T型をInt型と決定できる。
let int2: Int? = someFunction3(1)
// 戻り値の代入先の方が決まっていないため、Tが決定できずエラー
// let c = someFunction3("abc")

// 型制約　型引数に対する制約
// スーパークラスや準拠するプロトコルに対する制約
// func 関数名<型引数: プロトコル名やスーパークラス名>(引数) {}
// 引数に使用される型引数Tを、Equatableプロトコルに準拠している型に限定した関数
// Equatableプロトコルに準拠している型は型制約により使えない。
func isEqual3<T: Equatable>(_ x: T, _ y: T) -> Bool {
    return x == y
}
isEqual3("abc", "def")

// 連想型のスーパークラスや準拠するプロトコルに対する制約
// 型引数TがCollectionプロトコルに準拠している、かつ、
// where節でT.Element型がComparableプロトコルに準拠していることを要求している。
// 引数は、比較可能なコレクションに限定される。
func sorted<T: Collection>(_ argment: T) ->[T.Element]
where T.Element : Comparable {
    return argment.sorted()
}
sorted([3, 2, 1])// Int型のソート処理
sorted(["ghi", "def", "abc"])// String型のソート処理
// エラーメッセージ
// 「Global function 'sorted' requires that 'Bool' conform to 'Comparable'」
// グローバル関数 'sorted' は 'Bool' が 'Comparable' に適合することを要求する。
// sorted([false, true, false])

// 型同士の一致を要求する制約
// Collectionプロトコルに準拠している、かつ、
// 連想型T.ElementとU.Elementが一致する事を要求しているconcat(_:)関数
func concat<T: Collection, U: Collection>(
    _ argument1: T, _ argument2: U) -> [T.Element]
    where T.Element == U.Element {
    // 2つの配列を連結する
    return Array(argument1) + Array(argument2)
}

let array = [1, 2, 3]
type(of: array)
let set = Set([1, 2, 3])
type(of: set)
// 2つの配列arrayとsetを連結する
let result = concat(array, set)

// ジェネリック型　汎用的な型
// 型引数<>を持つクラス・構造他・列挙型のこと。
// 構造体
struct GenericStruct<T> {
    // 型引数<T>をプロパティとして使用
    var property: T
}
// 型引数<T>型引数を指定してString型で特殊化
let genericStruct = GenericStruct<String>(property: "abc")
type(of: genericStruct)
genericStruct.property

// クラス
class GenericClass<T> {
    // 型引数<T>をメソッドの引数として使用
    func someFunction(x: T) {
        print(x)
    }
}
// 型引数<T>をString型で特殊化
let genericClass = GenericClass<String>()
genericClass.someFunction(x: "abc")

// 列挙型
enum GenericEnum<T> {
    // 型引数<T>を連想値の型として使用
    case SomeCase(T)
}

// 特殊化方法
// 型引数の指定による特殊化
// ジェネリクスを使用して汎用的に定義されたものに対して、
// 具体的な型引数を与えて型を確定させることを「特殊化」と言う。具体的な型を決めること。
// 例: Container<Content> -> Container<String>, Container<Int>
// Contentは型引数 抽象的な型
struct Container1<Content> {
    var content: Content
}

// Container<String>型のインスタンス化
// 型引数<Content>がString型であることを明示して特殊化する
let stringContainer1 = Container<String>(content: "abc")
type(of: stringContainer)

// Container<Int>型のインスタンス化
// 型引数<Content>がInt型であることを明示して特殊化する
let intContainer1 = Container<Int>(content: 11)
type(of: intContainer)

// 型推論による特殊化
struct Container2<Content> {
    var content: Content
}

// 型引数<Content>を型推論して特殊化する
let intContainer2 = Container2(content: 1)
type(of: intContainer2)
let stringContainer2 = Container2(content: "abcd")
type(of: stringContainer2)

// 型制約　型引数に対する制約
// ジェネリック型では、型引数のスーパークラスや準拠するプロトコルに対する制約が使用できる。


