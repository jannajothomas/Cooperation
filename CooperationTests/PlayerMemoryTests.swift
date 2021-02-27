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
        expectedArray = getDeckWithoutAColor(colorToRemove:Card.Col)
        computerMemory.removeFromColumn(color: color, column: column)
        XCTAssertEqual(expectedArray,computerMemory.cardPossibilities[column],"Array does not contain the correct values")
    }

}

//TODO: redo this by filter and remove
func getDeckWithoutANumber(number: Int)->[Card]{
    var numbers = [Card.Num]()
    let colors = Card.Col.all
   
    for count in 1...5{
        if count != number{
            switch count {
            case 1:
                numbers.append(Card.Num.one)
            case 2:
                numbers.append(Card.Num.two)
            case 3:
                numbers.append(Card.Num.three)
            case 4:
                numbers.append(Card.Num.four)
            default:
                numbers.append(Card.Num.five)
            }
        }
    }
    return createDeckWithModifiedParameters(numbers: numbers, colors: colors)
}

//TODO:  Redo this by filter and remove
func getDeckWithoutAColor(colorToRemove: Card.Col)->[Card]{
    let numbers = Card.Num.all
    var colors = [Card.Col]()
   
    for color in colors{
        if color != colorToRemove{
            switch color {
            case Card.Col.red:
                colors.append(Card.Col.red)
            case Card.Col.blue:
                colors.append(Card.Col.blue)
            case Card.Col.magenta:
                colors.append(Card.Col.magenta)
            case Card.Col.orange:
                colors.append(Card.Col.orange)
            default:
                colors.append(Card.Col.purple)
            }
        }
    }
    return createDeckWithModifiedParameters(numbers: numbers, colors: colors)
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


