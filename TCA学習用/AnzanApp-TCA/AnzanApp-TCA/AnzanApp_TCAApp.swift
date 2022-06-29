//
//  AnzanApp_TCAApp.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/29.
//

import SwiftUI
import ComposableArchitecture

@main
struct AnzanApp_TCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: CounterState(),
                    reducer: coutnerReducer,
                    environment: CounterEnvironment()
                )
            )
        }
    }
}
