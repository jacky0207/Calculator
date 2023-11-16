//
//  CalculatorButton.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

struct CalculatorButton: View {
    var type: CalculatorButtonType
    var halfScreen: Bool = false
    var span: Int = 1
    var spanSpacing: CGFloat = 0
    var isSelected: Bool = false
    var action: (CalculatorButtonType) -> Void

    var body: some View {
        Button(
            action: { action(type) },
            label: { type.view }
        )
        .buttonStyle(CalculatorButtonStyle(
            isSelected: isSelected,
            type: type,
            halfScreen: halfScreen,
            span: span,
            spanSpacing: spanSpacing
        ))
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorButton(type: .digit(.one)) { _ in

            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Digit")

            CalculatorButton(type: .operator(.plus)) { _ in

            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Operator")

            CalculatorButton(type: .function(.allClear)) { _ in

            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Function")
        }
    }
}
