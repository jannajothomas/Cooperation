//
//  ViewController.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/7/20.
//  Copyright © 2020 Personal. All rights reserved.
//


//This is really concerned with making info from the model visible.
import UIKit
import GameplayKit

class GameViewController: UIViewController {
    //var game = Game(playerNames: ["player1","player2"])
    var dealingComplete = false
    
    var playerHands = Array(repeating: Array(repeating: CardView(), count: 5),count: 2)
    var stacks = Array(repeating: Array(repeating: CardView(), count: 5), count: 5)
    var discardPiles = Array(repeating: Array(repeating: CardView(), count: 10), count: 5)
    var deck = CardView()
    //var cardArray = Array(repeating: Array(repeating: CardView(), count: 5), count: 5)
    var strategist: GKMinmaxStrategist!
    var table: Table!
    var layout = Layout()   //this should be a struct not a class
    var lastHand = 1    //Dont know what this is
    var screenDetails = ScreenDetails(windowWidth: 0, windowHeight: 0, topPadding: 0, rightPadding: 0, leftPadding: 0, bottomPadding: 0)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        screenDetails.windowWidth = self.view.frame.size.width
        screenDetails.windowHeight =  self.view.frame.size.height
        
        //game.delegate = self
        
        for hand in 0...1{
            for card in 0...4{
                playerHands[hand][card] = addCard(hand: hand, card: card)
                view.addSubview(playerHands[hand][card])
            }
        }
        addCard(name: "deck")
        
        strategist = GKMinmaxStrategist()
        strategist.maxLookAheadDepth = 4
        strategist.randomSource = GKARC4RandomSource()
        resetTable()
        view.backgroundColor = UIColor.red
        
        //print("screen dtails in view did load", screenDetails)
        //screenDetails.bottomPadding = self.view.frame.size.bottomPadding
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
        //print("Deck tapped")
        if(dealingComplete == true){
            //TODO: Notify the game that a card should be drawn
            print("deck tapped and dealing is complete")
        }else{
            dealCards(hand: 0, card: 0)
            print("the card dealing animation should happen now")
            dealingComplete = true
            //TODO: Animate the dealing of the cards
        }
    }
    
    @objc func cardTappedAction(){
        
    }
    
    //This is called when a new card is created during the card dealing process
    func drawCardView(hand: Int, card: Int)->CardView{
        let newCard = CardView()
        if hand == 0{
            //newCard.num = game.stacksOfCards.playerHands[hand][card].num.rawValue
            //newCard.cardBackgroundColor = game.getUIColor(card: game.stacksOfCards.playerHands[hand][card])
            //newCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCardAction(_:))))
        }
            
        if hand == 1{
            //newCard.num = gamePlay.stacksOfCards.playerHands[hand][card].num.rawValue
            //newCard.cardBackgroundColor  = gamePlay.getUIColor(card: gamePlay.stacksOfCards.playerHands[hand][card])
             //newCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(detectPanAction(_:))))
            //Temporary
            //newCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCardAction(_:))))
        }
        return newCard
    }
    
    
    
    
    


/*
     var layout = Layout()
     
     //MARK: objects
     lazy var PlayerCardView = Array(repeating: Array(repeating: HanabiCards(), count:5), count:4) //Hand  0,1
     var ColorHintView = LabeledCardArea()   // Hand 4 Card 0
     var DeckView = HanabiCards()            // Hand 4 Card 1
     var DiscardView = LabeledCardArea()     //Hand 4 Card 2
     var NumberHintView = LabeledCardArea()  //Hand 4 Card 3
     lazy var StackCardsView = Array(repeating: HanabiCards(), count: 5)      //Hand 5
     lazy var DiscardedCardsView = [[HanabiCards()],[HanabiCards()],[HanabiCards()],[HanabiCards()],[HanabiCards()]]
     var cardSelected = [false,false,false,false,false]
     
     var hintImages = [HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol(),HintSymbol()]
     var turnImage = TurnIndicator()
     
     //Testing Only
     
     
     //MARK: Constants
     var lastHand = 1    //this  should ultimately come from somewhere else
     var timeInterval = TimeInterval(6)

     //MARK: Animation flags
     var discardCard = Bool()
     var dealingComplete = Bool() {
         didSet{
             layoutBoard()
             turnOverCards();
         }
     }


     */

     //Recursive function that animates the dealing of the cards
     private func dealCards(hand: Int, card: Int){
         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations:{
            self.playerHands[hand][card].center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: hand, card: card, cardIndex: card))}  , completion: { _ in
                    //see if is the last card in the hand
                    if(card == 4){
                        if hand == self.lastHand{
                            //Dealing is done.  Move deck its perm location
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {self.deck.center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: 4, card: 1, cardIndex: 1))},
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
    
    override func viewDidLayoutSubviews() {
            //updateScreenDetails()
            //layoutCardCentersAndSize()
            
        }

     /*
     private func turnOverCards(){
         for card in 0...4{
             UIView.transition(
                 with: PlayerCardView[0][card],
                 duration: 1.5,
                 options: .transitionFlipFromLeft,
                 animations: {self.PlayerCardView[0][card].isFaceUp = true},
                 completion: {_ in
                     if(card == 4){
                         self.gamePlay.selectFirstPlayer()
                     }
             })
         }
     }
     
     //MARK: Refresh Layout
    
     //MARK: Recognizer Actions
     @objc func hintCardAction(_ recognizer:UITapGestureRecognizer){
         if let chosenCardView = recognizer.view as? LabeledCardArea{
             if(chosenCardView.cardText == "Number Hint"){
                 gamePlay.getHint(number: numberHint)
             }
             if(chosenCardView.cardText == "Color Hint"){
                 gamePlay.getHint(color: colorHint)
             }
         }
     }
     
     var selectedNumber = [0,0,0,0,0]
     var selectedColor = [UIColor.black,UIColor.black,UIColor.black,UIColor.black,UIColor.black]
     var numberHint = 0
     var colorHint = UIColor.black
     
     //Controls logic of card selection and the hints that are available for the computer's hand
     @objc func selectCardAction(_ recognizer: UITapGestureRecognizer){
         var hideColorHints = false
         var hideNumberHints = false
         switch recognizer.state{
         case .ended:
             if let chosenCardView = recognizer.view as?  HanabiCards{
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
         }
     }
     
     @objc func flipCardAction(_ recognizer: UITapGestureRecognizer) {
          switch recognizer.state {
          case .ended:
              if let chosenCardView = recognizer.view as? HanabiCards{
                  UIView.transition(with: chosenCardView, duration: 0.5, options: .transitionFlipFromLeft, animations:{
                      chosenCardView.isFaceUp = !chosenCardView.isFaceUp}
                     )
              }
          default:
              break
          }
      }
     
     var lastLocation = CGPoint()
     @objc func detectPanAction(_ recognizer:UIPanGestureRecognizer) {
         if let chosenCardView = recognizer.view as? HanabiCards{
             //var lastLocation = chosenCardView.center
             chosenCardView.superview?.bringSubviewToFront(chosenCardView)
             switch  recognizer.state{
             case .began:
                 lastLocation = chosenCardView.center
             case .ended:
                 lastLocation = chosenCardView.center
                 if chosenCardView.frame.intersects(DiscardView.frame){
                     gamePlay.discardCard(sourceHand: chosenCardView.handTag, sourceCard: chosenCardView.cardTag, playedToHand: 4, playedToCard: 2)
                 }
                 for card in 0...4{
                     if chosenCardView.frame.intersects(StackCardsView[card].frame){
                         gamePlay.playCard(hand: chosenCardView.handTag, card: chosenCardView.cardTag, playedToHand: 5, playedToCard: card)
                     }
                 }
             case .changed:
                 print("x location", chosenCardView.center.x, "y location", chosenCardView.center.y)
                 let translation = recognizer.translation(in: self.view)
                 chosenCardView.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
                 if (chosenCardView.frame.intersects(DiscardView.frame)){
                     DiscardView.backgroundColor = UIColor.gray
                 }else{
                     DiscardView.backgroundColor = UIColor.clear
                 }
                 for card in 0...4{
                     if (chosenCardView.frame.intersects(StackCardsView[card].frame)){
                         StackCardsView[card].backgroundColor = UIColor.gray
                     }else{
                         StackCardsView[card].backgroundColor = UIColor.clear
                     }
                 }
             default: break
             }
         }
     }
     

     */
    
    
    
}



 //MARK: ScreenLayout


     /*
    // func setupScreen(){
  
    // }
     
     func createStackCard(card: Int, color: UIColor)->HanabiCards{
         let newStack = HanabiCards()
         newStack.frame.size = layout.Size(Details: screenDetails)
         newStack.center = layout.Location(Details: screenDetails, item: CardIdentity(hand: 5, card: card, cardIndex: card))
         //newStack.backgroundColor = UIColor.clear
         newStack.num = 0
         newStack.cardBackgroundColor = color
         return newStack
     }
     
     func configureSpecialCards(name: String, card: Int)->LabeledCardArea{
         let specialCard = LabeledCardArea()
         specialCard.frame.size = layout.Size(Details: screenDetails)
         specialCard.center = layout.Location(Details: screenDetails, item: CardIdentity(hand: 3, card: card, cardIndex: card))
         specialCard.backgroundColor = UIColor.clear
         if name == "Discard"{
             specialCard.numberOfLines = 1
             //specialCard.isHidden = false
         }else{
             specialCard.numberOfLines = 2
             //specialCard.isHidden = true
             specialCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hintCardAction(_:))))
         }
         specialCard.cardText = name
         //specialCard.cardBackgroundColor = UIColor.orange
         return specialCard
     }
     
     func layoutCardCentersAndSize(){
         DeckView.center = layout.Location(Details: screenDetails, item: viewLocationIndex["Deck"]!)
         DeckView.frame.size = layout.Size(Details: screenDetails)
         
         DiscardView.center = layout.Location(Details: screenDetails, item: viewLocationIndex["Discard"]!)
         DiscardView.frame.size = layout.Size(Details: screenDetails)
         
         ColorHintView.center = layout.Location(Details: screenDetails, item: viewLocationIndex["ColorHint"]!)
         ColorHintView.frame.size = layout.Size(Details: screenDetails)
         
         NumberHintView.center = layout.Location(Details: screenDetails, item: viewLocationIndex["NumberHint"]!)
         NumberHintView.frame.size = layout.Size(Details: screenDetails)
         

          if dealingComplete{
             for hand in 0...1{
                 for card in 0...4{
                     PlayerCardView[hand][card].frame.size = layout.Size(Details: screenDetails)
                     PlayerCardView[hand][card].center = layout.Location(Details: screenDetails, item: CardIdentity(hand: hand, card: card, cardIndex: card))
                     }
                 }
          for stack in 0...4{
              StackCardsView[stack].frame.size = layout.Size(Details: screenDetails)
              StackCardsView[stack].center = layout.Location(Details: screenDetails, item: CardIdentity(hand: 5, card: stack, cardIndex: stack))
             }
          for discards in 0...4{
              for rows in 0...DiscardedCardsView[discards].count - 1{
                  DiscardedCardsView[discards][rows].frame.size = layout.Size(Details: screenDetails)
                  DiscardedCardsView[discards][rows].center = layout.Location(Details: screenDetails, item: CardIdentity(hand: rows + 5, card: discards, cardIndex: discards))
              }
          }
          for count in 0...6{
              hintImages[count].center = layout.StarLocation(Details: screenDetails, Index: count)
                 }
             turnImage.center = layout.centerOfScreen
          }else{DeckView.center = layout.centerOfScreen}
      }

     
     //MARK: WORKING HERE
     @objc func colorHint(_ recognizer:UITapGestureRecognizer){
         gamePlay.getHint(color: colorHint)
     }
     
     @objc func numberHint(_ recognizer: UITapGestureRecognizer){
         gamePlay.getHint(number: numberHint)
     }
     
     func layoutBoard(){
         //setup Hands - MAYBE THIS HAPPENS SOMEWHERE ELSE OR DOESN'T NEED TO HAPPEN?
                  for hand in 0...1{
                      for card in 0...4{
                          PlayerCardView[hand][card].tag = card
                      }
                  }
         
         DiscardView = configureSpecialCards(name: "Discard",card: 2)
         view.addSubview(DiscardView)
         print(view)
         
         ColorHintView = configureSpecialCards(name: "Color Hint", card: 1)
         view.addSubview(ColorHintView)
         ColorHintView.isHidden = true
         ColorHintView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorHint(_:))))
         
         NumberHintView = configureSpecialCards(name: "Number Hint", card: 3)
         view.addSubview(NumberHintView)
         NumberHintView.isHidden = true
         NumberHintView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(numberHint(_:))))
         
         //setup Hints
             for count in 0...6{
                 let newImage = HintSymbol()
                 newImage.center = layout.StarLocation(Details: screenDetails, Index: count)
                 newImage.frame.size = layout.starSize(Details: screenDetails)
                 newImage.fontSize = (layout.starSize(Details: screenDetails)).height
                 //newImage.fontSize = 80
                //  if gamePlay.hintsLeft >= count{
                //     newImage.isFaceUp = true
                // }else{
                //     newImage.isFaceUp = false
                // }
                 hintImages[count] = newImage
                 view.addSubview(hintImages[count])
             }
         
         //setup Turn image
             let newHintImage = TurnIndicator()
         newHintImage.frame.size = layout.starSize(Details: screenDetails)
         newHintImage.fontSize = (layout.starSize(Details: screenDetails)).height
         turnImage = newHintImage
         print(view)
         view.addSubview(turnImage)
             
         //setup Stacks
            let stackColor = [UIColor.red, UIColor.blue, UIColor.magenta, UIColor.orange,UIColor.purple]
                 for card in 0...4{
                     let newStack = HanabiCards()
                    newStack.frame.size = layout.Size(Details: screenDetails)
                     newStack.center = layout.Location(Details: screenDetails, item: CardIdentity(hand: 5, card: card, cardIndex: card))
                     newStack.backgroundColor = UIColor.clear
                     newStack.num = 0
                     newStack.cardBackgroundColor = stackColor[card]
                     StackCardsView[card] = newStack
                     StackCardsView[card].isHidden = false
                     view.addSubview(StackCardsView[card])
                 }
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
     
     func drawCardAnimation(hand: Int, card: Int) {
             let delay = GameBoardViewController.cardMoveTime * 2 + GameBoardViewController.cardFlipTime
             PlayerCardView[hand][card] = createHanabiCardAtLocation(hand: hand, card: card, location: layout.Location(Details: screenDetails, item: CardIdentity(hand: 4, card: 1, cardIndex: 1)))
             UIView.animate(withDuration: GameBoardViewController.cardMoveTime, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {

                 self.PlayerCardView[hand][card].center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: hand, card: card, cardIndex: card))
                    })
         }
     
     func moveCardAnimation(sourceHand: Int, sourceCard: Int, destinationCard: Int, destintionHand: Int, playedToCard: Int, playedToHand: Int) {
                let chosenCardView = PlayerCardView[sourceHand][sourceCard]
         view.bringSubviewToFront(chosenCardView)
                 self.view.layoutIfNeeded()
                 UIView.animate(
                  withDuration: GameBoardViewController.cardMoveTime,
                     animations: {
                         chosenCardView.center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: playedToHand, card: playedToCard, cardIndex: playedToCard))},
                     completion: {_ in
                         UIView.transition(
                             with: chosenCardView,
                             duration: GameBoardViewController.cardFlipTime,
                             options: .transitionFlipFromLeft,
                             animations: {
                                 chosenCardView.isFaceUp = true},
                             completion: {_ in
                                     UIView.animate(
                                      withDuration: GameBoardViewController.cardMoveTime,
                                         animations:  {
                                             chosenCardView.center = self.layout.Location(Details: self.screenDetails, item: CardIdentity(hand: destintionHand, card: destinationCard, cardIndex: destinationCard))
                                     },
                                         completion: {_ in
                                          if destintionHand == 5{
                                               self.DiscardedCardsView[destinationCard][destintionHand - 5] = chosenCardView
                                          }else{
                                              self.DiscardedCardsView[destinationCard].append(chosenCardView)
                                          }
                                     }
                                  )
                             }
                         )
                     }
                 )
     }

     func playCardAnimation(hand:Int, card: Int, stackIndex: Int, cardInStack: Int){
         
     }
 }
     
 extension GameBoardViewController{
     static var cardMoveTime = 0.8
     static var cardFlipTime = 0.5
 }

 */

extension GameViewController: delegateUpdateView{
    func moveCard(card: Card, stack: String, location: Int) {
        print("here")
    }
    
    func drawCard(hand: Int, card: Int) {
        print("and here")
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
        print("got message to update hints")
    }
    
    func addCard(name: String) {
        switch(name){
            case "deck":
                deck.backgroundColor = UIColor.clear
                deck.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deckTappedAction)))
                deck.isFaceUp = false
                deck.frame = layout.Frame(Details: screenDetails, item: CardIdentity(hand: 4, card: 1, cardIndex: 1))
                view.addSubview(deck)
            default:
                print("error, name is not found in addCard")
        }
    }
    
    func addCard(hand:Int, card: Int)->CardView{
        let newCard = CardView()
        newCard.backgroundColor = UIColor.clear
        newCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cardTappedAction)))
        newCard.isFaceUp = false
        newCard.frame = layout.Frame(Details: screenDetails, item: CardIdentity(hand: 4, card: 1, cardIndex: 1))
        return newCard
    }
}
