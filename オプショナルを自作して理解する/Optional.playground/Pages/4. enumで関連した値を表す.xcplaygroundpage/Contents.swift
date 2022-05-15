//: [Previous](@previous)

import Foundation

// 今回の例: enumで関連した値を表す
// 例1
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


// 例2
// 以下の名前種別を表す
// - 匿名
// - 記名(具体的な名前も表す)

enum 名前 {
    case 匿名
    case 記名(String)
}

let name: 名前 = .匿名

let name2: 名前 = .記名("佐藤")

let name3: 名前 = .記名("John")
//: [Next](@next)
