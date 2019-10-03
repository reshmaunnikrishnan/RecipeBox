//
//  UITextField+Rounded.swift
//  RecipeBox
//
//  Extension to allow rounded corners for UITextField
//
//  Created by Reshma Unnikrishnan on 29.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import UIKit

extension UITextField {
    // MARK: - Public methods
    
    /// Round the text field edges
    func rounded() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}
