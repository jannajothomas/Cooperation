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

protocol sendGamePlayActionDelegate{
    func playCard(hand:Int, card:Int, column:Int)
    func discardCard(hand:Int, card:Int, column:Int)
    func giveHint()
}

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
    
    var delegate: sendGamePlayActionDelegate?
    
    //TODO: Make the first value of current player randomly selected
    var currentPlayer = 1{
        didSet{
           //changePlayers()
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
        currentPlayer = 1
    }
    
    func executeComputerTurn(){
        computerPlayer.playBestMove()
        switch computerPlayer.action{
             case"play":
                 //print("Play")
                playCard(hand: 0, card: computerPlayer.cardToAct, stack: computerPlayer.stackToActOn)
                 //TODO:  This si a placeholder
                 
                 //delegate?.playCard(hand:0, card:computerPlayer.cardToAct, column: Int(1))
             
             //TODO: Add other possible actions here
             default:
                print("unexpeted choice")
        }
    }

    
    func changePlayers(){
        print("changing players.  The current player is ", currentPlayer)
           if(currentPlayer == 0){
               currentPlayer = 1
           }else{
            currentPlayer = 0
            executeComputerTurn()
        }
        print("end of changing players function, current player is ", currentPlayer)
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
            //print("card is a one")
            //Card is a one
            if ((cardNum == 1) && (nextCardNum[cardColIndex] == 1)){
                //Card was played on an empty stack and that color hasn't already been played
                return true
            }
        }else{
            //print("card is a ", cardNum)
            //Card is any number other than one

            if((stack == cardColIndex) && (cardNum == nextCardNum[cardColIndex])){
                //print("card was played on the correct color stack and is the correct number")
                //Card was played on the correct color stack and is the correct number
                return true
            }else{
                //print("card is wrong color or wrong number")
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
        //print("next card num", nextCardNum)
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
    
    func isCardPlayableAtThisLocation(hand:Int, card:Int, stack:Int, correctStack:Int)->Bool{
        if hands[hand][card].num.rawValue == 1{
            
            //Special cases is card is a one (doesn't have to be played on the correct spot.
            //It needs to be not  already played
            let nextCardNumberOnCardStack = getNextCardNumber(column: correctStack)
            //It needs to be played on a blank stack
            let nextCardNumOnStackCardWasPlayedOn = getNextCardNumber(column: stack)
            
            if(nextCardNumberOnCardStack == 1 && nextCardNumOnStackCardWasPlayedOn == 1){
                return true

        }else if((stack == correctStack) && (getNextCardNumber(column: stack) == hands[hand][card].num.rawValue)){
                return true
            }
        }
        return false
    }
    
    func playCard(hand:Int, card:Int, stack:Int){
        let correctStack = hands[hand][card].col.rawValue - 1
        let playIsValid = isCardPlayableAtThisLocation(hand:hand, card:card, stack:stack, correctStack: correctStack)
        if(playIsValid){
            //play card
            //put card in next empty stack
            stacks[correctStack][getNextEmptyStackPosition(column: correctStack)] = hands[hand][card]
            //Update view to reflect play
            delegate?.playCard(hand:hand, card:card, column: correctStack)
            
        }else{
            discardCard(hand: hand, card: card)
        }
        
        //Draw new card to replace attempted play
        hands[hand][card] = deck.drawCard()!
        
        //update computer memory as necessary
        computerPlayer.computerMemory.cardPlayedOrDiscarded(player: hand, cardLocation: card, cardPlayed: hands[hand][card])
        
        //printGameBoard()
        changePlayers()
        
        
    }
    
    func discardCard(hand:Int, card:Int)->Int{
        let discardColumn = hands[hand][card].col.rawValue - 1
        let firstEmptySlot = getFirstEmptySlot(column: discardColumn)
        discardPiles[discardColumn][firstEmptySlot] = hands[hand][card]
        hands[hand][card] = deck.drawCard()!
        computerPlayer.computerMemory.cardPlayedOrDiscarded(player: hand, cardLocation: card, cardPlayed: hands[hand][card])
        //printGameBoard()
        changePlayers()
        
        delegate?.discardCard(hand: hand, card: card, column: Int(1))
        return discardColumn
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
    

    
    func getFirstEmptySlot(column: Int)->Int{
        for count in 0...9{
            if (discardPiles[column][count].num.rawValue == 0){
                return count
            }
        }
        return -1
    }
}


