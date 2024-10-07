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
        // Do any additional setup after loading the view.
    }
    
    // To ensures the segue is triggered once  the conditions are met.
    @IBAction func startBtnOnClicked(_ sender: UIButton) {
        if shouldPerformSegue(withIdentifier: "goToGameVC", sender: self) {
                    performSegue(withIdentifier: "goToGameVC", sender: self)
            
                }
       
    }
    
    // function to move the input in the textfields of player 1 and player 2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToGameVC" {
                if let controller = segue.destination as? GameViewController {
                    controller.player1Name = player1NameField.text
                    controller.player2Name = player2NameField.text
                }
            }
        }
    // function to make user the player has to put in a name before the  game can go to the next viewcontroller
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if identifier == "goToGameVC" {
                
                // Check if both player name fields are not empty
                
                if player1NameField.text!.trimmingCharacters(in: .whitespaces).isEmpty || player2NameField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                    return false
            }
        }
        
        return true
    }
    
    
    
}
    
    


    



