//
//  Schema.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 01.11.2022.
//

import Foundation


// MARK: - Recipes
struct RecipesList: Codable {
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let title: String
    let image: String
}

// MARK: - Random Recipes
struct RandomRecipesList: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
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

// MARK: - DishNutrition
struct DishNutrition: Codable {
    let calories, fat, protein, carbs: Calories
    
    var description: String {
        return
            "Calories: \(calories.value) \(calories.unit)\n" +
            "Fat: \(fat.value) \(fat.unit)\n" +
            "Protein: \(protein.value) \(protein.unit)\n" +
            "Carbs: \(carbs.value) \(carbs.unit)"
    }
}

// MARK: - Calories
struct Calories: Codable {
    let value: Int
    let unit: String
}
