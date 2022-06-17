//
//  ContentView.swift
//  TCA-CounterApp
//
//  Created by nakamura motoki on 2022/06/16.
//

import SwiftUI
import ComposableArchitecture

let readMe = """
  This screen demonstrates the basics of the Composable Architecture in an archetypal counter \
  application.

  The domain of the application is modeled using simple data types that correspond to the mutable \
  state of the application and any actions that can affect that state or the outside world.
  """

struct CounterState: Equatable {
    var count = 0
}

enum CounterAction: Equatable {
    case decrementButtonTapped
    case incrementButtonTapped
}

struct CounterEnvironment {}

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> {
    state, action, _ in
    switch action {
    case .decrementButtonTapped:
        // countはこの画面の状態を表すStateです。 var count = 0のこと
        state.count -= 1
        return .none
    case .incrementButtonTapped:
        // countはこの画面の状態を表すStateです。 var count = 0のこと
        state.count += 1
        return .none
    }
}

struct CounterView: View {
    // ViewStoreはstateというプロパティを持っていて、こいつの実体はCounterStateのインスタンスです。なので、viewStore.state.countという感じで参照することが可能です。
    let store: Store<CounterState, CounterAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            // ViewStore.sendというメソッドでアクション（CounterAction.incrementButtonTapped）を通知すると、
            // TCAの内部を経由して、最終的にReducer(counterReducer)にアクションが通知されます。
            HStack {
                // マイナスボタンをタップしたときに、{ viewStore.send(.incrementButtonTapped) }
                // というクロージャが実行されるようになっています。
                Button {
                    // アクションの通知はViewStore.sendを起点としますが、ViewStore.sendの実体はStore.sendです。
                    viewStore.send(.decrementButtonTapped)
                } label: {
                    Text("-")
                }
                // ビュー側ではText("\(viewStore.count)")という形でcountを参照しています。


                // viewStoreはWithViewStoreのプロパティで、 @ObservedObjectで宣言されているため、
                // 値の変更を検知して画面を再描画することができます。
                // このため、アクションによってcountが変化すると、それに伴って画面上の数字も変化します。
                // viewStore = @ObservedObject
                Text("\(viewStore.state.count)")
                // プラスボタンをタップしたときに、{ viewStore.send(.incrementButtonTapped) }
                // というクロージャが実行されるようになっています。
                Button {
                    viewStore.send(.incrementButtonTapped)
                } label: {
                    Text("+")
                }
            }
        }
    }
}

struct CounterDemoView: View {
    let store: Store<CounterState, CounterAction>

    var body: some View {
        Form {
            Section(header: Text(readMe)) {
                CounterView(store: self.store)
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarTitle("Counter Demo")
    }
}
struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
            )
        )
    }
}
