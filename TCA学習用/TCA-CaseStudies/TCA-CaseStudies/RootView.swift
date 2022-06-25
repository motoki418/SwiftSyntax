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

                        NavigationLink(
                            "Optional state",
                            destination: OptionalBasicsView(
                                store: self.store.scope(
                                    state: \.optionalBasics,
                                    action: RootAction.optionalBasics)
                            )
                        )

                        NavigationLink(
                            "Shared state",
                            destination: SharedStateView(
                                store: self.store.scope(
                                    state: \.shared,
                                    action: RootAction.shared
                                )
                            )
                        )

                        NavigationLink(
                            "Alert and confirmation dialog",
                            destination: AlertAndConfirmationDialogView(
                                store: self.store.scope(
                                    state: \.alertAndConfirmationDialog,
                                    action: RootAction.alertAndConfimatinDialog
                                )
                            )
                        )
                    }

                    Section(header: Text("Navigation")) {
                        NavigationLink(
                            "Navigation and load data",
                            destination: NavigateAndLoadView(
                                store: self.store.scope(
                                    state: \.navigateAndLoad,
                                    action: RootAction.navigateAndLoad
                                )
                            )
                        )

                        NavigationLink("Load data then navigate", destination: LoadThenNavigateView(
                            store: self.store.scope(
                                state: \.loadThenNavigate,
                                action: RootAction.loadThenNavigate
                            )
                        )
                        )
                    }// Navigation
                }// Form
                .navigationTitle("Case Studies")
                .onAppear { viewStore.send(.onAppear)}
            }// NavigationView
        }// WithViewStore
    }
}

