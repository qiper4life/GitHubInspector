//
//  LoginWireframe.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 1/8/19.
//  Copyright © 2019 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class LoginWireframe {
    private let repoListWireframe = RepositoryListWireframe()

    var presenter: LoginPresenter?
    weak var view: LoginViewController?
    
    func showLogin(from root: RootWireframe, in window: UIWindow) {
        let view = makeLoginViewController()
        self.view = view
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: view,
                                       wireframe: self,
                                       interactor:interactor)
        self.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        root.showRoot(viewController: view, from: window)
    }
    
    func makeLoginViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        return vc as! LoginViewController
    }
    
    func showRepositoriesList() {
        let nc = view!.navigationController
        repoListWireframe.showRepositoryListView(from: nc!)
    }
}
