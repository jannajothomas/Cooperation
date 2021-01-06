//
//  ViewController.swift
//  Cooperation
//
//  Created by Janna Thomas on 12/7/20.
//  Copyright © 2020 Personal. All rights reserved.
//


//TODO: Card doesn't start at the center of the screen
//TODO:

import UIKit
import GameplayKit
import Foundation

class GameViewController: UIViewController {
    var dealingComplete: Bool = false{
        didSet{
            turnOverCards()
            layoutTable()
        }
    }
 
    var table: Table!
    var layout = Layout()   //this should be a struct not a class
    
    var playerHands = Array(repeating: Array(repeating: CardView(), count: 5),count: 2)
    
    var ColorHintView = LabeledCardArea()   // Hand 4 Card 0
    var deck = CardView()
    var DiscardLocation = LabeledCardArea()     //Hand 4 Card 2
    var NumberHintView = LabeledCardArea()  //Hand 4 Card 3
    
    lazy var stackPiles = Array(repeating: CardView(), count: 5)      //Hand 5
    var discardPiles = Array(repeating: Array(repeating: CardView(), count: 10), count: 5)
    
    var strategist: GKMinmaxStrategist!
    var numPlayers = 2    //Dont know what this is
    var screenDetails = ScreenDetails(windowWidth: 0, windowHeight: 0, topPadding: 0, rightPadding: 0, leftPadding: 0, bottomPadding: 0)

    let  color =  [1 : UIColor.red,
                   2: UIColor.blue,
                   3: UIColor.magenta,
                   4: UIColor.orange,
                   5: UIColor.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenDetails.windowWidth = self.view.frame.size.width
        screenDetails.windowHeight =  self.view.frame.size.height
    
        strategist = GKMinmaxStrategist()
        strategist.maxLookAheadDepth = 4
        strategist.randomSource = GKARC4RandomSource()
        resetTable()
        //game.delegate = self
        
        for hand in 0...1{
            for card in 0...4{
                playerHands[hand][card] = addCard(hand: hand, card: card)
                view.addSubview(playerHands[hand][card])
            }
        }
        deck = addCard(name: "deck")
    }

    func resetTable(){
        table = Table()
        strategist.gameModel = table
        updateUI()
    }
    
    func updateUI(){
        title = "/(board.currentPlayer.name)'s Turn"
    }

    @objc func deckTappedAction(){
        dealCards(hand: 0, card: 0)
        for gesture in deck.gestureRecognizers! {
            gesture.isEnabled = false
        }
    }
    
    @objc func selectCardAction(_ recognizer: UITapGestureRecognizer){
        switch recognizer.state{
            case .ended:
            if let chosenCardView = recognizer.view as? CardView{
                chosenCardView.isSelected = !chosenCardView.isSelected
                
            }
            default:
            print("reached default condition in selectCardAction")
            }
        }
      /*var hideColorHints = false
      var hideNumberHints = false
      switch recognizer.state{
      case .ended:
          if let chosenCardView = recognizer.view as?  CardView{
              chosenCardView.cardSelected = !chosenCardView.cardSelected
              if chosenCardView.cardSelected{
                  cardSelected[chosenCardView.tag] = true
                  chosenCardView.layer.shadowColor = UIColor.black.cgColor
                  chosenCardView.layer.shadowOpacity = 1
                  chosenCardView.layer.shadowOffset = .zero
                  chosenCardView.layer.shadowRadius = 10
                  selectedNumber[chosenCardView.tag] = chosenCardView.num
                  selectedColor[chosenCardView.tag] = chosenCardView.cardBackgroundColor
                  
                  //TEMPORARY FOR TROUBLESHOOTING
                  gamePlay.computerPlayer.printComputerHandPossibilities(card: chosenCardView.tag)
                 
              }else{
                  chosenCardView.layer.shadowRadius = 0
                  cardSelected[chosenCardView.tag] = false
                  selectedNumber[chosenCardView.tag] = 0
                  selectedColor[chosenCardView.tag] = UIColor.black
              }
              numberHint = 0
              colorHint = UIColor.black
              
              for card in 0...4{
                  if selectedNumber[card] != 0{       //Only looks at cards that have been selected
                      if numberHint == 0{
                          //This checks to see if a number has been stored
                          numberHint = selectedNumber[card]  //If there isn't a number, this is the first number
                      }
                      if(selectedNumber[card] != numberHint){    //If this card number is the stored value
                          hideNumberHints = true         //make the numbers show
                      }
                  }
                  if selectedColor[card] !=  UIColor.black{
                      if colorHint == UIColor.black{
                          colorHint = selectedColor[card]
                      }
                      if(selectedColor[card] != colorHint){
                          hideColorHints = true
                      }
                  }
              }
              if numberHint == 0{
                  hideNumberHints = true
              }
              if colorHint == UIColor.black{
                  hideColorHints = true
              }
              NumberHintView.isHidden = hideNumberHints
              ColorHintView.isHidden = hideColorHints
          }
      default: break
      }*/
      
      
      @objc func flipCardAction(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
          case .ended:
              if let chosenCardView = recognizer.view as? CardView{
                  UIView.transition(with: chosenCardView, duration: 0.5, options: .transitionFlipFromLeft, animations:{
                      chosenCardView.isFaceUp = !chosenCardView.isFaceUp}
                     )
              }
          default:
              break
          }
       }
    
    @objc func cardTappedAction(){
        print("Card tapped Action")
    }
    
    @objc func colorHint(_ recognizer:UITapGestureRecognizer){
        print("colorHint")
    }
    
    @objc func numberHint(_ recognizer: UITapGestureRecognizer){
        print("numberHint")
    }
    
    @objc func hintCardAction(_ recognizer:UITapGestureRecognizer){
        print("hintCard Action")
         if let chosenCardView = recognizer.view as? LabeledCardArea{
             if(chosenCardView.cardText == "Number Hint"){
                 //gamePlay.getHint(number: numberHint)
             }
             if(chosenCardView.cardText == "Color Hint"){
                 //gamePlay.getHint(color: colorHint)
             }
         }
     }
    
    func layoutTable(){
        DiscardLocation = configureSpecialCards(name: "discard",card: 2)
        DiscardLocation.isHidden = false
        view.addSubview(DiscardLocation)
        //print(view)
        
        ColorHintView = configureSpecialCards(name: "colorHint", card: 1)
        ColorHintView.isHidden = false
        ColorHintView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorHint(_:))))
        view.addSubview(ColorHintView)
        
        NumberHintView = configureSpecialCards(name: "numberHint", card: 3)
        view.addSubview(NumberHintView)
        NumberHintView.isHidden = false
        NumberHintView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(numberHint(_:))))
        
        //setup Hints
            //for count in 0...6{
           //     let newImage = HintSymbol()
           //     newImage.center = layout.StarLocation(Details: screenDetails, Index: count)
          //      newImage.frame.size = layout.starSize(Details: screenDetails)
          //      newImage.fontSize = (layout.starSize(Details: screenDetails)).height
                //newImage.fontSize = 80
               //  if gamePlay.hintsLeft >= count{
               //     newImage.isFaceUp = true
               // }else{
               //     newImage.isFaceUp = false
               // }
           //     hintImages[count] = newImage
           //     view.addSubview(hintImages[count])
          //  }
        
        //setup Turn image
           // let newHintImage = TurnIndicator()
        //newHintImage.frame.size = layout.starSize(Details: screenDetails)
        //newHintImage.fontSize = (layout.starSize(Details: screenDetails)).height
        //turnImage = newHintImage
        //print(view)
        //view.addSubview(turnImage)
            
        //setup Stacks
           let stackColor = [UIColor.red, UIColor.blue, UIColor.magenta, UIColor.orange,UIColor.purple]
                for card in 0...4{
                    let newStack = CardView()
                   newStack.frame.size = layout.Size(Details: screenDetails)
                    newStack.center = layout.Location(Details: screenDetails, item: CardIdentity(hand: 5, card: card))
                    newStack.backgroundColor = UIColor.clear
                    newStack.num = 0
                    newStack.cardBackgroundColor = stackColor[card]
                    stackPiles[card] = newStack
                    stackPiles[card].isHidden = false
                    view.addSubview(stackPiles[card])
                }
    }
    
    
    func layoutCardCentersAndSize(){
        
       deck.center = layout.Location(Details: screenDetails, item: viewLocationIndex["Deck"]!)
       deck.frame.size = layout.Size(Details: screenDetails)
       
       DiscardLocation.center = layout.Location(Details: screenDetails, item: viewLocationIndex["Discard"]!)
       DiscardLocation.frame.size = layout.Size(Details: screenDetails)
       
       ColorHintView.center = layout.Location(Details: screenDetails, item: viewLocationIndex["ColorHint"]!)
       ColorHintView.frame.size = layout.Size(Details: screenDetails)
       
       NumberHintView.center = layout.Location(Details: screenDetails, item: viewLocationIndex["NumberHint"]!)
       NumberHintView.frame.size = layout.Size(Details: screenDetails)
       

       /* if dealingComplete{
           for hand in 0...1{
               for card in 0...4{
                
                   PlayerCardView[hand][card].frame.size = layout.Size(Details: screenDetails)
                   PlayerCardView[hand][card].center = layout.Location(Details: screenDetails, item: CardIdentity(hand: hand, card: card))
                   }
               }
        for stack in 0...4{
            StackCardsView[stack].frame.size = layout.Size(Details: screenDetails)
            StackCardsView[stack].center = layout.Location(Details: screenDetails, item: CardIdentity(hand: 5, card: stack))
           }
        for discards in 0...4{
            for rows in 0...DiscardedCardsView[discards].count - 1{
                DiscardedCardsView[discards][rows].frame.size = layout.Size(Details: screenDetails)
                DiscardedCardsView[discards][rows].center = layout.Location(Details: screenDetails, item: CardIdentity(hand: rows + 5, card: discards))
            }
        }
        //for count in 0...6{
        //    hintImages[count].center = layout.StarLocation(Details: screenDetails, Index: count)
        //       }
        //   turnImage.center = layout.centerOfScreen
        }else{deck.center = layout.centerOfScreen}*/
    }

    
    
    func configureSpecialCards(name: String, card: Int)->LabeledCardArea{
        let specialCard = LabeledCardArea()
        specialCard.frame = layout.Frame(Details: screenDetails, name: name)
        specialCard.backgroundColor = UIColor.clear
        if name == "Discard"{
            specialCard.numberOfLines = 1
        }else{
            specialCard.numberOfLines = 2
            specialCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hintCardAction(_:))))
        }
        specialCard.cardText = name
        return specialCard
    }
    
    
  
/*

     var cardSelected = [false,false,false,false,false]
     
     var hintImages = [HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol()]
     var turnImage = TurnIndicator()
     var timeInterval = TimeInterval(6)

     //MARK: Animation flags
     var discardCard = Bool()


     */

     //Recursive function that animates the dealing of the cards
     private func dealCards(hand: Int, card: Int){
         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations:{
            self.playerHands[hand][card].center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: hand, card: card))}  , completion: { _ in
                    //see if is the last card in the hand
                    if(card == 4){
                        if hand == self.numPlayers  - 1{
                            //Dealing is done.  Move deck its perm location
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                                self.deck.frame = self.layout.Frame(Details: self.screenDetails, name: "deck")
                            },
                            completion: { _ in self.dealingComplete  = true})
                            return;
                        }else{
                             self.dealCards(hand: hand + 1, card: 0)
                        }
                    }else{
                        self.dealCards(hand: hand, card: card + 1)
                    }
            }
        )
     }

     private func turnOverCards(){
         for card in 0...4{
             UIView.transition(
                with: playerHands[0][card],
                 duration: 1.5,
                 options: .transitionFlipFromLeft,
                 animations: {self.playerHands[0][card].isFaceUp = true},
                 completion: {_ in
                     if(card == 4){
                         //self.gamePlay.selectFirstPlayer()
                     }
             })
         }
     }

    var lastLocation = CGPoint()
    
    @objc func detectPanAction(_ recognizer:UIPanGestureRecognizer) {
        if let chosenCardView = recognizer.view as? CardView{
            //print(chosenCardView.center)
            //var lastLocation = chosenCardView.center
            chosenCardView.superview?.bringSubviewToFront(chosenCardView)
            switch  recognizer.state{
            case .began:
                lastLocation = chosenCardView.center
            case .ended:
                print("in pan gesture recognizer Card",chosenCardView.card, "hand", chosenCardView.hand, " is ",table.hands[chosenCardView.hand][chosenCardView.card])
                print(" pile Num", table.discardCard(hand:chosenCardView.hand, card: chosenCardView.card))
                lastLocation = chosenCardView.center
                if chosenCardView.frame.intersects(DiscardLocation.frame){
                    let pileNum = table.discardCard(hand:chosenCardView.hand, card: chosenCardView.card)
                    discardCardAnimation(hand: chosenCardView.hand, card: chosenCardView.card, column: pileNum)
                    
                   
                    //TODO: activate animation to appropriate location.
                    //print("intersecet A")
                    //gamePlay.discardCard(sourceHand: chosenCardView.handTag, sourceCard: chosenCardView.cardTag, playedToHand: 4, playedToCard: 2)
                }
                for card in 0...4{
                    if chosenCardView.frame.intersects(stackPiles[card].frame){
                        //print("intersect B")
                        //gamePlay.playCard(hand: chosenCardView.handTag, card: chosenCardView.cardTag, playedToHand: 5, playedToCard: card)
                    }
                }
            case .changed:
                let translation = recognizer.translation(in: self.view)
                chosenCardView.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
                //print("Chosen card view center after changed", chosenCardView.center)
                if (chosenCardView.frame.intersects(DiscardLocation.frame)){
                    DiscardLocation.backgroundColor = UIColor.gray
                }else{
                    DiscardLocation.backgroundColor = UIColor.clear
                }
                for card in 0...4{
                    if (chosenCardView.frame.intersects(stackPiles[card].frame)){
                        stackPiles[card].backgroundColor = UIColor.gray
                    }else{
                        stackPiles[card].backgroundColor = UIColor.clear
                    }
                }
            default: break
            }
        }
    }

 //MARK: ScreenLayout
     /*
     
     func createStackCard(card: Int, color: UIColor)->HanabiCards{
         let newStack = HanabiCards()
         newStack.frame.size = layout.Size(Details: screenDetails)
         newStack.center = layout.Location(Details: screenDetails, item: CardIdentity(hand: 5, card: card, cardIndex: card))
         //newStack.backgroundColor = UIColor.clear
         newStack.num = 0
         newStack.cardBackgroundColor = color
         return newStack
     }

 }
 //MARK: DelegateUpdateCards
 extension GameBoardViewController: delegateUpdateCards{
     func updateTurn(turn: Bool) {
         if turn{
             turnImage.isPointingUp = true
         }else{
             turnImage.isPointingUp = false
         }
         
     }
     
     func updateHints(hints: Int) {
                for count in 0...6{
                  //let newImage = HintSymbol()
                 if count <= hints{
                     hintImages[count].isFaceUp  = true

                  }else{
                     hintImages[count].isFaceUp = false
                  }
              }
     }
     */
     func drawCardAnimation(hand: Int, card: Int) {
             let delay = GameViewController.cardMoveTime * 2 + GameViewController.cardFlipTime
            playerHands[hand][card] = addCard(hand: hand, card: card)
            //playerHands[hand][card] = createHanabiCardAtLocation(hand: hand, card: card, location: layout.Location(Details: screenDetails, item: CardIdentity(hand: 4, card: 1)))
             UIView.animate(withDuration: GameViewController.cardMoveTime, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {

                 self.playerHands[hand][card].center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: hand, card: card))
                    })
         }
     
     func moveCardAnimation(sourceHand: Int, sourceCard: Int, destinationCard: Int, destintionHand: Int, playedToCard: Int, playedToHand: Int) {
                let chosenCardView = playerHands[sourceHand][sourceCard]
         view.bringSubviewToFront(chosenCardView)
                 self.view.layoutIfNeeded()
                 UIView.animate(
                  withDuration: GameViewController.cardMoveTime,
                     animations: {
                         chosenCardView.center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: playedToHand, card: playedToCard))},
                     completion: {_ in
                         UIView.transition(
                             with: chosenCardView,
                             duration: GameViewController.cardFlipTime,
                             options: .transitionFlipFromLeft,
                             animations: {
                                 chosenCardView.isFaceUp = true},
                             completion: {_ in
                                     UIView.animate(
                                      withDuration: GameViewController.cardMoveTime,
                                         animations:  {
                                             chosenCardView.center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: destintionHand, card: destinationCard))
                                     },
                                         completion: {_ in
                                          if destintionHand == 5{
                                               self.discardPiles[destinationCard][destintionHand - 5] = chosenCardView
                                          }else{
                                              self.discardPiles[destinationCard].append(chosenCardView)
                                          }
                                     }
                                  )
                             }
                         )
                     }
                 )
     }

    func discardCardAnimation(hand: Int, card: Int, column: Int) {
        let nextEmptyRow = self.findNextCardSlot(column: column)
        print("next  empty row: ",nextEmptyRow)
        let chosenCardView = playerHands[hand][card]
        view.bringSubviewToFront(chosenCardView)
                self.view.layoutIfNeeded()
                UIView.animate(
                 withDuration: GameViewController.cardMoveTime,
                    animations: {
                        chosenCardView.frame = self.layout.Frame(Details: self.screenDetails, item: CardIdentity(hand: 4, card: 2))},
                    completion: {_ in
                        UIView.transition(
                            with: chosenCardView,
                            duration: GameViewController.cardFlipTime,
                            options: .transitionFlipFromLeft,
                            animations: {
                                chosenCardView.isFaceUp = true},
                            completion: {_ in
                                    UIView.animate(
                                     withDuration: GameViewController.cardMoveTime,
                                        animations:  {
                                            
                                            chosenCardView.center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: nextEmptyRow + 6, card: column))
                                           // chosenCardView.center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: self.findNextCardSlot(stack: stack), card: stack))
                                    },
                                        completion: {_ in
                                            self.discardPiles[column][nextEmptyRow] = self.playerHands[hand][card]
                                    }
                                 )
                            }
                        )
                    }
                )
    }

    func findNextCardSlot(column: Int)->Int{
        print("finding next card in column ", column)
        print(discardPiles)
        for row in 0...discardPiles[column].count - 1{
            if(discardPiles[column][row].num == 0){
                print("found a slot in row ", row)
                return row
            }
            
        }
        return -1
    }
    
     func playCardAnimation(hand:Int, card: Int, stackIndex: Int, cardInStack: Int){
         
     }
 }
  
 extension GameViewController{
     static var cardMoveTime = 0.8
     static var cardFlipTime = 0.5
 }

 

extension GameViewController: delegateUpdateView{
    func moveCard(card: Card, stack: String, location: Int) {
        print("move  card")
    }
    
    func drawCard(hand: Int, card: Int) {
        print("draw Card")
    }
    
    func draw() {
        print("draw")
    }
    
    func discard() {
        print("discard")
    }
    
    func play() {
        print("play")
    }
    
    func hint() {
        print("hint")
    }
    
    func updateHints(hints: Int) {
        //TODO:
        print("updateHints")
    }
    
    //TODO: Combine these two functions in any way reasonable
    func addCard(name: String)->CardView {
        let newCard = CardView()
        newCard.backgroundColor = UIColor.clear
        newCard.isFaceUp = false
        switch(name){
            case "deck":
                
                //newCard.addGestureRecognizer(deal)
                newCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deckTappedAction)))
                newCard.frame = layout.Frame(Details: screenDetails, name: "center")
                view.addSubview(newCard)
            default:
                print("error, name is not found in addCard")
        }
        return newCard
    }
    
    func addCard(hand:Int, card: Int)->CardView{
        let newCard = CardView()
        newCard.backgroundColor = UIColor.clear
        if hand == 0{
            newCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCardAction)))
        }
        if hand == 1{
              newCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCardAction)))
            newCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(detectPanAction(_:))))
        }
        newCard.hand = hand
        newCard.card = card
        newCard.isFaceUp = false
        newCard.frame = layout.Frame(Details: screenDetails, name: "center")
        newCard.num = table.hands[hand][card].num.rawValue
        newCard.col = color[table.hands[hand][card].col.rawValue]!
        return newCard
    }
}
