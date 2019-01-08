//
//  RepositoryListPresenter.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryListPresenter {
    private let interactor: RepositoryListInteractorInput
    private let view: RepositoryListView
    private weak var wireframe: RepositoryListWireframe?
    
    private var repositories: RepositoryListDisplayData
    private var counter: Int = 0
    
    init(interector: RepositoryListInteractorInput,
         view: RepositoryListView,
         wireframe: RepositoryListWireframe) {
        self.interactor = interector
        self.view = view
        self.wireframe = wireframe
        self.repositories = RepositoryListDisplayData()
    }
}

extension RepositoryListPresenter: RepositoryListModuleInterface {
    func loadNewPage() {
        let request1 = GitHubRepositorySearchRequest(query: "tetris", page: counter)
        counter += 1
        let request2 = GitHubRepositorySearchRequest(query: "tetris", page: counter)
        counter += 1
        interactor.searchRepos(for: request1)
        interactor.searchRepos(for: request2)
    }
    
    func cancelSearh() {
        // implement
    }
    
    func showDetails(of repo: Repository) {
        wireframe?.presentRepositoryDetails(for: repo)
    }
}

extension RepositoryListPresenter: RepositoryListInteractorOutput {
    func foundRepos(_ repos: [Repository], for request: RepositorySearchRequest) {
        repositories.addRepositories(repos)
        view.showRepositories(repositories)
    }
    
    func errorWhileLookingForRepos(_ error: Error, for request: RepositorySearchRequest) {
        view.showError(error)
    }
}
