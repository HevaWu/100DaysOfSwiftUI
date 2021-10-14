//
//  ImagePicker.swift
//  Instafilter
//
//  Created by He Wu on 2021/10/14.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // update later
    }
}
