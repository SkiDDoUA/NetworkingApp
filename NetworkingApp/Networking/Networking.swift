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

struct RecipeAnalyzelnstruction: NetworkRequestBodyConvertible {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var data: Data? {
        "instructions=\(text)".data(using: .utf8)
    }
    
    var queryItems: [URLQueryItem]? { nil }
    var parameters: [String : Any]? {
        ["instructions" : text]
    }
}

protocol Endpoint {
    var pathComponent: String { get }
}

enum RecipesEndpoint: String, Endpoint {
    case analyzer = "recipes/analyzeInstructions"
    var pathComponent: String {
        rawValue
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
        var request = URLRequest(url: host.appending(path: endpoint.pathComponent))
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
