//
//  CalculatorValue.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-30.
//

import UIKit

struct CalculatorValue {
    static let shared = CalculatorValue()
    private init() {}

    static var deviceScale: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 0.75
        default:
            return 1
        }
    }

    static var ratio: CGFloat = {
        UIScreen.main.bounds.width / 375 * deviceScale
    }()

    // screen
    let row: Int = 6
    let column: Int = 4
    let padding: CGFloat = 20 * ratio
    let spanSpacing: CGFloat = 12 * ratio
    // text
    let textFontSize: CGFloat = 40
    let textPadding: CGFloat = 16 * ratio
    let textMaxLength: Int = 10
    // button
    var buttonWidth: CGFloat = 32 * ratio
    var buttonHeight: CGFloat {
        return buttonWidth
    }
    var buttonFontSize: CGFloat = 24
    var buttonHorizontalPadding: CGFloat {
        return (UIScreen.main.bounds.width * CalculatorValue.deviceScale - padding * 2 - buttonWidth * CGFloat(column) - spanSpacing * CGFloat(column - 1)) / (CGFloat(column) * 2)
    }
    func buttonVerticalPadding(forHalfScreen halfScreen: Bool) -> CGFloat {
        if halfScreen {
            return (UIScreen.main.bounds.height / 2 * CalculatorValue.deviceScale - padding * 2 - buttonHeight * CGFloat(row) - spanSpacing * CGFloat(row - 1)) / (CGFloat(row) * 2)
        } else {
            return buttonHorizontalPadding
        }
    }
    func buttonTrailingPadding(for span: Int) -> CGFloat {
        return (spanSpacing + buttonWidth + buttonHorizontalPadding * 2) * (CGFloat(span) - 1)
    }
    var buttonCornerRadius: CGFloat {
        return buttonWidth / 2 + buttonHorizontalPadding
    }
}
