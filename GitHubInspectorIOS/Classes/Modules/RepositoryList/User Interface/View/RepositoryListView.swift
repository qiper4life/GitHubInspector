//
//  RepositoryListView.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

protocol RepositoryListView {
    func showRepositories(_ repositories: RepositoryListDisplayData)
    func showError(_ error: Error)
}
