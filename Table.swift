//
//  Board.swift
//  Cooperation
//
//  Created by Janna Thomas on 12/24/20.
//  Copyright © 2020 Personal. All rights reserved.
//

/* Complete game state
 1. both players hands
 2. played cards in stacks
 3. played cards in discard pile
 4. hints remaining
 5. number of cards left in deck
*/

/* Fixed game parameters
 A. Number of players
 
 */

/*
 Methods
 1. Report what car is at a specific stack location
 2. Find the next  empty spot in a stack
 3. Determine if a card move is legal
 4. Play a card
 5. Discard a card
 6. Give a hint
 */


import UIKit
import GameplayKit

class Table: NSObject{
    
    var players: [GKGameModelPlayer]?{
        return Player.allPlayers
    }
    var activePlayer: GKGameModelPlayer?{
        return currentPlayer
    }
    var currentPlayer: Player

    
    var numPlayers = 2 /* A */
    var hands = [[Card]]() /* 1 */
    var stacks = [[Card]]() /* 2 */
    var discardPiles = [[Card]]() /* 3 */
    var hints = Array(repeating: true, count: 8) /* 4 */
    var cardLeftInDeck = 50 /*Need to make this automatically update or something.  This is a really clunky way to do this*/
    
    var deck = Deck()
    
    override init() {
        //print("initialized")
        currentPlayer = Player.allPlayers[0]
        super.init()
        hands = buildCardPiles(numberOfPiles: numPlayers, cardInEachPile: 5)
        stacks = buildCardPiles(numberOfPiles: 5, cardInEachPile: 5)
        discardPiles = buildCardPiles(numberOfPiles: 5, cardInEachPile: 10)

        for hand in 0...1{
            for card in 0...4{
              
                hands[hand][card] = deck.drawCard()!
                print(hands[hand][card])
            }
        }
    }
    
    func buildCardPiles(numberOfPiles:Int, cardInEachPile:Int)->[[Card]]{
        let newArray = Array(repeating: Array(repeating: Card(), count: cardInEachPile), count: numberOfPiles)
        //print("new array capactiy" = newArray.count)
        return newArray
    }
    
    func isOutOfCards() -> Bool {
        return false
    }
    
    func isWin(for player: GKGameModelPlayer) -> Bool {
        //the top card in each stack is a 5
        return false
    }
    /*
     var slots = [ChipColor]()

     override init() {
         for _ in 0 ..< Board.width * Board.height {
             slots.append(.none)
         }

         super.init()
     }
     */
    
    func score(for player: GKGameModelPlayer)->Int{
        if let playerObject = player as? Player {
               if isWin(for: playerObject) {
                   return 1000
               } else if isWin(for: playerObject.opponent) {
                   return -1000
               }
           }
           return 0
    }
    

     func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
         //We optionally downcast our GKGameModelPlayer parameter into a Player object.
         //if let playerObject = player as? Player {
             // If the player or their opponent has won, return nil to signal no moves are available.
             //if isWin(for: playerObject) || isWin(for: playerObject.opponent) {
              //   return nil
             //}

             // Otherwise, create a new array that will hold Move objects.
          //   var moves = [Move]()

             // Loop through every column in the board, asking whether the player can move in that column.
             //for column in 0 ..< Board.width {
                 //if canMove(in: column) {
                     // Loop through every column in the board, asking whether the player can move in that column.
                     //moves.append(Move(column: column))
               //  }
            // }

             // Finally, return the array to tell the AI all the possible moves it can make.
          //   return moves
       //  }

         return nil
     }
     
    //execute once for every move
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
       // if let move = gameModelUpdate as? Move {
            //add(chip: currentPlayer.chip, in: move.column)
            //currentPlayer = currentPlayer.opponent
       // }
    }

    

    
    func nextEmptySpotInStack(){
        
    }
    
    func discardCard(hand:Int, card:Int)->Int{
        print("Got message to discard card hand: ",hand," card: ",card)
        print("returning stack number : ",hands[hand][card].col.rawValue)
        print("disarding Card: ",hands[hand][card].num , hands[hand][card].col)
        //-1 is to leave a spot for none
        return hands[hand][card].col.rawValue - 1
    }
    
}

extension Table: GKGameModel{
    
    //make an empty board object then call setGameMdodel to acdtaul copy the data set to the active player
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Table()
        copy.setGameModel(self)
        return copy
    }
    
    //actually copy  across the stack data? and set the active player
    func setGameModel(_ gameModel: GKGameModel) {
        if let table = gameModel as? Table{
            //???
        currentPlayer = table.currentPlayer
        }
    }
    
}

struct Deck {
    var cards = [Card]()
    
    init() {
        for col in Card.Col.all{
            for num in Card.Num.all{
                switch num{
                case Card.Num.one:
                    cards.append(Card(num: num, col: col))
                    cards.append(Card(num: num, col: col))
                    cards.append(Card(num: num, col: col))
                case Card.Num.five:
                    cards.append(Card(num: num, col: col))
                default:
                    cards.append(Card(num: num, col: col))
                    cards.append(Card(num: num, col: col))
                }
            }
        }
    }
    
    mutating func drawCard() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
        } else {
            return nil
        }
        //TODO: add other error catching stuff here
    }
}
