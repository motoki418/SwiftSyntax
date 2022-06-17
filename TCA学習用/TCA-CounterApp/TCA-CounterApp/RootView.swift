//
//  RootView.swift
//  TCA-CounterApp
//
//  Created by nakamura motoki on 2022/06/17.
//

import Combine
import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: Store<RootState, RootAction>

    var body: some View {
        WithViewStore(self.store.stateless) { viewStore in
            NavigationView {
                Form {
                    Section(header: Text("Getting started")) {
                        NavigationLink("Basics",
                                       destination: CounterDemoView(
                                        store: self.store.scope(
                                            state: \.counter,
                                            action: RootAction.counter
                                        )
                                       )
                        )
                        NavigationLink("Pullback and combine", destination: TwoCountersView())
                    }
                }


                .navigationTitle("Case Studies")
                .onAppear { viewStore.send(.onAppear)}
            }
        }
    }
}

//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
