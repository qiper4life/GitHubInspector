//
//  RepositoryListWireframe.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class RepositoryListWireframe {
    
    private let repoDetailsWireframe = RepositoryDetailsWireframe()
    private var presenter: RepositoryListPresenter?
    
    private var repositoryListViewController: UIViewController?
    func showRepositoryListView(from nc: UINavigationController) {
        let view = makeRepositoryListViewController()
        let reposProvider: RepositoryProvider = GitHubRepositoryProvider() // for now
        let interector = RepositoryListInteractor(repositoryProvider: reposProvider)
        let presenter = RepositoryListPresenter(interector: interector,
                                                view: view,
                                                wireframe: self)
        interector.output = presenter
        self.presenter = presenter
        view.eventHandler = presenter
        nc.pushViewController(view, animated: true)
        repositoryListViewController = view
    }
    
    private func makeRepositoryListViewController() -> RepositoryListViewController {
        let repositoryListViewController = storyboard().instantiateViewController(withIdentifier: "RepositoryListViewController")
        return repositoryListViewController as! RepositoryListViewController
    }
    
    private func storyboard() -> UIStoryboard {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
    func presentRepositoryDetails(for repo: Repository) {
        guard let currentRepoListViewController = repositoryListViewController else {
            return
        }
        repoDetailsWireframe.presentRepositoryDetailsView(from: currentRepoListViewController,
                                                          withDetails: repo)
    }
}
