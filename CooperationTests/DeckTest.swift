//
//  DeckTest.swift
//  CooperationTests
//
//  Created by Janna Thomas on 12/15/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import Cooperation

class DeckTest: XCTestCase {
    var sut: Deck!
    
    override func setUp() {
        super.setUp()
        sut = Deck()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDeckSize() {
        XCTAssertEqual(sut.cards.count,50, "Deck size is incorrect")
    }
    
    func testDeckSizeAfterDrawing(){
        _ = sut.drawCard()
        let cardsRemaining = sut.cards.count
        XCTAssertEqual(cardsRemaining,49,"Deck count is wrong after card drawn")
    }

    func testDrawLastCard(){
        for _ in 0...49{
            _ = sut.drawCard()
        }
        XCTAssertEqual(sut.cards.count,0,"There are still cards in the deck")
    }
    
    func testDeckShuffle(){
        var testDeck = [Card]()
        let originalDeck = sut.cards
        for _ in 0...49{
            testDeck.append(sut.drawCard()!)
        }
        XCTAssertNotEqual(testDeck,originalDeck,"Decks are equal")
    }
}

