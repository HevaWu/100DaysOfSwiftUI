//
//  ContentView.swift
//  Instafilter
//
//  Created by He Wu on 2021/10/13.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let input = UIImage(named: "nice") else { return }
        let begin = CIImage(image: input)
        
        let context = CIContext()
        
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        
        currentFilter.setValue(begin, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(
            CIVector(x: input.size.width/2, y: input.size.height/2),
            forKey: kCIInputCenterKey)
        
        guard let output = currentFilter.outputImage else { return }
        if let cgImage = context.createCGImage(output, from: output.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
