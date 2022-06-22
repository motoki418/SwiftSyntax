//
//  OptionalState.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/20.
//

// 参考文献
// [SwiftUI]TCAを理解する：OptionalState、Stateの共有
// https://zenn.dev/chiii/articles/2e814245384089#sharedstate-1


import ComposableArchitecture
import SwiftUI

private let readMe = """
  This screen demonstrates how to show and hide views based on the presence of some optional child \
  state.

  The parent state holds a `CounterState?` value. When it is `nil` we will default to a plain text \
  view. But when it is non-`nil` we will show a view fragment for a counter that operates on the \
  non-optional counter state.

  Tapping "Toggle counter state" will flip between the `nil` and non-`nil` counter states.
  """
// 今回の場合StateのoptionalCounterが、optional型である事が1つのポイントとなります。

struct OptionalBasicsState: Equatable {
    var optionalCounter: CounterState?
}

enum OptionalBasicsAction: Equatable {
    case optionalCounter(CounterAction)
    case toggleCounterButtonTapped
}

struct OptionalBasicsEnvironment {}

// toggleCounterButtonTappedのActionがコールされた際に、
// Stateの更新の部分でoptionalの場合を考慮していて、
// nilの場合はCounterStateを入れ、non-nilの場合はnilを入れています。
let optionalBassicsReducer =
counterReducer
    .optional()// ポイント
    .pullback(
        state: \.optionalCounter,
        action: /OptionalBasicsAction.optionalCounter,
        environment: { _ in CounterEnvironment() }
    )
// ポイント
    .combined(
        with: Reducer<OptionalBasicsState,OptionalBasicsAction, OptionalBasicsEnvironment
        > { state, action, environment in
            switch action {
                // optionalの場合を考慮して、
                // nilの場合はCounterStateを入れ、non-nilの場合はnilを入れています。
            case .toggleCounterButtonTapped:
                state.optionalCounter = state.optionalCounter == nil ? CounterState() : nil
                return .none
            case .optionalCounter:
                return .none
            }
        }
    )

struct OptionalBasicsView: View {

    let store: Store<OptionalBasicsState, OptionalBasicsAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Text(readMe)) {
                    Button {
                        viewStore.send(.toggleCounterButtonTapped)
                    } label: {
                        Text("Toggle counter state")
                    }// Button

                    // ポイント
                    // ここでのポイントはIfLetStoreを使用し、Stateのnil判定を行なっている部分となります。
                    // IfLetStoreにオプショナルなStateの型を持つStoreを渡します。
                    // ここではCounterState?型のState(OptionalBasicsState)を持つStoreを渡しています。
                    // IfLetStoreのドキュメントには、主に2つの用途で使用すると記載があります。
                    // 今回のようにStateが存在するかどうかでビューを切り替える。
                    // 画面遷移時にビューを切り替える。
                    IfLetStore(
                        self.store.scope(
                            state: \.optionalCounter,
                            action: OptionalBasicsAction.optionalCounter
                        ),
                        // then:にはStoreが持つStateがnon-nilであるときに表示されるビューを指定します。
                        // Stateのnil判定でnon-nilの場合thenクロージャが実行される。
                        then: { store in
                            VStack(alignment: .leading, spacing: 16) {
                                Text("`CounterState is non-nil`")
                                CounterView(store: store)
                                    .buttonStyle(.borderless)
                            }
                        },
                        // else:には反対にStateがnilであるときに表示されるビューを指定します。
                        // Stateのnil判定でnilの場合elseクロージャが実行される。
                        else: {
                            Text("`CounterState` is `nil`")
                        }
                    )// IfLetStore
                }// Section
            }// Form
        } // WithViewStore
        .navigationTitle("Optional State")
    }
}

//struct OptionalState_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionalState()
//    }
//}
