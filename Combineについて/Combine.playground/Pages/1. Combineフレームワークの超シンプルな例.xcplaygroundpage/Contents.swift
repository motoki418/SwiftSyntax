import Foundation
import Combine

// Combineフレームワーク
// 値を出力するパブリッシャーと値を受け取るサブスクライバーの二つがある

// 整数型の値を出力するパブリッシャー
let publisher = Just(100)

// 整数の値を受け取るサブスクライバー
let subscriber = Subscribers.Sink<Int,Never>(receiveCompletion: {
    completion in
    switch completion {
    case .failure(let error):
        print(error.localizedDescription)
    case .finished:
        print("終了")
    }
}, receiveValue: { value in
    print("受け取った値： \(value)")
})
// publisherで出力した値を、subscriberで受け取る
publisher.subscribe(subscriber)


// 上の処理と同じ
Just(999).sink(receiveCompletion: { completion in
    switch completion {
    case .failure(let error):
        print(error.localizedDescription)
    case .finished:
        print("終了")
    }
}, receiveValue: { value in
    print("受け取った値： \(value)")
})

// Switch文を省略した書き方
Just(777).sink(receiveValue: { value in
    print("簡単に受け取り：\(value)")
})
