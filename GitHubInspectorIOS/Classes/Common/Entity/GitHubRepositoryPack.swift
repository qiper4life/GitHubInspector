//
//  GitHubRepositoryPack.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

struct GitHubRepositoryPack: Codable {
    let items: Array<GitHubRepository>
    let totalCount: Int
    let incomplete: Bool
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
        case incomplete = "incomplete_results"
    }
}
