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
    
//----------Card Arrays--------------
    var deck = Deck()
    var stack = [[Card]]()
    var discard = [[Card]]()
    
    
//----------Initialization-------------
    init(playerNames: [String]){
        numPlayers = playerNames.count
            for count in 0...numPlayers-1{
                players.append(Player(name: playerNames[count], handSize: handSize))
        }
    }
    
    func discardCard(card: Card){
        let index = card.col.hashValue
        discard[index].append(card)
    }
    
    func addCardToStack(card: Card){
        let index = card.col.hashValue
        stack[index].append(card)
    }
    
    func playCard(card: Card, index: Int){
        let nextNum = (stack[index].last?.num.hashValue ?? 0) + 1
        let nextCard = Card(num: Card.Num(rawValue: nextNum)!, col: Card.Col(rawValue: index)!)
        
        
        
        
        
        
        
        if(nextCard == card){
            addCardToStack(card: card)
        }else{
            discardCard(card: card)
        }
    }

    func dealCards(){
        for p in players{
            for _ in 0...4{
                _ = p.addCardToHand(card: deck.drawCard()!)
            }
        }
    }
}


