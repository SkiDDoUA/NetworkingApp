//
//  Enums.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 07.11.2022.
//

import Foundation

enum RecipesEndpoint: Endpoint {
    case analyzer
    case recipes
    case recipeInformation(id: Int)
    case nutrition
    case cuisine
    case random
    
    var details: (pathComponent: String, parameter: String) {
        switch self {
        case .analyzer:
            return (pathComponent: "recipes/analyzeInstructions", parameter: "instructions")
        case .recipes:
            return (pathComponent: "recipes/complexSearch", parameter: "query")
        case .recipeInformation(let id):
            return (pathComponent: "recipes/\(id)/information", parameter: "id")
        case .nutrition:
            return (pathComponent: "recipes/guessNutrition", parameter: "title")
        case .cuisine:
            return (pathComponent: "recipes/cuisine", parameter: "ingredientList")
        case .random:
            return (pathComponent: "recipes/random", parameter: "number")
        }
    }
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}
