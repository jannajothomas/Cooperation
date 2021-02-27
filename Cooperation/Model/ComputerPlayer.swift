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

    var action = ""
    var cardToAct = -1
    var stackToActOn = -1
    
    static var totalTurns = 0
    
    func updateAI(){
        
    }
    
    mutating func playBestMove(){
        //get points for play
        
        //get points for discard
        
        //get points for hint
        
        //TODO: Replace hard wired play action with a informed move
        action = "play"
        cardToAct = 1
        stackToActOn = 1
        
        
        //TODO:  Determine the best move and execute it
       // print("Computer playBestMove")
        ComputerPlayer.totalTurns+=1
    }
    
    //How do i make this meerly a math problem.
        //1. Build piles
                //not throw away cards that are the last ones remaining
                //get cards on stacks asap
    
    
    
    //Best Moves
        //My hand facing
        //Opponent facing
    
    //Conditional Moves
        //My hand facing
        //Opponent facing
    
    //Moves of despiration
        //best probability
    
    
}

