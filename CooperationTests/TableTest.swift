//
//  TableTest.swift
//  CooperationTests
//
//  Created by Susan Jensen on 1/12/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import XCTest
@testable import Cooperation

class TableTest: XCTestCase {
    
    var sut: Table!
    var compKnow: CompKnowledge!
    var deck: Deck!

    let red3 = Card(num: Card.Num.three, col: Card.Col.red)
    let blue3 = Card(num: Card.Num.three, col: Card.Col.blue)
    let blue2 = Card(num: Card.Num.two, col: Card.Col.blue)
    let magenta2 = Card(num: Card.Num.two, col: Card.Col.magenta)
    let magenta4 = Card(num: Card.Num.four, col: Card.Col.magenta)
    let orange1 = Card(num: Card.Num.one, col: Card.Col.orange)
    let purple1 = Card(num: Card.Num.one, col: Card.Col.purple)
    
    override func setUp() {
        super.setUp()
        sut = Table()
        deck = Deck()
        compKnow = CompKnowledge(deck: deck)
    }

    override func tearDown() {
           sut = nil
        super.tearDown()
    }
    
    func scenerioOne(){
        sut.stacks[0][0] = Card(num: Card.Num.one, col: Card.Col.none)
        sut.stacks[0][1] = Card(num: Card.Num.two, col: Card.Col.none)
        sut.stacks[1][0] = Card(num: Card.Num.one, col: Card.Col.none)
        sut.stacks[2][0] = Card(num: Card.Num.one, col: Card.Col.none)
        sut.stacks[2][1] = Card(num: Card.Num.two, col: Card.Col.none)
        sut.stacks[2][2] = Card(num: Card.Num.three, col: Card.Col.none)
        //Playable  cards: Red 3, blue 2, magneta 4, orange 1, purple 1
        
    }
    
    func scenerioTwo(){
        sut.stacks[2][0] = Card(num: Card.Num.one, col: Card.Col.magenta)
    }
    
    func testIsPlayableCardRecognized(){
        scenerioOne()
        _ = sut.getArrayOfPlayableCards()
        
        //Playing a red 3
        sut.hands[0][1] = red3
        var test = sut.isCardPlayable(hand: 0, card: 1, stack: 0)
        XCTAssertEqual(test,true,"Playable Card Rejected")
        
        //Playing a blue 2
        sut.hands[0][1] = blue2
        test = sut.isCardPlayable(hand: 0, card: 1, stack: 1)
        XCTAssertEqual(test,true,"Playable Card Rejected")
        
        //Playing a magenta 4
        sut.hands[0][1] = magenta4
        test = sut.isCardPlayable(hand: 0, card: 1, stack: 2)
        XCTAssertEqual(test,true,"Playable Card Rejected")
        
        //Playing a orange 1 on a blank spot (not its correct stack)
        sut.hands[0][1] = orange1
        test = sut.isCardPlayable(hand: 0, card: 1, stack: 4)
        XCTAssertEqual(test,true,"Playable Card Rejected")
        
        //Playing a purple 1
        sut.hands[0][1] = purple1
        test = sut.isCardPlayable(hand: 0, card: 1, stack: 4)
        XCTAssertEqual(test,true,"Playable Card Rejected")
        
        scenerioTwo()
        sut.hands[0][1] = magenta2
        test = sut.isCardPlayable(hand: 0, card: 1, stack: 2)
        XCTAssertEqual(test,true,"Playable Card Rejected")
        
    }
    
    func  testIsBadCardRejected(){
        scenerioOne()
        _ = sut.getArrayOfPlayableCards()
        var test = Bool()
        
        //Plaing a purple 1 on a stack with cards already played
        for count in 0...2{
            sut.hands[0][1] = purple1
            test = sut.isCardPlayable(hand: 0, card: 1, stack: count)
            XCTAssertEqual(test,false,"Non-playable card accepted")
        }
        
        //Playing wrong color, right number
        sut.hands[0][1] = blue3
        test = sut.isCardPlayable(hand: 0, card: 1, stack: 1)
        XCTAssertEqual(test,false,"Non-playable card accepted")
        
        //Playing wrong number, right color
        test =  sut.isCardPlayable(hand: 0, card: 1, stack: 0)
        XCTAssertEqual(test,false,"Non-playable card accepted")
    }
    
    func testNextEmptyStackPosition(){
        var nextPlayableCard = sut.getNextEmptyStackPosition(column: 0)
        XCTAssertEqual(nextPlayableCard,0,"Wrong next empty spot")
        scenerioOne()
        let expectedValues = [2,1,3,0,0]
        for count in 0...4{
            nextPlayableCard = sut.getNextEmptyStackPosition(column: count)
            XCTAssertEqual(nextPlayableCard,expectedValues[count],"Wrong next empty spot in column /(count)")
        }
    }
    
    func testGetNextCardNumber(){
        var nextCardNumber = sut.getNextCardNumber(column: 0)
         XCTAssertEqual(nextCardNumber,1,"Wrong next card number")
        scenerioOne()
        let expectedValues = [3,2,4,1,1]
        for count in 0...4{
            nextCardNumber = sut.getNextCardNumber(column: count)
            XCTAssertEqual(nextCardNumber,expectedValues[count],"Wrong next empty spot in column /(count)")
        }
    }
    
    func testGetArrayOfPlayableCards(){
        scenerioOne()
        let expectedValues = [3,2,4,1,1]
        let actualValues = sut.getArrayOfPlayableCards()
        XCTAssertEqual(actualValues,expectedValues,"Array of playable cards")
    }
    
    func testCardShown(){
        compKnow.cardShown(knownCard: Card(num: Card.Num.two, col: Card.Col.blue))
    XCTAssertEqual(compKnow.cardPossibilities[0].count,49,"Array is not the correct size")
        
        
        let localDeck = Deck()
        var expectedArray = localDeck.cards
        expectedArray.remove(at: 14)
        
        let actualArray = compKnow.newCardPossibilities
    XCTAssertEqual(expectedArray,actualArray,"Array does not contain the correct values")
    }
    
}
