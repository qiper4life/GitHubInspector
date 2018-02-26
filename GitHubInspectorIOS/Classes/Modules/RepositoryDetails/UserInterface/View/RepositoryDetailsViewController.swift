//
//  RepositoryDetailsViewController.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class RepositoryDetailsViewController: UIViewController {
    weak var eventHandler: (AnyObject & RepositoryDetailsModuleInterface)?
}

extension RepositoryDetailsViewController: RepositoryDetailsView {
    func showDetailsForRepository(from url: URL) {
        
    }
}
