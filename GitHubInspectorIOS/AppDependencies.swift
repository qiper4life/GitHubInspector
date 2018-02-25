//
//  AppDependencies.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

struct AppDependencies {
    let reposListWireframe: RepositoryListWireframe
    
    init() {
        self.reposListWireframe = RepositoryListWireframe()
    }
}
