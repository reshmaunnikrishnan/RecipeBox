//
//  Recipes.swift
//  RecipeBox
//
//  Created by Reshma Unnikrishnan on 26.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import Foundation
import UIKit

enum HelloFreshApi {
    case getRecipes
    case user(login: String)
}

struct Recipes {
    let recipe_count: Int
    let recipes: [Recipe]
}

struct Recipe  {
    let calories: String
    let card: String
    let country: String
    let carbos: String
    let deliverable_ingredients: [String]
    let desciption: String
    let difficulty: Int
    let favorites: Int
    let headline: String
    let image: String
    let name: String
    var rating: Int
    var isFavorite: Bool
    
    init(_ dictionary: [String: Any]) {
        self.calories = dictionary["calories"] as? String ?? ""
        self.card = dictionary["card"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? ""
        self.carbos = dictionary["carbos"] as? String ?? ""
        self.desciption = dictionary["desciption"] as? String ?? ""
        self.difficulty = dictionary["difficulty"] as? Int ?? 0
        self.favorites = dictionary["favorites"] as? Int ?? 0
        self.image = dictionary["image"] as? String ?? ""
        self.headline = dictionary["headline"] as? String ?? ""
        self.deliverable_ingredients = dictionary["deliverable_ingredients"] as? [String] ?? []
        self.name = dictionary["name"] as? String ?? ""
        self.rating = dictionary["rating"] as? Int ?? 0
        self.isFavorite = false
    }
    
}

