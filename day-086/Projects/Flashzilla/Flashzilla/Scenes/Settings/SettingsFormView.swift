//
//  SettingsFormView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/22/20.
// ✌️
//

import SwiftUI


struct SettingsFormView {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var store: AppStore

    
    private var restacksIncorrectCards: Binding<Bool> {
        store.binding(for: \.settingsState.restacksIncorrectCards) {
            .settings(.restacksIncorrectCardsSet($0))
        }
    }
}


// MARK: - View
extension SettingsFormView: View {

    var body: some View {
        Form {
            Section {
                Toggle(isOn: restacksIncorrectCards) {
                    Text("Restack After Wrong Answers")
                }
            }
        }
        .navigationBarItems(trailing: doneButton)
        .navigationBarTitle("Settings")
    }
}


// MARK: - Computeds
extension SettingsFormView {
    var settingsState: SettingsState { store.state.settingsState }
}


// MARK: - View Variables
extension SettingsFormView {
    
    private var doneButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        }
    }
}


// MARK: - Private Helpers
private extension SettingsFormView {
}



// MARK: - Preview
struct SettingsFormView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsFormView()
            .environmentObject(PreviewData.AppStores.default)
    }
}
