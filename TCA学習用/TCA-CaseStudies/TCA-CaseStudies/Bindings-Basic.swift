//
//  Bindings-Basic.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/18.
//

// 参考文献
// The Composable Architecture（TCA）におけるBindingの扱い方
// https://bamboo-hero.com/entry/tca-binding
// [SwiftUI]TCAを理解する：binding
// https://zenn.dev/chiii/articles/db7371f5904b2e

// 本サンプルの要点
// TCAには単方向データフローを強制する仕組みが備わっている
// Bindingにおいても単方向データフローが守られている
// BindingActionを使用することで、UIコントロールに対するActionを一つに統合することができる

import ComposableArchitecture
import SwiftUI

private let readMe = """
  This file demonstrates how to handle two-way bindings in the Composable Architecture.

  Two-way bindings in SwiftUI are powerful, but also go against the grain of the "unidirectional \
  data flow" of the Composable Architecture. This is because anything can mutate the value \
  whenever it wants.

  On the other hand, the Composable Architecture demands that mutations can only happen by sending \
  actions to the store, and this means there is only ever one place to see how the state of our \
  feature evolves, which is the reducer.

  Any SwiftUI component that requires a Binding to do its job can be used in the Composable \
  Architecture. You can derive a Binding from your ViewStore by using the `binding` method. This \
  will allow you to specify what state renders the component, and what action to send when the \
  component changes, which means you can keep using a unidirectional style for your feature.
  """

// この画面のStateは、以下のような値を保持しています。
struct BindingBasicsState: Equatable {
    var sliderValue = 5.0
    var stepCount = 10
    var text = ""
    var toggleIsOn = false
}

enum BindingBaseicsAction {
    case sliderValueChanged(Double)// Actionに引数を持たせる
    case stepCountChanged(Int)
    case textChanged(String)
    case toggleChanged(isOn: Bool)
}

struct BindingBasicsEnivironment {}

let bindingBasicsReducer = Reducer<
    BindingBasicsState, BindingBaseicsAction, BindingBasicsEnivironment
> {
    state, action, _ in
    switch action {
        // 本サンプルでは、SliderはstepCountより大きい値を指定することはできないという仕様になっています。
        // このようなドメインのロジックはReducerに閉じ込めるというのがTCAにおけるルールです。
    case let .sliderValueChanged(value): // Actionの引数の値でStateを更新します。
        state.sliderValue = value
        return .none

    case let .stepCountChanged(count):
        state.sliderValue = .minimum(state.sliderValue, Double(count))
        state.stepCount = count
        return .none

    case let .textChanged(text):
        state.text = text
        return .none

    case let .toggleChanged(isOn):
        state.toggleIsOn = isOn
        return .none
    }
}

struct BindingsBasicsView: View {
    let store: Store<BindingBasicsState, BindingBaseicsAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Text(readMe)) {
                    HStack {
                        TextField(
                            "Type here",
                            // ここのポイントは、bindingを使用している、
                            // viewStore.binding(get: \.text, send: BindingBasicsAction.textChanged)です。
                            // TextFieldで入力された値をgetに、sendでこれまでと同じようにActionに送っています。
                            // 他のTextField以外のコンポーネント(Toggle, Stepper, Slider)も同様です。
                            // ここのget,setのパラメータで双方向のバインディング
                            text: viewStore.binding(get: \.text, send: BindingBaseicsAction.textChanged)
                        )// TextField
                        .disableAutocorrection(false)
                        .foregroundColor(viewStore.toggleIsOn ? .gray : .orange)
                        Text(viewStore.text)
                    }// HStack
                    .disabled(viewStore.toggleIsOn)

                    Toggle(
                        isOn: viewStore.binding(get: \.toggleIsOn, send: BindingBaseicsAction.toggleChanged)
                    ) {
                        Text("Disable other controls")
                    }// Toggle

                    // ViewStore.binding(get:send:)でBindingを生成します。
                    // get:にはViewStoreが持っているStateを取り出す関数もしくはKeyPathを指定します。
                    // send:にはActionを指定します。
                    // 画面操作でStepperの値が変更されたときに、ここで指定したActionが送信されます。

                    Stepper(value: viewStore.binding(
                        get: \.stepCount,send: BindingBaseicsAction.stepCountChanged),
                            in: 0...100
                    ) {
                        Text("Max slider value: \(viewStore.stepCount)")
                    }// Stepper
                    .disabled(viewStore.toggleIsOn)

                    HStack {
                        Text("Slider value: \(Int(viewStore.sliderValue))")
                        // Stepperと同じくSliderの値変更時にActionが送信されます。
                        Slider(value: viewStore.binding(
                            get: \.sliderValue,
                            send: BindingBaseicsAction.sliderValueChanged
                        ),
                               in: 0...Double(viewStore.stepCount)
                        )// Slider
                    }// Hstack
                    .disabled(viewStore.toggleIsOn)
                }// Section
            }// Formここまで
        }// WithViewStore
        .navigationTitle("Bindings basics")
    }
}

//struct Bindings_Basic_Previews: PreviewProvider {
//    static var previews: some View {
//        Bindings_Basic()
//    }
//}
