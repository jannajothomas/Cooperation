//
//  game.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/7/20.
//  Copyright © 2020 Personal. All rights reserved.
//

//Computer is player 0
//Human is player 1

import Foundation

protocol delegateUpdateView {
    func updateHints(hints:Int)
    func moveCard(card:Card, stack:String, location:Int)
    func drawCard(hand:Int, card:Int)
}

class Game{
    
    var delegate: delegateUpdateView?
    
//----------Game settings--------------
    var handSize = 5
    var computerTurn = Bool()       
    
//----------Player Settings
    var numPlayers = Int()
    var players = [Player]()
    
//----------Card Arrays--------------
    var deck = Deck()
    var stack = [[Card](),[Card](),[Card](),[Card](),[Card]()]
    var discard = [[Card](),[Card](),[Card](),[Card](),[Card]()]
    
//----------Initialization-------------
    init(playerNames: [String]){
        numPlayers = playerNames.count
            for count in 0...numPlayers-1{
                players.append(Player(name: playerNames[count], handSize: handSize,  playerId: count))
        }
    }
    
    func chooseFirstPlayer(){
        //Determine first player
        if(Int.random(in: 0...1) == 1){
            computerTurn = false
        }else{
            computerTurn = true
        }
    }
    
    func startGame(){
        dealCards()
        if(computerTurn == true){
            //Get computer move
        }
    }
    
    func discardCard(card: Card){
        let index = card.col.rawValue
        //let index = card.Col
        //let index = card
        //let index = card.Card.col
        //let index = card.col
        //let index = card.col.rawValue
        discard[index].append(card)
    }
    
    func addCardToStack(card: Card){
        let index = card.col.rawValue
        stack[index].append(card)
    }
    
    func playCard(player: Int, card: Card, index: Int){
        let nextNum = (stack[index].last?.num.rawValue ?? 0)  + 1
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


