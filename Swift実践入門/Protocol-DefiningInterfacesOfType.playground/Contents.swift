import UIKit
import Foundation

var greeting = "Hello, playground"

// プロトコル
// 型のインターフェースの定義
// インターフェースは、型がどのようなプロパティやメソッドを持っているかを示すもの。
// プロトコルが要求するインターフェースを型が満たすことを準拠と言う。

// 次の関数は、2つの引数に渡した値が同じ時だけ値を出力するが、渡せる引数の型を、
// Equatableプロトコルに準拠している型だけに制限している。
func printIfEqual<T: Equatable>(_ arg1: T, _ arg2: T) {
    if arg1 == arg2 {
        print("Both are \(arg1)")
    }
}
// 2つの引数に渡した値が同じ時だけ値を出力
printIfEqual(123, 123)
printIfEqual("abc", "abc")
printIfEqual(Double(12.0), Double(12.0))
printIfEqual(Float(12.9), Float(12.9))
printIfEqual(true, true)

// Conflicting arguments to generic parameter 'T' ('String' vs. 'Int')
// 汎用パラメータ 'T' の引数の衝突（'String' と 'Int' の比較）
// printIfEqual(123, "abc")

// プロトコルの基本
// 定義方法
//protocol プロトコル名 {
//    プロトコルの定義
//}

// 準拠方法
// プロトコルに準拠するには、プロトコルが要求している全てのインターフェースに対する、
// 実装を用意する必要がある。
//
protocol SomeProtocol {
    func someMethod()
}
// SomeStruct型はSomeProtocolが要求しているsomeMethod()メソッドを、
// 実装しているためOK
struct SomeStuct: SomeProtocol {
    func someMethod() {}
}

// SomeStruct1型は、SomeProtocolが要求しているsomeMethod()メソッドを、
// 実装していないためエラー。
//struct SomeStuct1: SomeProtocol {}

// クラス継承時の準拠方法
// クラスではクラスの継承とプロトコルの準拠が同じ書式になっている。
// プロトコル
protocol SomeProtocol1 {}
// スーパークラス
class SomeSuperClass {}
// スーパークラスを1番目に指定して、プロトコルは2番目以降に指定する
class SomeClass: SomeSuperClass, SomeProtocol1 {}

// エクステンションによる準拠方法
// 1つのプロトコルに対して1つのエクステンションを定義することで、プロパティ、
// メソッドとプロトコルの対応が明確になる。コードの可読性を高める事が出来る。
protocol SomeProtocol2 {
    func someMethod2()
}

protocol SomeProtocol3 {
    func someMethod3()
}
// SomeStruct1型本来の実装
struct SomeStruct1 {
    let someProperty: Int
}
// SomeProtocol2プロトコルが要求する実装
extension SomeStruct1: SomeProtocol2 {
    func someMethod2() {}
}
// SomeProtocol3プロトコルが要求する実装
extension SomeStruct1: SomeProtocol3 {
    func someMethod3() {}
}

// コンパイラによる準拠チェック
// プロトコルが要求しているインターフェースが一つでも欠けていればエラーとなる。
protocol RemoteObject {
    var id: Int { get }
}
// Ariticle型はRemoteObjectプロトコルへの準拠を宣言しているが、
// idプロパティが実装されていないためエラー
// エラーメッセージ
// 「Type 'Ariticle' does not conform to protocol 'RemoteObject'」
// タイプ 'Ariticle' はプロトコル 'RemoteObject' に適合していません。
//struct Ariticle: RemoteObject {}

// 利用方法
// プロトコルは引数の型として使用可能。
protocol SomeProtocol4 {
    var variable: Int { get }
}
func someMethod(x: SomeProtocol4) {
    // 引数xのプロパティやメソッドのうち、SomeProtocol4で定義されているものが使用可能
    x.variable
}

// プロトコルコンポジション　複数のプロトコルの組み合わせ
protocol SomeProtocol5 {
    var variable1: Int { get }
}
protocol SomeProtocol6 {
    var variable2: Int { get }
}

struct SomeStruct2: SomeProtocol5, SomeProtocol6 {
    var variable1: Int
    var variable2: Int
}
// プロトコルコンポジションを使用するには、プロトコル名1 & プロトコル名2のように記述する
// SomeProtocol5とSomeProtocol6プロトコルの両方のインターフェースを使用している。
func someFunction(x: SomeProtocol5 & SomeProtocol6) {
    x.variable1 + x.variable2
}
// インスタンス生成
let a = SomeStruct2(variable1: 1, variable2: 2)
someFunction(x: a)


// プロトコルを構成する要素
// プロパティ
// somePropertyプロパティを持ったSomeProtocol7プロトコル
protocol SomeProtocol7 {
    //var プロパティ名: 型　{get set}
    var someProperty: Int { get set }
}

// ゲッタの実装
// プロパティゲッタしかない場合は、変数または定数のストアドプロパティを実装するか、
// ゲッタを持つストアドプロパティを実装する
protocol SomeProtocol8 {
    var id: Int { get }
}
// 変数のストアドプロパティ
struct SomeStruct3: SomeProtocol8 {
    var id: Int
}
// 変数のストアドプロパティ
struct SomeStruct4: SomeProtocol8 {
    let id: Int
}
// コンピューテッドプロパティ
struct SomeStruct5: SomeProtocol8 {
    var id: Int {
        return 1
    }
}

// セッタの実装
// セッタも必要としている場合は、変数のストアドプロパティを実装するか、
// ゲッタとセッタの両方を持つコンピューテッドプロパティを実装する
protocol SomeProtocol9 {
    var title: String { get set }
}
// 変数のストアドプロパティ
struct SomeStruct6: SomeProtocol9 {
    var title: String
}

struct SomeStruct7: SomeProtocol9 {
    var title: String {
        get {
            return "title"
        }

        set {}
    }
}
// 定数のストアドプロパティは変更が不可能なためプロトコルの要件を満たす事ができずエラーになる
//struct SomeStruct8: SomeProtocol9 {
//    let title: Int
//}

// メソッド
// プロトコルのメソッドでは、メソッド名、引数の型、戻り値の型のみを定義する {}は省略
// メソッドの実装
protocol SomeProtocol10 {
    func someMethod() -> Void
    static func someStaticMethod() -> Void
}
// メソッドが実装されているプロトコルに準拠するには、同じインターフェースを持つメソッドを実装
struct SomeStruct8: SomeProtocol10 {
    func someMethod() -> Void{
        // メソッドの実装
    }

    static func someStaticMethod() -> Void {
        // メソッドの実装
    }
}

// mutatingキーワード　値型のインスタンスの変更を宣言するキーワード
protocol SomeProtocol11 {
    // プロトコルの定義では、実装を伴わないため、{}は省略する
    // 値型のインスタンスを変更しうるメソッドをプロトコルに定義するには、
    // プロトコル側のメソッドの定義にmutatingキーワードを追加する必要がある
    mutating func someMutatingMethod()
    func someMethod()
}

// SomeProtocol11プロトコルに準拠した構造体
struct SomeStruct9: SomeProtocol11 {
    var number: Int

    mutating func someMutatingMethod() -> Void{
        // SomeStruct11の値を変更する処理を入れる事が出来る
        number = 1
    }

    func someMethod() {
        // SomeStruct11の値を変更する処理を入れることはできないためエラー
        //number = 1
    }
}
var someStruct9 = SomeStruct9(number: 23)
someStruct9.number
someStruct9.someMutatingMethod()
someStruct9.number

// SomeProtocol11プロトコルに準拠したクラス
class SomeClass1: SomeProtocol11 {
    var number = 0

    // 参照型であるクラスではmutatingは不要
    func someMutatingMethod() -> Void{
        // SomeClass1の値を変更する処理を入れる事が出来る
        number = 1
    }

    func someMethod() {
        // SomeClass11の値を変更する処理を入れる事が出来る
        number = 3
    }
}
var someClass1 = SomeClass1()
someClass1.number
someClass1.someMutatingMethod()
someClass1.number
someClass1.someMethod()
someClass1.number

// 連想型　プロトコルの準拠時に指定可能な型
// 連想値を用いると、プロトコルの準拠時に型の指定ができるようになる。
// プロトコル側では連想型はプレースホルダとして働き、連想型の実際の型は、
// 準拠する型の方で指定する
// 定義方法
protocol SomeProtocol12 {
    //associatedtype 連想型
    associatedtype Associatedtype

    // 連想型はプロパティやメソッドでも使用可能
    // var プロパティ名: 連想型名
    var value: Associatedtype { get }
    // func メソッド名(引数名: 連想型名)
    func someMethod(value: Associatedtype) -> Associatedtype
}

// Associatedtypeを定義することで要求を満たす
// 連想型と同名の型エイリアスを定義している
struct SomeStruct10: SomeProtocol12 {
    // 連想型の実際の型の指定には型エイリアスを使用し、
    // 連想型と同名の型エイリアスを、typealias　連想型名 = 指定する型名と定義する
    typealias Associatedtype = Int

    var value: Associatedtype

    func someMethod(value: Associatedtype) -> Associatedtype {
        return 1
    }
}

var someStruct10 = SomeStruct10(value: 4)
someStruct10.value

// someMethod(_:)メソッドの戻り値の型から自動的に連想型が決定するので、
// 型エイリアスを定義する必要がない。
struct SomeStruct11: SomeProtocol12 {
    var value: Int

    func someMethod(value: Int) -> Int {
        return 1
    }
}
// 連想型と同名のネストしたstruct AssociatedType型が定義されてるのでこの型が連想型となる
struct SomeStruct12: SomeProtocol12 {
    struct AssociatedType {}

    var value: AssociatedType

    func someMethod(value: AssociatedType) -> AssociatedType {
        return AssociatedType()
    }
}

// ランダムな値を生成するという性質を表現しているプロトコル
protocol RandomValueGenerator {
    //associatedtype 連想型
    associatedtype Value

    // 連想型はプロパティやメソッドでも使用可能
    // func メソッド名(引数名: 連想型名)
    // 戻り値のValue型はプレースホルダ型なので、プロトコルに準拠する型ごとに指定できる。
    func randomValue() -> Value

}

struct IntegerRandomValueGenerator: RandomValueGenerator {
    // Value型をInt型に指定している型
    // ランダムな数値を生成し、返却するメソッド
    func randomValue() -> Int {
        return Int.random(in: Int.min...Int.max)
    }
}
var intRandom = IntegerRandomValueGenerator()
intRandom.randomValue()

struct StringRandomValueGenerator: RandomValueGenerator {
    // 連想型ValueをString型に指定
    // lettersに格納している文字列の中からランダムな文字を返却するメソッド
    func randomValue() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let offset = Int.random(in: 0..<letters.count)
        let index = letters.index(letters.startIndex, offsetBy: offset)
        return String(letters[index])
    }
}

let stringRandom = StringRandomValueGenerator()
stringRandom.randomValue()
stringRandom.randomValue()

// 型制約の追加
class SomeClass2 {}

protocol SomeProtocol13 {
    // SomeProtocol13プロトコルに準拠する
    associatedtype Associatedtype: SomeClass2
}

class SomeSubClass: SomeClass2 {}
// SomeSubClassはSomeClass2のサブクラスなのでAssociatedtypeの制約を満たす
struct ConforomedStruct: SomeProtocol13 {
    typealias Associatedtype = SomeSubClass
}

// IntはSomeClass2のサブクラスではないのでエラー
//struct NonConformedStruct: SomeProtocol13 {
//    typealias Associatedtype = Int
//}


// プロトコルの継承
protocol ProtocolA {
    var id: Int { get }
}
protocol ProtocolB {
    var title: String { get }
}
// ProtocolCは、id,titleの2つを要求するプロトコルとなる。
// ProtocolAとProtocolBを継承するプロトコル
protocol ProtocloC: ProtocolA, ProtocolB {}

// クラス専用プロトコル 準拠する型をクラスのみに限定できる。
// 準拠する型が参照型であることを想定する場合に使用する。
// protocol SomeClassOnlyProtocol: class, プロトコル名{}

// プロトコルエクステンション　プロトコルの実装の定義
// エクステンションはプロトコルにも定義できる。
protocol Item {
    var name: String { get }
    var category: String { get }
}
// Itemプロトコルに変数descriptionの実装を追加する
extension Item {
    var description: String {
        return "商品名: \(name), カテゴリ: \(category)"
    }
}

// Itemプロトコルを継承
struct Book: Item {
    let name: String

    var category: String {
        return "書籍"
    }
}
// インスタンスを生成
let book = Book(name: "Swift実践入門")
print(book.description)

// Itemプロトコルを継承
//struct Book1: Item {
//    // エラーメッセージ
//    // 「Type 'Book1' does not conform to protocol 'Item'」
//    //　タイプ 'Book1' はプロトコル 'Item' に適合していません。
//    // Itemプロトコルが要求しているnameプロパティを、実装していないためエラー。
//    // let name: String
//
//    var category: String {
//        return "書籍"
//    }
//}

// デフォルト実装による実装の任意化
// デフォルト実装を与えて実装を任意化することにより、標準的な機能を提供しつつも、
// カスタマイズの余地を与える事が可能となる。
protocol Item1 {
    var name: String { get }
    var caution: String? { get }
}

extension Item1 {
    // caucionプロパティにデフォルト実装を定義
    var caution: String? {
        return nil
    }

    var description: String {
        var description = "商品名: \(name)"
        // オプショナルString型のcautionプロパティをアンラップ
        if let caution = caution {
            description += ", 注意事項: \(caution)"
        }
        return description
    }
}
// Item2プロトコルに準拠する型ではcautionプロパティを必ずしも実装する必要はない。
struct Book1: Item1 {
    let name: String

    var caution: String? {
        return "プライム配送の対象ではありません"
    }
}

struct Fish: Item1 {
    let name: String

    var caution: String? {
        return "クール便での配送となります"
    }
}

let book1 = Book1(name: "Swift実践入門")
print(book1.description)
print(book1.name)
// 警告
// Expression implicitly coerced from 'String?' to 'Any'
// 式が暗黙のうちに 'String?' から 'Any' に強制される
print(book1.caution)

let fish = Fish(name: "秋刀魚")
print(fish.description)
print(fish.name)
// 警告
// Expression implicitly coerced from 'String?' to 'Any'
// 式が暗黙のうちに 'String?' から 'Any' に強制される
print(fish.caution)

// 型制約の追加
// extension　プロトコル名　where　型制約　{
//     制約を満たす場合に有効となるエクステンション
//}

// Collectionプロトコルの連想型ElementがInt型と一致する場合にのみ、
// 利用可能となるクステンションを定義し、sumeプロパティで各要素の合計を返す
extension Collection where Element == Int {
    var sum: Int {
        return reduce(0) { return $0 + $1}
    }
}
let integers = [1, 2, 3]
integers.sum// 要素の合計

let strings = ["a", "b", "c"]
// stringsの要素はInt型ではないため、sumeプロパティは利用できない。
// strings.sum// エラー
