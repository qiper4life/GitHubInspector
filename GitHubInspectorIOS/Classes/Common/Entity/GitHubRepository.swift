//
//  GitHubRepository.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

struct GitHubRepository: Repository, Codable {
    var id: Int
    var name: String
    var description: String?
    var url: URL
    var score: Double
}
