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
    var alertAndConfirmationDialog = AlertAndConfirmationDialogState()
    var counter = CounterState()
    var twoCounters = TwoCounterState()
    var threeCounters = ThreeCounterStete()
    var bindingBasics = BindingBasicsState()
    var bindingForm = BindingFormState()
    var optionalBasics = OptionalBasicsState()
    var navigateAndLoad = NavigateAndLoadState()
    var loadThenNavigate = LoadThenNavigateState()
    var shared = SharedState()
    var effectsBasics = EffectsBasicsState()
    var effectsCancellation = EffectsCancellationState()
}

enum RootAction {
    case alertAndConfimatinDialog(AlertAndConfirmationDialogAction)
    case counter(CounterAction)
    case twoCounters(TwoCountersAction)
    case threeCouters(ThreeCounerAction)
    case bindingsBasics(BindingBaseicsAction)
    case bindingForm(BindingFormAction)
    case optionalBasics(OptionalBasicsAction)
    case navigateAndLoad(NavigatiteAndLoadAction)
    case loadThenNavigate(LoadThenNavigateAction)
    case shared(SharedStateAction)
    case effectsBasics(EffectsBasicsAction)
    case effectsCancellation(EffectsCancellationAction)
    case onAppear
}

struct RootEnvironment {
    var fact: FactClient
    var mainQueue: AnySchedulerOf<DispatchQueue>

    static let live = Self(
        fact: .live,
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
        alertAndCofirmationDialogRedcer
            .pullback(
                state: \.alertAndConfirmationDialog,
                action: /RootAction.alertAndConfimatinDialog,
                environment: { _ in .init() }
            ),
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
        threeCounterReducer
            .pullback(
                state: \.threeCounters,
                action: /RootAction.threeCouters,
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
        sharedStateReducer
            .pullback(
                state: \.shared,
                action: /RootAction.shared,
                environment: { _ in () }
            ),
        effectsBasicsReducer
            .pullback(
                state: \.effectsBasics,
                action: /RootAction.effectsBasics,
                environment: { .init(
                    fact: $0.fact, mainQueue: $0.mainQueue) }
            ),
        effectsCancellationReducer
            .pullback(
                state: \.effectsCancellation,
                action: /RootAction.effectsCancellation,
                environment: { .init(
                    fact: $0.fact,
                    mainQueue: $0.mainQueue) }
            ),
        navigateAndLoadReducer
            .pullback(
                state: \.navigateAndLoad,
                action: /RootAction.navigateAndLoad,
                environment: { .init(mainQueue: $0.mainQueue) }
            ),
        loadThenNavigateReducer
            .pullback(
                state: \.loadThenNavigate,
                action: /RootAction.loadThenNavigate,
                environment: { .init(mainQueue: $0.mainQueue) }
            )
    )
// .debug()????????????????????????
// state??????????????????git????????????-???+????????????????????????????????????
    .debug()
    .signpost()

