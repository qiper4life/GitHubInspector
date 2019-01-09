//
//  AppDelegate.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/21/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let dependencies = AppDependencies.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let thing = NSThing()
        thing.someStrangeActivity()
        dependencies.rootWireframe.showLogin(from: window!)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.absoluteString.contains("githubinspectorios.githubauth") {
            if url.absoluteString.contains("githubinspectorios.githubauth://?code=") {
                let token = url.absoluteString.replacingOccurrences(of: "githubinspectorios.githubauth://?code=", with: "")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AppDelegateDidReceiveGitHubToken"),
                                                object: self,
                                                userInfo: ["code": token])
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AppDelegateDidFailGitHubAuth"),
                                                object: self,
                                                userInfo: nil)
            }
        }
        return true
    }
}

