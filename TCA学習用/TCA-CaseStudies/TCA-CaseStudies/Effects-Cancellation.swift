//
//  Effects-Cancellation.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/27.
//
// 参考文献
// [SwiftUI]TCAを理解する：Effect
// https://zenn.dev/chiii/articles/e43ebc5c77286a

import Combine
import ComposableArchitecture
import SwiftUI

private let readMe = """
  This screen demonstrates how one can cancel in-flight effects in the Composable Architecture.

  Use the stepper to count to a number, and then tap the "Number fact" button to fetch \
  a random fact about that number using an API.

  While the API request is in-flight, you can tap "Cancel" to cancel the effect and prevent \
  it from feeding data back into the application. Interacting with the stepper while a \
  request is in-flight will also cancel it.
  """

// MARK: - Demo app domain

struct EffectsCancellationState: Equatable {
    var count = 0
    var currentTrivia: String?
    var isTriviaRequestFlight = false
}

enum EffectsCancellationAction: Equatable {
    case cancelButtonTapped
    // 今回はStepperで+,-incrementとdecrementを実装
    // Effects-Basicsのincrement・decrementが、
    // 今回はStepperで実装されているのでstepperChangedのみになっています。
    case stepperChanged(Int)
    case triviaButtonTapped
    // numberFactResponseの引数でレスポンスを受け取る
    //「Number fact」ボタンにより発生するEffectの戻りのアクション
    case triviaResoponse(Result<String, FactClient.Error>)
}

struct EffectsCancellationEnvironment {
    var fact: FactClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

// MARK: - Business logic

let effectsCancellationReducer = Reducer<EffectsCancellationState, EffectsCancellationAction, EffectsCancellationEnvironment
> {
    state, action, environment in

    enum TriviaRequestId {}

    switch action {
    case.cancelButtonTapped:
        state.isTriviaRequestFlight = false
        return .cancel(id: TriviaRequestId.self)

    case let .stepperChanged(value):
        state.count = value
        state.currentTrivia = nil
        state.isTriviaRequestFlight = false
        return .cancel(id: TriviaRequestId.self)

    case .triviaButtonTapped:
        state.currentTrivia = nil
        state.isTriviaRequestFlight = true

        return environment.fact.fetch(state.count)
            .delay(for: 1, scheduler: environment.mainQueue)
        // receive(on:) は実行スレッドの指定
            .receive(on: environment.mainQueue)
        // catchToEffect()はreceive(on:)でPublisherに変換された型を再び Effectに戻しています。
            .catchToEffect(EffectsCancellationAction.triviaResoponse)

        // .catchToEffectの後に.cancellableメソッドを定義することで、
        // Effectをキャンセル可能なものに変更します。
            .cancellable(id: TriviaRequestId.self)

    case let .triviaResoponse(.success(response)):
        state.isTriviaRequestFlight = false
        state.currentTrivia = response
        return .none

    case .triviaResoponse(.failure):
        state.isTriviaRequestFlight = false
        return .none
    }
}
struct EffectsCancellationView: View {
    let store: Store<EffectsCancellationState, EffectsCancellationAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Text(readMe),
                        footer:  Button {
                    UIApplication.shared.open(URL(string: "http://numbersapi.com")!)
                } label: {
                    Text("Number fact provided by number")
                }// Button
                ) {
                    Stepper(value: viewStore.binding(
                        get: \.count,
                        send: EffectsCancellationAction.stepperChanged)
                    ) {
                        Text("\(viewStore.count)")
                    }// Stepper

                    if viewStore.isTriviaRequestFlight {
                        HStack {
                            Button {
                                viewStore.send(.cancelButtonTapped)
                            } label: {
                                Text("Cancel")
                            }// Cancel Button

                            Spacer()

                            ProgressView()

                        }// HStack
                    } else {
                        Button {
                            viewStore.send(.triviaButtonTapped)
                        } label: {
                            Text("Number fact")
                        }
                        .disabled(viewStore.isTriviaRequestFlight)

                        viewStore.currentTrivia.map {
                            Text($0)
                                .padding(.vertical, 8)
                        }
                    }// if else
                }// Section
            }// Form
        }// WithViewStore
        .navigationTitle("Effect cancellation")
    }
}


struct Effects_Cancellation_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EffectsCancellationView(
                store: Store(
                    initialState: EffectsCancellationState(),
                    reducer: effectsCancellationReducer,
                    environment: EffectsCancellationEnvironment.init(
                        fact: .live,
                        mainQueue: .main
                    )
                )
            )
        }
    }
}
