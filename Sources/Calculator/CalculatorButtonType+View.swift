//
//  CalculatorButtonType+View.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-25.
//

import SwiftUI

extension CalculatorButtonType {
    var view: some View {
        switch self {
        case .digit(let type):
            return AnyView(type.view)
        case .operator(let type):
            return AnyView(type.view)
        case .function(let type):
            return AnyView(type.view)
        }
    }
}

extension CalculatorDigit {
    var text: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .dot:
            return "."
        }
    }

    var view: some View {
        Text(text)
    }
}

extension CalculatorOperator {
    var view: some View {
        switch self {
        case .plus:
            return Image(systemName: "plus")
        case .minus:
            return Image(systemName: "minus")
        case .multiply:
            return Image(systemName: "multiply")
        case .divide:
            return Image(systemName: "divide")
        case .equal:
            return Image(systemName: "equal")
        }
    }
}

extension CalculatorFunction {
    var view: some View {
        switch self {
        case .allClear:
            return AnyView(Text("AC"))
        case .clear:
            return AnyView(Text("C"))
        case .inverseSign:
            return AnyView(Image(systemName: "plus.slash.minus"))
        case .delete:
            return AnyView(Image(systemName: "delete.backward"))
        case .percentage:
            return AnyView(Text("%"))
        }
    }
}
