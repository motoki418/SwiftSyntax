import Foundation


// guard文
/*
 基本的な書式
 guard 条件 else {
    条件式がfalseの時に実行する処理
    return または break 基本的に2つのどちらか必須
 }
 */

// 例　a ÷ bをする関数

func div(a: Int, b: Int) -> Double? {
     // aとbに0を代入するとguard文の中の処理が実行され
    guard a != 0 && b != 0 else {
        print("Error: aまたはbに0を代入しないでください")
        return nil
    }
    // aとbに0以外の数字を代入した時の処理
    return Double(a) / Double(b)
}

div(a: 4, b: 2)// 2
div(a: 3, b: 0)// nil
div(a: 0, b: 0)// nil
// 例
// 今回の例では辞書型pを自作しているため値がある事は分かっているが、
// アプリ開発ではチームで開発するので、もしかしたら値がない可能性がある。
// そのようなときに強制アンラップをするとアプリがクラッシュしてしまう。
let array = ["name" : "中村", "location": "東京", "phone": "11-2222-3333"]

let arryay2 = ["name" : "山田", "phone": "44-5555-6666"]

// 辞書型でアクセスした値はオプショナル型で返ってくる
print(type(of: array["name"]))

func greeting(person: [String : String]) {
    
    // nameキーがない時はguard文の中が実行される
    guard person["name"] != nil else {
        print("Error: 引数データにnameキーが存在しません")
        print("処理を終了します")
        return
    }
    // guard文でnameキーがない時のアンラップ処理を書いているので、ここではnameキーが確実に存在している事になるので強制アンラップをしても大丈夫
    print("こんにちは\(person["name"]!)さん！")
    
    // locationキーがない時はguard文の中が実行される
    guard person["location"] != nil else {
        print("Error: 引数データにlocationキーが存在しません")
        print("処理を終了します")
        return
    }
    // locationキーがない時のアンラップ処理をguard文で書いているので、ここではlocationキーが確実に存在している事になるので強制アンラップをしても大丈夫
    print("今日の\(person["location"]!)は晴れです！")
    
    guard person["phone"] != nil else {
        print("Error: 引数データにphoneキーが存在しません")
        print("処理を終了します")
        return
    }
    print("後で\(person["phone"]!)に電話をかけますね！")
    
}

greeting(person: array)

greeting(person: arryay2)


// guard let文
/*
 基本的な書式
オプショナル型のアンラップができる。
また、guard let 定数名 の定数名はguard letの外でも使える。
 guard let 定数名 = オプショナル型 else {
    アンラップに失敗した場合の処理を記述
    return または break
 }
 */

func sample(value: Int?) {
    
    guard let v = value else {
        print("Error")
        return
    }
    
    print(v, type(of: v))
}
// 定数valueには1000かnilどちらかの値がランダムに代入される
let value = [1000, nil].randomElement()!
sample(value: value)

func greeting2(person: [String: String]) {
    
    guard let value1 = person["name"] else {
        print("Error: 引数データにnameキーが存在しません")
        print("処理を終了します")
        return
    }
    print("こんにちは\(value1)さん！")
    
    guard let value2 = person["location"] else {
        print("Error: 引数データにlocationキーが存在しません")
        print("処理を終了します")
        return
    }
    print("今日の\(value2)の天気はいかがですか？")
    
    guard let value3 = person["phone"] else {
        print("Error: 引数データにphoneキーが存在しません")
        print("処理を終了します")
        return
    }
    print("今日の\(value3)はいかがですか？")
}

greeting2(person: arryay2)
