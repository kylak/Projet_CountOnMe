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
    var model = Operations()

    override func viewDidLoad() {
        super.viewDidLoad()
        var name = Notification.Name(rawValue: "textView_modified")
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
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    @objc func present_incorrectCalc_alertVC() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Entrez une expression correcte !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    @objc func present_newCalc_alertVC() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    @objc func refreshView() {
        textView = model.textView
    }

    func refreshModel() {
        model.textView = textView
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        refreshModel()
        model.touchedButton(sender)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        refreshModel()
        model.tappedAdditionButton(sender)
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        refreshModel()
        model.tappedSubstractionButton(sender)
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        refreshModel()
        model.tappedMultiplicationButton(sender)
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        refreshModel()
        model.tappedDivisionButton(sender)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        refreshModel()
        model.tappedEqualButton(sender)
    }

}
