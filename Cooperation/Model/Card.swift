//
//  Card.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible,Equatable{
    var description: String {return "\(num)\(col)"}
 
    var num: Num
    var col: Col
    
    enum Num: Int{
        case one = 1
        case two, three, four, five
        case zero = 0
            
        static var all = [Num.one,Num.two,Num.three,Num.four,Num.five]
    }

    enum  Col: Int{
        case red = 0
        case blue = 1
        case magenta = 2
        case orange = 3
        case purple = 4
        case black = 5
    
        static var all: [Col] {
            var allCols = [Col.red]
            allCols.append(Col.blue)
            allCols.append(Col.magenta)
            allCols.append(Col.orange)
            allCols.append(Col.purple)
            return allCols
        }
    }
}
