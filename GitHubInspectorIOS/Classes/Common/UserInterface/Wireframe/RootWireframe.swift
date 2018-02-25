//
//  RootWireframe.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe {
    func showRoot(viewController: UIViewController, from window: UIWindow) {
        guard let navigationController = window.rootViewController as? UINavigationController else {
            fatalError("Expected to have `UINavigationController` in \(window) rootViewController got: \(window.rootViewController!)")
        }
        navigationController.viewControllers = [viewController]
    }
}
