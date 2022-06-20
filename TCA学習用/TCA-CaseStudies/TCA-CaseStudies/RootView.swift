//
//  RootView.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/18.
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
                        NavigationLink(
                            "Basics",
                            destination: CounterDemoView(
                                store: self.store.scope(
                                    state: \.counter,
                                    action: RootAction.counter)
                            )
                        )

                        NavigationLink(
                            "Pullback and combine",
                            destination: TwoCountersView(
                                store: self.store.scope(
                                    state: \.twoCounters,
                                    action: RootAction.twoCounters)
                            )
                        )

                        NavigationLink(
                            "Bindings",
                            destination: BindingsBasicsView(
                                store: self.store.scope(
                                    state: \.bindingBasics,
                                    action: RootAction.bindingsBasics)
                            )
                        )

                        NavigationLink(
                            "Form bindings",
                            destination: BindingFormView(
                                store: self.store.scope(
                                    state: \.bindingForm,
                                    action: RootAction.bindingForm)
                            )
                        )
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
