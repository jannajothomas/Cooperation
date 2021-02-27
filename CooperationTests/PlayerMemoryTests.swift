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
    
    func testRemoveValueFromColumn(){
        let column = 0
        let number = 1
        let  expectedArray = getDeckWithoutANumber(number:number)
        print("this is ok")
        computerMemory.removeFromColumn(number: number, column: column)
       print("what about this")
        XCTAssertEqual(expectedArray,computerMemory.cardPossibilities[column],"Array does not contain the correct values")
    }

}


func getDeckWithoutANumber(number: Int)->[Card]{
    var modifiedDeck  = [Card]()
    var list = [Card.Num]()
    
    for count in 1...5{
        if count != number{
            switch count {
            case 1:
                list.append(Card.Num.one)
            case 2:
                list.append(Card.Num.two)
            case 3:
                list.append(Card.Num.three)
            case 4:
                list.append(Card.Num.four)
            default:
                list.append(Card.Num.five)
            }
        }
    }
    
    for col in Card.Col.all{
        for num in list{
            switch num{
            case Card.Num.one:
                modifiedDeck.append(Card(num: num, col: col))
                modifiedDeck.append(Card(num: num, col: col))
                modifiedDeck.append(Card(num: num, col: col))
            case Card.Num.five:
                modifiedDeck.append(Card(num: num, col: col))
            default:
                modifiedDeck.append(Card(num: num, col: col))
                modifiedDeck.append(Card(num: num, col: col))
            }
        }
    }

    print(modifiedDeck)
            
    return modifiedDeck
}
