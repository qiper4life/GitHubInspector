//
//  RepositoryProvider.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

protocol RepositoryProvider {
    func findRepos(for request: RepositorySearchRequest,
                   _ completion: @escaping (Result<Repository>) -> ())
}
