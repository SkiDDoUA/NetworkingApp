//
//  RecipeViewController.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 01.11.2022.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cookingTimeLabel: UILabel!
    @IBOutlet private weak var cuisineLabel: UILabel!
    @IBOutlet private weak var recipeImageView: UIImageView!
    
    var recipe: RecipeElement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(for recipe: RecipeElement) {
        DispatchQueue.main.async {
            self.titleLabel.text = recipe.title
            self.cookingTimeLabel.text = "\(recipe.readyInMinutes) Min"
            self.cuisineLabel.text = recipe.cuisine
            self.recipeImageView.kf.setImage(with: URL(string: recipe.image))
        }
    }
}
