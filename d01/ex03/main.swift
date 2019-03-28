import Foundation

print(Deck.allCards)
var copy = Deck.allCards
copy.randomShuffle()
print(copy)
