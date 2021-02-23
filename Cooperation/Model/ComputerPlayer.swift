//
//  ComputerPlayer.swift
//  Cooperation
//
//  Created by Janna Thomas on 1/15/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import Foundation

struct ComputerPlayer{
   var computerMemory = ComputerMemory()
   var computerHand = 0
    var otherPlayersHand = Array(repeating: Card(), count: 5)
    var stacks = Array(repeating: Array(repeating: Card(), count: 5), count: 5)
    var discards = Array(repeating:  Array(repeating: Card(), count: 10), count: 5)


    //TODO: Make this an enum?
    var action = ""
    var cardToAct = -1
    
    static var totalTurns = 0
    
    func updateAI(){
        
        
        
    }
    
    mutating func playBestMove(){
        //TODO: Replace hard wired play action with a informed move
        action = "play"
        cardToAct = 1
        
        
        //TODO:  Determine the best move and execute it
        print("Computer playBestMove")
        ComputerPlayer.totalTurns+=1
        
        
    }
}

