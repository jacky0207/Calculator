//
//  CalculatorStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

fileprivate extension View {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct CalculatorText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: CalculatorValue.shared.buttonWidth * 3 + CalculatorValue.shared.buttonHorizontalPadding * 5 + CalculatorValue.shared.spanSpacing * 2, alignment: .trailing)
            .padding(.horizontal, CalculatorValue.shared.buttonHorizontalPadding / 2)
            .foregroundColor(CalculatorColor.white)
            .font(Font.system(size: CalculatorValue.shared.textFontSize))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    var isSelected: Bool = false

    var type: CalculatorButtonType
    var halfScreen: Bool
    var span: Int = 1
    var spanSpacing: CGFloat = 0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? type.foregroundSelectedColor : type.foregroundColor)
            .font(Font.system(size: CalculatorValue.shared.buttonFontSize))
            .frame(width: CalculatorValue.shared.buttonWidth, height: CalculatorValue.shared.buttonHeight)
            .padding(.trailing, CalculatorValue.shared.buttonTrailingPadding(for: span))
            .padding(.horizontal, CalculatorValue.shared.buttonHorizontalPadding)
            .padding(.vertical, CalculatorValue.shared.buttonVerticalPadding(forHalfScreen: halfScreen))
            .background(
                RoundedRectangle(cornerRadius: CalculatorValue.shared.buttonCornerRadius)
                    .fill(configuration.isPressed ? type.highlightColor : (isSelected ? type.selectedColor : type.normalColor) )
            )
    }
}
