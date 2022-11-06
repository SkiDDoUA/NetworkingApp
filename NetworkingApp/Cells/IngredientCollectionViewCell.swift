//
//  IngredientCollectionViewCell.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 06.11.2022.
//

import Foundation
import Kingfisher

class IngredientCollectionViewCell: UICollectionViewCell {    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(for ingredient: ExtendedIngredient) {
        DispatchQueue.main.async {
            self.titleLabel.text = ingredient.name
            self.imageView.kf.setImage(with: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(ingredient.image)"))
            
            self.imageView.layer.cornerRadius = 12
        }
    }
}
