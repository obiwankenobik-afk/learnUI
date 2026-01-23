//
//  CalucaloreButtonsFactory.swift
//  SkillBoxUI_4
//
//  Created by Danya on 22.01.2026.
//

///Создаем массив кнопок и собираем его
import UIKit

enum CalculatorButtonsFactory {
    ///Функция для заполнения массива кнопок
    private static func makeRow(_ items: [(ButtonViewModel.ButtonType, UIColor, ButtonViewModel.ActionType)]) -> [ButtonViewModel] {
        var row: [ButtonViewModel] = []
        
        for item in items {
            let model = ButtonViewModel(type: item.0, backgroundColor: item.1, actionType: item.2)
            row.append(model)
        }
        return row
    }
    
    ///Прописываем сам массив и добавляем во вьюху
    static func makeRows() -> [[ButtonViewModel]] {
        [makeRow(
            [(.image("delete.left"), .systemGray, .other),
             (.text("AC"), .systemGray, .other),
             (.text("%"), .systemGray, .other),
             (.text("÷"), .systemOrange, .operation )]),
         
         makeRow(
            [(.text("7"), .darkGray, .number),
             (.text("8"), .darkGray, .number),
             (.text("9"), .darkGray, .number),
             (.text("×"), .systemOrange, .operation)]),
         
         makeRow(
            [(.text("4"), .darkGray, .number),
             (.text("5"), .darkGray, .number),
             (.text("6"), .darkGray, .number),
             (.text("+"), .systemOrange, .operation)]),
         
         makeRow(
            [(.text("1"), .darkGray, .number),
             (.text("2"), .darkGray, .number),
             (.text("3"), .darkGray, .number),
             (.text("-"), .systemOrange, .operation)]),
         
         makeRow(
            [(.text("+/-"), .darkGray, .other),
             (.text("0"), .darkGray, .number),
             (.text("."), .darkGray, .other),
             (.text("="), .systemOrange, .equality)])]
    }
}
