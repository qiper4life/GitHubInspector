//
//  RepositorySearchRequest.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

protocol RepositorySearchRequest {
    var query: String { get }
    var page: Int { get }
    var perPage: Int { get }
    var sort: String? { get }
    var order: String? { get }
}
