//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var digitButtons: [UIButton]! // This outlet is use for test.
    var model = Operations()

    override func viewDidLoad() {
        super.viewDidLoad()
        var name = Notification.Name(rawValue: "calculatorExpression_modified")
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: name, object: nil)

        name = Notification.Name(rawValue: "present_button_alertVC")
        NotificationCenter.default.addObserver(self, selector: #selector(present_button_alertVC),
                                               name: name, object: nil)

        name = Notification.Name(rawValue: "present_incorrectCalc_alertVC")
        NotificationCenter.default.addObserver(self, selector: #selector(present_incorrectCalc_alertVC),
                                               name: name, object: nil)

        name = Notification.Name(rawValue: "present_newCalc_alertVC")
        NotificationCenter.default.addObserver(self, selector: #selector(present_newCalc_alertVC),
                                               name: name, object: nil)
    }

    @objc func present_button_alertVC() {
        let alertVC = UIAlertController(title: nil, message: "Un operateur est déja mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    @objc func present_incorrectCalc_alertVC() {
        let alertVC = UIAlertController(title: nil,
                                        message: "Entrez une expression correcte !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    @objc func present_newCalc_alertVC() {
        let alertVC = UIAlertController(title: nil, message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func refreshView() {
        textView.text = model.calculatorExpression
    }

    func refreshModel() {
        model.calculatorExpression = textView.text
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        refreshModel()
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        model.digitButtonTouched(numberText)
    }

    @IBAction func tappedAdditionButton() {
        refreshModel()
        model.tappedAdditionButton()
    }

    @IBAction func tappedSubstractionButton() {
        refreshModel()
        model.tappedSubstractionButton()
    }

    @IBAction func tappedMultiplicationButton() {
        refreshModel()
        model.tappedMultiplicationButton()
    }

    @IBAction func tappedDivisionButton() {
        refreshModel()
        model.tappedDivisionButton()
    }

    @IBAction func tappedEqualButton() {
        refreshModel()
        model.tappedEqualButton()
    }

}
