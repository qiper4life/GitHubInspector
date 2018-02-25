//
//  GitHubRepositorySearchRequest.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

struct GitHubRepositorySearchRequest {
    let query: String
    let page: Int
    let perPage: Int
    let sort: String?
    let order: String?
    
    init(query: String,
         page: Int,
         perPage: Int = 15,
         sort: String? = "stars",
         order: String? = "desc") {
        self.query = query
        self.page = page
        self.perPage = perPage
        self.sort = sort
        self.order = order
    }
}

extension GitHubRepositorySearchRequest: Request {
    typealias Response = GitHubRepositoryPack
    
    var url: URL {
        return URL(string: "http://api.github.com/search/repositories")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryParams: [String: String] {
        var params: [String: String] = [:]
        params["q"] = query
        params["sort"] = sort
        params["order"] = order
        params["page"] = "\(page)"
        params["per_page"] = "\(perPage)"
        return params
    }
}
