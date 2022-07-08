//
//  AlertsAndActionSheets.swift
//  TCA-CaseStudies
//
//  Created by nakamura motoki on 2022/06/25.
//
// 参考文献
// The Composable Architecture（TCA）でアクションシート（Action Sheet）を実装する方法
// https://bamboo-hero.com/entry/tca-action-sheet
// The Composable Architecture（TCA）でアラート（Alert）を実装する方法
// https://bamboo-hero.com/entry/tca-alert
// [SwiftUI]TCAを理解する：Alert/Dialog
// https://zenn.dev/chiii/articles/5f59087a0d8216

import ComposableArchitecture
import SwiftUI

private let readMe = """
  This demonstrates how to best handle alerts and confirmation dialogs in the Composable \
  Architecture.

  Because the library demands that all data flow through the application in a single direction, we \
  cannot leverage SwiftUI's two-way bindings because they can make changes to state without going \
  through a reducer. This means we can't directly use the standard API to display alerts and sheets.

  However, the library comes with two types, `AlertState` and `ConfirmationDialogState`, which can \
  be constructed from reducers and control whether or not an alert or confirmation dialog is \
  displayed. Further, it automatically handles sending actions when you tap their buttons, which \
  allows you to properly handle their functionality in the reducer rather than in two-way bindings \
  and action closures.

  The benefit of doing this is that you can get full test coverage on how a user interacts with \
  alerts and dialogs in your application
  """


// ここでのポイントとしては、AlertStateもConfirmationDialogStateも、
// OptionalStateであることがポイントとなります。
struct AlertAndConfirmationDialogState: Equatable {
    var alert: AlertState<AlertAndConfirmationDialogAction>?// OptionalState
    var confirmationDialog: ConfirmationDialogState<AlertAndConfirmationDialogAction>?// OptionalState
    var count = 0
}

enum AlertAndConfirmationDialogAction: Equatable {
    case alertButtonTapped
    case alertDismissed
    case confirmationDialogButtonTapped
    case confirmationDialogDismissed
    case decrementButtonTapped
    case incrementButtonTapped
}

struct AlertAndConfirmationDialogEnvironment {}

// 各Actionがコールされた際に、alertとconfirmationDialogのStateの更新では、
// .initで表示したい内容を設定出来ます。
let alertAndCofirmationDialogRedcer = Reducer<AlertAndConfirmationDialogState, AlertAndConfirmationDialogAction, AlertAndConfirmationDialogEnvironment> { state, action, _ in
    switch action {

    case .alertButtonTapped:
        // 画面上の「Alert」ボタンをタップするとalertButtonTappedアクションが送信され、
        // Reducerがstate.alertにAlertStateのインスタンスをセットします。
        // これでアラートが画面に表示されます。
        // AlertStateは.init()でも良い。
        state.alert = AlertState(
            // titleやmessage、Buttonなどの設定方法は以下のコードの通りです。
            title: TextState("Alert!"),
            message: TextState("This is an alert"),
            primaryButton: .cancel(TextState("Cancel")),
            // アラート内の「Increment」ボタンをタップすると,
            // incrementButtonTappedアクションが送信されます。
            secondaryButton: .default(TextState("increment"), action: .send(.incrementButtonTapped))
        )
        return .none
        // Alertをから戻る際の挙動では、alertDismissedというアクションを送ることで、   Alertが消えるようになります。
        // state.alert = nilでAlertが消えるようになる。
    case .alertDismissed:
        state.alert = nil
        return .none

        // titleやmessage、Buttonなどの設定方法は以下のコードの通りです。
    case .confirmationDialogButtonTapped:
        state.confirmationDialog = ConfirmationDialogState(
            title: TextState("Confirmation dialog"),
            message: TextState("This is a confimation dialog."),
            buttons: [
                .cancel(TextState("Cancel")),
                .default(TextState("Increment"), action: .send(.incrementButtonTapped)),
                .default(TextState("Decrement"), action: .send(.decrementButtonTapped))
            ]
        )
        return .none

        // Dialogから戻る際の挙動では、confirmationDialogDismissedアクションを送り、
        // Dialogが消えるようになります。
        // 基本的にはAlertと同じような処理となります。
        // state.confirmationDialog = nilでconfirmationDialogが消えるようになる。
    case .confirmationDialogDismissed:
        state.confirmationDialog = nil
        return .none

        // -ボタン
    case .decrementButtonTapped:
        state.alert = AlertState(title: TextState("Decemented!"))
        state.count -= 1
        return .none

        // +ボタン
        // incrementButtonTappedアクションが送信されたら、
        // Reducerがstate.alertに新しいAlertStateのインスタンスをセットします。
        // これで「Incremented!」というタイトルの新しいアラートが画面に表示されます。
    case .incrementButtonTapped:
        state.alert = AlertState(title: TextState("Incremented!"))
        state.count += 1
        return .none
    }
}
struct AlertAndConfirmationDialogView: View {
    let store: Store<AlertAndConfirmationDialogState, AlertAndConfirmationDialogAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Text(readMe)) {

                    Text("Count: \(viewStore.count)")

                    Button {
                        viewStore.send(.alertButtonTapped)
                    } label: {
                        Text("Alert")
                    }// Alert Button

                    Button {
                        viewStore.send(.confirmationDialogButtonTapped)
                    } label: {
                        Text("Confirmatin Dialog")
                    }// Confirmatin Dialog Button
                }// Section
            }// Form
            .navigationTitle("Alerts & Confrimatin Dialogs")
            .alert(
                self.store.scope(state: \.alert),
                dismiss: .alertDismissed)
            .confirmationDialog(
                self.store.scope(state: \.confirmationDialog),
                dismiss: .confirmationDialogDismissed)
        }// WithViewStore
    }
}

struct AlertsAndActionSheets_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlertAndConfirmationDialogView(
                store: Store(
                    initialState: AlertAndConfirmationDialogState(),
                    reducer: alertAndCofirmationDialogRedcer,
                    environment: AlertAndConfirmationDialogEnvironment()
                )
            )
        }
    }
}
