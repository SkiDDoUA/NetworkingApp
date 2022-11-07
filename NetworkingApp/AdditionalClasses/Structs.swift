//
//  Structs.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 07.11.2022.
//

import Foundation

struct NetworkSettings {
    static var headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "59ca79f22emshfb362fb4da9a242p18e413jsn177512184626",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    static var networkService = Network<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: headers)
    
    static var networkServiceAlamofire = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: headers)
}

struct RecipesQuery: NetworkRequestBodyConvertible {
    var text: String
    var parameter: RecipesEndpoint
    
    init(_ text: String, _ parameter: RecipesEndpoint) {
        self.text = text
        self.parameter = parameter
    }
    
    var data: Data? {
        "\(parameter.details.parameter)=\(text)".data(using: .utf8)
    }
    
    var queryItems: [URLQueryItem]? { nil }
    var parameters: [String : Any]? {
        ["\(parameter.details.parameter)" : text]
    }
}

struct SegueIdentifier {
    static var toRecipe = "toRecipe"
}
