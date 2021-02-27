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
    
    func printCardPossibilities(){
        for column in 0...cardPossibilities.count - 1{
            for row in 0...cardPossibilities[column].count - 1{
                print(cardPossibilities[count])
            }
        }
    }
}
