//
//  GitHubApiClient.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class GitHubAPIClient: APIClient {
    let urlSession: URLSession
    
    static let `default`: GitHubAPIClient = GitHubAPIClient()
    
    init() {
        self.urlSession = URLSession(configuration: .default)
    }
}
