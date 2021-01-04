//
//  Player.swift
//  Cooperation
//
//  Created by Janna Thomas on 12/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//



import Foundation
import GameplayKit

class Player: NSObject,  GKGameModelPlayer{
    var name: String
    var handSize: Int
    var playerId: Int
    
    static var allPlayers = [Player(name: "Human", handSize: 5, playerId: 0),Player(name: "Computer", handSize: 5, playerId: 1)]
    
    lazy private var hand = Hand(size: handSize)
    
    init(name:String, handSize: Int, playerId:Int){
        self.name = name
        self.handSize = handSize
        self.playerId = playerId
        super.init()
    }
    
    var opponent: Player {
        if playerId == 0 {
            return Player.allPlayers[1]
        } else {
            return Player.allPlayers[0]
        }
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
