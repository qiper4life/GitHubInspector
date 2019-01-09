//
//  AppDependencies.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

@objc
class AppDependencies: NSObject {
    
    @objc
    static let shared = AppDependencies()
    
    let rootWireframe = RootWireframe()
    let gitAccount = GitAccount()
    
    @objc
    var funnyArray: [Any] = []
}

class GitAccount {
    var token: String?
}
