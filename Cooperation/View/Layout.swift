//
//  Layout.swift
//  Cooperation
//
//  Created by Janna Thomas on 4/16/20.
//  Copyright © 2020 Susan Jensen. All rights reserved.
//
//OLD
//  Hand -2: Stacks
//  Hand -1: Deck, Discard, Hints

//CURRENT
//  Hand -1: Center of Screen
//  Hand 0: Computer
//  Hand 1: Player
//  Hand 2: Place holder
//  Hand 3: Place holder
//  Hand 4: (0)Color Hint (1)Deck, (2)Discard, (3)Number Hint
//  Hand 5: Stacks
//  Hand 6: Start of discard piles
//  Hand 7
//  Hand 8
//  Hand 9
//  Hand 10

//The difference betweeen yCardLocation and yCardLocations should be sorted out

// cards go off the left and right side of the screen
// cards go off the bottom of the screen

import Foundation
import UIKit

//This is actually its frame and should probably be deleted
struct CardLocation: CustomStringConvertible{
    var description: String {return "size \(size) center \(center)"}
    let size: CGSize
    let center: CGPoint
}


struct CardIdentity:  CustomStringConvertible{
    var description: String{return "hand \(hand) card \(card) "}
    let hand: Int
    let card: Int
    //let cardIndex: Int
}

//TODO: Add more rows for discard....row ten is not enough
let  viewLocationIndex =  ["colorHint" : CardIdentity(hand: 4, card: 0/*, cardIndex: 0*/),
                           "numberHint"  : CardIdentity(hand: 4, card: 3/*, cardIndex: 3*/),
                           "deck" : CardIdentity(hand: 4, card: 1/*, cardIndex: 1*/),
                           "discard" : CardIdentity(hand: 4, card: 2/*, cardIndex: 2*/),
                           "center" : CardIdentity(hand: -1, card: 1/*, cardIndex: 1*/)
]

struct  ScreenDetails{
    var windowWidth: CGFloat
    var windowHeight: CGFloat
    var topPadding: CGFloat
    var rightPadding: CGFloat
    var leftPadding:  CGFloat
    var bottomPadding: CGFloat
}

class Layout{
    var cardCenters = Array(repeating: Array(repeating: CGPoint(),count: 5), count: 11)
    var cardHeight = CGFloat()
    var cardWidth = CGFloat()
    var orientation = String()
    var centerOfScreen = CGPoint()
    
    var spacingX = CGFloat()
    var starWidth = CGFloat()
    var starBuffer = CGFloat()
    var starXLocations = [CGFloat(),CGFloat(),CGFloat(),CGFloat(),CGFloat(),CGFloat(),CGFloat()]
    var starYLocation = CGFloat()
    
    func Location(Details: ScreenDetails, item: CardIdentity)->CGPoint{
        setupLocations(screenDetails: Details)
        if item.hand == -1{
            return centerOfScreen
        }else{
           return cardCenters[item.hand][item.card]
        }
    }
    
    func Frame(Details: ScreenDetails, item: CardIdentity)->CGRect{
        let loc = Location(Details: Details, item: item)
        let size = Size(Details: Details)
        
        let rect = CGRect(x:loc.x,  y: loc.y, width:size.width, height: size.height)
        return  rect
    }
    
    func Frame(Details: ScreenDetails, name: String)->CGRect{
        return Frame(Details: Details, item: viewLocationIndex[name]!)
    }
    
    
    func Size(Details: ScreenDetails)->CGSize{
        setupLocations(screenDetails: Details)
        return CGSize(width: cardWidth, height: cardHeight)
    }

    func starSize(Details: ScreenDetails)->CGSize{
        setupLocations(screenDetails: Details)
        return CGSize(width: starWidth, height: starWidth)
    }
    
    func StarLocation(Details: ScreenDetails, Index: Int)->CGPoint{
        setupLocations(screenDetails: Details)
        return CGPoint(x: starXLocations[Index], y: starYLocation)
    }

    func setupLocations(screenDetails: ScreenDetails){
        
        if screenDetails.windowHeight > screenDetails.windowWidth{  //portrait
                    cardWidth = screenDetails.windowWidth / 8
                    cardHeight = cardWidth * 1.6
                    starWidth = screenDetails.windowWidth / 10
                    starBuffer = screenDetails.windowHeight / 80
                    orientation = "P"
               }else{ //landscape
                    cardHeight = screenDetails.windowHeight / 5
                    cardWidth = cardHeight * 0.625
                    starWidth = screenDetails.windowHeight /  4
                    starBuffer = screenDetails.windowHeight / 20
                    orientation = "L"
               }
        var xCardLocations = CGFloat()
        var yCardLocations = CGFloat()
        if orientation == "L"{
            spacingX = CGFloat(20)
        }else{
            spacingX = (screenDetails.windowWidth - (5 * cardWidth)) / 6
        }
        
        for card in 0...4{
            if orientation == "L"{
                xCardLocations = screenDetails.windowWidth - ((cardWidth  / 2) + (cardWidth * CGFloat(card)) + (spacingX * CGFloat(card)) + screenDetails.leftPadding)
                yCardLocations = screenDetails.topPadding + (cardHeight / 2) + screenDetails.topPadding
            }else{  //"P"
                xCardLocations  = (cardWidth  / 2) + (cardWidth * CGFloat(card)) + spacingX + (spacingX * CGFloat(card)) + screenDetails.leftPadding
                yCardLocations = screenDetails.topPadding + (cardHeight / 2) + spacingX
            }
        //HAND 0
            cardCenters[0][card] = CGPoint(x: xCardLocations, y: yCardLocations)
            
        //Hand 1: Player Card Locations
            cardCenters[1][card] = CGPoint(x: xCardLocations, y: screenDetails.windowHeight + screenDetails.topPadding - (cardHeight / 2))

        //Hand 4: (0)Color Hint (1)Deck, (2)Discard, (3)Number Hint
            let leftPadding = (screenDetails.windowWidth - cardWidth * 4 - spacingX * 3) / 2
            for location in 0...3{
                cardCenters[4][location] = CGPoint(
                    x: leftPadding +  screenDetails.leftPadding + cardWidth * CGFloat(location) + cardWidth / 2 + spacingX * CGFloat(location) + spacingX /  2,
                    y: yCardLocations + cardHeight + spacingX) //+ spacingX)
               }
            
        //Hint Stars
            let starSpacing = screenDetails.windowWidth / 8
            for count in 0...6{
                starXLocations[count] = starSpacing + starSpacing * CGFloat(count)}
            starYLocation = yCardLocations + cardHeight * CGFloat(1.5) + spacingX * CGFloat(1) + starWidth * (0.5)  + starBuffer
            
        //Hand5: Stack Card Locations
            cardCenters[5][card] = CGPoint(
                x: xCardLocations,
                y: yCardLocations + cardHeight * CGFloat(2) + spacingX + starWidth + starBuffer * 2)
            
        //Hand6: Discard stacks
            for count in 6...10{
                let localOffset = CGFloat(count - 6)
                let localSpacing = CGFloat(0.21 * cardHeight) * localOffset
                cardCenters[count][card] = CGPoint(
                    x: xCardLocations,
                    y: yCardLocations + cardHeight * CGFloat(3) + spacingX * CGFloat(2)  + localSpacing + starWidth + starBuffer * 2) //+ CGFloat(50))
            }
            //Center of screen
            centerOfScreen = CGPoint(x: (screenDetails.windowWidth / 2) - (cardWidth / 2), y: (screenDetails.windowHeight / 2) - (cardHeight / 2))
        }
    }
}
