import Foundation

func ==(_ object : Any?, _ object_bis : Any?) -> Bool
{
    if let card = object as? Card, let card_bis = object_bis as? Card
    {
        return (card.color == card_bis.color && card.value == card_bis.value)
    }
    return false
}

class Card : NSObject
{
    var color : Color
    var value : Value

    override var description : String { return "[\(self.color): \(self.value)]" }

    init(color : Color, value : Value)
    {
        self.color = color
        self.value = value
        super.init()
    }

    override func isEqual(_ object: Any?) -> Bool
    {
        if let card = object as? Card {
            return (card.color == self.color && card.value == self.value)
        }
        return false
    }

}