//
//  CustomError.swift
//  SkillBoxUI_2
//
//  Created by Danya on 13.01.2026.
//

enum CustomError: Error {
    case divideZero
    var errorDescription: String {
        switch self {
        case .divideZero: "На ноль делить нельзя"
        }
    }
}
