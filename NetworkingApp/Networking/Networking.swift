//
//  Networking.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 31.10.2022.
//

import Foundation

protocol NetworkRequestBodyConvertible {
    var data: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String : Any]? { get }
}

struct RecipesQuery: NetworkRequestBodyConvertible {
    var text: String?
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

struct NetworkSettings {
    static var headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "4e63d4faa0msh378a71badc41377p1acfa1jsnee0352aaf9dc",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    static var networkService = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: headers)
}

protocol Endpoint {
    var details: (pathComponent: String, parameter: String) { get }
}

enum RecipesEndpoint: String, Endpoint {
    case analyzer
    case recipes
    case recipeInformation
    case nutrition
    case cuisine
    case random
    
    var details: (pathComponent: String, parameter: String) {
        switch self {
        case .analyzer:
            return (pathComponent: "recipes/analyzeInstructions", parameter: "instructions")
        case .recipes:
            return (pathComponent: "recipes/complexSearch", parameter: "query")
        case .recipeInformation:
            return (pathComponent: "recipes/", parameter: "id")
        case .nutrition:
            return (pathComponent: "recipes/guessNutrition", parameter: "title")
        case .cuisine:
            return (pathComponent: "recipes/cuisine", parameter: "ingredientList")
        case .random:
            return (pathComponent: "recipes/random", parameter: "number")
        }
    }
}

final class Network<T: Endpoint> {
    //https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com
    
    enum Result {
        case data(Data?)
        case error(Error)
    }
    
    enum NetworkError: Error {
        case badHostString
    }
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
        case patch = "PATCH"
    }
    
    private var host: URL
    private var headers: [String : String]
    private var session = URLSession.shared
    
    init(_ hostString: String, headers: [String: String] = [:]) throws {
        if let url = URL(string: hostString) {
            self.host = url
            self.headers = headers
            
            return
        }
        throw NetworkError.badHostString
    }
    
    private func makeRequest(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible?) -> URLRequest {
        var request = URLRequest(url: host.appending(path: endpoint.details.pathComponent))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method == .get {
            request.url?.append(queryItems: parameters?.queryItems ?? [])
        } else if method == .post {
            request.httpBody = parameters?.data
        }
        
        return request
    }
    
    func perform(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible? = nil, completion: @escaping (Result) -> ()) {
        let request = makeRequest(method, endpoint, parameters)
        
        session.dataTask(with: request) { data, _, error in
            if let error {
                completion(.error(error))
            } else {
                completion(.data(data))
            }
        }.resume()
    }
    
    func perform(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible? = nil) async throws -> Data {
        let request = makeRequest(method, endpoint, parameters)
        let (data, _) = try await session.data(for: request)
        return data
    }
}
