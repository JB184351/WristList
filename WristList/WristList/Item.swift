//
//  Item.swift
//  WristList
//
//  Created by Justin on 5/13/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var text: String
    var isDone: Bool
    
    init(text: String, isDone: Bool) {
        self.text = text
        self.isDone = isDone
    }
}
