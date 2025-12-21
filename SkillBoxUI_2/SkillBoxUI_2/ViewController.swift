//
//  ViewController.swift
//  SkillBoxUI_2
//
//  Created by Danya on 13.12.2025.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    ///переменная для проверки вводит пользователь число или он закончил операцию
    var typingNumber = false
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    ///какой знак вычисления выбрали
    var operationType: MathOperation?
    ///для проверки стоит точка или нет
    var dotIsPlace = false
    ///вычисляемое значение (число, которое на экране) + удаляю с его помощью точки
    var currentInput: Double {
        get {
            let text = displayLabel.text ?? "0"
            return Double(text) ?? 0
        }
        set {
            let value = Int(newValue)
            let helpValue = newValue - Double(value)
            if helpValue != 0 {
                displayLabel.text =  "\(newValue)"
            } else {
                displayLabel.text = "\(value)"
            }
            
            typingNumber = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    //нажатие 0-9
    @IBAction func nubmerPressed(_ sender: UIButton) {
        guard
            //прикол поделится прикол пофикшен
            let title = sender.titleLabel?.text,
            let currentValue = displayLabel.text
        else { return }
        
        // если пользователь только начал ввод
        guard typingNumber else {
            displayLabel.text = title
            typingNumber = true
            return
        }
        
        // меняем начальный "0"
        guard currentValue != "0" else {
            displayLabel.text = title
            return
        }
        
        displayLabel.text = currentValue + title
    }
    
    //нажатие операции
    @IBAction func activeComputing(_ sender: UIButton) {
        guard
            let text = sender.titleLabel?.text,
            let operation = MathOperation(rawValue: text)
        else { return }
        
        operationType = operation
        firstNumber = currentInput
        typingNumber = false
        dotIsPlace = false
    }
    
    //вычисление
    @IBAction func equalityPressed(_ sender: UIButton) {
        guard let operation = operationType else { return }
        
        if typingNumber {
            secondNumber = currentInput
        }
        
        switch operation{
        case .add:
            currentInput = firstNumber + secondNumber
        case .subtract:
            currentInput = firstNumber - secondNumber
        case .multiply:
            currentInput = firstNumber * secondNumber
        case .divide:
            guard secondNumber != 0 else {
                resetAll()
                return
            }
            currentInput = firstNumber / secondNumber
        }
        operationType = nil
        dotIsPlace = false
        
    }
    
    func resetAll() {
        firstNumber = 0
        secondNumber = 0
        currentInput = 0
        displayLabel.text = "0"
        typingNumber = false
        dotIsPlace = false
        operationType = nil
    }
    
    @IBAction func otherOperation(_ sender: UIButton) {
        guard
            let title = sender.titleLabel?.text,
            let operation = OtherOperation(rawValue: title)
        else { return }
        
        switch operation {
            
        case .deleteLastNumber:
            guard let text = displayLabel.text, !text.isEmpty else { return }
            displayLabel.text = String(text.dropLast())
            
            if displayLabel.text == "" {
                displayLabel.text = "0"
                typingNumber = false
            }
            
        case .deleteAllNumber:
            resetAll()
            
        case .percentPressed:
            if operationType == nil {
                currentInput = currentInput / 100
            } else {
                secondNumber = firstNumber * currentInput / 100
                currentInput = secondNumber
            }
            typingNumber = false
            dotIsPlace = false
            
        case .plusAndMinus:
            currentInput = -currentInput
            typingNumber = true
            
        case .makeDoubleNumber:
            if typingNumber && !dotIsPlace {
                displayLabel.text?.append(".")
                dotIsPlace = true
                
            } else if !typingNumber && !dotIsPlace {
                displayLabel.text = "0."
                typingNumber = true
                dotIsPlace = true
            }
        }
    }
}



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


