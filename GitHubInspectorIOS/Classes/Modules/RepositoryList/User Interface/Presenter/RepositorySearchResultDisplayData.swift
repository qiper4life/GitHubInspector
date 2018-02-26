//
//  RepositorySearchResultDisplayData.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

struct RepositorySearchResultDisplayData {
    let title: String
    let score: String
    let description: String?
    
    init(repository: Repository) {
        title = repository.name
        score = RepositorySearchResultDisplayData.getDisplayScore(from: repository.score)
        description = RepositorySearchResultDisplayData.getDisplayDescription(from: repository.description)
    }
    
    static func getDisplayScore(from score: Double) -> String {
        let scoreStr = String(format: "%.2f", score)
        return "\(scoreStr) ⭐"
    }
    
    static func getDisplayDescription(from description: String?) -> String? {
        let displayDescription: String?
        if let description = description {
            if description.count >= 31 {
                let endIndex = description.index(description.startIndex, offsetBy: 31)
                let shortDescriptionSlice = description[..<endIndex]
                displayDescription = String(shortDescriptionSlice)
            } else {
                displayDescription = description
            }
        } else {
            displayDescription = nil
        }
        return displayDescription
    }
}
