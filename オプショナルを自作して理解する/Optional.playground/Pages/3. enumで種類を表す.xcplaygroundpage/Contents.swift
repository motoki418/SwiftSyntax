//: [Previous](@previous)

import Foundation

// enumで種類を表す
// 血液型をenumで表している
enum BloodType {
    case a
    case b
    case o
    case ab
}

let myBloodType: BloodType = .a // A型

let yourBloodType: BloodType = .b // B型
// BloodType型には99というケースはないのでエラーになる。
// let hisBloodType: BloodType = 99

enum Device {
    case iPhone
    case iPad
    case mac
}

let myDevice: Device = .iPhone

let yourDevice: Device = .mac
// Device型の変数・定数にはiPhone,iPad,macの3つしか入れられない
// let hisDevice: Device = .playStation
//: [Next](@next)
