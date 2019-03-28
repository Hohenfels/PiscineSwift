import Foundation

extension Array
{
    mutating func randomShuffle()
    {
        for i in indices
        {
            let j = Int(arc4random_uniform(UInt32(self.count - i))) + i
            let tmp = self[i]
            if (j != i)
            {
                self[i] = self[j]
                self[j] = tmp
            }
        }
    }
}

class Deck : NSObject
{
    static var allSpades : [Card] = 
    {
        return Deck.getCards(type : .Pique)
    }()
    static var allDiamonds : [Card] = 
    {
        return Deck.getCards(type : .Carreau)
    }()
    static var allHearts : [Card] = 
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
