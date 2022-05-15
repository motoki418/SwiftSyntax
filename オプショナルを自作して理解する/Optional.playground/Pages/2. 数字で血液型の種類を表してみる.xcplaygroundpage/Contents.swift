//: [Previous](@previous)

import Foundation

// 数字で血液型の種類を表してみる

//var myBloodType: Int = 0 // A
//myBloodType = 1 // B
//myBloodType =2 // O
//myBloodType =3 // AB

// 問題点：1や2が何を表すのかぱっと見でわからない

// 解決策：各血液型を表す定数を作る
let bloodTypeA: Int = 0 // A
let bloodTypeB = 1 // B
let bloodTypeO = 2 // O
let bloodTypeAB = 3 // AB
// Aを入れている事がわかる
let myBloodTyepA: Int = bloodTypeA

// 問題点：Int型なので、A,B,O,AB以外も入れられてしまう。
let yourBloodType: Int = 5 //5は何型?

//: [Next](@next)
