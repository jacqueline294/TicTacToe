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
    
    // connect the boxes
    @IBOutlet weak var box1: UIImageView!
    
    @IBOutlet weak var box2: UIImageView!
    
    @IBOutlet weak var box3: UIImageView!
    
    @IBOutlet weak var box4: UIImageView!
    
    @IBOutlet weak var box5: UIImageView!
    
    @IBOutlet weak var box6: UIImageView!
    
    @IBOutlet weak var box7: UIImageView!
    
    @IBOutlet weak var box8: UIImageView!
    
    @IBOutlet weak var box9: UIImageView!
    
    @IBOutlet weak var WinnerLabel: UILabel!
    
    var player1Name: String = "Player 1"
    var player2Name: String = "Player 2"
    var lastValue = "o"
    var isPlayerOneTurn = true
    var playerOneChoices: [Box] = []
    var playerTwoChoices: [Box] = []
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1Namelbl.text = player1Name
        player2NameLbl.text = player2Name
        whosTurnLbl.text = "Turn: \(player1Name)"
        
        // Set up tap gestures on each box
                createTap(on: box1, type: .one)
                createTap(on: box2, type: .two)
                createTap(on: box3, type: .three)
                createTap(on: box4, type: .four)
                createTap(on: box5, type: .five)
                createTap(on: box6, type: .six)
                createTap(on: box7, type: .seven)
                createTap(on: box8, type: .eight)
                createTap(on: box9, type: .nine)
            }
            
            func createTap(on imageView: UIImageView, type box: Box) {
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:)))
                tap.name = box.rawValue
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tap)
            }
            
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        let selectedBox = getBox(from: sender.name ?? "")
        
        guard selectedBox.image == nil else { return } // Prevent selecting already marked boxes
        
        // Make choice and record it for the current player
        makeChoice(selectedBox)
        
        if isPlayerOneTurn {
            playerOneChoices.append(Box(rawValue: sender.name!)!)
        } else {
            playerTwoChoices.append(Box(rawValue: sender.name!)!)
        }
        // Check for a win or draw after each move
        checkIfWon()
        
        // update the label to reflect the current player
        isPlayerOneTurn.toggle()
        whosTurnLbl.text = isPlayerOneTurn ? "\(player1Name)'s Turn" : "\(player2Name)'s Turn"
    }

            //to play the x or o  where player one is x and player two is o
            func makeChoice(_ selectedBox: UIImageView) {
                guard selectedBox.image == nil else { return }
                
                if isPlayerOneTurn {
                    selectedBox.image = #imageLiteral(resourceName: "ex")
                    lastValue = "x"
                } else {
                    selectedBox.image = #imageLiteral(resourceName: "oh")
                    lastValue = "o"
                }
            }
            // check for possible wins  with the different combinations  array ,
            func checkIfWon() {
                let winningCombinations: [[Box]] = [
                    [.one, .two, .three], [.four, .five, .six], [.seven, .eight, .nine], //row
                    [.one, .four, .seven], [.two, .five, .eight], [.three, .six, .nine], // colums
                    [.one, .five, .nine], [.three, .five, .seven] // daiagonal
                ]
                
                for combination in winningCombinations {
                    let playerOneMatch = playerOneChoices.filter { combination.contains($0) }.count
                    let playerTwoMatch = playerTwoChoices.filter { combination.contains($0) }.count
                    
                    if playerOneMatch == combination.count {
                        WinnerLabel.text = "\(player1Name) Wins!"
                        WinnerLabel.isHidden = false
                        player1ScoreLbl.text = String((Int(player1ScoreLbl.text ?? "0") ?? 0) + 1)
                        resetGame(after: 2.0)
                        return
                    } else if playerTwoMatch == combination.count {
                        WinnerLabel.text = "\(player2Name) Wins!"
                        WinnerLabel.isHidden = false
                        player2ScoreLbl.text = String((Int(player2ScoreLbl.text ?? "0") ?? 0) + 1)
                        resetGame(after: 2.0)
                        return
                    }
                }
                
                if playerOneChoices.count + playerTwoChoices.count == 9 {
                    WinnerLabel.text = "It's a Draw!"
                    WinnerLabel.isHidden = false
                    resetGame(after: 2.0)
                }
            }
            
            func resetGame(after delay: TimeInterval) {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    for box in Box.allCases {
                        let imageView = self.getBox(from: box.rawValue)
                        imageView.image = nil
                    }
                    self.playerOneChoices.removeAll()
                    self.playerTwoChoices.removeAll()
                    self.lastValue = "o"
                    self.isPlayerOneTurn = true
                    self.whosTurnLbl.text = (self.player1Name)
                    self.WinnerLabel.isHidden = true
                }
            }
            
            func getBox(from name: String) -> UIImageView {
                switch Box(rawValue: name) ?? .one {
                case .one: return box1
                case .two: return box2
                case .three: return box3
                case .four: return box4
                case .five: return box5
                case .six: return box6
                case .seven: return box7
                case .eight: return box8
                case .nine: return box9
                }
            }
            
            @IBAction func ExitBtn(_ sender: UIButton) {
                dismiss(animated: true, completion: nil)
            }
        }

        enum Box: String, CaseIterable {
            case one, two, three, four, five, six, seven, eight, nine
        }

