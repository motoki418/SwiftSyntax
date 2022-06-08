//: [Previous](@previous)

import Foundation
// シンプルな値(Simple Values)

var myVariable = 42
myVariable = 50
let myConstant = 42

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 4

let label = "The width is"
let width = 94
// 他の型に変換したい場合は、変換したい型のインスタンスを明示的に作成する。
let widthLabel = label + String(width)
// 型が違うため演算をしているため、エラーとなる
// let widthLabel = label + width

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitsSummary = "I have \(apples + oranges) prices of fruit."

let quptation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit"
"""

var optionalString: String? = "Hello"
print(optionalString == nil)
print(optionalString != nil)

// 制御フロー(Control Flow)
var optionalName: String? = nil
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Good Morining"
}

let nickName: String? = nil
let fullName: String? = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"

let vegetable = "red pepper"
print(vegetable)
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it aspicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

var n = 101
while n < 100 {
    n *= 2
}
print(n)
let cat = "🐱"; print(cat)

let anotherPi = 3 + 0.14159
print(type(of: anotherPi))
//: [Next](@next)
