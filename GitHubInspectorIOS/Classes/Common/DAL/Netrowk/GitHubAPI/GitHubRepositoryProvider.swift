//
//  GitHubRepositoryProvider.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class GitHubRepositoryProvider: RepositoryProvider {
    let gitHubClient: GitHubAPIClient
    
    init(gitHubClient: GitHubAPIClient = .default) {
        self.gitHubClient = gitHubClient
    }
    
    func findRepos(for request: RepositorySearchRequest,
                   _ completion: @escaping (Result<[Repository]>) -> ()) {
        let searchRequest = GitHubRepositorySearchRequest(repositoryRequest: request)
        gitHubClient.performRequest(searchRequest) { result in
            switch result {
            case .value(let reposPack):
                completion(.value(reposPack.items))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
