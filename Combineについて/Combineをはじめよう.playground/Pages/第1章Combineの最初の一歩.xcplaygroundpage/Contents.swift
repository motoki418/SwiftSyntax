import Combine

// 1.2 値の送信と受信
// イベントの型をStringに指定
// Neverはエラーが発生しないことを意味する特別な指定
let subject = PassthroughSubject<String, Never>()

// subject.sendから送られてきた値を受信し、.sink内の処理を行う。
// .sinkはエラーの型がNeverの場合にのみ使用可能。
subject
    .sink { value in
        print("Recived value:", value)
    }
// .sendでsubjectにString型の値を送信
subject.send("あ")
subject.send("い")
subject.send("う")
subject.send("え")
subject.send("お")

print("---------------------")
// 1.3 イベントの完了
let subject1 = PassthroughSubject<String, Never>()

// receiveValueは先ほどと同様にイベントを受信した際に実行する処理です。
// receiveCompletionが新しく増えたクロージャで、イベント完了を受信した際に実行する処理です。
subject1
    .sink(receiveCompletion: { completion in
        print("Received completion:", completion)
    }, receiveValue: { value in
        print("Received Value:", value)
        
    })
subject1.send("あ")
subject1.send("い")
subject1.send("う")
subject1.send("え")
subject1.send("お")
// 値を送信する代わりにイベントの完了を意味する.finishedを送信している
subject1.send(completion: .finished)
// イベント完了の後ではsendメソッドで値を送信しても受信処理は行われない
subject1.send("あ")
subject1.send("い")

print("---------------------")

// 1.4 イベントのエラー
enum MyError: Error {
    case failed
}
// インスタンスを生成する際にイベントの型をStringに、
// エラーの型をMyErrorに指定している。
let subject2 = PassthroughSubject<String, MyError>()
subject2
    .sink(receiveCompletion: { completion in
        print("Received completion:", completion)
    }, receiveValue: { value in
        print("Received value:", value)
    })
subject2.send("あ")
subject2.send("い")
subject2.send("う")
subject2.send("え")
subject2.send("お")
// 、値を送信する代わりにエラーを意味する.failureを送信しています。
// エラーの場合も.finishedと同じreceiveCompletionクロージャが実行されます。

subject2.send(completion: .failure(.failed))
