//
//  Card.swift
//  Flashzilla
//
//  Created by He Wu on 2021/11/14.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
