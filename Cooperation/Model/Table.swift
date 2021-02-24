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

    //Constants
    let humanHand = 1
    let computerHand = 1
    let numPlayers = 2
    
    var computerPlayer = ComputerPlayer()

    var hands = [[Card]]()
    
    var humanHandColorHints = [Bool]()
    var humanHandNumberHints = [Bool]()
    var computerHandColorHints = [Bool]()
    var computerHandNumberHints = [Bool]()
    
    var stacks = [[Card()]]
    var discardPiles = [[Card]]()

    var deck = Deck()
    
    //TODO: Make the first value of current player randomly selected
    var currentPlayer = 1{
        didSet{
           changePlayers()
        }
    }
    
    private func changePlayers(){
           if(currentPlayer == 0){
               computerPlayer.playBestMove()
               switch computerPlayer.action{
                    case"play":
                       playCard(hand: 0, card: computerPlayer.cardToAct)
                    
                    //TODO: Add other possible actions here
                    default:
                       print("unexpeted choice")
               }
               currentPlayer = 1
           }
    }
    
    //***************************Init***************************
    override init() {
        super.init()
        hands = buildCardPiles(numberOfPiles: numPlayers, cardInEachPile: 5)
        discardPiles = buildCardPiles(numberOfPiles: 5, cardInEachPile: 10)
        stacks = buildCardPiles(numberOfPiles: 5, cardInEachPile: 5)

        for hand in 0...1{
            for card in 0...4{
                hands[hand][card] = deck.drawCard()!
                computerPlayer.computerMemory.cardDrawn(player: hand, cardLocation: card, cardToRemove: hands[hand][card])
            }
        }
    }
    
    private func buildCardPiles(numberOfPiles:Int, cardInEachPile:Int)->[[Card]]{
        let newArray = Array(repeating: Array(repeating: Card(), count: cardInEachPile), count: numberOfPiles)
        return newArray
    }

    func isOutOfCards() -> Bool {
        return false
    }
    
    //**************************Check if moves are valid**********
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
    //Helper Function
    func  getNextCardNumber(column: Int)->Int{
        return getNextEmptyStackPosition(column: column) + 1
    }
    
    //**************Get info about where next card will be played
    func getNextEmptyStackPosition(column: Int)->Int{
        for row in 0...4{
            if stacks[column][row].num.rawValue == 0{
                return row
            }
        }
        return 4
    }
    
    func playCard(hand:Int, card:Int){
        let stack = hands[hand][card].col.rawValue - 1
    stacks[stack][getNextEmptyStackPosition(column: stack)] = hands[hand][card]
        hands[hand][card] = deck.drawCard()!
        computerPlayer.computerMemory.cardPlayedOrDiscarded(player: hand, cardLocation: card, cardPlayed: hands[hand][card])
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
        computerPlayer.computerMemory.cardPlayedOrDiscarded(player: hand, cardLocation: card, cardPlayed: hands[hand][card])
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


//MARK: DECK
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

