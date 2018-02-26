//
//  RepositoryDetailsInterector.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryDetailsInteractor: RepositoryDetailsInteractorInput {
    weak var output: (AnyObject & RepositoryDetailsInteractorOutput)?
    
    let repository: Repository
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getUrlPageForRepositoryDetails() {
        self.output?.getUrlPageForRepositoryDetails(repository.url)
    }
}
