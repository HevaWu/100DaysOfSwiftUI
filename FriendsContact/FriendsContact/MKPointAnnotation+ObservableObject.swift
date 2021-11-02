//
//  MKPointAnnotation+ObservableObject.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/02.
//

import Foundation
import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedDescription: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        set {
            subtitle = newValue
        }
    }
}
