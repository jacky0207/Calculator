//
//  CalculatorDigit+Concat.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-25.
//

extension CalculatorDigit {
    static func concat(_ text: String, with digit: CalculatorDigit) -> String {
        // case 1: "0" + "0" -> "0"
        // case 2: "abc.xyz" + "." -> "abc.xyz"
        // case 3: "0" + "[1-9] -> "[1-9]"
        // default: "a" + "b" -> "ab"
        if digit == .zero && text == SumTextCalculator.defaultValue {
            return text
        } else if digit == .dot && text.contains(CalculatorDigit.dot.text) {
            return text
        } else if digit != .dot && text == SumTextCalculator.defaultValue {
            return digit.text
        } else {
            return text + digit.text
        }
    }
}
