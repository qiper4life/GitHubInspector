//
//  RepositoryListDisplayData.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryListDisplayData {
    // Parallel reading, barrier writing
    private let syncQueue = DispatchQueue(label: "com.vladimirWowan.GitHubInspectorIOS.SynchronizedDisplayData",
                                          attributes: .concurrent)
    
    private var _repositories: [Repository] = []
    
    var repositories: [Repository] {
        var repos: [Repository]!
        syncQueue.async {
            repos = self._repositories
        }
        return repos
    }
    
    func addRepositories(_ repositories: [Repository]) {
        syncQueue.async(flags: .barrier) {
            self._repositories.append(contentsOf: repositories)
        }
    }
}
