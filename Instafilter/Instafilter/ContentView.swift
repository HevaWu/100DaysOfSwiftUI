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
    @State private var filterIntensity = 0.5
    
    @State private var showFilterSheet = false
    
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?

    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding()
            
                HStack {
                    Button("Change Filter") {
                        showFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // save picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .actionSheet(isPresented: $showFilterSheet) {
                ActionSheet(
                    title: Text("Select Filter"),
                    buttons: [
                        .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                        .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                        .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                        .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                        .default(Text("Sepia Tone")) { self.setFilter(.sepiaTone()) },
                        .default(Text("Unsharp Mask")) { self.setFilter(.unsharpMask()) },
                        .default(Text("Vignete")) { self.setFilter(.vignette()) },
                        .cancel()
                    ])
            }
        }
    }
    
    func loadImage() {
        guard let input = inputImage else { return }
        
        let beginImage = CIImage(image: input)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let output = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(output, from: output.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
