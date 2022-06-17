//: [Previous](@previous)

import Foundation

// 格納プロパティ(Stored Properties)
// 下記の例では、FixedLengthRange という構造体を定義しています。
// これは、作成後に範囲の長さを変更できない整数の範囲を表します。
struct FixedLenghtRange {
    var firstValue: Int
    let length: Int
}
// FixedLengthRange のインスタンスには、firstValue と呼ばれる変数格納プロパティと length という定数格納プロパティがあります。
// 下記の例では、定数のため、長さは新しい範囲が作成されたときに初期化され、それ以降は変更できません。
var rangeOfThreeItems = FixedLenghtRange(firstValue: 0, length: 3)
print(rangeOfThreeItems)
// 0, 1, 2 の整数の範囲を表しています
rangeOfThreeItems.firstValue = 6
// 6, 7, 8 の整数の範囲を表しています

let rangeOfFourItems = FixedLenghtRange(firstValue: 0, length: 4)
// 0, 1, 2 の整数の範囲を表しています
//rangeOfFourItems.firstValue = 6
// firstValue は変数ですがエラーになります
// この挙動は、構造体が値型のためです。
// 値型のインスタンスが定数としてマークされている場合、その全てのプロパティも同様です。

// 参照型のクラスには同じことが当てはまりません。
// 参照型のインスタンスを定数に割り当てた場合でも、そのインスタンスの変数を変更できます。

// 遅延格納プロパティ(Lazy Stored Properties)
// 遅延格納プロパティは、最初に使用されるまで初期値が計算されないプロパティです。
// 宣言の前に lazy 修飾子を記述して、遅延格納プロパティを示します。
class DataImporter {
    /*
       DataImporter は、外部ファイルからデータをインポートするためのクラスです
       このクラスは、初期化にかなりの時間がかかると想定します
       */
       var filename = "data.txt"
       // DataImporter クラスは、ここでデータのインポート機能を提供します
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // DataManager クラスはここでデータの管理機能を提供します
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// importer プロパティの DataImporter インスタンスはまだ作成されていません
// lazy 修飾子でマークされているため、importer プロパティの DataImporter インスタンスは、
// importer プロパティが最初にアクセスされたとき(filename プロパティが照会されたときなど)にのみ作成されます。
print(manager.importer.filename)
//: [Next](@next)
