//
//  ViewController.swift
//  SkillBoxUI_2
//
//  Created by Danya on 13.12.2025.
//

import UIKit

final class ViewController: UIViewController {
    //MARK: Переменные для состояния, дисплей, главный экран.
    @IBOutlet weak var displayLabel: UILabel!
    
    private var typingNumber = false
    private var firstNumber: Double = 0
    private var secondNumber: Double = 0
    private var operationType: MathOperation?
    private var dotIsPlace = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}

//MARK: Работа с дисплеем.
private extension ViewController {
    
    /// Строка, отображаемая в лейбле
    var displayText: String {
        get { displayLabel.text ?? "0" }
        set { displayLabel.text = newValue }
    }
    
    func divide() throws {
        guard displayValue != 0 else {
            displayText = CustomError.divideZero.errorDescription
            throw CustomError.divideZero
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
        displayValue = firstNumber / displayValue
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
        displayText = String(displayText.dropLast())
        if displayText.isEmpty {
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

//MARK: Взаимодействия с кнопками.
private extension ViewController {
    
    ///нажатие 0-9
    @IBAction func nubmerPressed(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        
        if !typingNumber {
            displayText = digit
            typingNumber = true
            return
        }
        
        if displayText == "0" {
            displayText = digit
        } else {
            displayText.append(digit)
        }
    }
    
    ///нажатие  + - × ÷
    @IBAction func activeComputing(_ sender: UIButton) {
        guard
            let symbol = sender.titleLabel?.text,
            let operation = MathOperation(rawValue: symbol)
        else { return }
        
        firstNumber = displayValue
        operationType = operation
        typingNumber = false
        dotIsPlace = false
    }
    
    ///нажатие =
    @IBAction func equalityPressed(_ sender: UIButton) {
        guard let operation = operationType else { return }
        
        if typingNumber {
            secondNumber = displayValue
        }
        
        calculate(operation)
        operationType = nil
        dotIsPlace = false
    }
    
    ///нажатие оставшихся операций
    @IBAction func otherOperation(_ sender: UIButton) {
        guard
            let title = sender.titleLabel?.text,
            let operation = OtherOperation(rawValue: title)
        else { return }
        
        calculateOtherOperation(operation)
    }
}

//MARK: Логика.
private extension ViewController {
    
    func calculate(_ operation: MathOperation) {
        switch operation {
        case .add:
            displayValue = firstNumber + secondNumber
        case .subtract:
            displayValue = firstNumber - secondNumber
        case .multiply:
            displayValue = firstNumber * secondNumber
        case .divide:
            guard secondNumber != 0 else {
                resetAll()
                return
            }
            displayValue = firstNumber / secondNumber
        }
    }
    
    func calculateOtherOperation(_ operation: OtherOperation) {
        switch operation {
            
        case .deleteLastNumber:
            displayText = String(displayText.dropLast())
            if displayText.isEmpty {
                displayText = "0"
                typingNumber = false
            }
            
        case .deleteAllNumber:
            resetAll()
            
        case .percentPressed:
            if operationType == nil {
                displayValue /= 100
            } else {
                secondNumber = firstNumber * displayValue / 100
                displayValue = secondNumber
            }
            
        case .plusAndMinus:
            displayValue = -displayValue
            typingNumber = true
            
        case .makeDoubleNumber:
            guard !dotIsPlace else { return }
            
            if typingNumber {
                displayText.append(".")
            } else {
                displayText = "0."
                typingNumber = true
            }
            dotIsPlace = true
        }
    }
    
    func resetAll() {
        firstNumber = 0
        secondNumber = 0
        operationType = nil
        typingNumber = false
        dotIsPlace = false
        displayText = "0"
    }
}

//MARK: Перечисления операций.
extension ViewController {
    enum MathOperation: String {
        case add = "+"
        case subtract = "-"
        case multiply = "×"
        case divide = "÷"
    }
    
    enum OtherOperation: String {
        case deleteLastNumber = " "
        case deleteAllNumber = "AC"
        case percentPressed = "%"
        case plusAndMinus = "+/-"
        case makeDoubleNumber = "."
    }
}


