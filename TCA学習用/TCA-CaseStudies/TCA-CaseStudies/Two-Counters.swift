//
//  Two-Counters.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/18.
//

// 参考文献
// The Composable Architecture（TCA）のサンプルからComposableなArchitectureを学ぶ
//　https://bamboo-hero.com/entry/learn-composable-architecture-from-tca-sample

import ComposableArchitecture
import SwiftUI

// 本サンプルでは、カウンターサンプルのコンポーネントであるCounterViewとCounterState、CounterActionを使っています。
// そして、これらを組み合わせることでより大きい単位の機能を作っています。
private let readMe = """
  This screen demonstrates how to take small features and compose them into bigger ones using the \
  `pullback` and `combine` operators on reducers, and the `scope` operator on stores.

  It reuses the the domain of the counter screen and embeds it, twice, in a larger domain.
  """
// [1]
// TwoCountersStateは本サンプル画面のStateです。
// 子ビュー（CounterView）のStateであるCounterState型のプロパティを2つ持っています。
struct TwoCounterState: Equatable {
    var counter1 = CounterState()
    var counter2 = CounterState()
}

enum TwoCountersAction {
    case counter1(CounterAction)
    case counter2(CounterAction)
}

struct TwoCountersEnvironment {}
// 小さいReducerを組み合わせて大きなReducerを作る
// 本サンプルでもう一つ学べるのはReducerの実装です。
// 以下のように、2つのcounterReducerを組み合わせています。
let twoCountersReducer = Reducer<TwoCounterState, TwoCountersAction,
                                 TwoCountersEnvironment>
// 2つのcounterReducerをcombineで一つのReducerに統合しています。
// ここで、combineメソッドに渡すReducerの順番は意識する必要があります。
// 本サンプルでは特に問題になりませんが、各Reducerが同じ状態を変更する可能性があるとき
// Reducerはcombineに渡した順番で実行されるので、
// ReducerA→ReducerBとReducerB→ReducerAでは状態変化の結果が変わる可能性があります。
    .combine(
        // counterReducerはCounterActionを受け取ってCounterStateを変化させるReducerです。
        // CounterViewで使われているものです。
        // ここではpullbackメソッドを使い、counterReducerをTwoCountersState、TwoCountersActionに対応させています。
        // pullbackはローカルStateで動作するReducerを上位のStateで動作するReducerに変換するためのメソッドです。
        // CounterState、CounterActionで動作するReducerを、
        // TwoCountersState、TwoCountersActionで動作するReducerに変換している。
        counterReducer.pullback(
            state: \TwoCounterState.counter1,
            action: /TwoCountersAction.counter1,
            environment: { _ in CounterEnvironment() }
        ),
        counterReducer.pullback(
            state: \TwoCounterState.counter2,
            action: /TwoCountersAction.counter2,
            environment: { _ in CounterEnvironment() }
        )
    )

// CounterViewが扱うStateをTwoCountersStateではなくCounterStateにすることで、
// CounterViewが上位の画面の状態を変更してしまう可能性を排除しています。
struct TwoCountersView: View {
    let store: Store<TwoCounterState, TwoCountersAction>
    var body: some View {
        Form {
            Section(header: Text(readMe)) {
                HStack {
                    Text("Counter 1")
                    // カウンター機能部分はCounterViewを使っています。
                    CounterView(
                        // [2]
                        // CounterViewのイニシャライザはStoreインスタンスを要求しますが、
                        // ここで渡すStoreが扱うStateをCounterStateに変換します。
                        // Store.scope(state:action:)は指定されたState、Actionの型に対応した、
                        // Storeインスタンスを新たに生成して返すメソッドです。
                        store:self.store.scope(
                        state:\.counter1,
                        action: TwoCountersAction.counter1)
                    )
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }

                HStack {
                    Text("Counter 2")
                    // カウンター機能部分はCounterViewを使っています。
                    CounterView(
                        store: self.store.scope(
                            state: \.counter2,
                            action: TwoCountersAction.counter2)
                    )
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }
            }
        }
        .navigationTitle("Two counter demo")
    }
}

//struct Two_Counters_Previews: PreviewProvider {
//    static var previews: some View {
//        Two_Counters()
//    }
//}
