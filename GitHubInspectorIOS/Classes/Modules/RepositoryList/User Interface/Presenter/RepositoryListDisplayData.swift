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
    private var _repositories: [Repository] = []
    private var repositories: [Repository] {
        return syncQueue.sync { _repositories }
    }
    
    func addRepositories(_ repositories: [Repository]) {
        syncQueue.async(flags: .barrier) { [weak self] in
            self?._repositories.append(contentsOf: repositories)
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
