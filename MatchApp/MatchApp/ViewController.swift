//
//  ViewController.swift
//  MatchApp
//
//  Created by Amadeo on 06/08/2019.
//  Copyright © 2019 Amadeo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    // CollectionView reference
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Initialize properties
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the ViewController as the delegate and dataSource for de CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // Call the getCards method of the CardModel
        cardArray = model.getCards()
        
    }
    
    // MARK: - UICollectionView Protocol Methods
    
    // Implementation of the required methods in CollectionView
    
    // First we need to know how many items to show (Similar to getItemCount on Android)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // The number of items is the number of cards in our previously defined cardArray
        return cardArray.count
        
    }
    
    // What data to display in each item (Similar to onBindViewHolder on Android)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Create a CollectionViewCell object using method dequeueReusableCell assigning it the CollectionViewCell we created and named as CardCell and cast it as a CardCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // Set the card for the cell
        cell.setCard(card)
        
        return cell
        
    }
    
    // What happends when a user taps on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the cell that the user tapped
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            // Flip the card
            cell.flip()
            
            // Set the status of the card
            card.isFlipped = true
            
            // Determine if it is the first or the second card that has been flipped over
            if firstFlippedCardIndex == nil {
                
                // This is the first card being flipped
                firstFlippedCardIndex = indexPath
                
            } else {
                
                // This is the second card being flipped
                
                // Perform the matching logic
                checkForMatches(indexPath)
                
            }
            
        }
        
    } // End of the didSelectedItemAt method
    
    // MARK: - Game Logic Methods
    
    func checkForMatches(_ sencondFlippedCardIndex:IndexPath) {
        
        // Get the cells for the two cards that were revealed. Need to unwrapp the optional and cast as optional
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: sencondFlippedCardIndex) as? CardCollectionViewCell
        
        // Get the cards for the two cards that were revealed. Neet to cast as optional CardCollectionViewCell
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[sencondFlippedCardIndex.row]
        
        // Check if the two cards are the same
        if cardOne.imageName == cardTwo.imageName {
            
            // It's a match
            
            // Set the status of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        } else {
            
            // It's not a match
            
            // Set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip both cards back
            cardOneCell?.flipback()
            cardTwoCell?.flipback()
            
        }
        // Tell the colletionView to reload the cell of the first card if it is nil
        if cardOneCell == nil {
            
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            
        }
        
        // Set index to nil to ensure it is nil everytime we call the match method
        firstFlippedCardIndex = nil
        
    }

} // End ViewController class

