//
//  CardModel.swift
//  MatchApp
//
//  Created by Amadeo on 07/08/2019.
//  Copyright © 2019 Amadeo. All rights reserved.
//

import Foundation

class CardModel {
    
    // This function returns an array of Card objects. Is used by the ViewController to set the cards
    func getCards() -> [Card]{
        
        // Declare an array to store numbers we've already generated
        var generatedNumbersArray = [Int]()
        
        // Array to store generated cards
        var generatedCardsArray = [Card]()
        
        // Generate pairs of cards randomly
        while generatedNumbersArray.count < 8 {
            
            // Get a random number
            let randomNumber = arc4random_uniform(13) + 1
            
            // Ensure that the random number isn't one we already have
            if generatedNumbersArray.contains(Int(randomNumber)) == false{
                
                // Log the number
                print(randomNumber)
                
                // Store the number in the generatedNumbersArray
                generatedNumbersArray.append(Int(randomNumber))
                
                // Create first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                // Add the card to the array
                generatedCardsArray.append(cardOne)
                
                // Create second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
                
            }
            
            
        }
        // TO DO: Fulflill the array
        
        for i in 0...generatedCardsArray.count-1 {
            
            //Find a random index to swap with
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            
            // Swap the two cards
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray [randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
        }

        
        // Return filled array
        return generatedCardsArray
    }
}
