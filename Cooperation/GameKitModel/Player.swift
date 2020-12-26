//
//  Player.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//



import Foundation
import GameplayKit

class Player: NSObject,  GKGameModelPlayer{
    var name: String
    var size: Int
    var playerId: Int
    
    lazy private var hand = Hand(size: size)
    
    init(name:String, handSize: Int, playerId:Int){
        self.name = name
        self.size = handSize
        self.playerId = playerId
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
