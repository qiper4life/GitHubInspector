//
//  RepositoryListPresenter.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryListPresenter: RepositoryListModuleInterface {
    let interactor: RepositoryListInteractorInput
    let view: RepositoryListView
    private var displayData: RepositoryListDisplayData
    
    func updateView() {
//        repositoryListInteractor.searchRepos(for: <#T##RepositorySearchRequest#>)
    }
    
    func cancelSearh() {
        
    }
    
    init(interector: RepositoryListInteractorInput,
         view: RepositoryListView) {
        self.interactor = interector
        self.view = view
        self.displayData = RepositoryListDisplayData()
    }
}

extension RepositoryListPresenter: RepositoryListInteractorOutput {
    func foundRepos(_ repos: [Repository], for request: RepositorySearchRequest) {
        self.displayData.addRepositories(repos)
        view.showData(displayData)
    }
    
    func errorWhileLookingForRepos(_ error: Error, for request: RepositorySearchRequest) {
        view.showError(error)
    }
}
