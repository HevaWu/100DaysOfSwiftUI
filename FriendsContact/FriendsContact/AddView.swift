//
//  AddView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var image: Image? = nil
    @State private var name: String = ""
    
    @State private var inputImage: UIImage? = nil
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 400, height: 400)
                
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
            .onAppear(perform: {
                showImagePicker = true
            })
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func saveFriend() {
        do {
            let newId = UUID()
            let friend = Friend(context: moc)
            friend.id = newId
            friend.name = name
            
            if let jpegData = inputImage?.jpegData(compressionQuality: 0.8),
               let filePath = FileManager.default.getDocumentDirectory()?.appendingPathComponent("\(newId).jpeg") {
                try jpegData.write(to: filePath, options: [.atomic, .completeFileProtection])
            }
            
            try moc.save()
        } catch {
            print("[AddView] Save Friend Failed.")
        }
    }
    
    func loadImage() {
        guard let input = inputImage else { return }
        image = Image(uiImage: input)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
