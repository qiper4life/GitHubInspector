//
//  GitHubRepositorySearchRequest.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

struct GitHubRepositorySearchRequest: RepositorySearchRequest, Equatable {
    let query: String
    let page: Int
    let perPage: Int
    let sort: String?
    let order: String?
    
    init(repositoryRequest: RepositorySearchRequest) {
        self.init(query: repositoryRequest.query,
                  page: repositoryRequest.page,
                  perPage: repositoryRequest.perPage,
                  sort: repositoryRequest.sort,
                  order: repositoryRequest.order)
    }
    
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

extension GitHubRepositorySearchRequest {
    static func ==(lhs: GitHubRepositorySearchRequest, rhs: GitHubRepositorySearchRequest) -> Bool {
        return lhs.query == rhs.query &&
            lhs.page == rhs.page &&
            lhs.perPage == rhs.perPage &&
            lhs.sort == rhs.sort &&
            lhs.order == rhs.order
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
