//
//  CardViewTest.swift
//  CooperationTests
//
//  Created by Janna Thomas on 12/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import Cooperation

class CardViewTest: XCTestCase {
     var sut: CardView!
    
    override func setUp() {
        super.setUp()
        sut = CardView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetCardLocation() {
        print("Sut.location",sut.location)
        //XCTAssertEqual(sut.cards.count,50, "Deck size is incorrect")
    }

}
