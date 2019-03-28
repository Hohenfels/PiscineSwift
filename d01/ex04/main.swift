import Foundation

var deckNoShuffle = Deck(sort: false)
print("Creating a Deck that is not shuffled : \(deckNoShuffle.cards)\n")
var deckShuffled = Deck(sort : true)
print("Creating a Deck that is shuffled : \(deckShuffled.cards)\n")

var drawCard = deckShuffled.draw()
print("#1\nDrawed card : \(drawCard!.description)")
print("Out cards : \(deckShuffled.outs)\n")

drawCard = deckShuffled.draw()
print("#2\nDrawed card : \(drawCard!.description)")
print("Out cards : \(deckShuffled.outs)\n")

drawCard = deckShuffled.draw()
print("#3\nDrawed card : \(drawCard!.description)")
print("Out cards : \(deckShuffled.outs)\n")

print("Out cards before discarding a card in outs: \(deckShuffled.outs)\n")
deckShuffled.fold(c : drawCard!)
print("Discarding \(drawCard!.description) in outs")
print("Discards state : \(deckShuffled.discards)")
print("After discard : \(deckShuffled.outs)\n")

print("Out cards before discarding a card not in outs: \(deckShuffled.outs)\n")

var newCard = Card(color: Color.Pique, value: Value.Neuf)
deckShuffled.fold(c : newCard)
print("Card should not be in outs so no discarding : \(deckShuffled.outs)")
print("State of discard despite no card discarded\(deckShuffled.discards)")
