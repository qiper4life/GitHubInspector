//
//  LoginInteractor.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 1/8/19.
//  Copyright © 2019 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class LoginInteractor: LoginInteractorInput {
    
    weak var output: LoginInteractorOutput?
    
    private let clientID = "bd3c1720106db6bae9d5"
    private let clientSecret = "b25e76e15e7a277d9c9e21fa84a7f55d4bd0ea6e"
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LoginInteractor.didRecieveGithubAuthToken(notification:)),
                                               name: NSNotification.Name(rawValue: "AppDelegateDidReceiveGitHubToken"),
                                               object: UIApplication.shared.delegate)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LoginInteractor.didRecieveGithubAuthToken(notification:)),
                                               name: NSNotification.Name(rawValue: "AppDelegateDidFailGitHubAuth"),
                                               object: UIApplication.shared.delegate)
        
    }
    
    func loginUser() {
//        let user = "qiper4life"
//        let url = URL(string: "https://github.com/login/oauth/authorize?scope=\(user)&client_id=\(clientID)")!
        let url = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientID)")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc
    func didRecieveGithubAuthToken(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let code = userInfo["code"] as? String else {
            output?.loginFailed()
            return
        }
        let urlString = "https://github.com/login/oauth/access_token?client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            /// code
            guard let `self` = self else { return }
            sleep(2)
            guard error == nil else {
                self.output?.loginFailed() // Custom response error
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                    self.output?.loginFailed() // Got wrong reponse status code
                    return
            }
            guard let responseData = data,
                let anyResponse = try? JSONSerialization.jsonObject(with: responseData, options: .init(rawValue: 0)),
                let jsonResponse = anyResponse as? [String: Any],
                let accessToken = jsonResponse["access_token"] as? String else {
                    self.output?.loginFailed() // Failed to parse response
                    return
            }
            // Got token
            print(accessToken)
            self.output?.loginSucceded()
        }
        task.resume()
    }
    
    @objc
    func didFailGitHubAuth(notification: Notification) {
        self.output?.loginFailed()
    }
}
