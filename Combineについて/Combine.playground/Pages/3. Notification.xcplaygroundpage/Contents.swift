//: [Previous](@previous)

import Foundation
import Combine
// 【Swift】Combine フレームワーク使ってみた 〜 その３ 〜 Notification
extension Notification.Name {
    static let finishCalc = Notification.Name("finishCalc")
}

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
let cancellable =  NotificationCenter.default.publisher(for: .finishCalc, object: nil)
    .map({ notification in
        return notification.userInfo?["result"] as? Int ?? 0
    })
    .assign(to: \.score, on: testResult)


// 採点処理

NotificationCenter.default.post(name: .finishCalc, object: nil, userInfo: ["result": 90])
print("代入後の点数：\(testResult.score)")

//: [Next](@next)
