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
    
    func removeCardFromPossibilities(){
        
    }
    
    func getCardPossibilities(column:Int)->[Card]{
        return cardPossibilities[column]
    }
    
    func addInfoFromHint(hintColor: Card.Col, values: [Bool]){
        for count in 0...4{
            if values[count] {      //card is this number
                onlyValueInColumn(color: hintColor, column: count)
            }else{                  //card is not this number
                removeValueFromColumn(color: hintColor, column: count)
            }
        }
    }
    
    func addInfoFromHint(hintNumber: Int, values: [Bool]){
        for count in 0...4{
            if values[count] {      //card is this number
                onlyValueInColumn(number: hintNumber, column: count)
            }else{                  //card is not this number
               // removeValueFromColumn(color: Card.Col(rawValue: hintNumber), column: count)
            }
        }
    }
    
    
    mutating func removeValueFromColumn(number:Int, column: Int){
        for count in 0...cardPossibilities[column].count - 1{
            if cardPossibilities[column][count].num.rawValue == number{
                
                
                let list = cardPossibilities[column].filter{(card) -> Bool in card.num.rawValue != number }
                                   
                print("list without number", list)
                
                

                
                //cardPossibilities.removeAll(where: { $0 == 1 })
               // cardPossibilities.removeAll(where: (Card.num.raw == number))
            }
        }
        
           //TODO: Implement
       }
    
    func removeValueFromColumn(color:Card.Col, column: Int){
        //TODO: Implement
    }
    
    func onlyValueInColumn(number:Int, column: Int){
        //TODO: Implement
    }
    
    func onlyValueInColumn(color:Card.Col, column: Int){
          //TODO: Implement
      }
}
