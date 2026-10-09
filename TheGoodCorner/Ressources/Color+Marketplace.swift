//
//  Color+Marketplace.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 9/10/2026.
//


import SwiftUI

extension Color {
    static let marketplaceBackground = Color(hex: 0xF8F9FF)
    static let marketplaceText = Color(hex: 0x141C2A)
    static let marketplaceNavy = Color(hex: 0x293040)
    static let marketplaceSecondary = Color(hex: 0x525D85)
    static let marketplaceOrange = Color(hex: 0xFF5A1F)
    static let marketplaceOnOrange = Color(hex: 0x852400)
    static let marketplaceUrgentBackground = Color(hex: 0xFFDBD0)
    static let marketplaceChip = Color(hex: 0xE8EDFF)
    static let marketplacePlaceholder = Color(hex: 0xE1E8FC)
    static let marketplaceBorder = Color(hex: 0xE4E7F0)

    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: 1
        )
    }
}
