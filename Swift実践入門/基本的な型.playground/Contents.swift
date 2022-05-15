import UIKit

var greeting = "Hello, playground"

// String型
let a = "1\n2\n3"
print(a)

// 文字列リテラル内での値の展開
let result = 7 + 9
let output = "結果: \(result)"

let result1 = "優勝"
let output1 = "結果: \(result1)"

// 複数行の文字列リテラル
let haiku = """
五月雨を
あつめて早し
最上川
"""
print(haiku)

let haiku1 = """
五月雨を
 あつめて早し
最上川
"""
print(haiku1)

//数値型との相互変換
//Int型をString型に変換する場合は、String型のイニシャライザを使用する
let i = 123
let s = String(i)

//String型をInt型に変換する場合は、String型のイニシャライザを使用する
//変換できない場合は、nilが返される
let s1 = "123"
let i1 = Int(s1)

let s2 = "abc"
let i2 = Int(s2)//Optional<Int>型の値になる
print(type(of: i2))

// String型の操作
// 比較
let string1 = "abc"
let string2 = "def"
string1 == string2
// 結合
var string3 = "abc"
let string4 = "def"
let string5 = string3 + string4
string3.append( string4)
// Foundationによる高度な操作
import Foundation
// 2つの文字列間の順序の比較
let options = String.CompareOptions.caseInsensitive
let order = "abc".compare("ABC", options: options)
order == ComparisonResult.orderedSame
// 文字列の探索
"abc".range(of: "bc")// 1から2の範囲を示す値を返す

// Optional<Wrapped>型　値があるか空のいずれかを表す型
// 値の不在を表す.noneと、アタイの存在を表す.some
let none = Optional<Int>.none
// String型のイニシャライザString(describing:)を使用して、
// Optional<Wrapped>型の文字列表現を取得すると、これらの表記が使用されている事がわかる
print(".none: \(String(describing: none))")
let some = Optional<Int>.some(2)
print("some: \(String(describing: some))")
// 型推論
let some1 = Optional.some(1)// Optional<Int>型
let none1: Int? = Optional.none// Optional<Int>型
// Optional<Wrapped>型の値の生成
// 列挙型のケース(.noneと.some)として詩生成する方法よりもシンプルに記述できるため、
// 一般的にはこれらの生成方法が使われる。
var a1: Int?
a1 = nil//nilリテラルの代入による.noneの生成
a1 = Optional(1)// イニシャライザによる.someの生成
a1 = 1// 値の代入による.someの生成
//nilリテラルの代入による.noneの生成
let optionalInt: Int? = nil
let optionaString: String? = nil
// 型と値の不在を表すnilを出力
print(type(of: optionalInt), String(describing: optionalInt))
print(type(of: optionaString), String(describing: optionaString))
// nilリテラルの代入先の変数と定数の型は、型アノテーションなどで先に決めておく必要がある。
let a2: Int? = nil// OK
//let b = nil// エラー

// イニシャライザによる.someの生成
// プレースホルダ型Wrappedはイニシャライザに渡された引数から型推論される
// Int型の値をイニシャライザの引数に渡した場合には、Int?型の.someが生成され、
// String型の値をイニシャライザの引数に渡した場合には、String?型の.someが生成される
let optionalInt1 = Optional(1)
let optionalString1 = Optional("a")
print(type(of: optionalInt1), String(describing: optionalInt1))
print(type(of: optionalString1), String(describing: optionalString1))

// 値の代入による.someの生成
// Int?型の.someを生成
let optionalInt2: Int? = 1
print(type(of: optionalInt2), String(describing: optionalInt2))

// Optional<Wrapped>型のアンラップ値の取り出し
// オプショナルバインディング　??演算子　強制アンラップ
// オプショナルバインディング　if文による値の取り出し
let optinalA = Optional("a")// String?型
if let a = optinalA {
    print(type(of: a))// optionalAに値がある場合のみ実行される
    print(a)
}
// ??演算子　値が存在しない場合のデフォルト値を指定する演算子
let opttionalInt3: Int? = 1
let int = opttionalInt3 ?? 1

let opttionalInt4: Int? = 0
let int1 = opttionalInt3 ?? 1

// 強制アンラップ !演算子によるOptional<Wrapped>型の取り出し
let a3: Int? = 1
let b: Int? = 1
a3! + b!

// オプショナルチェイン　アンラップを伴わずにアタイのプロパティやメソッドにアクセス
// Optional<Double>型からDouble型のisInfiniteプロパティにアクセスするために
// オプショナルバインディングを行なっている
let optionalDouble = Optional(1.0)
let optionalIsInfinite: Bool?
if let double = optionalDouble {
    optionalIsInfinite = double.isInfinite
} else {
    optionalIsInfinite = nil
}
print(String(describing: optionalIsInfinite))
// 上記のコードをオプショナルチェインを使って書き換えた文
let optionalDouble1 = Optional(1.0)
let optionalIsInfinite1 = optionalDouble1?.isInfinite
print(String(describing: optionalIsInfinite1))
// contains(_:)メソッドを呼び出し、定数optionalRangeの範囲に指定
// した値が含まれるかどうかを判定
let optionalRange = Optional(0..<10)
let containSeven = optionalRange?.contains(7)
print(String(describing: containSeven))

// map(_:)とflatMap(_:)メソッド　アンラップを伴わずに値の変換を行うメソッド
// 「二重」に不確かな状態を1つにまとめてくれるのがflatMap(_:)メソッド
// Int?型の定数a4に対して、値を2倍にするクロージャを実行し、
// 結果としてInt?型の値を受け取っている
// 結果としてString？型の値"17"を受け取っている
let a4 = Optional(17)
// valueが引数名　inキーワード以降が戻り値を返す式
let b4 = a4.map({ value in value * 2})
type(of: b4)

// Int?型の定数a5に対して、Int型をString型に変換するクロージャを実行し、
// 結果としてString？型の値"17"を受け取っている
let a5 = Optional(17)
// a5の値を引数valueに渡して、String(value)でString?型に変換している
let b5 = a5.map({ value in String(value)})
type(of: b5)

// String?型の定数a6に対して、String型をInt?型に変換するクロージャを実行し、
// 結果としてInt？型の値17を受け取っている
let a6 = Optional("17")
// a5の値を引数valueに渡して、Int(value)でInt?型に変換している
let b6 = a6.flatMap({ value in Int(value)})
type(of: b6)
// 上記のa6.flatMap()の処理をa7.map()を使用して行うと
// 最終的な結果は二重にOption<Wrap>型に包まれたInt??型となってしまう
let a7 = Optional("17")
// a5の値を引数valueに渡して、Int(value)でInt?型に変換している
let b7 = a7.map({ value in Int(value)})
type(of: b7)

// 暗黙的にアンラップされたOptional<Wrapped>型
// Optional<Wrapped>型にはOptional?とOptional!と表記するシンタックスシュガーがある
// シンタックスシュガー = 定義済みの構文を簡単に読み書きできるようにする構文。
let a8: String? = "a"
let b8: String? = "b"
print(type(of: a8))
print(type(of: b8))

var c: String! = a8
var d: String? = b8

let a9: Int! = 1
a9 + 1// Int型と同様に演算が可能

//let b9: Int! = nil
//b9 + 1// 値が入っていないため実行時エラー


// Any型　任意の型を表す型
let string6: Any = "abc"
print(type(of: string6))
let int6: Any = 123

// Any型への代入による型の損失
// あまり使われない
// 元の情報は失われるため、元の方では可能だった操作ができなくなってしまう
let a10: Any = 1
let b10: Any = 1
//a10 + b10// コンパイルエラー


// タプル型　複数の値をまとめる型
// (Int,String)型の変数tuple
// タプル型の値は「タプル」という
var tuple: (Int, String)
tuple = (1, "a")

// 要素へのアクセス
// インデックスによるアクセス・要素名によるアクセス・代入によるアクセスの3つがある
// インデックスによるアクセス」
// 変数名.インデックスという書式でアクセス
let tuple1 = (1, "a")
tuple1.0
tuple1.1

// 要素名によるアクセス
// (要素名1：要素1, 要素名2:要素2)のように書く
// 変数名.要素名という書式でアクセスする
let tuple2 = (int: 1, string: "a")
tuple2.int
tuple2.string

// 代入によるアクセス
// 定数Int7とString7を()内に列挙し、タプル(1, "a")を通じて、
// 定数に一度に値を代入している
let int7: Int
let string7: String
(int7, string7) = (1, "a")
int7
string7
// 定数int8とString8を()内で宣言すると同時に、タプル(1, "a")を代入して初期化している
let (int8, string8) = (1, "a")
int8
string8

// Void型　空のタプル
// 要素の型が0個のタプル型をVoid型と言う。
// Void型は値が存在し得ないことを表す型　絶対に存在しないと言う事。
// nilリテラルは、値が存在しうる場所で値がないことを示すもの
()// Void型

// 型のキャスト　別の型として扱う操作
// 値の型を確認し、可能であれば別の型として扱う操作のこと
// 階層関係がある型同士において、階層の下位となる具体的な型を、
// 上位の抽象的な型として扱う操作のこと。
// アップキャスト 上位の型として扱う操作
let any = "abc" as Any // String型をAny型にアップキャスト
//let int9 = "abc" as Int// String型はInt型を継承していないため、コンパイルエラー
let any1: Any = "abc"// String型からAny型への暗黙的なアップキャスト

// ダウンキャスト　下位の型として操作
// 階層関係がある型同士において、階層の上位の抽象的な型を、
// 下位となる具体的な型として扱う操作のこと。
// アップキャストは常に成功する操作だが、ダウンキャストはコンパイル可能でも、
// 失敗する可能性があるため、as?演算子もしくはas!演算子を使用する。
// as?演算子によるダウンキャスト
let any2 = 1 as Any
let int10 = any2 as? Int// 成功したため、Int?型のOptional(1)となる。
let string10 = any2 as? String// 失敗したため、String?型のnilとなる。
print(type(of: string10))

// as!演算子によるダウンキャスト
let any3 = 1 as Any
let int11 = any3 as! Int// 成功したため、Int?型の1となる。
//let string11 = any3 as! String// 実行時エラー
print(type(of: int11))

// 型の判定
// is演算子を使用して、値の型が特定の型であるかを確認する。
let any4: Any = 1
let isInt = any4 is Int// true

