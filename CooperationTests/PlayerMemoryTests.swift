//
//  PlayerMemoryTests.swift
//  CooperationTests
//
//  Created by Susan Jensen on 2/26/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import XCTest
@testable import Cooperation

class PlayerMemoryTests: XCTestCase {
    var computerMemory: ComputerMemory!
    var deck: Deck!
    
    override func setUp() {
        super.setUp()
        computerMemory = ComputerMemory()
        deck = Deck()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialValueOfArrays(){
        for count in 0...4{
            let cardPossibilities  = computerMemory.getCardPossibilities(column: count)
            XCTAssertEqual(deck.getFullDeck(),cardPossibilities,"Array does not contain the correct values")
        }
        let cardPossibilities = computerMemory.newCardPossibilities
         XCTAssertEqual(deck.getFullDeck(),cardPossibilities,"Array does not contain the correct values")
    }
    
    func testPrintCardPossibilites() {
        computerMemory.printCardPossibilities()
        computerMemory.removeValueFromColumn(number: 1, column: 1)
    }

}
