//
//  LoginModule.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 1/8/19.
//  Copyright © 2019 Volodya wovan. All rights reserved.
//

import Foundation

/// View
protocol LoginView: class {
    /// presenter listener
    func loginFailed()
    func loginSucceded()
}

/// Presenter
protocol LoginModuleInterface: class {
    func performLogin()
    func continueLogin()
}

/// Presenter
protocol LoginInteractorOutput: class {
    // interactor listener
    func loginSucceded(token: String)
    func loginFailed()
}

/// Interecator
protocol LoginInteractorInput {
    func loginUser()
    // presenter listener
}

