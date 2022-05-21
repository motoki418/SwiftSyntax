//: [Previous](@previous)

import Foundation
import Combine

// 【Swift】Combineフレームワーク使ってみた 〜 その２ 〜 オペレーター

// クラスの点数を管理するclass
class TestResult {
    var score: Int
    init(score: Int) {
        self.score = score
    }
}
let testResult = TestResult(score: 0)
print("点数：\(testResult.score)")

// testResultのscoreプロパティに受け取った値を渡し代入する
// assignがサブスクライバー
let cancellable = Just(100).assign(to: \.score, on: testResult)

print("代入後の点数：\(testResult.score)")

// クラスの点数を管理するclass
// 値を出力するパブリッシャーと値を受け取るサブスクライバーの型が違うとエラーになるので、
// 値の型などを変換するオペレーターを使用する
// パブリッシャー(値を出力する )
//       ↓　Int型
// オペレーター(値の型などを変換する )
//       ↓　String型
// サブスクライバー(値を受け取る)
class TestResult1 {
    var score: String
    init(score: String) {
        self.score = score
    }
}
let testResult1 = TestResult1(score: "0")
print("点数：\(testResult1.score)")

// testResultのscoreプロパティに受け取った値を渡し代入する
// assignがサブスクライバー
let cancellable1 = Just(100)
// .mapでInt型をString型に変換する
    .map({ value in
        return String(value)
    })
// ↑.assignから見ると上の4行がパブリッシャーとなる。
    .assign(to: \.score, on: testResult1)

print("代入後の点数：\(testResult1.score)")
//: [Next](@next)

