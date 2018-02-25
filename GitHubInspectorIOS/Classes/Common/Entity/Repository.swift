//
//  Repository.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

protocol Repository {
    var name: String { get }
    var description: String? { get }
    var url: URL { get }
    var score: Double { get }
}
