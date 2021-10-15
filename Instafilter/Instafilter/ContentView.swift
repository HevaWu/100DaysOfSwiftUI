//
//  ContentView.swift
//  Instafilter
//
//  Created by He Wu on 2021/10/13.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved!")
    }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showImagePicker = false
    
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showImagePicker = true
            }
        }
        .sheet(
            isPresented: $showImagePicker,
            onDismiss: loadImage,
            content: {
                ImagePicker(image: $inputImage)
            })
    }
    
    func loadImage() {
        guard let input = inputImage else { return }
        image = Image(uiImage: input)
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: input)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
