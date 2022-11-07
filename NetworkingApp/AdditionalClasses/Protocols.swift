//
//  Protocols.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 07.11.2022.
//

import Foundation

protocol Endpoint {
    var details: (pathComponent: String, parameter: String) { get }
}

protocol NetworkRequestBodyConvertible {
    var data: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String : Any]? { get }
}
