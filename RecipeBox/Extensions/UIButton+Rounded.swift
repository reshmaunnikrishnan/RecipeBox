//
//  UIButton+Rounded.swift
//  RecipeBox
//
//  Extension to allow rounded corners for UIButton
//
//  Created by Reshma Unnikrishnan on 29.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import UIKit

extension UIButton {
    // MARK: - Public methods
    
    /// Round the button edges
    func rounded() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
