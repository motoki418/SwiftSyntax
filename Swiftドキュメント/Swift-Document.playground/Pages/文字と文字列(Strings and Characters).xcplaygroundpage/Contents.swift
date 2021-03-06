//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $  Unicode scalar U+0024
let blackHeart = "\u{2664}"      // â¥  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // ð Unicode scalar U+1F496

// ç©ºã®æå­åã®ä½æ(Initializing an Empty String)
// é·ãæå­åãæ§ç¯ããã¨ãã«ãåæå¤ã¨ãã¦ç©ºã®æå­åãä½ãã¨ããæå­åãªãã©ã«ãå¤æ°ã«è¨­å®ãããã
// Stringã®ã¤ãã·ã£ã©ã¤ã¶ãä½¿ç¨ãã¦æ°ããã¤ã³ã¹ã¿ã³ã¹ãåæåãã¾ãã

var emptyString = "" // ç©ºã®æå­å
var anotherEmptyString = String() // ã¤ãã·ã£ã©ã¤ã¶
// 2ã¤ã®å¤æ°ã¯ã©ã¡ããç©ºã®æå­åã§ç­ããã§ã

// isEmpty ã¨ãããã¼ã«å¤ã®ãã­ããã£ããã§ãã¯ãããã¨ã§ String ãç©ºæå­ãã©ãããå¤å®ã§ãã¾ãã
if anotherEmptyString.isEmpty {
    print("Nothing to see here")
} else {
    print(emptyString)
}

//: [Next](@next)
