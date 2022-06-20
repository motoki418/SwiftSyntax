//
//  Bindings-Forms.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/20.
//

// 参考文献
// The Composable Architecture（TCA）におけるBindingの扱い方
// https://bamboo-hero.com/entry/tca-binding
// [SwiftUI]TCAを理解する：binding
// https://zenn.dev/chiii/articles/db7371f5904b2e

// 本サンプルでは、BindableStateというStateの定義をすることで、
// BindingActionというActionを使用し、bindingの処理をより簡潔にすることを学びます。

import ComposableArchitecture
import SwiftUI

private let readMe = """
  This file demonstrates how to handle two-way bindings in the Composable Architecture using \
  bindable state and actions.

  Bindable state and actions allow you to safely eliminate the boilerplate caused by needing to \
  have a unique action for every UI control. Instead, all UI bindings can be consolidated into a \
  single `binding` action that holds onto a `BindingAction` value, and all bindable state can be \
  safeguarded with the `BindableState` property wrapper.

  It is instructive to compare this case study to the "Binding Basics" case study.
  """

// この画面のStateは、以下のような値を保持しています。
// Bindings-Basicsと異なるのは、BindableStateのアノテーションを付与している点と、
// 同じ機能なのにActionのケースが少なくなっている点です。
// BindableActionを継承し、
// BindingActionにBindingFormStateを持つことで一括りで保持出来ます。
struct BindingFormState: Equatable {
    @BindableState var sliderValue = 5.0
    @BindableState var stepCount = 10
    @BindableState var text = ""
    @BindableState var toggleIsOn = false
}

enum BindingFormAction: BindableAction, Equatable {
  case binding(BindingAction<BindingFormState>)
  case resetButtonTapped
}
struct BindingFormEnvironment {}

// ReducerでBindings-Basicsと異なるのは、
// まず各機能のアクションケースごとにStateを更新する必要が無い点と、最後に.binding()というメソッドを使用していることです。
// Reducerのロジックを実行する前に、Stateに対してBindingActionの変更を適用する為のReducerを返します。
// 簡単に整理するとBindingActionを使用する場合は必須なメソッドのようです。
let bindingFormReducer = Reducer<
  BindingFormState, BindingFormAction, BindingFormEnvironment
> {
  state, action, _ in
  switch action {
  case .binding(\.$stepCount):
    state.sliderValue = .minimum(state.sliderValue, Double(state.stepCount))
    return .none

  case .binding:
    return .none

  case .resetButtonTapped:
    state = .init()
    return .none
  }
}
.binding()

// View,Store
// ここでBindings-Basicsと異なるのは、各機能の実行アクションのところです。
// 例えばTextFieldの部分は、Bindings-Basicsではgetとsendでbindingしてましたが、
// 今回の場合は、viewStore.binding(\.$text)だけで済みます。
struct BindingFormView: View {
  let store: Store<BindingFormState, BindingFormAction>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      Form {
        Section(header: Text(readMe)) {
          HStack {
            TextField("Type here", text: viewStore.binding(\.$text))
              .disableAutocorrection(true)
              .foregroundColor(viewStore.toggleIsOn ? .gray : .primary)

          }// HStack
          .disabled(viewStore.toggleIsOn)

          Toggle("Disable other controls", isOn: viewStore.binding(\.$toggleIsOn))

          Stepper(value: viewStore.binding(\.$stepCount), in: 0...100) {
            Text("Max slider value: \(viewStore.stepCount)")
              .font(.body.monospacedDigit())
          }// Stepper
          .disabled(viewStore.toggleIsOn)

          HStack {
            Text("Slider value: \(Int(viewStore.sliderValue))")
              .font(.body.monospacedDigit())

            Slider(value: viewStore.binding(\.$sliderValue), in: 0...Double(viewStore.stepCount))
          }// HStack
          .disabled(viewStore.toggleIsOn)

            Button {
                viewStore.send(.resetButtonTapped)
            } label: {
                Text("Reset")
                    .foregroundColor(.red)
            }// Button
        }// Section
      }// Form
    }// WithViewStore
    .navigationBarTitle("Bindings form")
  }
}


//struct Bindings_Forms_Previews: PreviewProvider {
//    static var previews: some View {
//        Bindings_Forms()
//    }
//}
