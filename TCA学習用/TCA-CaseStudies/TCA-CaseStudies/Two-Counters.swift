//
//  Two-Counters.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/18.
//

// 参考文献
// The Composable Architecture（TCA）のサンプルからComposableなArchitectureを学ぶ
//　https://bamboo-hero.com/entry/learn-composable-architecture-from-tca-sample
// [SwiftUI]TCAを理解する：pullback/combine/scope
// https://zenn.dev/chiii/articles/d3113459d22ba0

// 本サンプルの要点
// 各モジュールが扱うStateのスコープを小さくすることで、そのモジュールの再利用性を高めることができる。

// Reducerの一つ一つは小さく実装した上で、上位レイヤで複数のReducerを組み合わせて、
// 一つの大きなReducerを作ることが出来る。
// その際、Reducerを組み合わせる順番を意識する必要がある。

import ComposableArchitecture
import SwiftUI

// 本サンプルでは、カウンターサンプルのコンポーネントである、
// CounterViewとCounterState、CounterActionを使っています。
// そして、これらを組み合わせることでより大きい単位の機能を作っています。

private let readMe = """
  This screen demonstrates how to take small features and compose them into bigger ones using the \
  `pullback` and `combine` operators on reducers, and the `scope` operator on stores.

  It reuses the the domain of the counter screen and embeds it, twice, in a larger domain.
  """

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
// 2つのcounterReducer(counterReducerとtwoCountersReducer)を、
// combineで一つのReducerに統合しています。
// ここで、combineメソッドに渡すReducerの順番は意識する必要があります。
// 本サンプルでは特に問題になりませんが、各Reducerが同じ状態を変更する可能性がある時、
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
// pullbackについて
// 今回の実装で整理すると、現状のまま参照すればもちろんcounterReducerの型は、
// Reducer<CounterState, CounterAction, CounterEnvironment>なので、
// Reducer<TwoCountersState, TwoCountersAction, TwoCountersEnvironment>に変換する必要があります。
// counterReducerに対してpullbackメソッドを使用することで上記のReducerに変換出来ます。
// pullbackという命名の通り、既存生成されているReducerを1回元に戻す（init）ことで、
// 変換したいReducerに必要な引数である、State・Action・Environmentを新たに指定することで変換するイメージです。

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
                        // CounterViewのイニシャライザはStoreインスタンスを要求しますが、
                        // ここで渡すStoreが扱うStateをCounterStateに変換します。
                        // Store.scope(state:action:)は指定されたState、Actionの型に対応した、
                        // Storeインスタンスを新たに生成して返すメソッドです。
                        store:self.store.scope(
                            state:\.counter1,
                            action: TwoCountersAction.counter1)
                    )// CounterView
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }// HStack

                HStack {
                    Text("Counter 2")
                    // カウンター機能部分はCounterViewを使っています。
                    CounterView(
                        // ここのポイントは、self.store.scopeの処理です。
                        // 共通のCounterViewというコンポーネントを使いますが、TwoCountersStateとTwoCountersActionには今回複数のケースがあります。
                        // それらを区別し使用したいStateとActionを引数に指定します。
                        // 今回は変数counter1もcounter2も同じCounterStateですが、グローバルなTwoCountersStateに別のstateが定義されている場合などは、
                        // 使用したいローカルなstateを指定するのによく使えると思います。
                        store: self.store.scope(
                            state: \.counter2,
                            action: TwoCountersAction.counter2)
                    )// CounterView
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }// HStack
            }// Section
        }// Form
        .navigationTitle("Two counter demo")
    }
}

//struct Two_Counters_Previews: PreviewProvider {
//    static var previews: some View {
//        Two_Counters()
//    }
//}
