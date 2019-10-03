//
//  RecipeTableViewController.swift
//  RecipeBox
//
//  Main view controller for the application
//
//  Created by Reshma Unnikrishnan on 28.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var viewModel: RecipesViewModel
    
    // MARK: - Initializations
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = RecipesViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        viewModel.loadJSONfromFile(name: "Recipes")
        
        setupUI()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RecipeCell! = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
            as? RecipeCell
        
        cell.recipeViewModel = viewModel.items[indexPath.row]
        
        cell.setupItems()
        
        return cell
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Yummy"
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
