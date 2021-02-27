//
//  ComputerPlayer.swift
//  Cooperation
//
//  Created by Janna Thomas on 1/15/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import Foundation

struct ComputerMemory{
    var cardPossibilities = Array(repeating: Array(repeating: Card(), count: 50), count: 5)
    var newCardPossibilities = [Card]()
    var deck: Deck!
    
    /* When initialized, comp knowledge consists of a two dimensional array where each element contains and entire deck of cards. */
    init(){
        deck = Deck()
        newCardPossibilities = deck.getFullDeck()
        for count in  0...4{
            cardPossibilities[count] = newCardPossibilities
        }
    }
    
    func printCardPossibilities(){
        for column in 0...cardPossibilities.count - 1{
            for row in 0...cardPossibilities[column].count - 1{
                print(cardPossibilities[column][row], terminator: "")
            
            }
        }
    }
    
    func getCardPossibilities(column:Int)->[Card]{
        return cardPossibilities[column]
    }
    
    mutating func addInfoFromHint(hintColor: Card.Col, values: [Bool]){
        for count in 0...4{
            if values[count] {      //card is this number
                onlyValueInColumn(color: hintColor, column: count)
            }else{                  //card is not this number
                removeFromColumn(color: hintColor, column: count)
            }
        }
    }
    
    mutating func addInfoFromHint(hintNumber: Int, values: [Bool]){
        for count in 0...4{
            if values[count] {      //card is this number
                onlyValueInColumn(number: hintNumber, column: count)
            }else{                  //card is not this number
               // removeValueFromColumn(color: Card.Col(rawValue: hintNumber), column: count)
            }
        }
    }
    
    mutating func removeFromColumn(number:Int, column: Int){
        cardPossibilities[column] = cardPossibilities[column].filter{
            (card) -> Bool in card.num.rawValue != number}
    }
    
    mutating func removeFromColumn(color:Card.Col, column: Int){
        cardPossibilities[column] = cardPossibilities[column].filter{
        (card) -> Bool in card.col != color}
    }
    
    mutating func removeFromColumn(card:Card, column: Int){
        let indexToRemove = cardPossibilities[column].firstIndex(of: card)!
        cardPossibilities[column].remove(at: indexToRemove)
    }
    
    mutating func onlyValueInColumn(number:Int, column: Int){
        cardPossibilities[column] = cardPossibilities[column].filter{
        (card) -> Bool in card.num.rawValue == number}
    }
    
    mutating func onlyValueInColumn(color:Card.Col, column: Int){
          cardPossibilities[column] = cardPossibilities[column].filter{
          (card) -> Bool in card.col == color}
      }
    
    mutating func onlyValueInColumn(card:Card, column:Int){
        cardPossibilities[column].removeAll()
        cardPossibilities[column].append(card)
    }
}
