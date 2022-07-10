import Combine
import Foundation
// 4.1 バインディング
// @Publishedとassignメソッドを使用したバインディング
final class Model {
    // valueが変更されるとViewModelのtextも自動的に変更される
    @Published var value: String = "0"
}

let model = Model()

final class ViewModel {
    var text: String = "" {
        didSet {
            print("didSet text:", text)
        }
    }
}

final class Receiver {
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel()
    
    init() {
        model.$value
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
    }
}
let receiver = Receiver()
model.value = "1"
model.value = "2"
model.value = "3"
model.value = "4"
model.value = "5"

print("----------4.1 バインディングここまで-------------")


// 4.2 map
// バインディングしたい型(今回はvalueとtext)が一致していない時に使う
final class Model1 {
    @Published var value: Int = 0
}
let model1 = Model1()

final class ViewModel1 {
    var text: String = "" {
        didSet {
            print("didSet text:", text)
        }
    }
}

final class Receiver1 {
    var subscriptions = Set<AnyCancellable>()
    let viewModel1 = ViewModel1()
    let formatter = NumberFormatter()
    
    init() {
        formatter.numberStyle = .spellOut
        model1.$value
        // Int型をString型に変換し、assignには変換後の値が渡される
            .map { value in
                self.formatter.string(
                    from: NSNumber(integerLiteral: value)) ?? ""
            }
            .assign(to: \.text, on: viewModel1)
            .store(in: &subscriptions)
    }
}

let receiver1 = Receiver1()
model1.value = 1
model1.value = 2
model1.value = 3
model1.value = 4
model1.value = 5
print("----------4.2 mapここまで-------------")


// 4.4 filter
// 条件に適合しない値をpublishしないようにするメソッド
// 今回はfilterを使用して、偶数のみpublishする処理を記述
final class Model2 {
    @Published var value: Int = 0
}
let model2 = Model2()

final class ViewModel2 {
    var text: String = "" {
        didSet{
        print("didSet text:", text)
        }
    }
}
final class Receiver2 {
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel2()
    let formatter = NumberFormatter()
    
    init() {
        formatter.numberStyle = .spellOut
        
        model2.$value
        // 偶数のみpublishする
            .filter { value in
                value % 2 == 0
            }
        // Int型をString型に変換
            .map { value in
                self.formatter.string(
                    from: NSNumber(integerLiteral: value)) ?? ""
            }
        // \.textはViewModel2クラスのプロパティtextを指定している
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
    }
}
let receiver2 = Receiver2()
model2.value = 1
model2.value = 2
model2.value = 3
model2.value = 4
model2.value = 5

print("----------4.4 filterここまで-------------")

// compactMap
// mapと似ているが、値がnilになった場合はpublishしない
final class Model3 {
    @Published var value: Int = 0
}
let model3 = Model3()

final class ViewModel3 {
    var text: String = "" {
        didSet {
            print("didSet text:", text)
        }
    }
}

final class Receiver3 {
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel3()
    let formatter = NumberFormatter()
    
    init() {
        formatter.numberStyle = .spellOut
        
        model3.$value
        // compactMapはnilをpublishしないので、クロージャの中で明示的にアンラップ処理を書く必要がない
            .compactMap { value in
                self.formatter.string(from: NSNumber(integerLiteral: value))
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
    }
}
let receiver3 = Receiver3()
model3.value = 1
model3.value = 2
model3.value = 3
model3.value = 4
model3.value = 5

print("----------4.5 compactMapここまで-------------")

// 4.6 combineLatest
// 二つのPublisherから一つのPublisherを作るOperator

final class Model4 {
    let subjectX = PassthroughSubject<String, Never>()
    let subjectY = PassthroughSubject<String, Never>()
}
let model4 = Model4()

final class ViewModel4 {
    var text: String = "" {
        didSet {
            print("didSet text:", text)
        }
    }
}
final class Receiver4 {
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel4()
    
    init() {
        model4.subjectX
        // combineLatestは、ふたつのPublisherのうちどちらかがpublishした場合に両方の最新の値をタプルで組にしてpublishするというもの
        // ただし、片方がまだひとつもpublishしていない場合はpublishしません。
            .combineLatest(model4.subjectY)
            .map { valueX, valueY in
                "X:" + valueX + " Y:" + valueY
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
    }
}
let receiver4 = Receiver4()
model4.subjectX.send("1")
model4.subjectX.send("2")
model4.subjectY.send("3")
model4.subjectY.send("4")
model4.subjectX.send("5")

//: [Next](@next)

