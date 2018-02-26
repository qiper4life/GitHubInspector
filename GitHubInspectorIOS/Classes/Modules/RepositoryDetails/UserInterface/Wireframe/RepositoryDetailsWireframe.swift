//
//  RepositoryDetailsWireframe.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class RepositoryDetailsWireframe {
    private var presenter: RepositoryDetailsPresenter?
    private var detailsViewController: UIViewController?
    
    func presentRepositoryDetailsView(from vc: UIViewController, withDetails repo: Repository) {
        let interactor = RepositoryDetailsInteractor(repository: repo)
        let view = makeRepoDetailsViewController()
        view.modalPresentationStyle = .overCurrentContext
        presenter = RepositoryDetailsPresenter(view: view,
                                               interactor: interactor,
                                               wireframe: self)
        view.eventHandler = presenter
        interactor.output = presenter
        vc.present(view, animated: true, completion: nil)
        detailsViewController = view
    }
    
    func dismissRepositoryDetailsView() {
        detailsViewController?.dismiss(animated: true, completion: nil)
    }

    private func makeRepoDetailsViewController() -> RepositoryDetailsViewController {
        let repoDetailsViewController = storyboard().instantiateViewController(withIdentifier: "RepositoryDetailsViewController")
        return repoDetailsViewController as! RepositoryDetailsViewController
    }

    private func storyboard() -> UIStoryboard {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
