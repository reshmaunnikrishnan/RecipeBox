//
//  RatingControl.swift
//  RecipeBox
//
//  Ratings Control
//
//  Created by Reshma Unnikrishnan on 28.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: - IBOutlets
    
    @IBInspectable var startCount: Int = 5
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
    
    // MARK: - Public Properties
    
    var recipeViewModel: RecipeViewModel? {
        didSet {
            setupRatingValue()
        }
    }
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    // MARK: - Private Properties
    
    private var ratingButtons = [UIButton]()

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Delegates
    
    /// Rating button tap delegate
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
        
        recipeViewModel?.setRating(rating: rating)
    }
    
    // MARK: - Private Methods
    
    // Set up buttons and ratings
    private func setup() {
        setupButtons()
        setupRatingValue()
    }
    
    /// Set up buttons
    private func setupButtons() {
        // Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        // Create the buttons
        for _ in 0..<startCount {
            // Create the button
            let button = UIButton()
            button.backgroundColor = UIColor.clear
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
    }
    
    /// Set up rating value from view model
    private func setupRatingValue() {
        rating = recipeViewModel?.rating() ?? 0
    }
    
    /// Update button states in the UI
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }
}
