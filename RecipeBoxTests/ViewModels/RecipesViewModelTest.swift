//
//  RecipesViewModelTests.swift
//  RecipeBoxTests
//
//  Created by Reshma Unnikrishnan on 29.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import XCTest

class RecipesViewModelTests: XCTestCase {
    var sut: RecipesViewModel!
    var items: [RecipeViewModel]!

    override func setUp() {
        super.setUp()
        
        sut = RecipesViewModel()
    }

    override func tearDown() {
       super.tearDown()
        
        sut = nil
    }
    
    func testRecipeItemsShouldShowNilWhenJsonFileIsNotExisted() {
        sut.loadJSONfromFile(name: "Hello")
        //considering the number of items is nil
        XCTAssertEqual(sut.items.count, 0)
    }
    
    func testRecipeItemsShouldShowWhenJsonFileExist() {
        sut.loadJSONfromFile(name: "Recipes")
        //considering the number of items is nil
        XCTAssertEqual(sut.items.count, 9)
    }

    func testWithTheGivenCellViewModels() {
        let recipe0 = Recipe(["desciption" : "fhhg", "name": "recipe0", "rating" : 5, "isFavorite": true])
        let recipe1 = Recipe(["desciption" : "fhvkjhg", "name": "recipe1", "rating" : 0, "isFavorite": true])
        let recipe2 = Recipe(["desciption" : "fhhg", "name": "recipe2", "rating" : 2, "isFavorite": true])
        
        sut.items.append(RecipeViewModel(recipe: recipe0))
       sut.items.append(RecipeViewModel(recipe: recipe1))
        sut.items.append(RecipeViewModel(recipe: recipe2))
        
        XCTAssertEqual(sut.items[0].name(), "recipe0" )
        XCTAssertEqual(sut.items[1].rating(), 0 )

        sut.items[2].setFavorite(isFavorite: true)
        XCTAssertTrue( sut.items[2].isFavorite())
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
