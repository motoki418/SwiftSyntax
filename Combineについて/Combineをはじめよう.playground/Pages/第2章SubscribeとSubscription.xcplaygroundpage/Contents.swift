import Combine
import Foundation

let subject = PassthroughSubject<String, Never>()

// イベントの受信側をクラスとして分離
// 2.1 sinkメソッド
final class Receiver {
    // sinkメソッドには戻り値があるため、sinkで指定した受信処理を有効にするには、sinkの戻り値を破棄せずに保持しておく必要がある
    // 定数subscriptionがsinkの戻り値を保持している
    let subscription: AnyCancellable
    
    init() {
        subscription = subject
            .sink { value in
                print("Received value:", value)
        }
    }
}

let receiver = Receiver()
subject.send("あ")
subject.send("い")
subject.send("う")
subject.send("え")
subject.send("お")

print("---------- 2.1 sinkメソッドここまで----------")

// 2.2 subscriptionのキャンセル
let subject1 = PassthroughSubject<String, Never>()

final class Receiver1 {
    // sinkで指定した受信処理を有効にするには、sinkの戻り値を破棄せずに保持しておく必要がある
    // subscriptionがsinkの戻り値を保持している
    let subscription: AnyCancellable
    
    init() {
        subscription = subject1
            .sink { value in
                print("Received value:", value)
        }
    }
}

let receiver1 = Receiver1()
subject1.send("か")
subject1.send("き")
subject1.send("く")
// subscription(subscribeの戻り値・受信)のキャンセル
receiver1.subscription.cancel()
// subscriptionがキャンセルされた後の受信処理は実行されない
subject1.send("け")
subject1.send("こ")


print("--------2.2 subscriptionのキャンセルここまで----------")
// 2.3 複数のsubscription
let subject2 = PassthroughSubject<String, Never>()

final class Receiver2 {
    let subscription1: AnyCancellable
    let subscription2: AnyCancellable
    
    init() {
        subscription1 = subject2
            .sink { value in
                print("[1] Received value:", value)
        }
        
        subscription2 = subject2
            .sink { value in
                print("[2] Received value:", value)
        }
    }
}
let receiver2 = Receiver2()
// 複数のsubscribeを行なった場合は、両方のsubscriptionで受信処理が実行される
subject2.send("さ")
subject2.send("し")
subject2.send("す")
// 片方だけキャンセルしても、もう片方のsubscriptionでは継続して受信処理が実行される
receiver2.subscription1.cancel()
subject2.send("せ")
subject2.send("そ")


print("----------2.3 複数のsubscriptionここまで----------")


// 2.4 storeメソッド
// 複数のsubscriptionを扱う場合、それらをまとめて保持したい時に使う

let subject3 = PassthroughSubject<String, Never>()

final class Receiver3 {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        subject3.sink { value in
            print("[1] Received value:", value)
        }
        // storeメソッドはCancellableプロトコルに用意されている
        // sinkの戻り値に対してstoreメソッドを呼ぶ事で、
        // 複数のsubscriptionをまとめて保持することが出来る。
        .store(in: &subscriptions)
        
        subject3.sink { value in
            print("[2] Received value:", value)
        }
        .store(in: &subscriptions)
    }
}

let receiver3 = Receiver3()
subject3.send("た")
subject3.send("ち")
subject3.send("つ")
subject3.send("て")
subject3.send("と")

print("----------2.4 storeメソッドここまで----------")


// 2.5 assignメソッド
// assignメソッドはsinkメソッドと同様にイベントを受信するsubscribeの処理の一種。
let subject4 = PassthroughSubject<String, Never>()

final class SomeObject {
    
    var value: String = "" {
        didSet {
            print("didSet value:", value)
        }
    }
}

final class Receiver4 {
    var subscriptions = Set<AnyCancellable>()
    let object = SomeObject()
    
    init() {
        subject4
        // \.valueはSomeObjectのクラスのプロパティvalueを指定している
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver4 = Receiver4()
subject4.send("な")
subject4.send("に")
subject4.send("ぬ")
subject4.send("ね")
subject4.send("の")

//: [Next](@next)
