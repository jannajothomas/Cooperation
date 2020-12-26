//
//  GameTest.swift
//  CooperationTests
//
//  Created by Susan Jensen on 12/15/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import Cooperation

class GameTest: XCTestCase {

    var sut: Game!

    override func setUp() {
        super.setUp()
        sut = Game(playerNames: ["Janna","Sue"])
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialization(){
        XCTAssertEqual(sut.numPlayers,2, "Wrong number of players")
        XCTAssertEqual(sut.players[0].name,"Janna", "First player name is incorrect")
        XCTAssertEqual(sut.players[1].name,"Sue", "Second player name is incorrect")
    }

    func testDealCards(){
        sut.dealCards()
        var handSize = sut.players[0].getHandSize()
        XCTAssertEqual(handSize,5,"Player one hand size is not correct")
        handSize = sut.players[1].getHandSize()
        XCTAssertEqual(handSize,5,"Player two hand size is not correct")
        XCTAssertEqual(sut.deck.cards.count,40,"Deck size is incorrect after dealing")
    }
    
    func testChooseFirstPlayer(){
        var foundTrue = false
        var foundFalse = false
        for _ in 0...50{
            sut.chooseFirstPlayer()
            if(sut.computerTurn){
                foundTrue = true
            }
            if(sut.computerTurn == false){
                foundFalse = true
            }
            if(foundTrue && foundFalse){
                break
            }
        }
        XCTAssertEqual(foundTrue,true,"True was never found")
        XCTAssertEqual(foundFalse,true,"False was never found")
    }
    
    func testPlayCardsInCorrectLocation(){
        sut.dealCards()
        var newCard = Card(num: Card.Num.one, col: Card.Col.orange)
        sut.playCard(player: 1, card: newCard, index: 3)
        
        newCard = Card(num: Card.Num.two, col: Card.Col.orange)
        sut.playCard(player: 1, card: newCard, index: 3)
        XCTAssertEqual(newCard,sut.stack[3].last, "Card was not played correctly")
    }
    
    func testPlayCardWrongNumber(){
        sut.dealCards()
        let newCard = Card(num: Card.Num.two, col: Card.Col.orange)
        sut.playCard(player: 1, card: newCard, index: 3)
        XCTAssertEqual(newCard, sut.discard[3].last, "Card was not discarded")
    }
    
    func testPlayCardWrongColor(){
        sut.dealCards()
        let newCard = Card(num: Card.Num.two, col: Card.Col.orange)
        sut.playCard(player: 1, card: newCard, index: 2)
        XCTAssertEqual(newCard, sut.discard[3].last, "Card was not discarded")
    }
}
