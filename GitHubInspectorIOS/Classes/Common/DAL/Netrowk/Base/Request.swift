//
//  Request.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// TO DO: implement: headers, shcema, host, path, headers, etc...
protocol Request {
    associatedtype Response
    var url: URL { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var queryParams: [String: String] { get }
    func reponse(from data: Data) -> Response?
}

// MARK: default values
extension Request {
    var body: Data? {
        return nil
    }
    
    var queryParams: [URLQueryItem] {
        return []
    }
}

// MARK: building reponse from URL response data
extension Request where Response: RawDataInitable {
    func reponse(from data: Data) -> Response? {
        guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json = jsonData as? [AnyHashable: Any] else {
                return nil
        }
        return Response(json: json)
    }
}

// MARK: To URLRequest converting
extension Request {
    func querryItems() -> [URLQueryItem] {
        return queryParams.map { URLQueryItem(name: $0, value: $1) }
    }
    
    func urlRequest() -> URLRequest {
        let url: URL
        if queryParams.isEmpty {
            url = self.url
        } else {
            var components = URLComponents(url: self.url, resolvingAgainstBaseURL: true)
            components?.queryItems = querryItems()
            if let urlWithParams = components?.url {
                url = urlWithParams
            } else {
                url = self.url
            }
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        return urlRequest
    }
}
