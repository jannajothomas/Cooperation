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
    
    var deck = Deck()
    var player = Player()
    var hints = Hint()
    var playerTurn = true
    public var dealingComplete = false
    
    var delegate: delegateUpdateView?
    
    func setupGame(){
        delegate?.addCard(name: "deck" )
        
    }
    
    
}


