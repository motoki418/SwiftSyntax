//: [Previous](@previous)

import Foundation

// タイプエイリアス(Type Aliases)
// タイプエイリアス(Type Aliases)は既存の型に別の名前を定義します。typealias キーワードを使います。

typealias AudioSample = UInt16
// ここでは、AudioSample が UInt16 のタイプエイリアスとして定義されています。
// エイリアスなので、AudioSample.minの実態はUInt16.minで、maxAmplitudeFoundの初期値は0になります。
var maxAmplitudeFound = AudioSample.min
print(type(of: maxAmplitudeFound))
// maxAmplitudeFound は 0

//タプル(Tuples)
// タプル(Tuples)は、複数の値を 1 つのまとまりにグループ化します。
// タプル内の値にはどんな型も入れることができ、全ての型を同じにする必要はありません。
// (404, "Not Found") タプルは、HTTP ステータスコードを、
// 2 つの値:(数値と人が理解できる説明文)に分けた Int と String を 1 つのグループにまとめています。
let http404Error = (404, "Not Found")

// タプルの個々の内容をそれぞれ定数や変数に分けて扱うこともでき、他の値と同じようにアクセスすることができます
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// The status code is 404
print("The status message is \(statusMessage)")
// The status message is Not Found
// もしタプルの一部だけが必要な場合、タプルを展開するときに、アンダースコア(_)を使用して無視することができます。
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// The status code is 404

// 各値へのアクセス方法としては、0 から始まるインデックスを使用することもできます
print("The status code is \(http404Error.0)")
// The status code is 404
print("The status message is \(http404Error.1)")
// The status message is Not Found

//タプルの定義時に、名前を付けることもできます
let http200Status = (statusCode: 200, description: "OK")
// 名前を付けた場合、その名前を使用して各値へアクセスすることができます
print("The status code is \(http200Status.statusCode)")
// The status code is 404
print("The status message is \(http200Status.description)")
// The status message is Not Found

// 下記の例は String を Int へ変換するイニシャライザの例です。
// イニシャライザは失敗するかもしれないので、Int ではなく、オプショナルの Int を返します。
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
print(type(of: convertedNumber))

// オプショナルな変数は、特別な値 nil を代入することで、値のない状態を設定することができます:
var serverResoponseCode: Int? = 404
// serverResponseCode Int の値の 404 を含んでいます
serverResoponseCode = nil
// serverResponseCode は 値を含んでいません

// 1 つの if 文の中に、複数のオプショナルバインディングとブール値をカンマ(,)区切りで含めることができます。
// そのうちのいずれかが nil または false の場合、
// if 文全体が false と判断されます。
// 次の if 文はこれに該当します。
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100{
    print("\(firstNumber) < \(secondNumber) < 100")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// 4 < 42 < 100



//: [Next](@next)
