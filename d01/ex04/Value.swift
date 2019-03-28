import Foundation

enum Value: Int
{
   case As = 1
   case Deux = 2
   case Trois = 3
   case Quatre = 4
   case Cinq = 5
   case Six = 6
   case Sept = 7
   case Huit = 8
   case Neuf = 9
   case Dix = 10
   case Valet = 11
   case Reine = 12
   case Roi = 13

   static let allValues = [Value.As, Value.Deux, Value.Trois, Value.Quatre, Value.Cinq, Value.Six,
                            Value.Sept, Value.Huit, Value.Neuf, Value.Dix, Value.Valet, Value.Reine, Value.Roi]
}