import Combine
// “2.2　Publisherの概要”
// リスト2.1: Justオペレーターの利用例
let publisher = Just(1)
publisher
    .sink(receiveCompletion: {
        print("completion:", $0)// completion: .finished 完了した時に呼ばれる
    }, receiveValue: {
        print("value:", $0)// value: 1 イベントを受信した時に呼ばれる
    })


// リスト2.4: AnySubscriberの利用例

let subscriber1 = AnySubscriber<Int, Never>(receiveSubscription: {
    print("subscription")
    $0.request(.unlimited)
}, receiveValue: {
    print("receive:", $0)
    return .unlimited
}, receiveCompletion: {
    print("completion:", $0)
})

let publisher1 = Just(1)
publisher1.subscribe(subscriber1)
//let subscriber = AnySubscriber<Int, Never>(receiveSubscription: {
//    print("subscription:")
//    $0.request(.unlimited)
//}, receiveValue: {
//    print("receive:", $0)
//    return .unlimited
//}, receiveCompletion: {
//    print("completion:", $0)
//})
//
//
//let publisher = Just(1)
//publisher.subscribe(subscriber)
//
//
