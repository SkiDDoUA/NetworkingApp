//
//  Schema.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 01.11.2022.
//

import Foundation


// MARK: - .recipes Query
struct RecipesList: Codable {
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let title: String
    let image: String
}

// MARK: - .random Query
struct RandomRecipesList: Codable {
    let recipes: [RecipeElement]
}

struct RecipeElement: Codable {
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    var cuisine: String?
}

struct ExtendedIngredient: Codable {
    let image: String
    let name: String
}

//struct Nutrition: Decodable {
//    let calories: [String: Any]
//    let carbs: [String: Any]
//    let fat: [String: Any]
//    let protein: [String: Any]
//}


//struct Nutrition {
//    let calories: Int
////    let carbs: Int
////    let fat: Int
////    let protein: Int
//    
//    init(json: [String: Any]) {
//        self.calories = json["calories"]["value"]
////        self.carbs = dictionary["jobName"] as? String ?? ""
////        self.fat = dictionary["jobName"] as? String ?? ""
////        self.protein = dictionary["jobName"] as? String ?? ""
//    }
//}

//extension Encodable {
//    var toDictionary: [String : Any]? {
//        guard let data =  try? JSONEncoder().encode(self) else {
//            return nil
//        }
//        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//    }
//}
