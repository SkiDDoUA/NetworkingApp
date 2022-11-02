//
//  RecipeCollectionViewCell.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 01.11.2022.
//

import UIKit
import Kingfisher

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configure(for recipe: Result) {
        DispatchQueue.main.async {
            self.titleLabel.text = recipe.title
            self.imageView.kf.setImage(with: URL(string: recipe.image))
        }
    }
}
