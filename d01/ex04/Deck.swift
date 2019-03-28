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

    var cards : [Card] = allCards
    var discards : [Card] = []
    var outs : [Card] = []

    override var description : String { return "\(self.cards.description)" }

    init(sort : Bool)
    {
        if sort == true
        {
            cards.randomShuffle()
        }
        super.init()
    }

    class func getCards(type : Color) -> [Card]
    {
        var arrayOfCards : [Card] = []

        for value in Value.allValues
        {
            arrayOfCards.append(Card(color : type, value : value))
        }
        return arrayOfCards
    }
    func draw() -> Card?
    {
        if let drawCard = cards.popLast()
        {
            outs.append(drawCard)
            return drawCard
        }
        return nil
    }
    func fold(c : Card)
    {
        if let index = outs.index(of : c)
        {
            discards.append(outs[index])
            outs.remove(at: index)
        }
    }
}
