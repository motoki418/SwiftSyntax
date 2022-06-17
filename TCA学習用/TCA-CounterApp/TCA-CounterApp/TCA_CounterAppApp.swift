//
//  TCA_CounterAppApp.swift
//  TCA-CounterApp
//
//  Created by nakamura motoki on 2022/06/16.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_CounterAppApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: .init(
                initialState: RootState(),
                reducer: rootReducer,
                environment: RootEnvironment())
            )
        }
    }
}
