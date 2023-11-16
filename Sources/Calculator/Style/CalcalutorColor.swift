//
//  CalcalutorColor.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-25.
//

import SwiftUI

// add a initialiser by hex color
// https://stackoverflow.com/a/56894458/12208834
extension Color {
    fileprivate init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

struct CalculatorColor {
    private init() {}

    // colours
    static let gray = Color(hex: 0xa5a5a5)
    static let grayHighlight = Color(hex: 0xd9d9d9)

    static let darkGray = Color(hex: 0x333333)
    static let darkGrayHighlight = Color(hex: 0x737373)

    static let orange = Color(hex: 0xff9f06)
    static let orangeHighlight = Color(hex: 0xfcc88d)

    static let white = Color(.white)
    static let black = Color(.black)
}
