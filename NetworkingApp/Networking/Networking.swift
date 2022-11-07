//
//  Networking.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 31.10.2022.
//

import Foundation

final class Network<T: Endpoint> {
    enum Result {
        case data(Data?)
        case error(Error)
    }
    
    private var host: URL
    private var headers: [String : String]
    private var session = URLSession.shared
    
    init(_ hostString: String, headers: [String: String] = [:]) {
        let url = URL(string: hostString)
        self.host = url!
        self.headers = headers
    }
    
    private func makeRequest(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible) -> URLRequest {
        var request = URLRequest(url: host.appending(path: endpoint.details.pathComponent))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method == .get {
            request.url?.append(queryItems: parameters.queryItems ?? [])
        } else if method == .post {
            request.httpBody = parameters.data
        }
        
        return request
    }
    
    func perform(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible, completion: @escaping (Result) -> ()) {
        let request = makeRequest(method, endpoint, parameters)
        
        session.dataTask(with: request) { data, _, error in
            if let error {
                completion(.error(error))
            } else {
                completion(.data(data))
            }
        }.resume()
    }
    
    func performAwait(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible) async throws -> Data {
        let request = makeRequest(method, endpoint, parameters)
        let (data, _) = try await session.data(for: request)
        return data
    }
}
