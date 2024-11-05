//
//  ViewController.swift
//  TicTacToe
//
//  Created by jacqueline Ngigi on 2024-09-02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1NameField: UITextField!
    @IBOutlet weak var player2NameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startBtnOnClicked(_ sender: UIButton) {
        if shouldPerformSegue(withIdentifier: "goToGameVC", sender: self) {
            performSegue(withIdentifier: "goToGameVC", sender: self)
        } else {
            showAlertForEmptyFields()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameVC" {
            if let gameVC = segue.destination as? GameViewController {
                gameVC.player1Name = player1NameField.text ?? "Player 1"
                gameVC.player2Name = player2NameField.text ?? "Player 2"
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToGameVC" {
            return !(player1NameField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
                   !(player2NameField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        }
        return true
    }
// function to show an alert to enter player names
    private func showAlertForEmptyFields() {
        let alert = UIAlertController(title: "Missing Names", message: "Please enter names for both players.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
    


    



