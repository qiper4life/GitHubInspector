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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url = "html_url"
        case score
    }
}

extension GitHubRepository: Equatable {
    static func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.url == rhs.url &&
            lhs.score == rhs.score
    }
}
