//
//  RepositoryListDisplayData.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryListDisplayData {
    private let syncQueue = DispatchQueue(label: "com.vladimirWowan.GitHubInspectorIOS.SynchronizedDisplayData",
                                          attributes: .concurrent)
    /// Write into this property
    private var _repositories: [Repository] = []
    /// Read this property
    private var repositories: [Repository] {
        var repos: [Repository]!
        syncQueue.sync {
            repos = self._repositories
        }
        return repos
    }
    
    func addRepositories(_ repositories: [Repository]) {
        syncQueue.async(flags: .barrier) {
            self._repositories.append(contentsOf: repositories)
        }
    }
    
    subscript(index: Int) -> RepositorySearchResultDisplayData {
        get {
            return RepositorySearchResultDisplayData(repository: repository(index: index))
        }
    }
    
    func count() -> Int {
        return repositories.count
    }
    
    func repository(index: Int) -> Repository {
        return repositories[index]
    }
}
