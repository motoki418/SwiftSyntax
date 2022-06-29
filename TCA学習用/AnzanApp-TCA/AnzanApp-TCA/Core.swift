//
//  Core.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/29.
//

import ComposableArchitecture
import SwiftUI

struct CounterState: Equatable{
    var alert: AlertState<CounterState>?// OptionalState
    var firstNumber = 0
    var secondNumber = 0
    var inputText = ""
    var inputNumber = 0
    var isPresented = false
}

enum CoutnerAction: Equatable {
    case onAppear
    case alertDismissed
    case randomFirstNumber
    case randomSecondNumber
    case textChanged(String)
    case AnswerButtonTapped
    case isShowAnswer
}

struct CounterEnvironment {}

let coutnerReducer = Reducer<CounterState, CoutnerAction, CounterEnvironment
    > { state, action, _ in

    switch action {
    case .randomFirstNumber:
        state.firstNumber = Int.random(in: 1...9)
        return .none

    case .randomSecondNumber:
        state.secondNumber = Int.random(in: 1...9)
        return .none

    case .AnswerButtonTapped:
        return .none

    case let .textChanged(text):
        state.inputNumber = Int(text) ?? state.inputNumber
        return .none

    case .alertDismissed:
        state.firstNumber = Int.random(in: 1...9)
        state.secondNumber = Int.random(in: 1...9)
        state.inputText = ""
        state.alert = nil
        return .none

    case .isShowAnswer:
        return .none
    case .onAppear:
        state.firstNumber = Int.random(in: 1...9)
        state.secondNumber = Int.random(in: 1...9)
        return .none
    }
}
    .debug()
