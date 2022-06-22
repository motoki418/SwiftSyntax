//
//  SharedState.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/22.
//

// 参考文献
// [SwiftUI]TCAを理解する：OptionalState、Stateの共有
// https://zenn.dev/chiii/articles/2e814245384089#sharedstate-1

import ComposableArchitecture
import SwiftUI

struct SharedState: Equatable {
    var counter = CounterState()
    var currentTab = Tab.counter

    enum Tab {
        case counter
        case profile
    }

    struct CounterState: Equatable {
//        var alert: AlertState<SharedStateAction.
        var count = 0
        var maxCount = 0
        var minCount = 0
        var numberOfCounts = 0
    }

    
}

enum SharedStateAction: Equatable {

}

struct SharedStateEnvironment {}

struct SharedStateView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct SharedState_Previews: PreviewProvider {
//    static var previews: some View {
//        SharedState()
//    }
//}
