//
//  Three-Counter.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/27.
//

import ComposableArchitecture
import SwiftUI

struct ThreeCounterStete: Equatable {
    var coutenr1 = CounterState()
    var counter2 = CounterState()
    var counter3 = CounterState()
}

enum ThreeCounerAction: Equatable {
    case counter1(CounterAction)
    case counter2(CounterAction)
    case counter3(CounterAction)
}

struct ThreeCounterEnvironment {}

let threeCounterReducer = Reducer<ThreeCounterStete, ThreeCounerAction, ThreeCounterEnvironment>
    .combine(
        counterReducer.pullback(
            state: \ThreeCounterStete.coutenr1,
            action: /ThreeCounerAction.counter1,
            environment: { _ in CounterEnvironment() }
        ),
        counterReducer.pullback(
            state: \ThreeCounterStete.counter2,
            action: /ThreeCounerAction.counter2,
            environment: { _ in CounterEnvironment() }
        ),
        counterReducer.pullback(
            state: \ThreeCounterStete.counter3,
            action: /ThreeCounerAction.counter3,
            environment: { _ in CounterEnvironment() }
        )
    )

struct ThreeCounterView: View {
    let store: Store<ThreeCounterStete, ThreeCounerAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Text("")) {
                    HStack {
                    Text("Counter1")
                        CounterView(store: self.store.scope(
                            state: \.coutenr1,
                            action: ThreeCounerAction.counter1)
                        )// CounterView
                        .buttonStyle(.borderless)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    }// HStack

                    HStack {
                    Text("Counter2")
                        CounterView(store: self.store.scope(
                            state: \.counter2,
                            action: ThreeCounerAction.counter2)
                        )// CounterView
                        .buttonStyle(.borderless)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    }// HStack

                    HStack {
                    Text("Counter2")
                        CounterView(store: self.store.scope(
                            state: \.counter3,
                            action: ThreeCounerAction.counter3)
                        )// CounterView
                        .buttonStyle(.borderless)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    }// HStack
                }// Section
            }// Form
        }// WithViewStore
        .navigationTitle("Three Counter Demo")
    }
}

struct Three_Counter_Previews: PreviewProvider {
    static var previews: some View {
        ThreeCounterView(
            store: Store(
                initialState: ThreeCounterStete(),
                reducer: threeCounterReducer,
                environment: ThreeCounterEnvironment()
            )
        )
    }
}
