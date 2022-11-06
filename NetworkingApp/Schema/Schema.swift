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

// MARK: - Recipe
struct Recipe: Codable {
    let calories, fat, protein, carbs: Calories
    
    var description: String {
        return
            "Calories: \(calories.value) \(calories.unit)\n" +
            "Fat: \(fat.value) \(fat.unit)\n" +
            "Protein: \(protein.value) \(protein.unit)\n" +
            "Carbs: \(carbs.value) \(carbs.unit)\n"
    }
}

// MARK: - Calories
struct Calories: Codable {
    let value: Int
    let unit: String
}
