//
//  AlamoNetworking.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 31.10.2022.
//

import Foundation
import Alamofire

class AlamoNetworking<T: Endpoint> {
    enum Result {
        case data(Data?)
        case error(Error)
    }
    
    private var host: String
    private var headers: [String : String]
    
    init(_ hostString: String, headers: [String : String] = [:]) {
        self.host = hostString
        self.headers = headers
    }
    
    func perform(_ method: HTTPMethod, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible, path: String, completion: @escaping (Result) -> ()) {
        AF.request(host + "/\(path)", method: method, parameters: parameters.parameters, headers: HTTPHeaders(headers))
            .response { response in
                if let error = response.error {
                    completion(.error(error))
                } else {
                    completion(.data(response.data))
                }
            }
    }
    
    func performAwait(_ method: HTTPMethod, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible, recipeID: String? = nil) async throws -> Data? {
        var requestPath = endpoint.details.pathComponent
        if let recipeID {
            requestPath += "\(recipeID)/information"
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            perform(method, endpoint, parameters, path: requestPath) { result in
                switch result {
                case .data(let data):
                    continuation.resume(returning: data)
                case .error(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}

