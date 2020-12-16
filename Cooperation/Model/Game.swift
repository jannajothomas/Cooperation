//
//  game.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/7/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol delegateUpdateView {
    func updateHints(hints:Int)
    func addCard(name: String)
    func draw()
    func discard()
    func play()
    func hint()
}

class Game{
    
    var delegate: delegateUpdateView?
    
//----------Game settings--------------
    var handSize = 5
    
//----------Player Settings
    var numPlayers = Int()
    var players = [Player]()
    
//----------Deck Settings--------------
    var deck = Deck()
    
//----------Initialization-------------
    init(playerNames: [String]){
        numPlayers = playerNames.count
            for count in 0...numPlayers-1{
                players.append(Player(name: playerNames[count], handSize: handSize))
        }
    }
    
    func dealCards(){
        
    }
    
}


