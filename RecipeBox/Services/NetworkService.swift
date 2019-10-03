//
//  NetworkService.swift
//  RecipeBox
//
//  Network Service to communicate to the api
//
//  Created by Reshma Unnikrishnan on 25.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import Foundation
import UIKit

/// NetworkDispatcher protocol
public protocol NetworkServiceProtocol {
    func execute(request : RequestData,
                 onSuccess: @escaping (AnyObject) -> Void,
                 onError: @escaping (Error) -> Void)
}

/// Https methods available
public enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// API endpoints
public enum APIEndPoint {
    case user(login: String)
    case showRecipes
}

/// End point types
public protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
}

/// Extension to the endpoint type
extension APIEndPoint: EndpointType {
    public var baseURL: URL {
        return URL(string: "https://api.hellofresh.com")!
    }
    
    public var path: String {
        switch self {
        case .user(login: let login):
            return "/users/\(login)"
        case .showRecipes:
            return "/libary/recipes"
        }
    }
}

///  Request data
public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public let params: [String: Any?]?
    public let headers: [String: String]?
    
    public init (
        path: String,
        method: HTTPMethod = .get,
        params: [String: Any?]? = nil,
        headers: [String: String]? = nil
        ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}

/// Response errors
public enum ResponseError: Swift.Error {
    case noData
    case invalidUrl
    case parseDataError
}

/// Networks Service
public class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Public methods
    
    public func execute(request: RequestData, onSuccess: @escaping (AnyObject) -> Void, onError: @escaping (Error) -> Void) {
        
        guard let url = NSURL(string: request.path) else {
            onError(ResponseError.invalidUrl)
            return
        }
        
        var urlRequest = URLRequest(url: url as URL)
        urlRequest.httpMethod = request.method.rawValue
        
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response ,error in
            if let error = error {
                onError(error)
                return
            }
            
            guard let responseData = data  else {
                onError(ResponseError.noData)
                return
            }
            
            do {
                guard let parsedData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
                }
                onSuccess(parsedData as AnyObject)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            }.resume()
    }
}
