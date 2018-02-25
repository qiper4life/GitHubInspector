//
//  RepositoryListInteractorIO.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

protocol RepositoryListInteractorInput {
    func searchRepos(for request: RepositorySearchRequest)
}

protocol RepositoryListInteractorOutput: class {
    func foundRepos(_ repos: [Repository], for request: RepositorySearchRequest)
    func errorWhileLookingForRepos(_ error: Error, for request: RepositorySearchRequest)
}
