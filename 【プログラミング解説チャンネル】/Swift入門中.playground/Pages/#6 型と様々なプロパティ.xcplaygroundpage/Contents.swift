import Foundation

// カスタムな型とプロパティの分類
// カスタムな型
// ユーザークラス
class User {
    // インスタンスプロパティ
    let ID: Int
    var name: String
    var age: Int
    var type: UserType
    // プロパティを持った型を使用するにはインスタンス化が必要
    // 型名(イニシャライザで指定した引数)
    init(ID: Int, name: String, age: Int) {
        self.ID = ID
        self.name = name
        self.age = age
        self.type = UserType()
    }
    
    // メソッド
    func selfIntroduction() {
        var str = "初めましてこんにちは\n"
        str += "私は\(self.name)と申します。\n"
        str += "以後ご承知おきください"
        print(str)
    }
    
    func userData() {
        var str = "ID:\(ID)\n名前:\(name)\n"
        str += "年齢:\(age)\nユーザータイプ:\(type)"
        print(str)
    }
}

// ユーザータイプ列挙型
enum UserType {
    case guest
    case host
    case owner
    
    // タイププロパティ
    static let guide = "これはユーザーのタイプを扱う型です"
    
    // イニシャライザ
    init() {
        self = .guest
    }
    
    // メソッド
    // タイププロパティは型名.プロパティ名でアクセス
    func printGuide() {
        print(UserType.guide)
    }
}

// インスタンス化
let user = User(ID: 39, name: "中村", age: 25)
// インスタンスプロパティはインスタンス名.プロパティ名でアクセス
print(user.name)
user.selfIntroduction()
user.userData()

/* プロパティの分類は4つに分けられる
 ・ ストアドインススタンスプロパティ
 ・ ストアドタイププロパティ
 ・ コンピューテッドインスタンスプロパティ
 ・ コンピューテッドタイププロパティ
 */

class Sphere {
    // ストアドタイププロパティ
    static let info = "これは球体を便利に扱うクラスです"
    // ストアドインスタンスプロパティ
    var radius: Double// 半径
    
    // イニシャライザ
    // 今回はradiusがどの変数のことかが自明ためselfを省略できる。
    init(r: Double) {
        radius = r
    }
    
    // コンピューテッドインスタンスプロパティ
    // 球の表面積　4πr2乗
    var area: Double {
        // プロパティにアクセスするとgetが動く
        get {
            // 戻り値
            return 4 * Double.pi * radius * radius
        }
        // プロパティに値を代入すると動く
        set(p) {
            radius = sqrt(p / (4 * Double.pi))
        }
    }
    // コンピューテッドインスタンスプロパティ
    // 球の体積
    var volume: Double {
        get {
            return 4 / 3 * Double.pi * radius * radius * radius
        }
        
        set(p) {
            radius = pow(3 * p / (4 * Double.pi), 1 / 3)
        }
    }
    
    // コンピューテッドタイププロパティ
    // Unit = 単位 = 1
    static var unit: Sphere {
        // getのみは可だが、setのみは不可(get,set両方必要)
        get {
            return Sphere(r: 1.0)
        }
    }
    // コンピューテッドプロパティは、
    // ゲッタのみの場合getを省略可能 ←実用上重要
    // 処理が1行の場合returnが省略可能 ←実用上重要
    // 半径が0の球
    static var zero: Sphere {
        Sphere(r: 0.0)
    }
}

// コンピューテッドインスタンスプロパティの使い方
// インスタンス化
let s = Sphere(r: 10)
// 半径10の球の表面積
// Shpere構造体のareaのget{}が動く
var value = s.area
print("表面積は: \(value)")

// 表面積から半径を決める
print("変更前: \(s.radius)")
// Shpere構造体のareaのパラメータpに100が代入され、set{}が動く
s.area = 100
print("変更後: \(s.radius)")


// コンピューテッドタイププロパティの使い方
let t = Sphere.unit
// 型名.プロパティ名でアクセス
print("半径1の球の表面積は\(t.area)")
print("半径1の球の体積は\(t.volume)")

// 型が決まっていると型名の省略ができる ←実用上重要
let u: Sphere
u = .zero
// 1行で書くとこうなる
let w: Sphere = .zero

// こんな使い方ができる
func printInfo(s: Sphere) {
    var str = "球の情報を出力します\n"
    str += "半径：\(s.radius)\n"
    str += "表面積：\(s.area)\n"
    str += "体積：\(s.volume)\n"
    print(str)
}
// 型が決まっているので型名を省略して .プロパティ名でアクセス出来る。
// 列挙型と同じ仕組み
printInfo(s: .unit)
printInfo(s: .zero)
