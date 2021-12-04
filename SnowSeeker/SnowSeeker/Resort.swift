//
//  Resort.swift
//  SnowSeeker
//
//  Created by He Wu on 2021/12/01.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    var sizeType: String  {
        switch size {
        case 1: return "Small"
        case 2: return "Average"
        default: return "Large"
        }
    }
    
    var priceType: String {
        String(repeating: "$", count: price)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    static let allResortsCountry: [String] = {
        Set(allResorts.map { $0.country} ).sorted()
    }()
    
    static let allSizeType: [String] = ["Small", "Average", "Large"]
    
    static let allPriceType: [String] = {
        Set(allResorts.map { $0.priceType} ).sorted()
    }()
}
