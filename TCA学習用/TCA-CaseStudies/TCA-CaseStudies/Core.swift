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
    var bindingBasics = BindingBasicsState()
    var bindingForm = BindingFormState()
    var optionalBasics = OptionalBasicsState()
    var navigateAndLoad = NavigateAndLoadState()
}

enum RootAction {
    case counter(CounterAction)
    case twoCounters(TwoCountersAction)
    case bindingsBasics(BindingBaseicsAction)
    case bindingForm(BindingFormAction)
    case optionalBasics(OptionalBasicsAction)
    case navigateAndLoad(NavigatiteAndLoadAction)
    case onAppear
}

struct RootEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>

    static let live = Self(
        mainQueue: .main
    )
}

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
            ),
        bindingBasicsReducer
            .pullback(
                state: \.bindingBasics,
                action: /RootAction.bindingsBasics,
                environment: { _ in .init() }
            ),
        .init { state, action, environment in
#if compiler(>=5.4)
            return
            bindingFormReducer
                .pullback(
                    state: \.bindingForm,
                    action: /RootAction.bindingForm,
                    environment: { _ in .init() }
                )
                .run(&state, action, environment)
        #else
            return .none
        #endif
        },
        optionalBassicsReducer
            .pullback(
                state: \.optionalBasics,
                action: /RootAction.optionalBasics,
                environment: { _ in .init() }
            ),
        navigateAndLoadReducer
            .pullback(
                state: \.navigateAndLoad,
                action: /RootAction.navigateAndLoad,
                environment: { .init(mainQueue: $0.mainQueue) }
            )
    )
// .debug()でデバッグできる
// stateの変更前後がgitみたいに-と+でコンソールに表示される
    .debug()
    .signpost()

