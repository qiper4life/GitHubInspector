//
//  RootWireframe.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import UIKit

class RootWireframe {

    let loginWireframe: LoginWireframe = LoginWireframe()
    
    func showLogin(from window: UIWindow) {
        loginWireframe.showLogin(from: self, in: window)
    }
    
    func showRoot(viewController: UIViewController, from window: UIWindow) {
        let navigationController = window.rootViewController as! UINavigationController
        navigationController.viewControllers = [viewController]
    }
}

func undefined<T>(_ msg: String = "Undefined in \(#file): \(#line).") -> T {
    fatalError(msg)
}

