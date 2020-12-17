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
}
