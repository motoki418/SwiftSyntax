import UIKit
import CoreGraphics

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
// プロパティやメソッド、イニシャライザなどの方を構成する要素は構造体で全て利用可能
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
