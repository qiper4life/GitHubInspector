//
//  RepositoryListInteractor.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryListInteractor: RepositoryListInteractorInput {
    weak var output: RepositoryListInteractorOutput?
    
    let repositoryProvider: RepositoryProvider
    init(repositoryProvider: RepositoryProvider) {
        self.repositoryProvider = repositoryProvider
    }
    
    func searchRepos(for request: RepositorySearchRequest) {
        self.repositoryProvider.findRepos(for: request) { [unowned self] result in
            switch result {
            case .value(let repos):
                self.output?.foundRepos(repos, for: request)
            case .error(let error):
                self.output?.errorWhileLookingForRepos(error, for: request)
            }
        }
    }
}
