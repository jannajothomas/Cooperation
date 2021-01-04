//
//  HandTest.swift
//  CooperationTests
//
//  Created by Janna Thomas on 12/10/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import Cooperation

class HandTest: XCTestCase {
    var sut: Hand!

    override func setUp() {
        super.setUp()
        sut = Hand(size: 5)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInitialCardArraySize() {
        XCTAssertEqual(sut.cards.count, 0, "Card array not empty")
        }

    func testSetHandSize() {
        sut.size = 2
        XCTAssertEqual(sut.size, 2, "Cannot set the hand size")
        }
        
    func testAddCardToHand() {
        let success = sut.addCardToHand(cardToAdd: Card(num: Card.Num.none, col: Card.Col.none))
        XCTAssertEqual(true, success, "Could not add card")
        XCTAssertEqual(sut.cards.count, 1, "Count after card added is incorrect")
        XCTAssertEqual(sut.cards[0].num, Card.Num.none,"Card number is incorrect")
        XCTAssertEqual(sut.cards[0].col, Card.Col.none, "Card color is incorrect")
    }
    
    func testRemoveOnlyCardFromHand(){
        let success = sut.addCardToHand(cardToAdd: Card(num: Card.Num.none, col: Card.Col.none))
        XCTAssertEqual(success, true, "Could not add card to hand")
        XCTAssertEqual(sut.removeCardFromHand(cardToRemove: Card(num: Card.Num.none, col: Card.Col.none)), true, "Could not remove card from array")
    }
    
    func testAddTwoCardsAndRemoveTwo(){
        var success = sut.addCardToHand(cardToAdd: Card(num: Card.Num.one, col: Card.Col.blue))
        XCTAssertEqual(success, true, "Could not add card to hand")
        XCTAssertEqual(sut.cards.count, 1, "Count after card added is incorrect")
        success = sut.addCardToHand(cardToAdd: Card(num: Card.Num.two, col: Card.Col.red))
        XCTAssertEqual(success, true, "Could not  add card to hand")
        XCTAssertEqual(sut.cards.count, 2, "Count after card added is incorrect")
        XCTAssertEqual(sut.removeCardFromHand(cardToRemove: Card(num: Card.Num.two, col: Card.Col.red)), true, "Could not remove card from array")
        XCTAssertEqual(sut.cards.count, 1, "Count after card added is incorrect")
        XCTAssertEqual(sut.removeCardFromHand(cardToRemove: Card(num: Card.Num.one, col: Card.Col.blue)), true, "Could not remove card from array")
        XCTAssertEqual(sut.cards.count, 0, "Count after card added is incorrect")
    }
        
    func testRemoveCardFromHandWhenThereAreNoCardsInHand(){
        print("test")
        XCTAssertEqual(sut.removeCardFromHand(cardToRemove: Card(num: Card.Num.two, col: Card.Col.red)), false, "Function did not return false")
    }
}
