import UIKit
//
//var greeting = "Hello, playground"
//// 配列
//var g = 1.2
//var f = [g/2.0, g/0.3, g/0.04]// 配列には、式を代入することも可能
//print(f)
//
//let digits = ["00", "01", "02", "03"]
//print(digits[2])
//print(digits.count)
//// 配列も値型のデータなので、コピーすると複製が作成される
//var nums = digits// numsにはdigits配列の複製が作られる。
//nums[2] = "Two"// 変数には代入可能
//// digits[2] = "Two"// エラー：定数 let digitsには代入できない
//print(digits[2])// 02を出力(コピー元の配列には影響がない)
//print(digits)//コピー元(let digits)の配列には影響がない
//print(nums)
//
//var roman = ["Ⅰ", "II", "III"]
//// appendメソッドで配列の末尾に要素を追加
//roman.append("IV")
//print(roman)
//let m = roman + ["5", "6"]
//print(m)
//roman += ["V", "VI"]
//print(roman)
//
//// 演算子
//// 値を次々に代入する記法は利用出来ない
//// a = b = 1 許されない
//// if a = 1 { 許されない
//
//// 演算子の記述に関する注意
//var a = 1
//var b = 2
//// 演算子の両側に空白があるか、どちらにも空白がない場合は、二項演算子として解釈される
//a + b// 二項演算子
//a+b// 二項演算子
//// b /(a +1) // 演算子/と+の前後に空白を入れるか、あるいは取り除く
//
//// 識別子
//// 単語の先頭を全て大文字開始のアッパーキャメルケースは、型名、クラス名などに使用する
////Int Void AnyObject CustomStringConvertible
//
//// 先頭の文字だけを小文字にするローアーキャメルケースは、メソッド名、変数名などに使用する
////message totalCount nextPartialResult
//
//// fallthroughはSwiftの予約語だが、バククォート「`」で囲むと変数名として利用できる
//var `fallthrough` = 10
//
//// 型パラメータ
//// Int型の配列であるという宣言は通常はこちらの気泡を使う(わかりやすいため)
//var a1: [Int]
//// Int型の配列であるという宣言はこのようにも書ける
//var a2: Array<Int>
//
//// モジュールのインポート
////import Cocoa // Cocoaフレームワークのインポート
////import UIKit // UIKitフレームワークのインポート
////import Foundation // 対話的に使うならFoundationだけで十分
////import Darwin // Founcationのうち、OS関係のもの
//
//let val = 10032
//var i = 1, mask = 2
//while mask <= val {
//    mask <<= 1
//    i += 1
//    print(i)
//}
//
//// repeat while文
//// コラッツの問題
//// nが偶数の時は2で割る、奇数の時は3倍して1を足すという操作を繰り返すと
//// 必ず1に到達するという未解決問題
//var n = 7// 任意の正整数でよい
//repeat {
//    print("\(n)", terminator: ",")// 改行しない
//    if n % 2 == 0 {// nが偶数の時は
//        n /= 2// nを2で割る
//    } else {// nが奇数の時は
//        n = n * 3 + 1// nを3倍して1を足す
//    }
//} while n > 1// nが1以下になるまで、repeat文の中の処理を繰り返す
//print(n)
//
//// for-in文
//
//for i in 1..<5 {
//    print(i)// iの値は、1,2,3,4となって{}内を4回実行する
//}
//
//for k in 1...5 {
//    print(k)// kの値は、1,2,3,4,5となって{}内を5回実行する
//}
//// for-in文を使用して、九九の表を作成
//for i in 1 ..< 10 {// iにはletやvarは指定しない
//    var line = "" // 1行分の文字を蓄える
//    for j in 1 ..< 10 {
//        let n = i * j// varではなく、letでよい
//        if n < 10 {
//            line += " "//文字列を連結
//        }// if文
//        line += " \(n)"
//    }
//    print(line)
//}
//// for-in分にはオプションでwhere説を記述し、
//// その条件に当てはまるコードブロックを実行させる事が出来る
//// where節を使って、3と8の倍数を表示しないように指定
//for i in 1..<64 where i % 3 != 0 && i % 8 != 0 {
//    // printはデフォルトでは、文字列を出力したあとに改行されるが、
//    // printを改行したくない場合は、引数にterminatorを指定し、空文字("")を渡す
//    print(i, terminator: " ")// 数字と空白を改行せずに表示
//}
//print()// 改行だけ
//// 配列から一致する文字列を探す(for-in文)
//let name = "koko"
//let group: [String] = ["jonah", "visha", "koko", "valmet", "tenya"]
//for s in group {
//    if name == s {// group配列と一致した文字列のみを出力
//        print("\(s)が見つかりました")
//        break// 繰り返しをやめる
//    }
//}
//
//// switch文
////switch 式 {　式に()は不要
////case ラベル1: 複数の連続が可能
////    文... 　breakは不要
////default: この部分はオプション　記述する場合は最後に書く
////    文...
////}
//let r = 3
//switch r {
//case 0: print("none")// breakは不要
////case 1: エラー 何か文がなければならない
//case 2, 3:// 複数を列挙する場合はこのように記述
//    print("a few")
//case 4,5:// 上の節から下に実行が及ぶことはない。
//    print("some")
//case 6: break// breakを記述しても良い
//default:// defaultは最後に書く
//    print("several")
//}
//
//let 追加下限 = 45
//var score = 74// 例えば得点が65点なら
//switch score {
//case 追加下限..<75: print("追試験")// 65点ならここを実行する
//case 90...100: print("秀")
//case 80...90: print("優")
//case 70...80: print("良")
//case 60..<70: print("可")
//default: print("不可")
//}

// ラベル付きのループ文
let days = 31// 1ヶ月の日数
let firstDay = 2// 1日目の曜日（0：日曜）
var w = 0// 曜日のための変数
while w < firstDay {// 月初めに空白を入れる
    print("   ", terminator: "")// 改行しない
    w += 1
}

var d = 1// 日にちを示す変数
loop: while true {
    while w < 7 {
        let pad = d < 10 ? " " : ""// 一桁の場合の詰め物
        print(pad + " \(d)", terminator: "")
        w += 1
        d += 1

        if d > days {// 月末になったら
            print()// 改行する
            break loop// 外側のループから脱出
        }
    }
    print()// 週の終わり
    w = 0// 曜日を日曜に戻す
}
