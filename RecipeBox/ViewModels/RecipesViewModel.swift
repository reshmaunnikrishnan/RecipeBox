//
//  RecipesviewModel.swift
//  RecipeBox
//
//  Created by Reshma Unnikrishnan on 27.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import Foundation
import UIKit

class RecipesViewModel: NSObject {
    // MARK: - Public Properties
    
    var items = [RecipeViewModel]()
    
    // MARK: - Overrides
    
    override init() {
        super.init()
    }
    
    // MARK: - Public Functions
    
    /// Allows loading data from a json file
    func loadJSONfromFile(name: String) {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                guard let json = jsonResult as? [[String: Any]] else {
                    return
                }

                for dict in json {
                    let recipe = Recipe(dict)
                    items.append(RecipeViewModel.init(recipe: recipe))
                }
            } catch {
                // handle error
            }
        }
    }
}

class RecipeViewModel: NSObject {
    // MARK: - Public Properties
    
    var recipe: Recipe?
    
    
    // MARK: - Initializers
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    // MARK: - Public Functions
    
    func name() -> String {
        return recipe?.name ?? ""
    }
    
    func imageURL() -> URL {
        let urlstring = recipe?.image ?? ""
        return URL(string: urlstring)!
    }
    
    func headline() -> String {
        return recipe?.headline ?? ""
    }
    
    func rating() -> Int {
        return recipe?.rating ?? 0
    }
    
    func isFavorite() -> Bool {
        return recipe?.isFavorite ?? false
    }
    
    func setRating(rating: Int) {
        recipe?.rating = rating
    }
    
    func setFavorite(isFavorite: Bool) {
        recipe?.isFavorite = isFavorite
    }
}
