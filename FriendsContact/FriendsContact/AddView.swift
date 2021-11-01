//
//  AddView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var image: Image? = nil
    @State var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                        .frame(width: 400, height: 400)
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                Form {
                    HStack {
                        Text("Name")
                            .font(.headline)
                        
                        TextField("Please input your name", text: $name)
                    }
                }
                    
            }
            .navigationBarTitle(Text("New Friend"))
            .navigationBarItems(trailing: Button(action: {
                saveFriend()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
            .onAppear(perform: presentImagePicker)
        }
    }
    
    func saveFriend() {
        print("Save Friend")
    }
    
    func presentImagePicker() {
        print("Present Image Picker")
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
