//
//  ViewController.swift
//  SkillBoxUI_2
//
//  Created by Danya on 13.12.2025.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var typingNumber = false //переменная для проверки вводит пользователь число или он закончил операцию
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var operationType: Int = 0 //какой знак вычисления выбрали
    var dotIsPlace = false //для проверки стоит точка или нет
    //вычисляемое значение (число, которое на экране) + удаляю с его помощью точки
    var currentInput: Double {
        get {
            return Double(displayLabel.text!)!
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


    @IBAction func nubmerPressed(_ sender: UIButton) {
        let number = sender.tag
        
        if typingNumber {
            displayLabel.text = displayLabel.text! + String(number)
        } else {
            displayLabel.text = String(number)
            typingNumber = true
        }
    }
    
    @IBAction func activeComputing(_ sender: UIButton) {
        operationType = sender.tag
        firstNumber = currentInput
        typingNumber = false
        dotIsPlace = false
        }
    
    @IBAction func equalityPressed(_ sender: UIButton) {
        var result: Double = 0
        
        if typingNumber {
            secondNumber = currentInput
        }
        
        dotIsPlace = false
        
//эти кейсы для операторов сделал через цифры, чтобы таг вызвать и меньше париться
        switch operationType {
        case 1:
            result = firstNumber + secondNumber
            typingNumber = false
        case 2:
            result = firstNumber - secondNumber
            typingNumber = false
        case 3:
            result =  firstNumber * secondNumber
            typingNumber = false
        case 4:
            result =  firstNumber / secondNumber
            typingNumber = false
        default: break
        }
        
        currentInput = result
    }
    
    @IBAction func deleteLastNumber(_ sender: UIButton) {
        displayLabel.text = String( displayLabel.text!.dropLast())
        if displayLabel.text == "" {
            currentInput = 0
        }
    }
    
    @IBAction func deleteAllNumber(_ sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        operationType = 0
        currentInput = 0
        displayLabel.text = "0"
        typingNumber = false
        dotIsPlace = false
    }
    
    @IBAction func percentPressed(_ sender: UIButton) {
        if firstNumber == 0 {
            currentInput = currentInput / 100
        } else {
            secondNumber = firstNumber * currentInput / 100
            typingNumber = false
        }
    }
    
    @IBAction func plusAndMinus(_ sender: UIButton) {
        currentInput = -currentInput
        typingNumber = true
    }
    
    @IBAction func makeDoubleNumber(_ sender: UIButton) {
        if typingNumber && !dotIsPlace {
            displayLabel.text = displayLabel.text! + "."
            dotIsPlace = true
        } else if !typingNumber && !dotIsPlace {
            displayLabel.text = "0."
        }
    }
    
}



