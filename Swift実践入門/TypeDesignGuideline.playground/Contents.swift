import UIKit
import Foundation

var greeting = "Hello, playground"

// 型の設計指針

// クラスに対する構造体の優位性
// 参照型のクラスがもたらすバグ
// クラスは様々な箇所で共有され、それぞれの箇所で値が更新されるため、
// そのインスタンスがどのような経路を辿ってきたかによって実行結果が変わってしまう。
// それにより、コードの一部を見ただけでは結果を推論することは困難になってしまう。
class Temperature {
    var celsius: Double = 0
}

class Country {
    var temperature: Temperature

    init(temperature: Temperature) {
        self.temperature = temperature
    }
}
let temperature = Temperature()
// 日本の気温を25度に設定
temperature.celsius = 25
// 参照型では、インスタンスが引数として渡されたときにその参照が渡される。
let Japan = Country(temperature: temperature)
// エジプトの気温を40度に設定
temperature.celsius = 40
let Egypt = Country(temperature: temperature)
// クラスは参照型なので、日本とエジプトの気温が両方とも40度になってしまう
// 同じインスタンスを参照しているので、片方の値を変更するともう片方の値も変わってしまう。
Japan.temperature.celsius
Egypt.temperature.celsius

// 値型の構造体がもたらす安全性
// 値型では、インスタンスが引数として渡されるときに、その参照ではなく値そのものが渡される。
// つまり、インスタンスのコピーが渡される。
struct Temperature1 {
    var celsius: Double = 0
}

struct Country1 {
    var temperature: Temperature1
}

var temperature1 = Temperature1()
temperature1.celsius = 25
// Japan1とEgypt1は別々のインスタンを保持している。
let Japan1 = Country1(temperature: temperature1)
temperature1.celsius = 40
let Egypt1 = Country1(temperature: temperature1)
Japan1.temperature.celsius
Egypt1.temperature.celsius

// コピーオンライト　構造体の不要なコピーを発生させない最適化
var array1 = [1, 2, 3]
var array2 = array1
array1
array2
// array1.append(4)が実行されてarray1とarray2に違いが生じるときに初めてコピーが発生する
// array1の変更はarray2には影響しない。
array1.append(4)
array1
array2

// クラスを利用するべきとき
// 参照を共有する必要がある・インスタンスのライフサイクルに合わせて処理を実行する
// 参照を共有する必要がある

// インスタンスのライフサイクルに合わせて処理を実行する
