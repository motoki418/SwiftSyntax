import UIKit

var greeting = "Hello, playground"

// 型の構成要素　プロパティ・イニシャライザ・メソッド
// 型の内部でのインスタンスへのアクセス
// 型の内部のプロパティやメソッドの中では、selfキーワードを通じてインスタンス自身にアクセス
// SomeStruct型のprintValue()メソッドで、インスタンス自身のvalueプロパティに
// アクセスするために、selfキーワードを使用している。
struct SomeStruct {
    let value = 123

    func printValue() {
        print(self.value)// self.プロパティ名
    }
}
let someStruct = SomeStruct()// SomeStruct型をインスタンス化
someStruct.printValue()

// インスタンスそのものではなく、インスタンスのプロパティやメソッドにアクセスする場合は、
// selfキーワードを省略出来る。
struct SomeStruct1 {
    let value = 123

    func printValue() {
        print(value)// プロパティ名
    }
}
let someStruct1 = SomeStruct1()// SomeStruct1型をインスタンス化
someStruct1.printValue()

// インスタンスのプロパティと同名の変数や定数がスコープ内に存在する場合は、
// それらを区別するために、selfキーワードを明記する必要がある。
struct SomeStruct2 {

    let value: Int

    init(value: Int) {
        // self.valueはプロパティの値を指し、valueは引数の値を指す。
        self.value = value
    }
}
let someStruct2 = SomeStruct2(value: 1)// SomeStruct2型をインスタンス化
someStruct2

// 型の内部での型自身へのアクセス
// 型の内部のプロパティやメソッドなどの中では、
// 大文字のSelfキーワードを通じて型自身にアクセスできる。
// SomeStruct3型のprintSharedValue()メソッドで、スタティックプロパティsharedValueに
// アクセスするために、大文字のSelfキーワードを使用している。
struct SomeStruct3 {

    static let sharedValue: Int = 73

    func printSharedValue() {
        print(Self.sharedValue)
    }
}
let someStruct3 = SomeStruct3()// SomeStruct3型をインスタンス化
someStruct3.printSharedValue()


// プロパティ　型に紐付いた値
// プロパティとは型に紐付いた値の事で、型が表すものの属性や表現などに使用される。
// 定義方法
struct SomeStruc4 {
    var variable = 123// 再代入可能なプロパティ
    let constant = 456// 再代入不可能なプロパティ
}
let someStruct4 = SomeStruc4()//インスタンスを生成
let a = someStruct4.variable// 変数名.プロパティ名でプロパティにアクセス
let b = someStruct4.constant// 変数名.プロパティ名でプロパティにアクセス

// 紐付く対象による分類
// インスタンスプロパティ　型のインスタンスに紐付くプロパティ
// インスタンスごとに異なる値を持たせる事ができる。
struct Greeting {
    var to = "Motoki Nakamura"
    var body = "Hello!"
}
// 挨拶を表すGreeting型のインスタンスを2つ生成し、
// 片方は、"Motoki Nakamura"宛、もう片方は、"Yuuki Sasaki"宛とする。
let greeting1 = Greeting()
var greeting2 = Greeting()
greeting2.to = "Yuuki Sasaki"

let to1 = greeting1.to
let to2 = greeting2.to

// スタティックプロパティ　型自身に紐付くプロパティ
// インスタンス間で共通する値の保持などに使用できる。
struct Greeting2 {
    // 共通の署名
    static let signature = "Sent from iPhone"
    // スタティックプロパティにはイニシャライザに相当する初期化のタイミングがないため、
    // 宣言時に必ず初期値を持たせる必要がある。
    //    static let signature1: String// 値を持っていないためエラー

    // 宛先
    var to = "Motoki Nakamura"
    // 文
    var body = "Hello!"
}
func print(greeting: Greeting2) {
    print("to: \(greeting.to)")
    print("body: \(greeting.body)")
    // signatureは型自身に紐付くスタティックプロパティなので、
    // インスタンスではなく、型名.スタティックプロパティ名でアクセスする。
    print("signature: \(Greeting2.signature)")
}
// 挨拶を表すGreeting型のインスタンスを2つ生成
let greeting3 = Greeting2()
var greeting4 = Greeting2()
greeting4.to = "Yuuki Sasaki"
greeting4.body = "Hi!"

print(greeting: greeting3)
print("------")
print(greeting: greeting4)

// ストアドプロパティ　値を保持するプロパティ
struct SomeStruct5 {
    // インスタンスストアドプロパティ
    var variable = 123// 再代入可能。　型のインスタンスに紐付く
    let constant = 456// 再代入不可能。型のインスタンスに紐付く

    // スタティックストアドプロパティ
    static var staticVariable = 789// 再代入可能。型自身に紐付く
    static let staticConstant = 890// 再代入不可能。型自身に紐付く
}

let someStruct5 = SomeStruct5()
someStruct5.variable// インスタンス.プロパティ名
someStruct5.constant// インスタンス.プロパティ名
SomeStruct5.staticVariable// 型名.スタティックプロパティ名
SomeStruct5.staticConstant// 型名.スタティックプロパティ名

// プロパティオブザーバ　ストアドプロパティの変更の監視
// ストアドプロパティの変更の監視し、変更前と変更後に文を実行するもの
// toプロパティへの代入時に、willSetキーワード、didSetキーワードで、
// 指定された文が実行される。
struct Greeting3 {
    var to = "Motoki Nakamura" {
        willSet {
            // プロパティの変更前に実行する文
            // 変更後の値には定数newValueとしてアクセスできる。
            print("willSet: (to: \(self.to), newValue: \(newValue))")

        }

        didSet {
            // プロパティの変更後に実行する文
            print("didSet: (to: \(self.to))")
        }
    }
}

var greeting5 = Greeting3()
greeting5.to = "Yuuki Sasaki"

// レイジーストアドプロパティ　アクセス時まで初期化を遅延させるプロパティ
// letキーワードによる再代入不可能なプロパティでは使用できない。
struct SomeStruct6 {
    var value: Int = {
        print("valueの値を生成します")
        return 1
    }()

    lazy var lazyValue: Int = {
        print("lazyValueの値を生成します")
        return 2
    }()
}
// 通常のストアドプロパティはインスタンス化時に初期化が行われ、
// レイジーストアドプロパティはアクセス時に初期化がおこわれている。
var someStruct6 = SomeStruct6()
print("SomeStruct6をインスタンス化しました")
print("valueの値は\(someStruct6.value)です")
// レイジーストアドプロパティはアクセス時に初期化がおこわれている。
print("lazyValueの値は\(someStruct6.lazyValue)です")

// インスタンスの生成よりも後にレイジーストアドプロパティの初期化が行われるため、
// 初期化時には他のプロパティやインスタンスにアクセスできる。
struct SomeStruct7 {
    var value = 1
    lazy var lazyValue = double(of: value)

    func double(of value: Int) -> Int {
        return value * 2
    }

}

var someStruct7 = SomeStruct7()
someStruct7.value
someStruct7.lazyValue
someStruct7.double(of: 4)

// コンピューテッドプロパティ　値を保持せずに算出するプロパティ
// ゲッタ　値の返却
// 他のストアドプロパティなどから値を取得して、今ピューテッドプロパティの値として返す処理
struct Greeting6 {
    var to = "Motoki Nakamura"
    // var プロパティ名: 型名
    var body: String {
        // ストアドプロパティtoを利用した値を取得し、bodyプロパティの値として返す。
        get {
            // return文によって値を返す処理　プロパティの値を返す処理
            return "Hello, \(to)!"// ストアドプロパティtoを利用可能
        }
    }
}
let greeting6 = Greeting6()
greeting6.body

// セッタ　値の更新
// プロパティに代入された値を利用して、他のストアドプロパティなどを更新する処理
struct Temperture {
    // 接し温度を表すストアドプロパティ
    var celsius: Double = 0.0
    // 華氏温度を表すコンピューテッドプロパティ
    var fahrenheit: Double {
        // 摂氏温度をcelsiusを華氏温度に変換して値を返す
        get {
            return (9.0 / 5.0) * celsius + 32.0
        }

        // 華氏温度newValueを接し温度に変換してcelsiusプロパティに代入している。
        set {
            celsius = (5.0 / 9.0) * (newValue - 32.0)
        }
        // セッタで暗黙的に宣言されたnewValueには、()内に定数名を追加する事で、
        // 任意の名前を与える事ができる。
        //        set(newFahrenheit) {
        //            celsius = (5.0 / 9.0) * (newFahrenheit - 32.0)
        //        }
    }
}
//
var temperature = Temperture()
temperature.celsius
temperature.fahrenheit
// celsiusプロパティとfahrenheitプロパティのどちらかを更新すれば、
// もう一方が同じ温度を表すように更新される。
temperature.celsius = 20
temperature.celsius
temperature.fahrenheit
// コンピューテッドプロパティは、今回のようにインスタンスの更新方法が複数あるが、
// プロパティ同士の生合成を持たせたい場合に有用。
temperature.fahrenheit = 32
temperature.celsius
temperature.fahrenheit

// セッタの省略
// セッタが存在しない場合は、getキーワードと{}を省略してゲッタを記述することもできる。
struct Greeting7 {
    var to = "Motoki Nakamura"
    var body: String {
        return "Hello, \(to)!"
    }
}
let greeting7 = Greeting7()
greeting7.body

// セッタが定義されていないコンピューテッドプロパティでは、プロパティの更新ができない。
struct Greeting8 {
    var to = "Motoki Nakamura"
    var body: String {
        return "Hello, \(to)"
    }
}
let greeting8 = Greeting8()
greeting8.body
// greeting8.body = "Hi!"// セッタが定義されていないためエラー


// イニシャライザ　インスタンスの初期化処理
// 定義方法　initキーワードで宣言し、引数と初期化に関する処理を定義する。
//init(引数) {
//    初期化処理
//}

struct Greeting9 {
    // 初期値を持たないため、イニシャライザ内で初期化する必要がある。
    let to: String

    var body: String {
        return "Hello, \(to)!"
    }

    init(to: String) {
        // self.toはプロパティの値を指し、toは引数の値を指す。
        self.to = to
    }
}
// Greeting9型に定義したイニシャライザを用いて、Greeting9型のインスタンスを初期化
let greeting9 = Greeting9(to: "Motoki Nakamura")
let body = greeting9.body

// 失敗可能イニシャライザ 初期化の失敗を考慮したイニシャライザ
struct Item {

    let id: Int
    let title: String

    init?(dictionary: [String: Any]) {
        // idをInt型として取り出せなかった場合と、
        // titleをString型として取り出せなかった場合に初期化を失敗させている。
        guard let id = dictionary["id"] as? Int,
              let title = dictionary["title"] as? String else {
            // このケースではidとtitleは未初期化のままでもコンパイル可能
            return nil
        }
        // self.idはプロパティの値、idはguard let idを指す。
        self.id = id
        // self.titleはプロパティの値、titleはguard let titleを指す。
        self.title = title
    }
}
let dictionaries: [[String: Any]] = [
    ["id": 1, "title": "abc"],
    ["id": 2, "title": "def"],
    ["title": "abc"], // idが欠けている辞書 Item型の初期化が失敗
    ["id": 3, "title": "jkl"]
]

for dictionary in dictionaries {
    // 失敗可能イニシャライザはItem?を返す
    if let item = Item(dictionary: dictionary) {
        print(item)
        print(type(of: item))
    } else {
        print("エラー:　辞書\(dictionary)からItemを生成できませんでした")
    }
}

// コンパイラによる初期化チェック
//struct Greeting10 {
//    let to: String
//    var body: String {
//        return "Hello, \(to)!"
//    }
//    // init内でプロパティtoを初期化していないため、エラーとなる。
//    init(to: String) {
//        // インスタンス化の初期化後にtoが初期値を持たないのでエラー
//        // self.to = to// ここでプロパティを初期化すればコンパイル可能となる。
//    }
//}

//  dictionary["to"]に値が存在しなかった場合、プロパティtoを初期化しないまま
// インスタンス化が終了してしまうためエラーとなる。
//struct Greeting11 {
//
//    let to: String
//
//    var body: String {
//        return "Hello, \(to)!"
//    }
//
//    init(dictionary: [String: STEntryIndex]) {
//        if let to = dictionary["to"] {
//            self.to = to
//        }
//        // プロパティtoを初期化できないケースを定義していないのでエラーとなる。
//    }
//}

// Greeting11の解決方法
// 失敗可能イニシャライザを使用する
struct Greeting12 {

    let to: String

    var body: String {
        return "Hello, \(to)!"
    }

    init?(dictionary: [String: String]) {
        // dictionary["to"]に値が存在しなかった場合は処理を終了
        guard let to = dictionary["to"] else {
            return nil
        }
        // self.idはプロパティの値、idはguard let idを指す。
        self.to = to
    }
}

let greetig12 = Greeting12(dictionary: ["to": "Motoki Nakamura"])
greetig12?.body
greetig12?.to

// デフォルト値の用意
struct Greeting13 {
    let to: String
    var body: String {
        return "Hello, \(to)!"
    }

    init(dictionary: [String: String]) {
        //dictionary["to"]に値が存在しなかった場合の初期値は"Motoki Nakamura"
        to = dictionary["to"] ?? "Motoki Nakamura"
    }
}

// メソッド　型に紐付いた関数
// 呼び出すには、型のインスタンスが代入された変数や定数に.とメソッド名をつけて
// 変数名.メソッド名と書く。引数がある場合は、()内に,区切りでならべる。
struct Greeting14 {
    func greet(user: String) -> Void {
        print("Hello: \(user)")
    }
}

let greeting14 = Greeting14()// 変数greeting14にGreeting14型のインスタンスを代入
greeting14.greet(user: "Motoki Nakamura")// 変数名.メソッド名でメソッドを呼び出す

// 紐付く対象による分類
// インスタンスメソッド　型のインスタンスに紐付くメソッド
struct SomeStruct8 {
    var value = 0

    func printValue() {
        print("value: \(self.value)")
    }
}
// それぞれのインスタンスに応じた値が出力される。
var someStruct8 = SomeStruct8()
someStruct8.value = 1
someStruct8.printValue()

var someStruct9 = SomeStruct8()
someStruct9.value = 2// インスタンス.プロパティ名
someStruct9.printValue()// インスタンス.メソッド名でメソッドの呼び出し

// スタティックメソッド　型自身に紐付くメソッド
// インスタンスに依存しない処理に使う。
struct Greeting15 {
    // スタティックストアドプロパティ　型自身に紐付くプロパティ
    static var signature = "Sent from iPhone"

    // withDevicenameが外部引数名　diviceNameが内部引数名
    static func setSignature(withDevicename deviceName: String) {
        signature = "Sent from \(deviceName)"
    }

    var to = "Motoki Nakamura"
    var body: String {
        // 変数signatureは型自身に紐付くプロパティなので、
        // 型名.プロパティ名でアクセスする。
        return "Hello, \(to)!\n\(Greeting15.signature)"
    }
}
let greeting15 = Greeting15()
print(greeting15.body)
print("-----")
// setSignature()メソッドは型自身に紐付くメソッドなので、型名.メソッド名で呼び出す。
// Xperiaを引数に渡してsignatureプロパティの値をSent from Xperiaに更新している。
Greeting15.setSignature(withDevicename: "Xperia")
print(greeting15.body)

// オーバーロード　型が異なる同名のメソッドの定義
// 引数によるオーバーロード
// 引数によってメソッドをオーバーロードするには引数の型が異なる同名のメソッドを複数定義する
struct Printer {
    // String型の引数を取るput(_:)メソッド
    func put(_ value: String) {
        print("string: \(value)")
    }

    // Int型の引数を取るput(_:)メソッド
    func put(_ value: Int) {
        print("int: \(value)")
    }
}
let printer = Printer()// インスタンスを生成し、変数に代入
// 引数の型によって実行されるメソッドが切り替わっている。
printer.put("abc")// String型のput(_:)メソッドを呼び出し
printer.put(123)// Int型のput(_:)メソッドを呼び出し

// 戻り値によるオーバーロード
// 戻り値によってメソッドをオーバーロードするには、戻り値の型が異なる、
// 同名のメソッドを複数定義する
struct ValueContainer {
    let stringValue = "abc"
    let intValue = 123

    // String型の戻り値を持つメソッド
    func getValue() -> String {
        return stringValue
    }

    // Int型の戻り値を持つメソッド
    func getValue() -> Int {
        return intValue
    }
}
let valueContainer = ValueContainer()
// 戻り値の代入先の定数の型によって、実行されるメソッドが切り替わっている。
// 戻り値の代入先の型アノテーションは省略できない。
let string: String = valueContainer.getValue()
let int: Int = valueContainer.getValue()


// サブスクリプト　コレクションの要素へのアクセス
// 数列を表すProgression型
struct Progression {
    var numbers: [Int]

    // subscript(引数) -> 戻り値の型
    subscript(index: Int) -> Int {
        // 値の取得時にはゲッタが呼び出される。
        get {
            // return文によって値を返す処理
            return numbers[index]
        }
        // 変数名[引数] = 新しい値のようにして、
        // 値が代入される時にはセッタが呼び出される。
        set {
            // 値を更新する処理
            numbers[index] = newValue
        }
    }
}
var progression = Progression(numbers: [1, 2, 3])
// 値の取得　この時にはゲッタが呼び出される。
let element1 = progression[1]// 配列numbersの2番目の要素にアクセス
// 新しい値を代入　この時にはセッタが呼び出される。
progression[1] = 4
// 値の取得　この時にはゲッタが呼び出される。
let element2 = progression[1]

// 引数が複数ある場合
// 行列を表すMatrix型
struct Matrix {
    var rows: [[Int]]

    subscript(row: Int, column: Int) -> Int{
        get {
            return rows[row][column]
        }

        set {
            rows[row][column] = newValue
        }
    }
}
let matrix = Matrix(rows: [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
])
// 外部引数名はデフォルトで_となるため。[1, 1]のように行列内の要素にアクセス出来る。
// 値の取得　この時にはゲッタが呼び出される。
let element = matrix[1, 1]// 2番目の配列の、2つ目の要素へのアクセス。

// セッタの省略
// コンピューテッドプロパティと同様にサブスクリプトでも、セッタの定義は省略出来る。
struct Progression1 {
    var numbers: [Int]

    // サブスクリプトのセッタを削除し、getキーワードと{}も省略している。
    subscript(index: Int) -> Int {
        return numbers[index]
    }
}
var progression1 = Progression1(numbers: [1, 2, 3, 4])
// 外部引数名はデフォルトで_となるため。[2]のように配列内の要素にアクセス出来る。
// 値の取得　この時にはゲッタが呼び出される。
progression1[2]

// Cannot assign through subscript: subscript is get-only
// 添え字を介して割り当てられない：添え字は取得専用です。
// progression1[2] = 5// セッタが定義されていないため値の更新は出来ない。


// エクステンション　型の拡張
// エクステンションで追加したメソッドは、通常のメソッドと同様に使用できる。
// String型を拡張して、printSelf()メソッドを追加している。
extension String {// extension エクステンションを定義する対象の型
    // 対象の方に追加したい要素
    func printSelf() {
        print(self)
    }
}
let string1 = "abc"
string1.printSelf()

// コンピューテッドプロパティの追加
// String型に【 】(隅付きかっこ)で囲んだ値を返す、
// コンピューテッドプロパティenclesedStringを追加している。
extension String {
    var enclosedString: String {
        return "【\(self)】"
    }
}
let title = "重要".enclosedString + "今日は休み"


// 型のネスト 型の中に型を定義できる。
// ニュースフィードのアイテムを表すNewsFeedItem型と、
// その種類を表すNewsFeedItemKind型があったとする。
enum NewsFeedItemKind {
    case a
    case b
    case c
}

struct NewsFeedItem {
    let id: Int
    let title: String
    let type: NewsFeedItemKind
}
// 上記はNewsFeedItemKind型はNewsFeedItem型の種類を表していることは推測できるが、
// 命名で縛っているに過ぎない。
// NewsFeedItemKind型をNewsFeedItem1型の中にネストさせてKindにリネームすると、
// NewFeedItem1.Kind型となる。
struct NewsFeedItem1 {
    enum kind {
        case a
        case b
        case c
    }
    // 初期値を持たないため、イニシャライザ内で初期化する必要がある。
    let id: Int
    let title: String
    let kind: kind

    init(id: Int, title: String, kind: kind) {
        // self.toはプロパティの値を指し、toは引数の値を指す。
        self.id = id
        // self.titleはプロパティの値を指し、titleは引数の値を指す。
        self.title = title
        // self.kindはプロパティの値を指し、kindは引数の値を指す。
        self.kind = kind
    }
}
// 列挙体Kindのa
// NewsFeedItem1.kind型はNewsFeedItemKind型と比べると、NewsFeedItem型との
// 関連性がより明確になっている。
let kind = NewsFeedItem1.kind.a
// 引数kindには、定数kindの値を渡す
let item = NewsFeedItem1(id: 1, title: "Table", kind: kind)
switch item.kind {
case .a: print("kind is a")
case .b: print("kind is b")
case .c: print("kind is c")
}
