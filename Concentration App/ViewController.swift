//
//  ViewController.swift
//  Concentration App
//
//  Created by Pedro Henrique Lopes Duca on 08/07/23.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2, theme: [])
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    //THEME
    var themes = [[String]]()
    var currentThemeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themes.append(["🐶", "🐱", "🐰", "🐻", "🐷", "🐨", "🐭", "🦊", "🦁", "🐸"])
        themes.append(["⚽️", "🏀", "🎾", "🏐", "⚾", "🏉", "🏋🏽", "🏓", "🚴🏼", "🏃🏼"])
        themes.append(["🇧🇷", "🇨🇦", "🇦🇷", "🇩🇰", "🇯🇵", "🇺🇸", "🇲🇫", "🇰🇷", "🇻🇳", "🇨🇱"])
        updateGameTheme()
        updateViewFromModel()
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
            if game.allCardsFaceUp {
                printContent("Toddas cartas viradas para cima")
                newGameButton.isHidden = false
            }
        } else {
            print("card was not in cardButtons")
        }
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        currentThemeIndex = Int(arc4random_uniform(UInt32(themes.count)))
        let theme = themes[currentThemeIndex]
        
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2, theme: theme)
        flipCount = 0
        updateViewFromModel()
//        newGameButton.isHidden = true
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                if card.isMatched { button.isHidden = true} else {
                    button.backgroundColor = UIColor.orange
                }
            }
        }
    }
    
    
    //   var emoji = Dictionary<Int, String>()
    var emoji = [Int:String]()
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, themes.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
            emoji[card.identifier] = themes[currentThemeIndex][card.identifier % themes[currentThemeIndex].count]
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func updateGameTheme() {
        currentThemeIndex = Int.random(in: 0..<themes.count)
    }
}

