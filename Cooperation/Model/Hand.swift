//
//  Hand.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct Hand{
    var cards = [Card]()
    var size = Int()
    
    init(size: Int){
        self.size = size
    }
    
    mutating func addCardToHand(cardToAdd: Card)->Bool{
        if cards.count < size{
            cards.append(cardToAdd)
            return true
        }
        return  false
    }
    
    mutating func removeCardFromHand(cardToRemove: Card)->Bool{
        if cards.count > 0{
            for count in 0...cards.count-1{
                if cardToRemove ==  cards[count]{
                    cards.remove(at: count)
                    return true
                }
            }
        }
        return false
    }
}
