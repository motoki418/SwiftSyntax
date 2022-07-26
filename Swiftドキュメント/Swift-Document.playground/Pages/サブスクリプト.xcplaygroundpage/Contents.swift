//: [Previous](@previous)

import Foundation

// subscript 構文
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTiemsTable = TimesTable(multiplier: 3)
print("six times three is \(threeTiemsTable[6])")
