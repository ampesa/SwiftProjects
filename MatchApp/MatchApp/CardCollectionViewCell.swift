//
//  CardCollectionViewCell.swift
//  MatchApp
//
//  Created by Amadeo on 07/08/2019.
//  Copyright © 2019 Amadeo. All rights reserved.
//

import UIKit

// Our special implementation of the UICollectionViewCell
class CardCollectionViewCell: UICollectionViewCell {
    
    // Front Image referenece
    @IBOutlet weak var frontImageView: UIImageView!
    
    // Back Image reference
    @IBOutlet weak var backImageView: UIImageView!
    
    // Card object reference
    var card:Card?
    
    // Method to set each card
    func setCard(_ card:Card) {
        
        // Track the card that gets passed in to the frontImageView
        self.card = card
        
        // If cards are already matched make the imageviews invisibles
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        } else {
            // If cards aren't matched make them visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        // Determine if the card is in a flipped up state or not
        if card.isFlipped == true {
            
            // Make sure the frontImage is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        } else {
            
            // Make sure the backImage is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
        
    }
    
    // Method to show the frontImageView of the card
    func flip() {
        
        // Show it with a transition
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    // Method to hide the hide de frontImageView and show the backImageView of the card
    func flipback() {
        
        // Add a delay to let the user remind card position
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            // Hide it with a transition
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        

        
    }
    
    // Removes both imageviews from being visible. Method used when there is a match
    func remove() {
        
        // TODO: animate it
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion:  nil)
        
        
    }
    
}
