//
//  Item.swift
//  ChatGPT-iOSApp
//
//  Created by Srivalli Kanchibotla on 1/24/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
