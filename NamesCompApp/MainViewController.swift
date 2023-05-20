//
//  ViewController.swift
//  NamesCompApp
//
//  Created by Артём Латушкин on 20.05.2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var youNameTextField: UITextField!
    @IBOutlet var partnerNameTextField: UITextField!
    
    @IBAction func resultButton() {
        guard let firstName = youNameTextField.text,
              let secondName = partnerNameTextField.text else { return }
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(
                title: "Names are missing",
                message: "Please enter both names"
            )
            return
        }
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToMaimBC(segue: UIStoryboardSegue) {
        youNameTextField.text = ""
        partnerNameTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.firstName = youNameTextField.text
        resultVC.secondName = partnerNameTextField.text
    }
}

extension MainViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == youNameTextField {
            partnerNameTextField.becomeFirstResponder()
        } else {
            resultButton()
        }
        return true
    }
}

extension MainViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

