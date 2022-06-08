//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $  Unicode scalar U+0024
let blackHeart = "\u{2664}"      // ♥  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖 Unicode scalar U+1F496

// 空の文字列の作成(Initializing an Empty String)
// 長い文字列を構築するときに、初期値として空の文字列を作るとき、文字列リテラルを変数に設定するか、
// Stringのイニシャライザを使用して新しいインスタンスを初期化します。

var emptyString = "" // 空の文字列
var anotherEmptyString = String() // イニシャライザ
// 2つの変数はどちらも空の文字列で等しいです

// isEmpty というブール値のプロパティをチェックすることで String が空文字かどうかを判定できます。
if anotherEmptyString.isEmpty {
    print("Nothing to see here")
} else {
    print(emptyString)
}

//: [Next](@next)
