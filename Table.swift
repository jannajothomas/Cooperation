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
    
    var computerPlayer = ComputerPlayer()
    var currentPlayer = 0{
        didSet{
            if(currentPlayer == 0){
                computerPlayer.playBestMove()
            }
        }
    }
    
    var numPlayers = 2 /* A */
    var hands = [[Card]]() /* 1 */
    var stacks = [[Card()]] /* 2 */
    var discardPiles = [[Card]]() /* 3 */
    var hints = Array(repeating: true, count: 8) /* 4 */
    var cardLeftInDeck = 50 /*Need to make this automatically update or something.  This is a really clunky way to do this*/
    
    var deck = Deck()
    
    override init() {
        super.init()
        hands = buildCardPiles(numberOfPiles: numPlayers, cardInEachPile: 5)
        discardPiles = buildCardPiles(numberOfPiles: 5, cardInEachPile: 10)
        stacks = buildCardPiles(numberOfPiles: 5, cardInEachPile: 5)

        for hand in 0...1{
            for card in 0...4{
              
                hands[hand][card] = deck.drawCard()!
                //print(hands[hand][card])
            }
        }
        //getArrayOfPlayableCards()
        printGameBoard()
    }
    
    func changePlayers() {
          currentPlayer = 1 - currentPlayer
          //updateUI()
      }
    
    func buildCardPiles(numberOfPiles:Int, cardInEachPile:Int)->[[Card]]{
        let newArray = Array(repeating: Array(repeating: Card(), count: cardInEachPile), count: numberOfPiles)
        return newArray
    }
    
    func isOutOfCards() -> Bool {
        return false
    }
    
    func isWin(for player: GKGameModelPlayer)->Bool {
        //the top card in each stack is a 5
        return false
    }
    
    func isCardPlayable(hand: Int, card: Int, stack: Int)->Bool{
        nextCardNum = getArrayOfPlayableCards()
        let cardNum = hands[hand][card].num.rawValue
        let cardColIndex = hands[hand][card].col.rawValue - 1
        
        //Played on an empty stack?
        if nextCardNum[stack] == 1{
            print("card is a one")
            //Card is a one
            if ((cardNum == 1) && (nextCardNum[cardColIndex] == 1)){
                //Card was played on an empty stack and that color hasn't already been played
                return true
            }
        }else{
            print("card is a ", cardNum)
            //Card is any number other than one
            
            //print("stack is ", stack, " cardColInex is ",cardColIndex)
            //print("cardNum is ", cardNum, "comp values is", nextCardNum[cardColIndex])
            if((stack == cardColIndex) && (cardNum == nextCardNum[cardColIndex])){
                print("card was played on the correct color stack and is the correct number")
                //Card was played on the correct color stack and is the correct number
                return true
            }else{
                print("card is wrong color or wrong number")
                //Card is wrong color or wrong number to be played
                return false
            }
        }
        return false
    }
    
    var nextCardNum = [0,0,0,0,0]
    func getArrayOfPlayableCards()->[Int]{
        for column in 0...4{
            nextCardNum[column] = getNextCardNumber(column: column)
        }
        print("next card num", nextCardNum)
        return nextCardNum
    }
    
    func getNextEmptyStackPosition(column: Int)->Int{
        for row in 0...4{
            if stacks[column][row].num.rawValue == 0{
                return row
            }
        }
        return 4
    }
    
    func  getNextCardNumber(column: Int)->Int{
        return getNextEmptyStackPosition(column: column) + 1
    }
    
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
    
    func playCard(hand:Int, card:Int){
        let stack = hands[hand][card].col.rawValue - 1
        stacks[stack][getNextEmptyStackPosition(column: stack)] = hands[hand][card]
        hands[hand][card] = deck.drawCard()!
        printGameBoard()
        changePlayers()
    }
    
    func printGameBoard(){
        nextCardNum = getArrayOfPlayableCards()
        for hand in 0...1{
            print("\nHand ",hand)
            for card in 0...4{
                print(hands[hand][card], terminator: "")
            }
        }
        print("\nStacks")
        for stack in 0...4{
            print(stacks[stack], terminator: "")
        }
        print("\nDiscard")
        for stack in 0...4{
            print("\nstack num:",stack, " ", terminator: "")
            for row in 0...9{
                print(discardPiles[stack][row], terminator: "")
            }
        }
        print("\nNext Cards To Play")
        for count in 0...4{
            print(nextCardNum[count],", ", terminator: "")
        }
        print("\n...................................................................")
    }
    
    func discardCard(hand:Int, card:Int)->Int{
        let discardColumn = hands[hand][card].col.rawValue - 1
        let firstEmptySlot = getFirstEmptySlot(column: discardColumn)
        discardPiles[discardColumn][firstEmptySlot] = hands[hand][card]
        hands[hand][card] = deck.drawCard()!
        printGameBoard()
        changePlayers()
        return discardColumn
    }
    
    func getFirstEmptySlot(column: Int)->Int{
        for count in 0...9{
            if (discardPiles[column][count].num.rawValue == 0){
                return count
            }
        }
        return -1
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
    
    func getFullDeck()->[Card]{
        return cards
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
