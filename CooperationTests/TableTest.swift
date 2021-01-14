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
    }

    override func tearDown() {
           sut = nil
        super.tearDown()
    }
    
    func scenerioOne(){
        //sut.stacks[0][0] = Card(num: Card.Num.one, col: Card.Col.none)
        sut.stacks[0] = Card(num: Card.Num.two, col: Card.Col.none)
        sut.stacks[1] = Card(num: Card.Num.one, col: Card.Col.none)
        //sut.stacks[2][0] = Card(num: Card.Num.one, col: Card.Col.none)
        //sut.stacks[2][1] = Card(num: Card.Num.two, col: Card.Col.none)
        sut.stacks[2] = Card(num: Card.Num.three, col: Card.Col.none)
        //Playable  cards: Red 3, blue 2, magneta 4, orange 1, purple 1
        
    }
    
    func scenerioTwo(){
        sut.stacks[2] = Card(num: Card.Num.one, col: Card.Col.magenta)
    }
    
    func testGetArrayOfPlayableCards(){
        scenerioOne()
        let ints = sut.getArrayOfPlayableCards()
        XCTAssertEqual(ints[0],3,"First element is not correct")
        XCTAssertEqual(ints[1],2,"Second element is not correct")
        XCTAssertEqual(ints[2],4,"Third element is not correct")
        XCTAssertEqual(ints[3],1,"Fourth element is not correct")
        XCTAssertEqual(ints[4],1,"Fifth element is not correct")
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
}
