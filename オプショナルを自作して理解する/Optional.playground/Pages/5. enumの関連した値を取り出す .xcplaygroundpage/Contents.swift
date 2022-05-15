//: [Previous](@previous)

import Foundation

// 今回の内容: enumの関連した値を取り出す

// 以下のクーポン種別を表す
// - 半額クーポン
// - 値引きクーポン(x円引き)

enum クーポン {
    case 半額
    case 値引き(Int)// 割引金額を付属する
}

let coupon1: クーポン = .半額

let coupon2: クーポン = .値引き(100)// 100円引き

let coupon3: クーポン = .値引き(200)// 200円引き


func printCoupon(coupon: クーポン) {
    switch coupon {// 引数で受け取ったcoupon
    case .半額:
        print("これは半額クーポンです")
    case .値引き(let yen):
        // let yenはcaseのスコープ内でのみ使用可能
        print("これは\(yen)円引きのクーポンです")
    }
}
// case .半額がマッチする
printCoupon(coupon: .半額)
//  case .値引き(let yen)がマッチする
printCoupon(coupon: .値引き(100))
//  case .値引き(let yen)がマッチする
printCoupon(coupon: .値引き(200))


//: [Next](@next)
