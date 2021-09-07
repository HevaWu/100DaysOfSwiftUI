//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct ContentView: View {
    
    @State private var agreeToTerms = false
    @State private var agreeToPrivacyPolicy = false
    @State private var agreeToEmails = false

    var body: some View {
        let agreeToAll = Binding<Bool>(
            get: {
                agreeToTerms && agreeToPrivacyPolicy && agreeToEmails
            },
            set: {
                self.agreeToTerms = $0
                self.agreeToPrivacyPolicy = $0
                self.agreeToEmails = $0
            }
        )
        
        return VStack {
            Toggle(isOn: $agreeToTerms, label: {
                Text("Agree To Terms")
            })
            
            Toggle(isOn: $agreeToPrivacyPolicy, label: {
                Text("Agree To PrivacyPolicy")
            })
            
            Toggle(isOn: $agreeToEmails, label: {
                Text("Agree To Emails")
            })
            
            Toggle(isOn: agreeToAll, label: {
                Text("Agree To All")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
