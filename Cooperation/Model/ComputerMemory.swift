struct ComputerMemory{
    var cardPossibilities = Array(repeating: Array(repeating: Card(), count: 50), count: 5)
    var newCardPossibilities = [Card]()
    var deck: Deck!
    
    /* When initialized, comp knowledge consists of a two dimensional array where each element contains and entire deck of cards. */
    init(){
        deck = Deck()
        newCardPossibilities = deck.getFullDeck()
        for count in  0...4{
            cardPossibilities[count] = newCardPossibilities
        }
    }
    
    mutating func cardDrawn(player: Int, cardLocation: Int, cardToRemove: Card){
        if player == 0{
            cardPossibilities[cardLocation] = newCardPossibilities
        }
        else{
            cardShown(knownCard: cardToRemove)
        }
        printComputerCardMemory()
    }
    
    mutating func cardPlayedOrDiscarded(player: Int, cardLocation: Int, cardPlayed: Card){
        if player == 0{
            cardShown(knownCard: cardPlayed)
            cardPossibilities[cardLocation] = newCardPossibilities
        }
        printComputerCardMemory()
    }
    
    /*Cards can be shown when the opposing player draws a card or when the comptuer discards or plays a card. */
    mutating func cardShown (knownCard: Card){
        //Remove the card from generic card possibility array
        newCardPossibilities = removeCardFromArray(card: knownCard, array: newCardPossibilities)
        //remove it from each specific array if it exists
        for count in 0...4{
            cardPossibilities[count] = removeCardFromArray(card: knownCard, array: cardPossibilities[count])
        }
    }
    
    /*If card exists in array, remove it.  If not, return the original array */
    func removeCardFromArray(card: Card, array: [Card])->[Card]{
        var newArray = array
        for count in 0...array.count - 1{
            if(array[count] == card){
                //print("count", count)
                
                newArray.remove(at: count)
                
                return newArray
            }
        }
        return newArray
    }
    
    func printComputerCardMemory(){
        for count in 0...4{
            var firstColor = cardPossibilities[count][0].col
            for card in 0...cardPossibilities[count].count - 1{
                if cardPossibilities[count][card].col != firstColor{
                    //print()
                    firstColor = cardPossibilities[count][card].col
                }
                //print(cardPossibilities[count][card],terminator:"")
                
                
            }
            //print()
        }
    }
}
