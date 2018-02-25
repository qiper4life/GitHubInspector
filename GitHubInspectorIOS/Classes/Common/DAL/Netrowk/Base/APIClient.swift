//
//  APIClient.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

enum APIClientError: Error {
    case urlRequestError(Error)
    case noResopnseFromURLRequest(URLRequest)
}

protocol APIClient {
    var urlSession: URLSession { get }
    func performRequest<T>(_ reqeust: T, _ completion: @escaping (Result<T.Response>) -> ()) where T: Request
}

extension APIClient {
    func performRequest<T>(_ reqeust: T, _ completion: @escaping (Result<T.Response>) -> ()) where T: Request {
        let urlRequest = reqeust.urlRequest()
        let task = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let `error` = error {
                completion(.error(APIClientError.urlRequestError(error)))
                return
            }
            guard let `data` = data else {
                completion(.error(APIClientError.noResopnseFromURLRequest(urlRequest)))
                return
            }
        }
        task.resume()
    }
}
