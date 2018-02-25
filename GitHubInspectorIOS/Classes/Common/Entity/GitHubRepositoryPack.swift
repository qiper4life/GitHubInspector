//
//  GitHubRepositoryPack.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

struct GitHubRepositoryPack: RawDataInitable {
    let pack: Array<GitHubRepository>
    
    init?(json: [AnyHashable: Any]) {
        pack = []
    }
}
