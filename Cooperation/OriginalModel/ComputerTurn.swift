//
//  ComputerTurn.swift
//  Cooperation
//
//  Created by Janna Thomas on 12/23/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct ComputerTurn{
    init(oponentCards: [Card], stacks: [Card], discardPiles: [[Card]], numHints:[Int], colHints:[Int]){
    }
    static var totalMoves = 0


    
    func  getNextMove()->String{
        //run through possible moves
        ComputerTurn.totalMoves+=1
        if(true){
            return "play"
        }else if(true){
            return "discard"
        }else if(true){
            return "hint"
        }
        
        //discard
        //hint
    }
    
    
    
    var deck = Deck()
    
    func createArrayOfPossibleCards(){
        var possibleCardsRemaining = Array(repeating: deck.getFullDeck(), count: 5)
    }
    
}

/*
var hands = [[Card]]() /* 1 */
var stacks = [Card(), Card(), Card(), Card(), Card()] /* 2 */
var discardPiles = [[Card]]() /* 3 */
var hints
*/
