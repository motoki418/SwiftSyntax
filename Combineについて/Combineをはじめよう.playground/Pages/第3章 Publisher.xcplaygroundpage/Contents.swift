import Combine
import Foundation

// 3.2 Sequence
// ArrayからPublisherを生成し、Arrayの要素を順番にpublishして、
// 最後に.finishedをpublishする。
let publisher = ["あ","い","う","え","お"].publisher
//let publisher = [1 ... 5].publisher
print(type(of: publisher))

final class Receiver {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        publisher
            .sink(receiveCompletion: { completion in
                print("Received completion:", completion)
            }, receiveValue: { value in
                print("Received value:", value)
            })
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()

print("---------3.2 Sequenceここまで----------")


// 3.3 Timer
// 1秒ごとに現在時刻をpublishするPublisher
let publisher1 = Timer.publish(every: 1, on: .main, in: .common)

final class Receiver1 {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        publisher1
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}
let receiver1 = Receiver1()
// TimerクラスのPublisherはconnect()を行わないとイベントをpublishしないことに注意
publisher1.connect()

print("---------3.3 Timerここまで----------")


// 3.4 Notification
let myNotification = Notification.Name("MyNotification")
type(of: myNotification)
let publisher2 = NotificationCenter.default.publisher(for: myNotification)
type(of: publisher2)

final class Receiver2 {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        publisher2
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}

let receiver2 = Receiver2()
NotificationCenter.default.post(Notification(name: myNotification))

print("---------3.4 Notificationここまで----------")


// 3.5 URLSession
let url = URL(string:"https://www.example.com")!
let publisher3 = URLSession.shared.dataTaskPublisher(for: url)

final class Receiver3 {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        publisher3
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Recevied error:", error)
                } else {
                    print("Recevied completion:", completion)
                }
            }, receiveValue: { data, response in
                print("Recevied data:", data)
                print("Recevied response:", response)
            })
            .store(in: &subscriptions)
            
    }
}

let receiver3 = Receiver3()
print("---------3.5 URLSessionここまで----------")


// 3.6 Subject
let subject = CurrentValueSubject<String, Never>("A")

final class Receiver4 {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        subject
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}
let receiver4 = Receiver4()
subject.send("あ")
subject.send("い")
subject.send("う")
subject.send("え")
subject.send("お")
print("Current value:", subject.value)

print("---------3.6 Subjectここまで----------")

// 3.7 Subjectの型消去
let subject5 = PassthroughSubject<String, Never>()
type(of: subject5)
// eraseToAnyPublisher()でsubject5がPassthroughSubjectから、単なるPublisherに変更される
let publisher5 = subject5.eraseToAnyPublisher()
type(of: publisher5)

final class Receiver5 {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // subject5を使わずにPublisheだけを使うように出来ている
        publisher5
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}
let receiver5 = Receiver5()
subject.send("か")
subject.send("き")
subject.send("く")
subject.send("け")
subject.send("こ")

print("---------3.7 Subjectの型消去ここまで----------")

// 3.8 @Published
final class Sender {
    @Published var event: String = "A"
}

let sender = Sender()

final class Receiver6 {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        sender.$event
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}

let receiver6 = Receiver6()
sender.event = "さ"
sender.event = "し"
sender.event = "す"
sender.event = "せ"
sender.event = "そ"
//: [Next](@next)
