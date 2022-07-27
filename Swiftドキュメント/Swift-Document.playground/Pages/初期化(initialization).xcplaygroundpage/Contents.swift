//: [Previous](@previous)

import Foundation


print("\n--------格納プロパティの初期値の設定--------\n")
// 格納プロパティの初期値の設定
// イニシャライザ
/*
 定義方法
 init() {
    ここでプロパティの初期化を実行する
 }
 
 下記の例では、華氏で表された温度を保存するために Fahrenheit
 という新しい構造体を定義している。
 Fahrenheit構造体には、Double型のtemperatureという1つの格納プロパティがある。
*/
struct Fahrenheit {
    
    var temperature: Double
    
    // プロパティの初期値を定義時に割り当てる
    var temperature1: Double = 20.0
    
    // パラメータのない単一のイニシャライザを定義
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
print("The default temperature1 is \(f.temperature1)° Fahrenheit")

print("\n------初期化のカスタマイズ-------\n")
// 初期化のカスタマイズ
// イニシャライザのパラメータ
// 摂氏で表された温度を格納するCelsiusという構造体を定義
struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.0
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print("boilingPointOfWater.temperatureInCelsiusは摂氏\(boilingPointOfWater.temperatureInCelsius)°")
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print("freezingPointOfWater.temperatureInCelsius は摂氏\(freezingPointOfWater.temperatureInCelsius)°")


print("\n-------パラメータ名と引数ラベル-------\n")
// パラメータ名と引数ラベル
// 三原色を表す構造体
struct Color {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
print(magenta)
let halfGray = Color(white: 0.5)
print(halfGray)
// 引数ラベルが必要になるため、下記のイニシャライザはコンパイルエラーになります
// let veryGreen = Color(0.0, 1.0, 0.0)


print("\n-------引数ラベルのないイニシャライザパラメータ-------\n")
// 引数ラベルのないイニシャライザパラメータ
// イニシャライザに引数ラベルを使用したくない場合は、アンダースコア(_)を記述する
struct Celsius1 {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.0
    }
    
    init(_ kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
// イニシャライザの呼び出しCelsius(37.0)は、意図が明確なので引数ラベルを必要としない
let bodyTemperature = Celsius1(37.0)
print("bodyTemperature.temperatureInCelsius は摂氏\(bodyTemperature.temperatureInCelsius)°")


print("\n-------オプショナルのプロパティ型-------\n")
// オプショナルのプロパティ型
// アンケートの質問を表すクラス
class SurveyQuestrion {
    var text: String
    var response: String?
    
    // initはオプショナル以外のプロパティに対し必須
    // オプショナルはデフォルトでnilが代入される
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
        print(response  ?? "まだこの質問への回答がありません")
    }
}

let cheeseQuestion = SurveyQuestrion(text: "チーズは好きですか?")
cheeseQuestion.ask()
let pizzaQuestion = SurveyQuestrion(text: "ピザは好きですか?")
cheeseQuestion.response = "はい、ピザは好きです"
cheeseQuestion.ask()
