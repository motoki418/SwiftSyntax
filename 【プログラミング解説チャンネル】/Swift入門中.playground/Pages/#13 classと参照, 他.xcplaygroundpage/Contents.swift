//: [Previous](@previous)

import Foundation

// クラス
/*class クラス名 {
    プロパティ定義
    イニシャライザ定義
    メソッド定義
}
 */
print("----クラス-----\n")
// 例
class Human {
    // ストアドインスタンスプロパティ
    var name: String
    var age: Int
    var habit: String?
    
    // initはオプショナル以外のプロパティに対し必須
    // オプショナルはデフォルトでnilが代入される
    init(name: String, age: Int) {
        // self.nameはvar name: Stringを、= nameは引数のnameを指している
        self.name = name
        self.age = age
    }
    
    // インスタンスメソッド
    func greeting() {
        print("こんにちは、私の名前は\(name)です")
    }
    
    // コンピューテッドタイププロパティ
    static var anonymous: Human {
        /*
        get {
           return Human(name: "", age: 0)
        }
        */
        // ゲッタだけの場合はgetを省略できて、処理が1行のみの場合はreturnも省略できる
        Human(name: "", age: 0)
    }
    
    // コンピューテッドインスタンスプロパティ
    var message: String {
        get {
            if let s = habit {
                return s
            } else {
                return "えーっと"
            }
        }
        // セッタはnewValueという暗黙の定数が使用可能
        // newValueには新しい値が代入されている
        set {
            habit = newValue
        }
    }
}

// インスタンス化は基本的に構造体と同じ
var h = Human(name: "中村", age: 25)
h.greeting()
print(h.message)// habitに値が代入されていないのでえーっとを出力
/* messageに値を代入すると、セッタ
set {
    habit = newValue
}
が動く
*/
h.message = "プログラミングは楽しい"
print(h.message)


// クラスは参照型
var i = h
i.message = "読書は楽しい"
print(i.message)


// 継承
/*
 class サブクラス名: スーパークラス名 {
 プロパティ定義
 イニシャライザ定義
 メソッド定義
}
*/
print("\n-----継承について-----\n")
// RPGを意識してHumanクラスの継承を行なっていく
// NPC = ノンプレイヤーキャラクター
class NPC: Human {
    var item: String?
    
    init(name: String, age: Int, item: String?) {
        self.item = item
        /* スーパークラスHumanで定義されているプロパティを初期化する時は、super(スーパークラスのという意味).init(初期化式)で初期化する
        */
        super.init(name: name, age: age)
    }
    
    // 貰えるもの
    var gift: String? {
        item
    }
}

class Player: Human{
    var job: String
    var weapon: String?
    var armor: String?
    var bag = [String]()
    
    init(name: String, age: Int, job: String) {
        // サブクラスで定義したプロパティを先に初期化する
        self.job = job
        // 最後にスーパークラスで定義したプロパティを初期化する
        super.init(name: name, age: age)
    }
    
    // コンピュータからアイテムをもらうメソッド
    func action2NPC(char: NPC) {
        // スーパークラスHumanのnameプロパティ
        print("\n\(name): こんにちは")
        print("\(char.name): こんにちは")
        
        if let gift = char.gift {
            print("\(char.name): \(gift)いらないのであげます")
            print("\(name)は\(gift)をもらった")
            bag.append(gift)
        }
    }
    
    // プレイヤーの持ち物を表示
    func showBag() {
        print("持ち物一覧:\(bag)")
    }
}

let n1 = NPC(name: "山田", age: 20, item: "ポーション")
let n2 = NPC(name: "佐藤", age: 30, item: nil)
let n3 = NPC(name: "鈴木", age: 25, item: "盾")

let p = Player(name: "田中", age: 20, job: "一般人")

p.showBag()
p.action2NPC(char: n1)
p.action2NPC(char: n2)
p.action2NPC(char: n3)
p.showBag()
/* 上記の例では、継承を使用して、人間の性質を表すHumanクラス・コンピューターを表すNPCクラス・プレイヤーを表すPlayerクラス作成している。これにより、部品化ができ、メンテナンスを行いやすくする事ができる。
*/


// オーバーライド = 上書き
/* サブクラスとスーパークラスのメソッドの名前を同じにしたいが、サブクラスのメソッドの処理は変えたい場合がある。そのような場合サブクラスでスーパークラスのメソッドの処理を上書きするオーバーライド等仕組みが用意されている。先頭にoverrideキーワードを付与する。
*/

print("\n-----オーバーライド-----\n")
// 職業勇者を表すサブクラス
class Hero: Player {
    init(name: String, age: Int) {
        // 職業は決まっている
        super.init(name: name, age: age, job: "勇者")
    }
    
    // スーパークラスHumanのgreeting()を上書き
    override func greeting() {
        print("こんにちは、私の名前は\(name)です")
        // Playerクラスにはない処理を追加
        print("勇者やってます！よろしく！")
    }
    
    // コンピューテッドインスタンスプロパティ
    // スーパークラスHumanのmessageプロパティを上書き
    override var message: String {
        get {
            if let s = habit {
                return s
            } else {
                return "ドラゴンを倒したい！\n"
            }
        }
        
        set {
            habit = newValue
        }
    }
}

// 職業魔法使いを表すサブクラス
class Wizard: Player {
    init(name: String, age: Int) {
        // 職業は決まっている
        super.init(name: name, age: age, job: "魔法使い")
    }
    
    // スーパークラスHumanのgreeting()を上書き
    override func greeting() {
        print("こんにちは、私の名前は\(name)です")
        // Playerクラスにはない処理を追加
        print("魔法使いです！")
    }
    
    // コンピューテッドインスタンスプロパティ
    // スーパークラスHumanのmessageプロパティを上書き
    override var message: String {
        get {
            if let s = habit {
                return s
            } else {
                return "あの薬草とこの鉱石を...\n"
            }
        }
        
        set {
            habit = newValue
        }
    }
}

var hero = Hero(name: "斉藤", age: 18)
var wizard = Wizard(name: "木下", age: 20)

hero.greeting()
print(hero.message)

wizard.greeting()
print(wizard.message)

hero.showBag()
hero.action2NPC(char: n1)
hero.action2NPC(char: n2)
hero.action2NPC(char: n3)
hero.showBag()

/*
 今回の継承関係について
        Human
    ↑            ↑
 Player         NPC
    ↑
 Hero, Wizard 2つのサブクラスのスーパークラスはPlayer 親の親はHumanクラス
 */


// クラスに紐づく要素
/* クラスに紐づ多要素としてクラスプロパティ、クラスメソッドがある。
 スタティックプロパティ・メソッドとクラスプロパティ・メソッドの違いは「オーバーライドの可否」にある。クラスプロパティ・メソッドはオーバライド可能。スタティックプロパティ・メソッドはオーバーライド不可能。
*/
print("\n------クラスに紐づく要素------\n")
class Sample {
    // クラスプロパティ
    // 継承先でオーバーライドする場合は、クラスプロパティが適している
    // 継承先でオーバーライドしない場合は、スタティックプロパティでも良い
    class var value: String {
        /*
        get {
           return "こんにちは"
        }
        */
        // ゲッタだけの場合はgetを省略できて、処理が1行のみの場合はreturnも省略できる
        "こんにちは"
    }
    
    // スタティック(タイプ)プロパティ
    static var amount: Int {
        10
    }
    
    // クラスメソッド
    class func showAmount() {
        print("amount: \(self.amount)")
    }
}

var str = Sample.value
print(str)

class Test: Sample {
    
    override class var value: String {
        "Hello, swift world!"
    }
    
    override class func showAmount() {
        print("amount: \(self.amount) pieces")
    }
    
    // スタティックプロパティはオーバーライドできないのでエラーになる。
//    override static var amount: String {
//        20
//    }
}

var testValue = Test.value
print(testValue)
Test.showAmount()
