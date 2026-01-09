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
    
    private var firstNumber: Double = 0
    private var operationType: MathOperation?
    
    /// Строка, отображаемая в лейбле
    var displayText: String = "0" {
        didSet {
            displayLabel.text = displayText
        }
    }
    
    /// Числовое значение дисплея
    var displayValue: Double {
        get { Double(displayText) ?? 0 }
        set {
            //проверка на целое число
            displayText = newValue.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(newValue))" : "\(newValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}

//MARK: Взаимодействия с кнопками.
private extension ViewController {
    
    ///нажатие 0-9
    @IBAction func nubmerPressed(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        
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
        displayText = "0"
    }
    
    ///нажатие =
    @IBAction func equalityPressed(_ sender: UIButton) {
        guard let operation = operationType else { return }
        
        calculate(operation)
        operationType = nil
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
    
    func divide() {
        guard displayValue != 0 else {
            resetAll()
            return
        }
        displayValue = firstNumber / displayValue
    }
    
    func calculate(_ operation: MathOperation) {
        switch operation {
        case .add: displayValue = firstNumber + displayValue
        case .subtract: displayValue = firstNumber - displayValue
        case .multiply: displayValue = firstNumber * displayValue
        case .divide: divide()
        }
    }
    
    func deleteLastNumber() {
        displayText = String(displayText.dropLast())
        if displayText.isEmpty {
            displayText = "0"
        }
    }
    
    func percentPressed(){
        if operationType == nil {
            displayValue /= 100
        } else {
            displayValue = firstNumber * displayValue / 100
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
    
    func calculateOtherOperation(_ operation: OtherOperation) {
        switch operation {
        case .deleteLastNumber: deleteLastNumber()
            
        case .deleteAllNumber: resetAll()
            
        case .percentPressed: percentPressed()
            
        case .plusAndMinus: displayValue = -displayValue
            
        case .makeDoubleNumber: makeDoubleNumber()
        }
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


