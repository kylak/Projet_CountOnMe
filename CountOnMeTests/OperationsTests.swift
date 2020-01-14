//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class OperationsTests: XCTestCase {

    var model: Operations!

    override func setUp() {
        super.setUp()
        model = Operations()
        model.ACjustBefore = false;
    }
    
    func testGivenACorrectExpression_WhenWeTryToCheckIfWeItSCorrect_ThencalculatorExpressionIsCorrectIsTrue() {
        model.calculatorExpression = "5 + 4"
        
        XCTAssertTrue(model.calculatorExpressionIsCorrect)
    }

    func testGivenACorrectExpression_WhenWeTryToCheckIfWeCanAddAnOperator_ThencanAddOperatorIsTrue() {
        model.calculatorExpression = ""
        
        let result = model.canAddOperator
        
        XCTAssertTrue(result)
    }
    
    func testGivenAnExpressionWith3Elements_WhenWeTryToCheckIfTheExpressionHaveEnoughElement_ThenTheExpressionHasEnoughElement() {
        model.calculatorExpression = "1 + 3"
        
        let result = model.calculatorExpressionHaveEnoughElement
        
        XCTAssertTrue(result)
    }

    func testGivenExpressionHasNoResult_WhenADigitButtonIsTouched_ThenThisNumeralDigitIsAppendToTextView() {
        model.digitButtonTouched("3")
        
        XCTAssertEqual(model.calculatorExpression, "3")
    }
    
    func testGivenAnExpressionHavingResult_WhenADigitButtonIsTouched_ThenErrorMessageAppeared() {
        let result = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "calculatorExpression_modified"))
        model.tappedEqualButton()
    
        model.digitButtonTouched("3")
    
        wait(for: [result], timeout: 1)
    }

    func testGivenCanAddOperatorToExpression_WhenAdditionButtonIsTouched_ThenAdditionSymbolIsAddedToExpression() {
        model.tappedAdditionButton()
        
        XCTAssertEqual(model.calculatorExpression, " + ")
    }
    
    func testGivenCanNotAddOperatorToExpression_WhenAdditionButtonIsTouched_ThenMessageErrorAppeared() {
        let result = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "present_button_alertVC"))
        
        model.tappedAdditionButton()
        model.tappedAdditionButton()
        
        wait(for: [result], timeout: 1)
    }
    
    func testGivenCanAddOperatorToExpression_WhenSubstractionButtonIsTouched_ThenSubstractionSymbolIsAddedToExpression() {
        model.tappedSubstractionButton()
        
        XCTAssertEqual(model.calculatorExpression, " - ")
    }
    
    func testGivenCanNotAddOperatorToExpression_WhenSubstractionButtonIsTouched_ThenMessageErrorAppeared() {
        let result = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "present_button_alertVC"))
        
        model.tappedSubstractionButton()
        model.tappedSubstractionButton()
        
        wait(for: [result], timeout: 1)
    }
    
    func testGivenCanAddOperatorToExpression_WhenDivisionButtonIsTouched_ThenDivisionSymbolIsAddedToExpression() {
        model.tappedDivisionButton()
        
        XCTAssertEqual(model.calculatorExpression, " / ")
    }
    
    func testGivenCanNotAddOperatorToExpression_WhenDivisionButtonIsTouched_ThenMessageErrorAppeared() {
        let result = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "present_button_alertVC"))
        
        model.tappedDivisionButton()
        model.tappedDivisionButton()
        
        wait(for: [result], timeout: 1)
    }
    
    func testGivenCanAddOperatorToExpression_WhenMultiplicationButtonIsTouched_ThenMultiplicationSymbolIsAddedToExpression() {
        model.tappedMultiplicationButton()
        
        XCTAssertEqual(model.calculatorExpression, " x ")
    }
    
    func testGivenCanNotAddOperatorToExpression_WhenMultiplicationButtonIsTouched_ThenMessageErrorAppeared() {
        let result = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "present_button_alertVC"))
        
        model.tappedMultiplicationButton()
        model.tappedMultiplicationButton()
        
        wait(for: [result], timeout: 1)
    }
    
    func testGivenCalculatorExpressionIsCorrectAndCalculatorExpressionHaveEnoughElement_WhenEqualButtonTapped_ThenAppendEqualSymbolAndResultToExpression() {
        let operand1 = 5
        let operand2 = 3
        let result = operand1 + operand2
        model.digitButtonTouched(String(operand1))
        model.tappedAdditionButton()
        model.digitButtonTouched(String(operand2))
        XCTAssertTrue(model.calculatorExpressionIsCorrect)
        XCTAssertTrue(model.calculatorExpressionHaveEnoughElement)
            
        model.tappedEqualButton()
        
        XCTAssertEqual(model.calculatorExpression, "\(operand1) + \(operand2) = \(result)")
    }
    
    func testGivenASubstraction_WhenEqualButtonTapped_ThenResultIsFoundAndDisplayed() {
            let operand1 = 5
            let operand2 = 3
            let result = operand1 - operand2
            model.digitButtonTouched(String(operand1))
            model.tappedSubstractionButton()
            model.digitButtonTouched(String(operand2))
            XCTAssertTrue(model.calculatorExpressionIsCorrect)
            XCTAssertTrue(model.calculatorExpressionHaveEnoughElement)
                
            model.tappedEqualButton()
        
            XCTAssertEqual(model.calculatorExpression, "\(operand1) - \(operand2) = \(result)")
    }
    
    func testGivenAMultiplication_WhenEqualButtonTapped_ThenResultIsFoundAndDisplayed() {
            let operand1 = 5
            let operand2 = 3
            let result = operand1 * operand2
            model.digitButtonTouched(String(operand1))
            model.tappedMultiplicationButton()
            model.digitButtonTouched(String(operand2))
            XCTAssertTrue(model.calculatorExpressionIsCorrect)
            XCTAssertTrue(model.calculatorExpressionHaveEnoughElement)
                
            model.tappedEqualButton()
        
            XCTAssertEqual(model.calculatorExpression, "\(operand1) x \(operand2) = \(result)")
    }
    
    func testGivenADivision_WhenEqualButtonTapped_ThenResultIsFoundAndDisplayedWithPrecision() {
            let operand1 = 7
            let operand2 = 3
            var result = Double(Double(operand1) / Double(operand2))
            let precision = 10000000.0
            result = Double(round(precision*result)/precision)
        
            model.digitButtonTouched(String(operand1))
            model.tappedDivisionButton()
            model.digitButtonTouched(String(operand2))
            XCTAssertTrue(model.calculatorExpressionIsCorrect)
            XCTAssertTrue(model.calculatorExpressionHaveEnoughElement)
                
            model.tappedEqualButton()
        
            XCTAssertEqual(model.calculatorExpression, "\(operand1) / \(operand2) = \(result)")
    }
    
    func testGivenAnExpressionHavingResult_WhenEqualButtonTapped_ThenErrorMessageAppeared() {
            let result = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "present_newCalc_alertVC"))
            model.calculatorExpression = "22"
        
            model.tappedEqualButton()
        
            wait(for: [result], timeout: 1)
    }
    
    func testGivenAnIncorrectExpression_WhenEqualButtonTapped_ThenErrorMessageAppeared() {
            let result = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "present_incorrectCalc_alertVC"))
            model.calculatorExpression = "14 + 5 = "
        
            model.tappedEqualButton()
        
            wait(for: [result], timeout: 1)
    }
    
    func testGivenANumber_WhenDivisingBy0_ThenCalculateWell() {
        let operand1 = 5
        let operand2 = 0
        model.digitButtonTouched(String(operand1))
        model.tappedDivisionButton()
        model.digitButtonTouched(String(operand2))
        XCTAssertTrue(model.calculatorExpressionIsCorrect)
        XCTAssertTrue(model.calculatorExpressionHaveEnoughElement)
        
        let operationsToReduce = model.calcul(model.elements)
        var result : String? = nil
        if (operationsToReduce.first != nil) {
            result = operationsToReduce.first!
        }
        XCTAssertNotNil(result)
        if let deballe = result {
            XCTAssertEqual(deballe, "inf")
        }
    }
    
    func testGivenANumber_WhenDivisingBy0_ThenDisplayErreur() {
        let operand1 = 5
        let operand2 = 0
        model.digitButtonTouched(String(operand1))
        model.tappedDivisionButton()
        model.digitButtonTouched(String(operand2))
        XCTAssertTrue(model.calculatorExpressionIsCorrect)
        XCTAssertTrue(model.calculatorExpressionHaveEnoughElement)
            
        model.tappedEqualButton()
        
        XCTAssertEqual(model.calculatorExpression, "Erreur")
    }
    
    func testGivenAMathExpressionAsString_WhenWeCalculateIt_ThenItReturnsTheResult() {
        let aMathematicalExpression = "(4 + 9) / 2"
        
        let result = aMathematicalExpression.calculate()
        
        XCTAssertEqual(6.5, result)
    }
    
    func testGivenDoubleWith0AsDecimalNumber_WhencleanIsCalled_ThenTheNumberIsDisplayedWithoutTheDecimalPart() {
        let aNumber = 25.0
        XCTAssertEqual(aNumber.clean, "25")
    }
    
    func testGiven0_WhencleanMethodIsCalled_ThenGives0() {
        let number = 0.0
        
        let cleanedNumber = number.clean
        
        XCTAssertEqual(cleanedNumber, "0")
    }
    
    func testGivenOnlyOneDigitNumberInTheCalculatorExpression_WhenThecalculMethodIsCalled_ThenItReturnsThisDigitNumber() {
        model.calculatorExpression = "5"
        
        let returnedValue =  model.calcul(model.elements)
        
        XCTAssertEqual(returnedValue.first, model.calculatorExpression)
    }
    
    func testGivenAnExpression_WhenACButtonTouched_ThencalculatorExpressionEqualsTo0AndACjustBeforeIsTrueAndANotifIsPosted() {
        let scheduledNotif = XCTNSNotificationExpectation(name: NSNotification.Name(rawValue: "calculatorExpression_modified"))
        model.calculatorExpression = "4 + 9 / 5"
        
        model.tappedAC_button()
        
        XCTAssertEqual(model.calculatorExpression, "0")
        XCTAssertTrue(model.ACjustBefore)
        wait(for: [scheduledNotif], timeout: 1)
    }
    
    
    func testGivenAMathExpressionUsingPriorityRules_WhenWeCalculate_ThenGiveTheCorrectResult() {
        let operand1 = 5
        model.digitButtonTouched(String(operand1))
        model.tappedDivisionButton()
        let operand2 = 11
        model.digitButtonTouched(String(operand2))
        model.tappedSubstractionButton()
        let operand3 = 14
        model.digitButtonTouched(String(operand3))
        model.tappedMultiplicationButton()
        let operand4 = 4
        model.digitButtonTouched(String(operand4))
        var result = Double(Double(operand1) / Double(operand2))
        let precision = 10000000.0
        result = Double(round(precision*result)/precision)
        result -= Double(operand3 * operand4)
        
        model.tappedEqualButton()
    
        XCTAssertEqual(model.calculatorExpression, "\(operand1) / \(operand2) - \(operand3) x \(operand4) = \(result)")
    }
}

