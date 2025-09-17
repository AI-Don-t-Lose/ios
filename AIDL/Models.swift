//
//  Models.swift
//  AIDL
//
//  Created by Assistant on 9/16/25.
//

import SwiftUI

struct Stock {
    let name: String
    let previousPrice: Double
    let currentPrice: Double
}

struct ExpenseCategory {
    let name: String
    let percentage: Double
    let color: Color
    
    init(name: String, percentage: Double, color: Color = .blue) {
        self.name = name
        self.percentage = percentage
        self.color = color
    }
}