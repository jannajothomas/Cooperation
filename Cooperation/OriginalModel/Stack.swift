//
//  Stack.swift
//  Cooperation
//
//  Created by Janna Thomas on 12/16/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class Stack{
    var cards = [Card]()
    
    func addCardToStack(newCard: Card){
        cards.append(newCard)
    }
}
