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
    
    //TODO: FInish populating this test
    func testRemoveValueFromColumn(){
        //test remove number
        let column = 0
        let number = 1
        var expectedArray = getDeckWithoutANumber(number:number)
        computerMemory.removeFromColumn(number: number, column: column)
    XCTAssertEqual(expectedArray,computerMemory.cardPossibilities[column],"Array does not contain the correct values")
        
        //test remove color
        let color = Card.Col.blue
        expectedArray = getDeckWithoutAColor(colorToRemove:color)
        computerMemory.removeFromColumn(color: color, column: column)
        XCTAssertEqual(expectedArray,computerMemory.cardPossibilities[column],"Array does not contain the correct values")
    }

}

//TODO: redo this by filter and remove
func getDeckWithoutANumber(number: Int)->[Card]{
    let numbers = Card.Num.all.filter{(num) -> Bool in num.rawValue != number}

    print(numbers)
    return createDeckWithModifiedParameters(numbers: numbers, colors: Card.Col.all)
}

//TODO:  Redo this by filter and remove
func getDeckWithoutAColor(colorToRemove: Card.Col)->[Card]{
    let colors = Card.Col.all.filter{(col) -> Bool in col != colorToRemove}
    
    return createDeckWithModifiedParameters(numbers: Card.Num.all, colors: colors)
}

func createDeckWithModifiedParameters(numbers:[Card.Num], colors:[Card.Col])->[Card]{
    
    var modifiedDeck  = [Card]()
    
    for col in colors{
        for num in numbers{
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
    return modifiedDeck
}


