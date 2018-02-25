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
    private let rootWireframe = RootWireframe()
    private var presenter: RepositoryListPresenter!
    
    func showRepositoryListView(from window: UIWindow) {
        let view = storyboard().instantiateViewController(withIdentifier: "RepositoryListViewController") as! RepositoryListViewController
        let reposProvider: RepositoryProvider = GitHubRepositoryProvider() // for now
        let interector = RepositoryListInteractor(repositoryProvider: reposProvider)
        let presenter = RepositoryListPresenter(interector: interector, view: view)
        interector.output = presenter
        self.presenter = presenter
        view.eventHandler = presenter
        rootWireframe.showRoot(viewController: view, from: window)
    }
    
    private func storyboard() -> UIStoryboard {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard
    }

}
