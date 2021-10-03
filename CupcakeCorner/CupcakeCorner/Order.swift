//
//  Order.swift
//  CupcakeCorner
//
//  Created by He Wu on 2021/10/01.
//

import Foundation

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

class OrderViewModel: ObservableObject {
    
    @Published var order: Order = Order()
    
    var hasValidAddress: Bool {
        if order.name.trimmingCharacters(in: .whitespaces).isEmpty
            || order.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
            || order.city.trimmingCharacters(in: .whitespaces).isEmpty
            || order.zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(order.quantity) * 2
        cost += Double(order.type) / 2
        
        if order.extraFrosting {
            cost += Double(order.quantity)
        }
        
        if order.addSprinkles {
            cost += Double(order.quantity) / 2
        }
        
        return cost
    }
}
