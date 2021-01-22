//
//  ComputerPlayer.swift
//  Cooperation
//
//  Created by Janna Thomas on 1/15/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import Foundation

struct ComputerPlayer{
   
    var otherPlayersHand = Array(repeating: Card(), count: 5)
    var stacks = Array(repeating: Array(repeating: Card(), count: 5), count: 5)
    var discards = Array(repeating:  Array(repeating: Card(), count: 10), count: 5)

    
    func updateAI(){
        
    }
    
    func playBestMove(){
    
    }
}
