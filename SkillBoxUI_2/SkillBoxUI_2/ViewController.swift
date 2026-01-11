//
//  ViewController.swift
//  SkillBoxUI_2
//
//  Created by Danya on 13.12.2025.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    private var firstNumber: Double = 0
    private var operationType: MathOperation?
    
    /// Строка, отображаемая в лейбле
    var displayText: String = "0" {
        didSet { displayLabel.text = displayText }
    }
    
    /// Числовое значение дисплея
    var displayValue: Double {
        get { Double(displayText) ?? 0 }
        set { formatTextDouble(for: newValue) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}

// MARK: - Логика
private extension ViewController {
    /// проверка на целое число
    func formatTextDouble (for number: Double) {
        displayText = number.truncatingRemainder(dividingBy: 1) == 0
        ? "\(Int(number))"
        : "\(number)"
    }
    
    func divide() throws {
        guard displayValue != 0 else {
            displayText = CustomError.divideZero.errorDescription
            throw CustomError.divideZero
        }
        displayValue = firstNumber / displayValue
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
    
    func calculate(_ operation: MathOperation) {
        switch operation {
        case .add: add()
        case .subtract: subtract()
        case .multiply: multiply()
        case .divide:
            do {
                try divide()
            } catch {
                operationType = nil
            }
        }
    }
    
    func deleteLastNumber() {
        displayText = String(displayText.dropLast())
        if displayText.isEmpty {
            displayText = "0"
        }
    }
    
    func percentPressed(){
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
private extension ViewController {
    /// нажатие 0-9
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        
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
    @IBAction func activeComputing(_ sender: UIButton) {
        guard
            let symbol = sender.titleLabel?.text,
            let operation = MathOperation(rawValue: symbol)
        else { return }
        
        firstNumber = displayValue
        operationType = operation
        displayText = "0"
    }
    
    /// нажатие =
    @IBAction func equalityPressed(_ sender: UIButton) {
        guard let operation = operationType else { return }
        
        calculate(operation)
        operationType = nil
    }
    
    /// нажатие оставшихся операций
    @IBAction func otherOperation(_ sender: UIButton) {
        guard
            let title = sender.titleLabel?.text,
            let operation = OtherOperation(rawValue: title)
        else { return }
        
        calculateOtherOperation(operation)
    }
}




