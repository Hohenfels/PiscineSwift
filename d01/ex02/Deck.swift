import Foundation

class Deck : NSObject
{
    static let allSpades : [Card] = 
    {
        return Deck.getCards(type : .Pique)
    }()
    static let allDiamonds : [Card] = 
    {
        return Deck.getCards(type : .Carreau)
    }()
    static let allHearts : [Card] = 
    {
        return Deck.getCards(type : .Coeur)
    }()
    static let allClubs : [Card] = 
    {
        return Deck.getCards(type : .Trefle)
    }()
    static let allCards : [Card] = 
    {
        return allSpades + allDiamonds + allHearts + allClubs
    }()

    class func getCards(type : Color) -> [Card]
    {
        var arrayOfCard : [Card] = []

        for value in Value.allValues
        {
            arrayOfCard.append(Card(color : type, value : value))
        }
        return arrayOfCard
    }
}