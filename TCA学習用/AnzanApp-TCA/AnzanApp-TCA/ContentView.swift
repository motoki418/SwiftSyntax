//
//  ContentView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/29.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {

    @State private var isShowAlert = false
    let store: Store<CounterState, CoutnerAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Image("bunbougu_kokuban")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack {
                    HStack {
                        Text("\(viewStore.state.firstNumber) + \(viewStore.state.secondNumber) =")
                            .font(.largeTitle)
                        TextField(
                            "答えは？",
                            text: viewStore.binding(get: \.inputText, send: CoutnerAction.textChanged))
                        //小数点入力可能な数値キーボードにする。
                        .keyboardType(.decimalPad)
                        //高さを40pxに指定
                        .frame(height: 40)
                        //幅を100pxに指定
                        .frame(width: 100)
                        //TextFieldに丸みのある長方形の枠を付加する
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }// HStack
                    .frame(width:300)
                    .frame(height: 60)
                    .background(Color.backgroundColor)

                    Button {
                        if viewStore.inputText.isEmpty{
                            self.isShowAlert.toggle()
                            viewStore.send(.alertDismissed)
                        } else if !viewStore.inputText.isEmpty {
                            viewStore.send(.AnswerButtonTapped)
                            print(viewStore.inputNumber)
                        }
                    } label: {
                        Text("答える")
                            .font(.title)
                        //ボタンの横幅を100pxに
                            .frame(width:100)
                        //ボタンの高さを60pxに
                            .frame(height: 60)
                    }// Button
                    .background(Color.backgroundColor)
                }// VStack
                .onAppear {
                    viewStore.send(.onAppear)
                }// onAppear
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text("注意"), message: Text("答えを入力してください"), dismissButton: .default(Text("了解")))
                }
            }// ZStack
        }// WithViewStore
    }// body
}// ContentView

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
