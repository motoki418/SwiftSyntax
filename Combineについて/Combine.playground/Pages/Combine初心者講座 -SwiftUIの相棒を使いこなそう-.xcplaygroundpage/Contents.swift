//: [Previous](@previous)

import Foundation
import Combine
// Combine初心者講座 -SwiftUIの相棒を使いこなそう-
// 参考サイト: https://www.bravesoft.co.jp/blog/archives/15610#:~:text=Combine%E3%81%A8%E3%81%AF,13.0%E4%BB%A5%E9%99%8D%E3%81%AB%E3%81%AA%E3%82%8A%E3%81%BE%E3%81%99%E3%80%82

// Combineは「Publisher」「Subscriber」「Operator」の3要素からなり、値を提供するPublisher、Publisherが提供した値を購読するSubscriberの２者間におけるデータの受け渡しがCombineの主な役割となります。一方、OperatorはPublisherが提供する値を受け取り、役割に応じて値を変化させたものを最終的にSubscriberへと流す、中間役職となります。

// またSwiftUIを使ってアプリを作る場合は、ObservableObject Protocolや@PublishedなどのProperty wrapperなど、Combineの機能の一部をCombineを知らない人であっても知らず知らずのうちに実は使用しています。そのためCombineはSwiftUIでアプリを作ろうと思った場合、習得が必須のフレームワークなのです。



// 基礎編

// Subject
// Subjectはsend(_:)を呼び出すことにより、値を注入することができるPublisherです。


var cancelleable: AnyCancellable?
// ①  これがSubject(Publisher)です。
// このPublisherはSubjectのため、前述した通りsendメソッドを利用することが可能になりました。
// また、PassthroughSubjectは型を2つ指定することが可能で一つは送るデータの型、もう一つはエラーになります。
// しかし今回はエラーを送らないため、2つ目にはNeverを指定しています。

let subject = PassthroughSubject<Int, Never>()
// ②  sinkメソッドを使用してPublisherを購読します。
//購読中に値が送られてくるとsinkメソッドの引数であるreciveCompletionやreceiveValueというコールバックメソッドが実行されます。
// また、①の2つ目の型にNeverを指定すると今回のサンプルのようにreciveCompletionを省略することが可能です。
// 今回は値が流れてきた時に標準出力しています。
cancelleable = subject.sink { num in
    print(num)
    type(of: num)
}

// ③ sendメソッドを使って引数の値をSubscriberに送っています。
// 値の送信に成功すると②のsink(receiveValue: Int)に値が送られるため、②で書いた通り引数に設定した値が標準出力されます。
subject.send(1)
subject.send(10)

// ④ 購読をキャンセルします。
// ここでキャンセルされたため、この後に書いているsubject.send(3)は実行されていません。
cancelleable?.cancel()
subject.send(100)// 実行されない

// Future
// Futureは非同期で一つの値を生成して出力するか失敗するPublisherです。
// 従来のClosureで処理していた非同期関数を、Futureに置き換えてみましょう。
// ▼これまでの書き方

print("2秒後に「HOGE」が出力されます")
performAsyncAction {
    print("HOGE")
}

func performAsyncAction(completionHandler: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completionHandler()
    }
}

// ▼ Combineを使った書き方
var cancellable1: AnyCancellable?

print("2秒後に「HOGE」が出力されます")
cancellable1 = performAsyncActionAsFuture().sink() { _ in
    print("HOGE")
}

func performAsyncActionAsFuture() -> Future<Void, Never> {
    return Future() { promiss in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promiss(Result.success(()))
        }
    }
}

// Just
// Justは一つの値を即時出力し、終了するPublisherです。
let subscribe: Just<Int> = Just(1)

subscribe.sink(receiveValue: { num in
    print(num)
})
//: [Next](@next)

