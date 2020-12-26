//
//  Board.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/24/20.
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


import UIKit
import GameplayKit

class Table: NSObject, GKGameModel {
    var players: [GKGameModelPlayer]?
    var currentPlayer: Player
    var activePlayer: GKGameModelPlayer?
    
    var numPlayers: Int! /* A */
    
    var hands = [[Card]]() /* 1 */
    var stacks = [[Card]]() /* 2 */
    var discardPiles = [[Card]]() /* 3 */
    var hints = Array(repeating: true, count: 8) /* 4 */
    var cardLeftInDeck = 50 /*Need to make this automatically update or something.  This is a really clunky way to do this*/
    
    override init() {
        super.init()
        hands = buildCardPiles(numberOfPiles: numPlayers, cardInEachPile: 5)
        stacks = buildCardPiles(numberOfPiles: 5, cardInEachPile: 5)
        discardPiles = buildCardPiles(numberOfPiles: 5, cardInEachPile: 10)
    }
    
    func setGameModel(_ gameModel: GKGameModel) {
        if let table = gameModel as? Table{
            //???
            currentPlayer = table.currentPlayer
        }
    }
    

     func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
         //We optionally downcast our GKGameModelPlayer parameter into a Player object.
         if let playerObject = player as? Player {
             // If the player or their opponent has won, return nil to signal no moves are available.
             //if isWin(for: playerObject) || isWin(for: playerObject.opponent) {
              //   return nil
             //}

             // Otherwise, create a new array that will hold Move objects.
             var moves = [Move]()

             // Loop through every column in the board, asking whether the player can move in that column.
             //for column in 0 ..< Board.width {
                 //if canMove(in: column) {
                     // Loop through every column in the board, asking whether the player can move in that column.
                     //moves.append(Move(column: column))
               //  }
            // }

             // Finally, return the array to tell the AI all the possible moves it can make.
             return moves
         }

         return nil
     }
     
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        if let move = gameModelUpdate as? Move {
            //add(chip: currentPlayer.chip, in: move.column)
            currentPlayer = currentPlayer.opponent
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Table()
        copy.setGameModel(self)
        return copy
    }
    
    func buildCardPiles(numberOfPiles:Int, cardInEachPile:Int)->[[Card]]{
        var newArray = [[Card]]()
        for counta in 0...numberOfPiles - 1{
            for _ in 0...cardInEachPile - 1{
                newArray[counta].append(Card())
            }
        }
        return newArray
        
    }
    
}
