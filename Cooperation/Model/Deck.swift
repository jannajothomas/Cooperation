//
//  Deck.swift
//  Cooperation
//
//  Created by Susan Jensen on 2/23/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import Foundation

struct Deck {
    var cards = [Card]()
    
    init() {
        for col in Card.Col.all{
            for num in Card.Num.all{
                switch num{
                case Card.Num.one:
                    cards.append(Card(num: num, col: col))
                    cards.append(Card(num: num, col: col))
                    cards.append(Card(num: num, col: col))
                case Card.Num.five:
                    cards.append(Card(num: num, col: col))
                default:
                    cards.append(Card(num: num, col: col))
                    cards.append(Card(num: num, col: col))
                }
            }
        }
    }
    
    func getFullDeck()->[Card]{
        return cards
    }
    
    //Function only for generting test decks
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
    
    mutating func drawCard() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
        } else {
            return nil
        }
        //TODO: add other error catching stuff here
    }
}



