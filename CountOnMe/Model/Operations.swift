//
//  Operations.swift
//  CountOnMe
//
//  Created by Gustav Berloty on 02/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Operations {
    
    // Iterate over operations while an operand still here
    static func calcul(_ opToReduce : [String]) -> [String] {
        var operationsToReduce = opToReduce
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Float
            switch operand {
                case "+": result = Float(left + right)
                case "-": result = Float(left - right)
                case "x": result = Float(left * right)
                case "/": result = Float(Float(left) / Float(right))
                default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result.clean)", at: 0)
            return operationsToReduce
        }
        return operationsToReduce
    }
}

/* This extension is use to remove the ".0" from a float number like "32.0" for example.
   So with clean we'd have "32" instead of "32.0". */
extension Float {
    var clean: String {
        let intValue = Int(self)
        if self == 0 {return "0"}
        if self / Float (intValue) == 1 { return "\(intValue)" }
        return "\(self)"
    }
}
