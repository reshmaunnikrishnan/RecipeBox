//
//  RecipeCell.swift
//  RecipeBox
//
//  Created by Reshma Unnikrishnan on 28.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet  var imgView : UIImageView?
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Public Properties
    
    var recipeViewModel: RecipeViewModel?
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public methods
    
    /// Set up values inside the cell
    func setupItems() {
        if let viewModel = self.recipeViewModel {
            recipeName.text = viewModel.name()
            
            let imageURL = viewModel.imageURL()
            imgView?.downloadImage(from: imageURL, placeholder: #imageLiteral(resourceName: "icons8-pizza-96"))
            
            ratingControl?.recipeViewModel = viewModel
            
            desciptionLabel.text = viewModel.headline()
            
            favoriteButton.addTarget(self, action: #selector(self.favoriteButtonTapped(button:)), for: .touchUpInside)
            
            updateFavoriteState()
        }
    }
    
    // MARK: - Delegates
    
    /// Callback for favorite button tap
    @objc func favoriteButtonTapped(button: UIButton) {
        if let viewModel = self.recipeViewModel {
            viewModel.setFavorite(isFavorite: !viewModel.isFavorite())
            
            updateFavoriteState()
        }
    }
    
    // MARK: - Private methods
    
    /// Update the favorite state on the UI
    private func updateFavoriteState() {
        if let viewModel = self.recipeViewModel {
            if viewModel.isFavorite() {
                DispatchQueue.main.async { [weak self] in
                    self?.favoriteButton.imageView?.image = #imageLiteral(resourceName: "filledHeart")
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.favoriteButton.imageView?.image = #imageLiteral(resourceName: "emptyHeart")
                }
            }
        }
    }
}
