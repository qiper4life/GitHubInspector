//
//  RepositoryListPresenter.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryListPresenter {
    let repositoryListInteractor: RepositoryListInteractorInput
//    let wireframe: Any // put wirefreame here
//    let userInterface: RepositoryListView
    
    func педаль() {
//        repositoryListInteractor.searchRepos(for: <#T##RepositorySearchRequest#>)
    }
    
    init(repositoryListInteractor: RepositoryListInteractorInput) {
        self.repositoryListInteractor = repositoryListInteractor
    }
}

extension RepositoryListPresenter: RepositoryListInteractorOutput {
    func foundRepos(_ repos: [Repository], for request: RepositorySearchRequest) {
//        view.takeThis
    }
    
    func errorWhileLookingForRepos(_ error: Error, for request: RepositorySearchRequest) {
//        view.takeThisTootwo
    }
}
