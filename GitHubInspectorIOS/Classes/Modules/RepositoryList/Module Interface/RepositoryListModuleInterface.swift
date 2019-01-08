//
//  RepositoryListModuleInterface.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

protocol RepositoryListModuleInterface {
    func loadNewPage()
    func cancelSearh()
    func showDetails(of repo: Repository)
}
