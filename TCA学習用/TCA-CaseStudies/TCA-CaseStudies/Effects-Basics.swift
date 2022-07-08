//
//  Effects-Basics.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/26.
//
// 参考文献
// [SwiftUI]TCAを理解する：Effect
// https://zenn.dev/chiii/articles/e43ebc5c77286a
// Numbers API を利用した実践的なアプリで学ぶ SwiftUI(UIKit) + TCA
// https://qiita.com/kalupas226/items/fb67003d43df8ad057f7#environment

import Combine
import ComposableArchitecture
import SwiftUI

private let readMe = """
  This screen demonstrates how to introduce side effects into a feature built with the \
  Composable Architecture.

  A side effect is a unit of work that needs to be performed in the outside world. For example, an \
  API request needs to reach an external service over HTTP, which brings with it lots of \
  uncertainty and complexity.

  Many things we do in our applications involve side effects, such as timers, database requests, \
  file access, socket connections, and anytime a scheduler is involved (such as debouncing, \
  throttling and delaying), and they are typically difficult to test.

  This application has two simple side effects:

  • Each time you count down the number will be incremented back up after a delay of 1 second.
  • Tapping "Number fact" will trigger an API request to load a piece of trivia about that number.

  Both effects are handled by the reducer, and a full test suite is written to confirm that the \
  effects behave in the way we expect.
  """

// MARK: - Feature domain

struct EffectsBasicsState: Equatable {
    var count = 0
    var isNumberFactRequestInFlight = false
    // numberFactには画面の「Number fact」ボタンを押下した時に、APIをコールし、
    // そのレスポンスを処理し結果を表示する文字列が格納されます。
    var numberFact: String?
}

enum EffectsBasicsAction: Equatable {
    case decrementButtonTapped
    case incrementButtonTapped
    case numberFactButtonTapped
    // numberFactResponseの引数でレスポンスを受け取る
    //「Number fact」ボタンにより発生するEffectの戻りのアクション
    case numberFactResponse(Result<String, FactClient.Error>)
}

struct EffectsBasicsEnvironment {
    var fact: FactClient
    // Schedulerを定義することでEffectで内で、例えばdelayやreceive等で使用します。
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

// MARK: - Feature business logic

let effectsBasicsReducer = Reducer<
    EffectsBasicsState, EffectsBasicsAction, EffectsBasicsEnvironment
> {
    state, action, environment in
    switch action {
    case .decrementButtonTapped:
        state.count -= 1
        state.numberFact = nil
        // Return an effect that re-increments the count after 1 second.
        // 引数のvalueではアクションを定義し、delayメソッドで1秒後にincrementButtonTappedアクションを送っています。

        return Effect(value: EffectsBasicsAction.incrementButtonTapped)
            .delay(for: 1, scheduler: environment.mainQueue)
        // このままだとPublishersなので最後にeraseToEffectでEffectに変換しています。
            .eraseToEffect()

    case .incrementButtonTapped:
        state.count += 1
        state.numberFact = nil
        return .none

    case .numberFactButtonTapped:
        state.isNumberFactRequestInFlight = true
        state.numberFact = nil

        return environment.fact.fetch(state.count)
        // receive(on:) は実行スレッドの指定
            .receive(on: environment.mainQueue)
        // catchToEffectのパラメータは、APIのレスポンスのResultを持つAction(numberFactResponse)を入れることで、
        // そのレスポンスの値を持つActionが走りStateに値を更新出来るようになります
        // catchToEffect()はreceive(on:)でPublisherに変換された型を再び Effectに戻しています。
            .catchToEffect(EffectsBasicsAction.numberFactResponse)

    case let .numberFactResponse(.success(response)):
        state.isNumberFactRequestInFlight = false
        state.numberFact = response
        return .none

    case .numberFactResponse(.failure):
        state.isNumberFactRequestInFlight = false
        return .none

    }
}

// MARK: - Feature view
struct EffectsBasicsView: View {
    let store: Store<EffectsBasicsState, EffectsBasicsAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Text(readMe)) {
                    EmptyView()
                }// Section

                Section(
                    footer: Button {
                        UIApplication.shared.open(URL(string: "http://numbersapi.com")!)
                    } label: {
                        Text("Number facts provided by numbersapi.com")
                    }//  Button,
                ) {
                    HStack {

                        Spacer()

                        Button {
                            viewStore.send(.decrementButtonTapped)
                        } label: {
                            Text("-")
                        }// -Button

                        Text("\(viewStore.count)")

                        Button {
                            viewStore.send(.incrementButtonTapped)
                        } label: {
                            Text("+")
                        }// + Button

                        Spacer()
                    }// HStack
                    .buttonStyle(.borderless)

                    Button {
                        viewStore.send(.numberFactButtonTapped)
                    } label: {
                        Text("Number fact")
                    }

                    // numbersapiからResoponseが返ってくるまでProgressViewを表示する。
                    // numbersapiからResoponseが返ってきたら、isNumberFactRequestInFlightがfalseになり、
                    // ProgressViewを非表示にする。
                    if viewStore.isNumberFactRequestInFlight {
                        ProgressView()
                    }
                    // numberFactはString?型で、numbersapiからResoponseとして文字列が返ってくるまでは、
                    // nilなのでアンラップして取り出す。
                    if let numberFact = viewStore.numberFact {
                        Text(numberFact)
                    }
                }// Section
            }// Form
            .navigationTitle(Text("Effects"))
        }// WithViewStore
    }
}

struct Effects_Basics_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EffectsBasicsView(
                store: Store(
                    initialState: EffectsBasicsState(),
                    reducer: effectsBasicsReducer,
                    environment: EffectsBasicsEnvironment(
                        fact: .live,
                        mainQueue: .main)))
        }
    }
}
