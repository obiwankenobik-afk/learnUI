//  ViewController 2.swift
//  SkillBoxUI_4
//
//  Created by Danya on 20.01.2026.
//

import UIKit

final class ButtonLogic {
    private var firstNumber: Double = 0
    private var operationType: MathOperation?
    
    /// Строка, отображаемая в лейбле
    private(set) var displayText: String = "0"
    
    /// Числовое значение дисплея
    var displayValue: Double {
        get { Double(displayText) ?? 0 }
        set { displayText = formatTextDouble(for: newValue) }
    }
}

// MARK: - Логика
extension ButtonLogic {
    /// проверка на целое число
    private func formatTextDouble (for number: Double) -> String {
        return number.truncatingRemainder(dividingBy: 1) == 0
        ? "\(Int(number))"
        : "\(number)"
    }
    
    func divide() throws {
        if displayValue == 0 {
            throw CustomError.divideZero
        } else {
            displayValue = firstNumber / displayValue
        }
    }
    
    func add() {
        displayValue = firstNumber + displayValue
    }
    
    func subtract() {
        displayValue = firstNumber - displayValue
    }
    
    func multiply() {
        displayValue = firstNumber * displayValue
    }
    
    func divisionByZero() {
        operationType = nil
        displayText = CustomError.divideZero.errorDescription
    }
    
    func catchError() {
        do {
            try divide()
        } catch {
            divisionByZero()
        }
    }
    
    func calculate(_ operation: MathOperation) {
        switch operation {
        case .add: add()
        case .subtract: subtract()
        case .multiply: multiply()
        case .divide: catchError()
        }
    }
    
    func deleteLastNumber() {
        if displayText.count > 1 {
            displayText.removeLast()
        } else {
            displayText = "0"
        }
    }
    
    func percentPressed() {
        if let _ = operationType {
            displayValue = firstNumber * displayValue / 100
        } else {
            displayValue /= 100
        }
    }
    
    func makeDoubleNumber() {
        guard !displayText.contains(".") else { return }
        
        if displayText == "0" {
            displayText = "0."
        } else {
            displayText.append(".")
        }
    }
    
    func resetAll() {
        firstNumber = 0
        operationType = nil
        displayText = "0"
    }
    
    func plusAndMinus() {
        displayValue = -displayValue
    }
    
    func calculateOtherOperation(_ operation: OtherOperation) {
        switch operation {
        case .deleteLastNumber: deleteLastNumber()
        case .deleteAllNumber: resetAll()
        case .percentPressed: percentPressed()
        case .plusAndMinus: plusAndMinus()
        case .makeDoubleNumber: makeDoubleNumber()
        }
    }
}

// MARK: - Взаимодействия с кнопками
extension ButtonLogic  {
    /// нажатие 0-9
    func numberPressed(_ digit: String) {
        if Double(displayText) == nil {
            displayText = digit
            return
        }
        
        if displayText == "0" {
            displayText = digit
        } else {
            displayText.append(digit)
        }
    }
    
    /// нажатие  + - × ÷
    func activeComputing(_ operation: MathOperation) {
        firstNumber = displayValue
        operationType = operation
        displayText = "0"
    }
    
    /// нажатие =
    func equalityPressed() {
        guard let operation = operationType else { return }
        calculate(operation)
        operationType = nil
    }
    
    /// нажатие оставшихся операций
    func otherOperation(_ operation: OtherOperation) {
        calculateOtherOperation(operation)
    }
}
