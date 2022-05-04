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
