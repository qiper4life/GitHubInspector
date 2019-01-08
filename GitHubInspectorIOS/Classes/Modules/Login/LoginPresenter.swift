//
//  LoginPresenter.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 1/8/19.
//  Copyright © 2019 Volodya wovan. All rights reserved.
//

import Foundation

class LoginPresenter: LoginModuleInterface, LoginInteractorOutput {
    weak var wireframe: LoginWireframe?
    let view: LoginView
    let interactor: LoginInteractorInput
    
    init(view: LoginView,
         wireframe: LoginWireframe,
         interactor: LoginInteractorInput) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func performLogin() {
        interactor.loginUser()
    }
    
    func continueLogin() {
        self.wireframe?.showRepositoriesList()
    }
    
    func loginSucceded() {
        view.loginSucceded()
    }
    
    func loginFailed() {
        view.loginFailed()
    }
    
}
