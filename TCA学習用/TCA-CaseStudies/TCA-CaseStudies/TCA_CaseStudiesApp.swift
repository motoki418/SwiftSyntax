//
//  TCA_CaseStudiesApp.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/18.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_CaseStudiesApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: .init(
                initialState: RootState(),
                reducer: rootReducer,
                environment: .live)
            )
        }
    }
}
