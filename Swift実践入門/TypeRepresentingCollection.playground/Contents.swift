import UIKit

var greeting = "Hello, playground"

// Array<Element>型　配列を表す型
// 配列リテラル
let a = [1, 2, 3]
let b = ["a", "b", "c"]
// 型推論
let strings = ["a", "b", "c"]// [String]型
let numbers = [1, 2, 3]// [Int]型
// からの場合は型推論できないので、型を明示する必要がある。
let array: [Int] = []
// 複数の型の要素を含む場合も型推論できないので、型を明示する必要がある。
let array1: [Any] = [1, "a"]

// 要素に出来る型
let integerArrays = [[1, 2, 3],[4, 5, 6]]// [[Int]]型 二次元配列

// Array<Element>型の操作
// 要素へのアクセス
// Array<Element>型の要素にアクセスするには、サブスクリプトを使用する
// コレクション[インデックス]
let strings1 = ["abc", "def", "ghi"]// インデックスは0,1,2
let strings2 = strings1[0]
let strings3 = strings1[1]
let strings4 = strings1[2]

// 要素の更新、追加、結合、削除
// 要素の更新
//　コレクション[インデックス] = 新しい値
var strings5 = ["abc", "def", "ghi"]// インデックスは0,1,2
strings5[1] = "xyz"
strings5

// 要素の追加
// 末尾に追加はappend(_:)を使用する
var integers = [1, 2, 3]
integers.append(4)
// 任意の位置に追加するにはinsert(_:)メソッドを使用する
var integers1 = [1, 3, 4]
integers1.insert(2, at: 1)

// 要素の結合
var integers2 = [1, 2, 3]
var integers3 = [4, 5, 6]
let result = integers2 + integers3

// 要素の削除
var integers4 = [1, 2, 3, 4, 5]
// 任意のインデックスの要素を削除するremove(_:)メソッド
integers4.remove(at: 2)
integers4
// 最後の要素を削除するremoveLast()メソッド
integers4.removeLast()
integers4
// 全ての要素を削除するremoveAll()メソッド
integers4.removeAll()
integers4


// Dictionary<Key, Value>型 辞書を表す型
// 辞書リテラル
// Dictionary<Key, Value>型は、["Key1": "Value1", "Key2": "Value2"]
// のように辞書リテラルで表現できる。
let dictionary = ["a": 1 , "b": 2]// [String: Int]型
let dictionary1: [String: Int] = [:]// 空の辞書

// キーと値にできる型
// Dictionary<Key, Value>型は正式には、Dictionary<Key : Hashable, Value>型
// Key型に指定できる型は、Hashableプロトコルに準拠していなければならない。
// Value型には型の制限はない。
// [String: [Int]]型の辞書
let dictionary2 = ["even": [2, 4, 6, 8], "odd": [1, 3, 5, 7, 9]]
//let dictionary3: [String: Int] = [
//    1: 2,//キーの方が異なるためエラー
//    "Key": "Value"// 値の型が異なるためエラー
//]

// Dictionary<Key, Value>型の操作
// 値へのアクセス
// サブスクリプトの引数にはKey型の値を指定する
// 返却される値の型がOptional<Value>型　<Value>はプレースホルダ型
let dictionary3 = ["key": 1]
let value = dictionary3["key"]

// "key1"と"key2"の値をnilと比較し、値が存在しているか確認している。
let dictionary4 = ["key1": "Value1"]
let valueForKey1Exists = dictionary4["key1"] != nil// 値があるためtrue
let valueForKey2Exists = dictionary4["key2"] != nil// 値がないためfalse

// 値の更新、追加、削除
// 更新
var dictionary5 = ["key": 1]
dictionary5["key1"] = 2
dictionary5
// 追加
var dictionary6 = ["key1": 1]
dictionary6["key2"] = 2
dictionary6
// 削除
var dictionary7 = ["key1": 1]
dictionary7["key1"] = nil
dictionary7


// 範囲型
// ..<演算子　末尾の値を含まない範囲を作る演算子
// 1.0..<3.5は、1.0以上3.5未満という範囲を表す、Range<Double>型の値を生成する
let range = 1..<4// CountableRange(1..<4)CountableRange<Int>型
for value in range {
    print(value)
}

// ...演算子 末尾の値を含む範囲を作る演算子
// 1.0...3.5は、1.0以上3.5以下という範囲を表す、CloseRange<Double>型の値を生成する
let range1 = 1...4// CountableClosedRange(1..<4)CountableClosedRange<Int>型
for value in range1 {
    print(value)
}

// 型推論
// プレースホルダ型Boundは、両辺の値から型推論される
let integerRange = 1..<3// CountableRange<Int>型
type(of: integerRange)
let doubleRange = 1.0..<3.0// Range<Double>型
type(of: doubleRange)
// 型アノテーションを用いて、両辺の値に関わらず、 Range<Float>型の値を生成
let floatRange: Range<Float> = 1..<3// Range<Float>型
type(of: floatRange)

// 範囲型の基本的な操作
// 境界の値へのアクセス
let range2 = 1.0..<4.0// Range(1.0..<4.0)
range2.lowerBound// 範囲の先頭の値
range2.upperBound// 範囲の末尾の値

let countableRange = 1..<4// CountableRange(1..<4)
countableRange.lowerBound
countableRange.upperBound

let closedRange = 1.0...4.0// CloseRange(1.0...4.0)
closedRange.lowerBound
closedRange.upperBound

let countableCloseRange = 1...4// countableCloseRange(1...4)
countableRange.lowerBound
countableRange.upperBound

// 片側範囲の場合は、片方の境界にのみアクセスできる
let rangeThrough = ...3.0// PartialRangeThrough(...3.0)
rangeThrough.upperBound
//rangeThrough.lowerBound// lowerBoundは存在しないためエラー
let rangeUpTo = ..<3.0// PartialRangeUpTo(..<3.0)
rangeUpTo.upperBound
//rangeUpTo.lowerBound// lowerBoundは存在しないためエラー

let rangeFrom = 3.0...// PartialRangeFrom(3.0...)
rangeFrom.lowerBound
//rangeFrom.upperBound// upperBoundは存在しないためエラー

let countableRangeFrom = 3...//CountablePartialRangeFrom(3...)
countableRangeFrom.lowerBound
//countableRangeFrom.upperBound// upperBoundは存在しないためエラー

// 値が範囲に含まれるかどうかの判定
// contains(_:)メソッドはBound型の値を受け取り、値が範囲に含まれているかどうかを、
// Bool型の値として返却する
let range3 = 1...4// CountableClosedRange(1...4)
range3.contains(2)// true
range3.contains(5)

// コレクションとしてのString型
// Character型　文字を表す型
// "a"のような単一の文字を表す型
let string = "a"
type(of: string)
let character: Character = "a"
type(of: character)

//String.Index型 文字列内の位置を表す型
let string1 = "abc"
let startIndex = string1.startIndex
type(of: startIndex)
let endIndex = string1.endIndex
type(of: endIndex)
let string2 = "abc"
let character1 = string1[string1.startIndex]

// 二番目の文字を取得する
// index(_:offsetBy)メソッドは、
// コレクション.index(元になるインデックス、offsetBy: ずらす数)という書式で利用する
let string3 = "abc"
let bIndex = string3.index(string3.startIndex, offsetBy: 1)
// 最後の文字を取得する
// 最後の文字から-1することで最後の文字を取得できる
//let cIndex = string3[string3.endIndex]// これは実行時エラーになる
let cIndex = string3.index(string3.endIndex, offsetBy: -1)

let string4 = "abc"
// 文字数のカウント
string4.count

// 要素の列挙
// for-in文を用いて、全ての要素に順次アクセス
for character in string4 {
    print(character)
}

// シーケンスとコレクションを扱うためのプロトコル
// Sequenceプロトコル　要素への順次アクセス

// forEach(_:)メソッド　要素に対して順次アクセスする
// 配列arrayの要素にアクセスし、その値を順次配列enumratedに追加する
let array2 = [1, 2, 3, 4, 5,6]
var enumerated = [] as [Int]
array2.forEach({ element in enumerated.append(element) })
enumerated

//filter(_:)メソッド　要素を絞り込む
// [Int]型の配列array3の要素のうち、2の倍数のものだけを含む、配列filterdを生成する
let array3 = [1, 2, 3, 4, 5, 6]
let filtered = array3.filter({ element in element % 2 == 0})
filtered

// map(_:)メソッド　要素を変換する
// [Int]型の配列array4の各要素を、2倍にした配列doubledを生成する
let array4 = [1, 2, 3, 4, 5, 6]
let doubled = array4.map({ element in element * 2})
doubled

// map(_:)メソッドを用いて、別の型のシーケンスへと変換することもできる
//[Int]型の配列array5を、[String]型の配列convetedに変換
let array5 = [1, 2, 3, 4, 5, 6]
let conveted = array5.map({ element in String(element)})
conveted

// flatMap(_:)メソッド　要素をシーケンスに変換し、それを1つのシーケンスに変換する
// 元々の要素と、それに1を足した値を含む配列を返却している
// 要素1を[1,2]、要素4を[3,4]、要素7を[7,8]へと変換している
let array6 = [1, 4, 7]
let array7 = array6.flatMap({ value in [value, value + 1] })
array7
// 上記の処理をmap(_:)メソッドに置き換えると、値が配列に二重に包まれた[[Int]]型になる
let array8 = [1, 4, 7]
let array9 = array8.map({ value in [value, value + 1] })
array9

// compactMap(_:)メソッド　要素を失敗する可能性のある処理を用いて変換する
// Int型に変換できる要素のみを配列integers6に格納する
let strings6 = ["abc", "123", "def", "456"]
let integers6 = strings6.compactMap({ value in Int(value) })
integers6
type(of: integers6)

// reduce(_:_:)メソッド　要素を1つの値にまとめる
// 配列array10の要素を足し合わせ、定数sumにInt型の値21を代入している
let array10 = [1, 2, 3, 4, 5, 6]
let sum = array10.reduce(0, { result, element in result + element})
sum
// 配列array10の要素を文字列にして連結し、
// String型の値"123456"を定数concatに代入している
let concat = array10.reduce("", { result, element in result + String(element) })
concat

// Collectionプロトコル　サブスクリプトによる要素へのアクセス
let array11 = [1, 2, 3, 4, 5, 6]
// サブスクリプトによる要素へのアクセス　指定した要素の読み書きを行う
array11[3]
// isEmptyプロパティ　コレクションが空かどうかを判定する
array11.isEmpty
// countプロパティ　要素の個数を取得する
array11.count
// firstプロパティ 最初の要素を取得する
array11.first
// lastプロパティ 最後の要素を取得する
array11.last
