//
//  SettingsView.swift
//  Flashzilla
//
//  Created by He Wu on 2021/11/17.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var enableTryWrongCardAgain: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Prefer Try Wrong Card Again?", isOn: $enableTryWrongCardAgain)
            }
            .navigationTitle(Text("Settings"))
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(enableTryWrongCardAgain: .constant(true))
    }
}
