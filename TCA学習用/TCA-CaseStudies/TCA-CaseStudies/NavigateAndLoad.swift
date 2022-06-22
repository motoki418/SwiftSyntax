//
//  NavigateAndLoad.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/22.
//

// 参考文献
// [SwiftUI]TCAを理解する：OptionalState、Stateの共有
// https://zenn.dev/chiii/articles/2e814245384089#sharedstate-1
// The Composable Architecture（TCA）で画面遷移を実装する方法
// https://bamboo-hero.com/entry/tca-navigation

// 画面遷移したあとデータをロードするサンプル
// 「Load optional countsaer」をタップすると画面遷移アクションが実行され、
// 同時にデータのロードが実行されます。
// 1秒後にデータのロードが完了し、カウンタービューが表示されます。

import ComposableArchitecture
import Combine
import SwiftUI

private let readMe = """
  This screen demonstrates navigation that depends on loading optional state.

  Tapping "Load optional counter" simultaneously navigates to a screen that depends on optional \
  counter state and fires off an effect that will load this state a second later.
  """

struct NavigateAndLoadState: Equatable {
    var isNavigationActive = false
    // 本サンプル画面のStateはCounterState?型のプロパティを持っています。
    var optionalCounter: CounterState?
}

enum NavigatiteAndLoadAction: Equatable {
    case optionalCounter(CounterAction)
    case setNavigation(isActive: Bool)
    case setNavigationIsActiveDelayCompleted
}

struct NavigateAndLoadEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let navigateAndLoadReducer =
    counterReducer
    .optional()
    .pullback(
        state: \.optionalCounter,
        action: /NavigatiteAndLoadAction.optionalCounter,
        environment: { _ in CounterEnvironment() }
    )
    .combined(
        with: Reducer<NavigateAndLoadState, NavigatiteAndLoadAction, NavigateAndLoadEnvironment
        > { state, action, environment in

            enum CanselId {}

            switch action {
            case .setNavigation(isActive: true):
                state.isNavigationActive = true
                return Effect(value: .setNavigationIsActiveDelayCompleted)
                    .delay(for: 1, scheduler: environment.mainQueue)
                    .eraseToEffect()
                    .cancellable(id: CanselId.self)

            case .setNavigation(isActive: false):
                state.isNavigationActive = false
                state.optionalCounter = nil
                return .cancel(id: CanselId.self)

            case .setNavigationIsActiveDelayCompleted:                state.optionalCounter = CounterState()
                return .none

            case .optionalCounter:
                return .none
            }
        }
    )



struct NavigateAndLoadView: View {
    let store: Store<NavigateAndLoadState, NavigatiteAndLoadAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Text(readMe)) {
                    NavigationLink(
                       //  NavigationLinkのイニシャライザのdestination:引数にIfLetStoreが指定されています。
                        // 「Load optional counter」ボタンがタップされると画面遷移してdestination:に指定されたビューが表示されるのですが、
                        // IfLetStoreが指定されているため、optionalCounterがnilの間はelse:に指定されているインジケータが表示され、
                        // non-nilになったらthen:に指定されているCounterViewが表示されるという動きになります
                        destination: IfLetStore(
                            self.store.scope(
                                state: \.optionalCounter,
                                action: NavigatiteAndLoadAction.optionalCounter
                            ),
                            then: CounterView.init(store:),
                            else: ProgressView.init
                        ),
                        // isActive:引数にはBindingを指定しています。
                        // このBindingは次の画面への遷移が実行されると.setNavigation(isActive: true)を送信し、
                        // 元の画面に戻る遷移が実行されると.setNavigation(isActive: false)を送信します。
                        isActive: viewStore.binding(
                            get: \.isNavigationActive,
                            send: NavigatiteAndLoadAction.setNavigation(isActive:)
                        )// isActive
                    ) {
                        HStack {
                            Text("Load optional counter")
                        }
                    }
                }// Section
            }// Form
        }// WithViewStore
        .navigationTitle("Navigate and Load")
    }
}

//struct NavigateAndLoad_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigateAndLoad()
//    }
//}
