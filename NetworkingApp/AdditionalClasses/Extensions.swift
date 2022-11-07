//
//  Extensions.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 07.11.2022.
//

import Foundation
import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
