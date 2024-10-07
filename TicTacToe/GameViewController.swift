//
//  GameViewController.swift
//  TicTacToe
//
//  Created by jacqueline Ngigi on 2024-09-09.
//

import UIKit

class GameViewController: UIViewController {

    
    // connect all the outlets
    @IBOutlet weak var player1Namelbl: UILabel!
    
    @IBOutlet weak var player2NameLbl: UILabel!
    
    
    @IBOutlet weak var whosTurnLbl: UILabel!
    
    @IBOutlet weak var player1ScoreLbl: UILabel!
    
    @IBOutlet weak var player2ScoreLbl: UILabel!
    
    // connect the imageviews
    @IBOutlet weak var box1: UIImageView!
    
    @IBOutlet weak var box2: UIImageView!
    
    @IBOutlet weak var box3: UIImageView!
    
    @IBOutlet weak var box4: UIImageView!
    
    @IBOutlet weak var box5: UIImageView!
    
    @IBOutlet weak var box6: UIImageView!
    
    @IBOutlet weak var box7: UIImageView!
    
    @IBOutlet weak var box8: UIImageView!
    
    @IBOutlet weak var box9: UIImageView!
    
    
    var player1Name: String?
        var player2Name: String?
        var player1Score = 0
        var player2Score = 0
        
    // Array to keep track of the game state (0: empty, 1: Player 1, 2: Player 2)
      var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
      
      var currentPlayer = 1
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Set player names and update labels
          player1Namelbl.text = player1Name
          player2NameLbl.text = player2Name
          updateTurnLabel()
          
          // Add tap gesture recognizers for each box
          addTapGestureToBoxes()
      }
      
      // Function to add tap gesture recognizers and set tag  gesture to all the boxes
      func addTapGestureToBoxes() {
          let boxes = [box1, box2, box3, box4, box5, box6, box7, box8, box9]
          
          for (index, box) in boxes.enumerated() {
              let tapGesture = UITapGestureRecognizer(target: self, action: #selector(boxTapped(_:)))
              box?.isUserInteractionEnabled = true
              box?.tag = index + 1
              box?.addGestureRecognizer(tapGesture)
          }
      }
      
      // Function to handle the tap on a box
      @objc func boxTapped(_ sender: UITapGestureRecognizer) {
          guard let tappedBox = sender.view as? UIImageView else { return }
          
          let tag = tappedBox.tag - 1
          
          // Check if the box is empty
          if gameState[tag] == 0 {
              gameState[tag] = currentPlayer
              
              // Display "X" for Player 1 and "O" for Player 2
              if currentPlayer == 1 {
                  tappedBox.image = UIImage(named: "ex")
              } else {
                  tappedBox.image = UIImage(named: "oh")
              }
              
              // Check if there's a winner after the move
              if checkWinner() {
                  if currentPlayer == 1 {
                      player1Score += 1
                  } else {
                      player2Score += 1
                  }
                  updateScores()
                  resetBoard()
              } else if !gameState.contains(0) {
                  // If the game is a draw (all boxes filled)
                  resetBoard()
              } else {
                  // Switch turn
                  currentPlayer = (currentPlayer == 1) ? 2 : 1
                  updateTurnLabel()
              }
          }
      }
      
      // Function to sho Who's Turn it is
      func updateTurnLabel() {
          if currentPlayer == 1 {
              whosTurnLbl.text = "\(player1Name ?? "Player 1")'s Turn"
          } else {
              whosTurnLbl.text = "\(player2Name ?? "Player 2")'s Turn"
          }
      }
      
      // Function to update scores
      func updateScores() {
          player1ScoreLbl.text = "\(player1Score)"
          player2ScoreLbl.text = "\(player2Score)"
      }
      
      // Function to check if there's a winner
      func checkWinner() -> Bool {
          // All possible winning combinations
          let winningCombinations = [
              [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
              [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
              [0, 4, 8], [2, 4, 6]             // Diagonals
          ]
          
          for combination in winningCombinations {
              if gameState[combination[0]] != 0 &&
                  gameState[combination[0]] == gameState[combination[1]] &&
                  gameState[combination[1]] == gameState[combination[2]] {
                  return true // There is a winner
              }
          }
          
          return false // No winner
      }
      
      // Function to reset the board after each round
      func resetBoard() {
          gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
          
          for i in 1...9 {
              let box = self.view.viewWithTag(i) as! UIImageView
              box.image = nil // Clear images on the board
          }
          
          currentPlayer = 1 // Player 1 always starts first
          updateTurnLabel()
      }
  }
    
    
