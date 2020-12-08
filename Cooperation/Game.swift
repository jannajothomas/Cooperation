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
}



class Game{
    var delegate: delegateUpdateView?
    
    func setupGame(){
        delegate?.addCard(name: "deck")
    }
    
    
}
