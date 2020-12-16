//
//  PlayerTest.swift
//  CooperationTests
//
//  Created by Susan Jensen on 12/14/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest

@testable import Cooperation

class PlayerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateAPlayer(){
        let player =  Player(name: "TestName", handSize: 5)
        XCTAssertEqual(player.name, "TestName", "Player name is not correct")
        XCTAssertEqual(player.getHandSize(),0,"Player hand size is not correct")
    }
    
    func testAddACardToAPlayersHand(){
        let player = Player(name: "TestName", handSize: 5)
        let success = player.addCardToHand(card: Card(num: Card.Num.four, col: Card.Col.magenta))
        XCTAssertEqual(success,true,"Adding was not successful")
        XCTAssertEqual(player.getHandSize(),1,"Wrong number of cards in hand")
    }

    func testChangePlayersName(){
        let player = Player(name: "TestName", handSize: 3)
        player.name = "NewName"
        XCTAssertEqual(player.name,"NewName", "Players name is not correct")
    }
    
    func testPrintPlayerHand(){
        let player = Player(name: "TestName", handSize: 3)
        let card1 = Card(num: Card.Num.one, col: Card.Col.red)
        let card2 = Card(num: Card.Num.two, col: Card.Col.blue)
        let card3 = Card(num: Card.Num.three, col: Card.Col.magenta)
        var success = player.addCardToHand(card: card1)
        XCTAssertEqual(success,true,"Could not add card to hand")
        success = player.addCardToHand(card: card2)
        XCTAssertEqual(success,true,"Could not add card to hand")
        success = player.addCardToHand(card: card3)
        XCTAssertEqual(success,true,"Could not add card to hand")
        XCTAssertEqual(player.getHand(),[card1,card2,card3])
    }
}
