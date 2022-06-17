//
//  Core.swift
//  TCA-CounterApp
//
//  Created by nakamura motoki on 2022/06/17.
//

import Combine
import ComposableArchitecture
import UIKit
import XCTestDynamicOverlay

struct RootState {
    var counter = CounterState()
}

enum RootAction {
    case counter(CounterAction)
    case onAppear
}

struct RootEnvironment {
//    var date: () -> Date
//    var favorite: (UUID, Bool) -> Effect<Bool, Error>
//    var fetchNumber: () -> Effect<Int, Never>
//    var mainQueue: AnySchedulerOf<DispatchQueue>
//    var notificationCenter: NotificationCenter
//    var uuid: () -> UUID

}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
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
        .pullback(state: \.counter,
                  action: /RootAction.counter, environment:  { _ in .init()})
)
.debug()
.signpost()
