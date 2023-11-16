//
//  CalculatorView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var calculator: SumTextCalculator
    var halfScreen: Bool

    init(
        sum: String,
        halfScreen: Bool,
        onChange: @escaping (String) -> Void
    ) {
        self._calculator = StateObject(wrappedValue: SumTextCalculator(sum: sum, onChange: onChange))
        self.halfScreen = halfScreen
    }

    var body: some View {
        VStack(spacing: CalculatorValue.shared.spanSpacing) {
            HStack(alignment: .bottom, spacing: CalculatorValue.shared.spanSpacing) {
                calculationText()
                functionButton(.delete)
            }
            HStack(spacing: CalculatorValue.shared.spanSpacing) {
                functionButton(calculator.isDigitInputted ? .clear : .allClear)
                functionButton(.inverseSign)
                functionButton(.percentage)
                operatorButton(.divide)
            }
            HStack(spacing: CalculatorValue.shared.spanSpacing) {
                digitButton(.seven)
                digitButton(.eight)
                digitButton(.nine)
                operatorButton(.multiply)
            }
            HStack(spacing: CalculatorValue.shared.spanSpacing) {
                digitButton(.four)
                digitButton(.five)
                digitButton(.six)
                operatorButton(.minus)
            }
            HStack(spacing: CalculatorValue.shared.spanSpacing) {
                digitButton(.one)
                digitButton(.two)
                digitButton(.three)
                operatorButton(.plus)
            }
            HStack(spacing: CalculatorValue.shared.spanSpacing) {
                digitButton(.zero, span: 2)
                digitButton(.dot)
                operatorButton(.equal)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, CalculatorValue.shared.padding)
        .background(CalculatorColor.black)
    }

    func calculationText() -> some View {
        Text(calculator.text)
            .textStyle(CalculatorText())
            .onChange(of: calculator.text) { text in
                if text.count > CalculatorValue.shared.textMaxLength {
                    calculator.text = String(text.prefix(CalculatorValue.shared.textMaxLength))
                }
            }
    }

    func digitButton(_ type: CalculatorDigit, span: Int = 1) -> some View {
        CalculatorButton(
            type: .digit(type),
            halfScreen: halfScreen,
            span: span,
            spanSpacing: CalculatorValue.shared.spanSpacing,
            action: calculator.pressButton
        )
    }

    func operatorButton(_ type: CalculatorOperator) -> some View {
        CalculatorButton(
            type: .operator(type),
            halfScreen: halfScreen,
            span: 1,
            spanSpacing: CalculatorValue.shared.spanSpacing,
            isSelected: calculator.isOperatorSelected(type),
            action: calculator.pressButton
        )
    }

    func functionButton(_ type: CalculatorFunction) -> some View {
        CalculatorButton(
            type: .function(type),
            halfScreen: halfScreen,
            span: 1,
            spanSpacing: CalculatorValue.shared.spanSpacing,
            action: calculator.pressButton
        )
    }
}

struct CalculatorFullView: View {
    @State private var sum = "abc"

    var body: some View {
        VStack {
            Text("Sum: \(sum)")
            CalculatorView(
                sum: sum,
                halfScreen: false,
                onChange: { sum in
                    self.sum = sum
                }
            )
        }
    }
}

struct CalculatorHalfView: View {
    @State private var sum = "abc"

    var body: some View {
        VStack {
            Text("Sum: \(sum)")
            CalculatorView(
                sum: sum,
                halfScreen: true,
                onChange: { sum in
                    self.sum = sum
                }
            )
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorFullView()
                .previewLayout(.sizeThatFits)
            CalculatorHalfView()
                .previewLayout(.sizeThatFits)
        }
    }
}
