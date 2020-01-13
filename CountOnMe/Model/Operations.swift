//
//  Operations.swift
//  CountOnMe
//
//  Created by Gustav Berloty on 02/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class Operations {

    var calculatorExpression = ""
    var ACjustBefore = true
    let notif = NotificationCenter.default

    var elements: [String] {
        return calculatorExpression.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    var calculatorExpressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "=" && !ACjustBefore
    }

    var calculatorExpressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var calculatorExpressionHaveResult: Bool {
        return (calculatorExpression.firstIndex(of: "=") != nil || calculatorExpression == "Erreur")
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && !calculatorExpressionHaveResult && !ACjustBefore
    }

    func digitButtonTouched(_ numberText: String) {
        if calculatorExpressionHaveResult {
            calculatorExpression = ""
        }
        calculatorExpression.append(numberText)
        if (ACjustBefore) {
            calculatorExpression = numberText
            ACjustBefore = false
        }
        notif.post(name: Notification.Name("calculatorExpression_modified"), object: nil)
    }

    func tappedAdditionButton() {
        if canAddOperator {
            calculatorExpression.append(" + ")
            notif.post(name: Notification.Name("calculatorExpression_modified"), object: nil)
        } else {
            notif.post(name: Notification.Name("present_button_alertVC"), object: nil)
        }
    }

    func tappedSubstractionButton() {
        if canAddOperator {
            calculatorExpression.append(" - ")
            notif.post(name: Notification.Name("calculatorExpression_modified"), object: nil)
        } else {
            notif.post(name: Notification.Name("present_button_alertVC"), object: nil)
        }
    }

    func tappedMultiplicationButton() {
        if canAddOperator {
            calculatorExpression.append(" x ")
            notif.post(name: Notification.Name("calculatorExpression_modified"), object: nil)
        } else {
            notif.post(name: Notification.Name("present_button_alertVC"), object: nil)
        }
    }

    func tappedDivisionButton() {
        if canAddOperator {
            calculatorExpression.append(" / ")
            notif.post(name: Notification.Name("calculatorExpression_modified"), object: nil)
        } else {
            notif.post(name: Notification.Name("present_button_alertVC"), object: nil)
        }
    }

    func tappedEqualButton() {
        guard calculatorExpressionIsCorrect else {
            return notif.post(name: Notification.Name("present_incorrectCalc_alertVC"), object: nil)
        }
        guard calculatorExpressionHaveEnoughElement else {
            return notif.post(name: Notification.Name("present_newCalc_alertVC"), object: nil)
        }
        if (!calculatorExpressionHaveResult) {
            // Iterate over operations while an operand still here
            let operationsToReduce = calcul(elements)
            if (operationsToReduce.first != nil && operationsToReduce.first != "inf") {
                calculatorExpression.append(" = \(operationsToReduce.first!)")
            }
            else { calculatorExpression = "Erreur" } // division par 0.
            notif.post(name: Notification.Name("calculatorExpression_modified"), object: nil)
        }
    }
    
    func tappedAC_button() {
        calculatorExpression = "0"
        ACjustBefore = true;
        notif.post(name: Notification.Name("calculatorExpression_modified"), object: nil)
    }

    // Iterate over operations while an operand still here
    func calcul(_ opToReduce: [String]) -> [String] {
        var operationsToReduce = opToReduce
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])
            var result: Double?
            switch operand {
            case "/":
                if right != 0, let openedRight = right, let openedLeft = left {
                    result = Double(Double(openedLeft) / Double(openedRight))
                }
                else { result = nil}
            default: result = 0.0
            }
            if (result != nil) {
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                let calculateForm = calculatorExpression.replacingOccurrences(of: " x ", with: " * ")
                result = calculateForm.calculate()
                let precision = 10000000.0
                if let openedResult = result {
                    result = Double(round(precision*openedResult)/precision)
                    if let openedResult2 = result {
                        operationsToReduce.insert(openedResult2.clean, at: 0)
                    }
                }
                return operationsToReduce
            }
            else {
                operationsToReduce.insert("inf", at: 0)
                return operationsToReduce
            }
        }
        return operationsToReduce
    }
}

extension String {

    private func allNumsToFloat() -> String {

        let symbolsCharSet = ".,"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        let chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
                loop: while i < chars.count {
                    if fullCharSet.contains(chars[i]) {
                        numString += String(chars[i])
                        i += 1
                    } else {
                        break loop
                    }
                }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }

    func calculate() -> Double? {
        let transformedString = allNumsToFloat()
        let expr = NSExpression(format: transformedString)
        return expr.expressionValue(with: nil, context: nil) as? Double
    }
}

/* This extension is use to remove the ".0" from a float number like "32.0" for example.
   So with clean we'd have "32" instead of "32.0". */
extension Double {
    var clean: String {
        let doubleValue = Int(self)
        if self == 0 {return "0"}
        if self / Double(doubleValue) == 1 { return "\(doubleValue)" }
        return "\(self)"
    }
}

