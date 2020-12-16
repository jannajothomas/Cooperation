//
//  Player.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class Player{
    var name: String
    var size: Int
    lazy private var hand = Hand(size: size)
    
    init(name:String, handSize: Int){
        self.name = name
        self.size = handSize
    }
    
    func getHandSize()->Int{
        return hand.cards.count
    }
    
    func getHand()->[Card]{
        return hand.cards
    }
    
    func addCardToHand(card: Card)->Bool{
        return hand.addCardToHand(cardToAdd: card)
    }
    
}
