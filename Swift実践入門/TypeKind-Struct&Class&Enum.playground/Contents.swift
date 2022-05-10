import UIKit
import CoreGraphics
import Foundation

// 型の種類　構造他・クラス列挙型
// 値の受け渡し方法による分類
// 値型　値を表す型　構造体と列挙型
var a = 4.0 // aに4.0が入る
var b = a // bに4.0が入る(aが持つ4.0への参照ではなく、値である4.0が入る)
a.formSquareRoot()// aの平方根を取る
a // aは2.0になる。
b // bはaの変更の影響を受けずに4.0のままとなる

// 変数と定数への代入とコピー
struct Color {
    var red: Int
    var green: Int
    var blue: Int
}
var a1 = Color(red: 255, green: 0, blue: 0)// a1に赤を代入
var b1 = a1// b1にa1を代入　参照ではなく、a1が示す赤という色そのものを代入している
a1.red = 0// a1を黒に変更する

// a1とb1はそれぞれ独立して赤という値を持っている。
// a1は黒になる
a1.red
a1.green
a1.blue

// b1は赤のまま
b1.red
b1.green
b1.blue

// mutatingキーワード　自身の値の変更を宣言するキーワード
extension Int {
    // 自身の値に1加算するメソッドをInt型に追加
    mutating func increment() {
        self += 1
    }
}
var a2 = 1
a2.increment()// 暗黙的にa2への再代入が行われている。
// mutatingキーワードが指定されたメソッドの呼び出しは、再代入として扱われる。
//let b2 = 1
//b2.increment()// 定数b2には再代入できないためエラー

// 参照型　値への参照を表す型　クラス
// 複数の変数や定数で1つの参照型のインスタンスを共有できる。
// 値の変更の共有
class IntBox {
    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    var value: Int

    init(value: Int) {
        // self.valueはプロパティの値を指し、valueは引数を指す。
        self.value = value
    }
}
var a3 = IntBox(value: 1)// a3はインスタンスIntBox(value: 1)を参照する
var b3 = a3// b3はa3と同じくIntBox(value: 1)を参照する
// a3.valueとb3.valueは両方とも値は1
a3.value
b3.value
// a3.valueの値を3に変更する
a3.value = 3
// a3.valueとb3.valueは両方とも値は3に変更される。
a3.value
b3.value


// 構造体　値型のデータ構造
// プロパティやメソッド、イニシャライザなどの型を構成する要素は構造体で全て利用可能
struct Article {

    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    let id: Int
    let title: String
    let body: String

    init(id: Int, title: String, body: String) {
        // self.idはプロパティの値を指し、idは引数を指す。
        self.id = id
        // self.titleプロパティの値を指し、titleは引数を指す。
        self.title = title
        // self.bodyはプロパティの値を指し、bodyは引数を指す。
        self.body = body
    }

    func printBody() {
        print(body)
    }
}
let article = Article(id: 1, title: "tltle", body: "body")
article.printBody()

// ストアドプロパティの変更による値の変更
// 定数のストアドプロパティは変更できない
struct SomeStruct {
    var id: Int

    init(id: Int) {
        self.id = id
    }
}
// 変数にSomeStruct型の値を代入した場合は、ストアドプロパティidは変更可能
var variable = SomeStruct(id: 1)
variable.id = 2
// 定数にSomeStruct型の値を代入した場合は、ストアドプロパティidは変更不可能
let constant = SomeStruct(id: 3)
//constant.id = 4// エラー

// メソッド内のストアドプロパティの変更には、mutatingキーワードが必要
// 構造体のストアドプロパティの変更は再代入を必要とするため、
// ストアドプロパティの変更を含むメソッドには、mutatingキーワードが必要
struct SomeStruct1 {
    var id: Int

    init(id: Int) {
        self.id = id
    }

    mutating func someMethod() {
        id = 4
    }

//    func someMethod1() {
//        id = 4// mutatingキーワードがついていないためエラー
//    }
}
var a4 = SomeStruct1(id: 1)
a4.someMethod()
a4.id

// メンバーワイズイニシャライザ　デフォルトで用意されるイニシャライザ
// 構造体では自動的に定義されるメンバーワイズイニシャライザが利用できる。
struct Article1 {

    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    let id: Int
    let title: String
    let body: String

    // 以下と同等のイニシャライザが、自動的に定義される。
//    init(id: Int, title: String, body: String) {
//        // self.idはプロパティの値を指し、idは引数を指す。
//        self.id = id
//        // self.titleプロパティの値を指し、titleは引数を指す。
//        self.title = title
//        // self.bodyはプロパティの値を指し、bodyは引数を指す。
//        self.body = body
//    }

    func printBody() {
        print(body)
    }
}
// メンバーワイズイニシャライザ　型が持っている各ストアドプロパティと同名の引数を取る
let article1 = Article(id: 1, title: "tltle", body: "body")
article1.id
article1.title
article1.body

// メンバーワイズイニシャライザのデフォルト引数
struct Mail {
    // 初期化式とともに定義されている場合は、
    // メンバーワイズイニシャライザ呼び出し時に省略出来る。
    var subject: String = "(No Subject)"
    var body: String

    // 以下と同等のイニシャライザが、自動的に定義される。
//    init(subject: String = "(No Subject)", body: String) {
//        self.subject = subject
//        self.body = body
//    }
}
// 引数subjectは初期値があるため、指定を省略出来る。
let noSubject = Mail(body: "Hello!")
noSubject.subject
noSubject.body
// 引数subjectの指定は省略出来るが、通常通り指定することも出来る。
let greeting = Mail(subject: "Greeting", body: "Hello!")
greeting.subject
greeting.body


// クラス　参照型のデータ構造
// プロパティやメソッド、イニシャライザなどの型を構成する要素は構造体で全て利用可能
struct SomeClass {

    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    let id: Int
    let name: String

    init(id: Int, name: String) {
        // self.idはプロパティの値を指し、idは引数を指す。
        self.id = id
        // self.nameプロパティの値を指し、titleは引数を指す。
        self.name = name
    }

    func printName() {
        print(name)
    }
}
let instance = SomeClass(id: 1, name: "name")
instance.printName()

// 継承　型の構成要素の引き継ぎ
// 新たなクラスを定義する時に、他のクラスのプロパティ、メソッド、イニシャライザなどの
// 型を再利用する仕組み

class User {
    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    let id: Int

    // コンピューテッドプロパティ
    var message: String {
        return "Hello."
    }

    init(id: Int) {
        // self.idはプロパティの値を指し、idは引数を指す。
        self.id = id
    }

    func printProfile() {
        print("id: \(id)")
        print("message: \(message)")
    }
}

print("-----")

// Userクラスを継承したクラス
//　Userクラスで定義されているid,messageプロパティ、printProfile()メソッドが利用可能
class RegisteredUser: User {
    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    let name: String

    init(id: Int, name: String) {
        // self.nameはプロパティの値を指し、nameは引数を指す。
        self.name = name
        // 継承元のUserクラスで宣言している定数idの初期化
        super.init(id: id)
    }
}
let registeredUser = RegisteredUser(id: 1, name: "Motoki Nakamura")
let id = registeredUser.id
let message = registeredUser.message
registeredUser.printProfile()

// オーバーライド　型の構成要素の再定義
// スーパークラスで定義されているプロパティやメソッドなどの要素は、
// サブクラスで再定義することができる。
// インスタンスプロパティとクラスプロパティのみ可能
class User1 {

    let id: Int

    var message: String {
        return "Hello!"
    }

    init(id: Int) {
        self.id = id
    }
    //
    func printProfile() {
        print("id: \(id)")
        print("message: \(message)")
    }
}
print("-----")

class RegisteredUser1: User1 {

    let name: String

    // コンピューテッドプロパティmessageをオーバーライドして再定義
    // override var プロパティ名: 型名
    override var message: String {
        // return文によって値を返す処理
        return "Hello, my name is \(name)"
    }

    init(id: Int, name: String) {
        // self.nameはプロパティの値を指し、nameは引数を指す。
        self.name = name
        // 継承元のUserクラスで宣言している定数idの初期化
        super.init(id: id)
    }

    override func printProfile() {
        // superキーワードでスーパークラスの実装を利用出来る。
        // スーパークラスのprintProfile()とRegisteredUser1クラスの
        // printProfile()を組み合わせて３つのプロパティの値を出力
        super.printProfile()
        print("name: \(name)")
    }
}
let user1 = User1(id: 1)
// User1クラスではidとmessageプロパティの値のみ出力　id, message
user1.printProfile()
print("-----")


let registeredUser1 = RegisteredUser1(id: 2, name: "Motoki Nakamura")
// RegisteredUser1クラスではスーパークラス(User1)のidとmessageに加えて、
// nameプロパティの値も出力している。　id, message, name
registeredUser1.printProfile()
print("-----")

// finalキーワード　継承とオーバーライドの禁止
class SuperClass {
    // サブクラスでオーバーライド可能
    func overridableMethod() {}

    // finalキーワードとともに定義しているため、サブクラスでオーバーライド不可能
    final func finalMethod() {}
}
class SubClass: SuperClass {
    // オーバーライド可能
    override func overridableMethod() {}
    // オーバーライド不可能なためエラー
    //override func finalMethod() {}
}

// クラス自体にfinalキーワードを付与することで、そのクラスを継承したクラス定義を禁止できる
// 継承可能
class InheritableClass {}
// 継承可能
class ValidSbuClass: InheritableClass {}

final class FinalClass {}
// 継承不可能なためエラー
// class InvalidSubClass: FinalClass {}

// クラスに紐付く要素
// クラスプロパティ　クラス自身に紐付くプロパティ
// 型自身に紐付くスタティックプロパティと性質が似ている
// インスタンスに依存しない値を扱う場合に利用する
class A {
    // プロパティ宣言の先頭にclassキーワードを付ける。
    class var className: String {
        // 型名を返す
        return "A"
    }
}
// Aクラスを継承
class B: A {
    // AクラスのclassNameプロパティをオーバーライドしている。
    override class var className: String {
        // 型名を返す
        return "B"
    }
}
A.className// 型名.クラスプロパティ名でアクセスする
B.className

// クラスメソッド　クラス自身に紐付くメソッド
// 型自身に紐付くスタティックメソッドと性質が似ている
// インスタンスに依存しない処理を実装する場合に利用する
class C {
    // クラスの継承関係を表現するメソッド
    class func ingeritanceHierarchy() -> String {
        return "C"
    }
}
// Cクラスを継承
class D: C {
    // スーパークラスのメソッドを呼び出し、自身のクラス名を追記して返す
    override class func ingeritanceHierarchy() -> String {
        // superキーワードでスーパークラスの実装を利用する
        return super.ingeritanceHierarchy() + "<-D"
    }
}

class E: D {
    // スーパークラスのメソッドを呼び出し、自身のクラス名を追記して返す
    override class func ingeritanceHierarchy() -> String {
        // superキーワードでスーパークラスの実装を利用する
        return super.ingeritanceHierarchy() + "<-E"
    }
}
C.ingeritanceHierarchy()
D.ingeritanceHierarchy()
E.ingeritanceHierarchy()

// スタティックプロパティ、スタティックメソッドとの使い分け
class F {
    // 継承先で変更されるべきなのでクラスプロパティとして定義
    class var className: String {
        return "F"
    }
    // 継承元のクラス名を返すスタティックプロパティ
    // 継承先でも同じ値であるべきなのでスタティックプロパティとして定義
    static var baseClassName: String {
        return "F"
    }
}
// Fクラスを継承
class G: F {
    // FクラスのclassNameプロパティをオーバーライド
    override class var className: String {
        return "G"
    }

    // スタティックプロパティはオーバーライドできないのでエラー
//    override static var baseClassName: String {
//        return "F"
//    }
}
F.className
G.className

F.baseClassName
G.baseClassName

// イニシャライザの種類と初期化のプロセス
// イニシャライザの役割は型のインスタンス化の完了までに全てのプロパティを初期化し、
// 型の整合性を保つこと。

// 指定イニシャライザ　主となるイニシャライザ
// クラスの主となるイニシャライザで、このイニシャライザの中で全ての
// ストアドプロパティが初期化されている必要がある。
class Mail1 {
    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    let from: String
    let to: String
    let title: String

    // 指定イニシャライザ
    init(from: String, to: String, title: String) {
        self.from = from
        self.to = to
        self.title = title
    }
}

// コンビニエンスイニシャライザ　指定イニシャライザをラップするイニシャライザ
// 指定イニシャライザを中継するイニシャライザで、内部で引数を組み立てて、
// 指定イニシャライザを呼び出す必要がある。
class Mail2 {
    // 初期値を定義していないため、イニシャライザ内で初期化する必要がある。
    let from: String
    let to: String
    let title: String

    // 指定イニシャライザ
    init(from: String, to: String, title: String) {
        self.from = from
        self.to = to
        self.title = title
    }

    // コンビニエンスイニシャライザ convenienceキーワード
    convenience init(from: String, to: String) {
        self.init(from: from, to: to, title: "Hello, \(from)")
    }
}

// デフォルトイニシャライザ　プロパティの初期化が不要な場合に定義されるイニシャライザ
class User2 {
    // 全てのプロパティが初期値を持っている場合は、指定イニシャライザ内で初期化しなくて良い
    let id = 0
    let name = "Taro"

    // 以下と同等のイニシャライザが自動的に定義される。デフォルトの指定イニシャライザ
    // init() {}
}
let user2 = User2()
user2.id
user2.name

class User3 {
    // 1つでも指定イニシャライザ内で初期化が必要なプロパティが存在する場合、
    // デフォルトイニシャライザinit()は無くなり、指定イニシャライザを定義する必要がある
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
let user3 = User3(id: 1, name: "Taro")
user3.id
user3.name


// 列挙型　複数の識別子をまとめる型
// Optional<Wrapped>型は列挙型
enum Weekday {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
// 列挙型名.ケース名のようにケース名を指定して、インスタンス化する
// .sundayと.mondayをインスタンス化している
let sunday = Weekday.sunday
let monday = Weekday.monday

// イニシャライザを定義して、インスタンス化することも出来る。
enum Weekday1 {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    // イニシャライザを追加し、引数に渡された文字列に応じて各ケースをselfに代入している
    init?(japaneseName: String) {
        switch japaneseName {
        case "日": self = .sunday
        case "月": self = .monday
        case "火": self = .tuesday
        case "水": self = .wednesday
        case "木": self = .thursday
        case "金": self = .friday
        case "土": self = .saturday
        default: return nil
        }
    }
}
// 引数に渡した文字列に応じてインスタンス化している。
let sunday1 = Weekday1(japaneseName: "日")
let monday1 = Weekday1(japaneseName: "月")

enum Weekday2 {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    // 列挙型はコンピューテッドプロパティのみ持つことができる。
    var name: String {
        switch self {
        case .sunday: return "日"
        case .monday: return "月"
        case .tuesday: return "火"
        case .wednesday: return "水"
        case .thursday: return "木"
        case .friday: return "金"
        case .saturday: return "土"

        }
    }
}
let weekday2 = Weekday2.monday
let name = weekday2.name

// ローバリュー　実態の定義

