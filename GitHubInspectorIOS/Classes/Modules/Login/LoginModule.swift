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
}

/// Presenter
protocol LoginModuleInterface: class {
    // view & wireframe listener
    func continueLogin()
}

/// Presenter
protocol LoginInteractorOutput: class {
    // interactor listener
}

/// Interecator
protocol LoginInteractorInput {
    // presenter listener
}

