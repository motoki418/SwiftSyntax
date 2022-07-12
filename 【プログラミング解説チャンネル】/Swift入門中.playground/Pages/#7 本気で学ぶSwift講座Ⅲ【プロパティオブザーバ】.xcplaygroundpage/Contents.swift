import Foundation

// プロパティオブザーバ
// ストアドプロパティ(格納プロパティ)の値の変更を監視するための仕組み
// willSetキーワードはプロパティの値が変更される前に実行される処理を指定する。
// didSetキーワードはプロパティの値が変更された後に実行される処理を指定する。

// 書式
/* var プロパティ名: 型名(= 初期値） {
 
    willSet{
        変更前に実行したい処理を指定する
    }
 
    didSet{
        変更後に実行したい処理を指定する
    }
 }
*/

class ID {
    
    var id: Int = 0
    
    func getID() -> Int {
    // IDの重複を避けるためにgetIDメソッドを呼び出すたびに1を足していく
        id += 1
        return id
    }
}

class User {
    
    let id: Int
    
    var name: String {
        // プロパティオブザーバを使用することで、
        // 他のプロパティと連携を取ることが出来る。
        willSet {
            print("氏名が変更されようとしています: \(name)")
        }
        
        didSet {
            print("氏名が正常に変更されました: \(name)")
            // 氏名が変更されるたびにカウントして変更回数を記録する
            count += 1
        }
    }
    // 氏名の変更回数格納する
    var count: Int
    
    init(id: ID, name: String) {
        self.id = id.getID()
        self.name = name
        self.count = 0
    }
    
    // 情報を出力する
    func info() {
        var str = "ID: \(self.id)\n"
        str += "氏名: \(self.name)\n"
        str += "変更回数: \(self.count)"
        print(str)
    }
}
// インスタンス化
let id = ID()
var user = User(id: id, name: "Yamada")
user.info()
/*
 ID: 1
 氏名: Yamada
 変更回数: 0
*/

// 氏名を変更
// nameの値が変わるとwillSet,didSetの処理が動く
user.name = "Suzuki"
/*
 氏名が変更されようとしています: Yamada
 氏名が正常に変更されました: Suzuki
*/

user.info()
/*
 ID: 1
 氏名: Suzuki
 変更回数: 1
*/



print("----------------------------")
/*
 プロパティオブザーバの暗黙の引数
 willSetの中には新しく代入された値であるnewValue,
 didSetの中には変更前の値であるoldValueという定数が暗黙的に用意されている
*/

// 在庫数を管理するクラス
class Product {
    
    var name : String
    
    init(name: String) {
        self.name = name
    }
    
    var stockNum: Int = 150 {
        willSet {
            print("\(self.name)の在庫数が変更されようとしています")
            // パラメータに名前をつけない場合は、
            // デフォルトパラメータ名としてnewValueが使用できる
            // newValueは変更後の値が格納されている
            print("変更内容: \(stockNum) -> \(newValue)")
        }
        
        didSet {
            print("\(self.name)の在庫数が変更されました")
            // パラメータに名前をつけない場合は、
            // デフォルトパラメータ名としてoldValueが使用できる
            // oldValueは変更前の値が格納されている
            print("変更内容: \(oldValue) -> \(stockNum)")
        }
    }
}

var parasol = Product(name: "日傘")
// stockNumの値が変わるとwillSet,didSetの処理が動く
parasol.stockNum = 10
/*
 日傘の在庫数が変更されようとしています
 変更内容: 150 -> 10
 日傘の在庫数が変更されました
 変更内容: 150 -> 10
*/

/*
 プロパティオブザーバは新しい値が新しい値がプロパティの現在の値と同じ場合でも、
 プロパティの値が設定されるたびに呼び出される
*/
parasol.stockNum = 10
/*
 日傘の在庫数が変更されようとしています
 変更内容: 10 -> 10
 日傘の在庫数が変更されました
 変更内容: 10 -> 10
*/
