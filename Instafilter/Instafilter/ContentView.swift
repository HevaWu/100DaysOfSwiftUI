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
        let currentFilter = CIFilter.crystallize()
        
        currentFilter.setValue(begin, forKey: kCIInputImageKey)
        currentFilter.radius = 200
        
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
