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
    @IBOutlet private weak var IngredientsCollectionView: UICollectionView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var ScrollHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var IngredientsCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var StackViewHeightConstraint: NSLayoutConstraint!
    
    var recipe: RecipeElement! {
        didSet {
            self.IngredientsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IngredientsCollectionView.delegate = self
        IngredientsCollectionView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        IngredientsCollectionViewHeightConstraint?.constant = IngredientsCollectionView.contentSize.height
        StackViewHeightConstraint?.constant = IngredientsCollectionView.contentSize.height + 37
        scrollView.resizeScrollViewContentSize()
    }
    
    func configure(for recipe: RecipeElement) {
        DispatchQueue.main.async {
            self.recipe = recipe
            self.titleLabel.text = recipe.title
            self.cookingTimeLabel.text = "\(recipe.readyInMinutes) Min"
            self.cuisineLabel.text = recipe.cuisine
            self.recipeImageView.kf.setImage(with: URL(string: recipe.image))
        }
    }
}

// MARK: - UICollectionViewDelegate
extension RecipeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let recipe {
            return recipe.extendedIngredients.count
        }
        return 0
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = IngredientsCollectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.reuseIdentifier, for: indexPath) as! IngredientCollectionViewCell
        cell.configure(for: recipe.extendedIngredients[indexPath.row])
        return cell
    }
}


extension UIScrollView {
    func resizeScrollViewContentSize() {
        var contentRect = CGRect.zero
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        self.contentSize = contentRect.size
    }
}
