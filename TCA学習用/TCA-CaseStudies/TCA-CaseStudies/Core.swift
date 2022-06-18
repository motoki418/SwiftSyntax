//
//  Core.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/18.
//

import Combine
import ComposableArchitecture
import UIKit
import XCTestDynamicOverlay

struct RootState {
    var counter = CounterState()
    var twoCounters = TwoCounterState()
}

enum RootAction {
    case counter(CounterAction)
    case twoCounters(TwoCountersAction)
    case onAppear
}

struct RootEnvironment {}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>
    .combine(
        .init { state, action, _ in
            switch action {
            case .onAppear:
                state = .init()
                return .none
            default:
                return .none
            }
        },
        counterReducer
            .pullback(
                state: \.counter,
                action: /RootAction.counter,
                environment:  { _ in .init() }
        ),
        twoCountersReducer
            .pullback(
                state: \.twoCounters,
                action: /RootAction.twoCounters,
                environment: { _ in .init() }
            )
    )
    .debug()
    .signpost()

