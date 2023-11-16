//
//  CalculatorButtonType+Color.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-25.
//

import SwiftUI

extension CalculatorButtonType {
    var foregroundColor: Color {
        switch self {
        case .digit:
            return CalculatorColor.white
        case .operator:
            return CalculatorColor.white
        case .function:
            return CalculatorColor.black
        }
    }

    var foregroundSelectedColor: Color {
        return normalColor
    }

    var normalColor: Color {
        switch self {
        case .digit:
            return CalculatorColor.darkGray
        case .operator:
            return CalculatorColor.orange
        case .function:
            return CalculatorColor.gray
        }
    }

    var highlightColor: Color {
        switch self {
        case .digit:
            return CalculatorColor.darkGrayHighlight
        case .operator:
            return CalculatorColor.orangeHighlight
        case .function:
            return CalculatorColor.grayHighlight
        }
    }

    var selectedColor: Color {
        return foregroundColor
    }
}
