//
//  RepositoryDetailsViewController.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class RepositoryDetailsViewController: UIViewController {
    weak var eventHandler: (AnyObject & RepositoryDetailsModuleInterface)?
    
    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.updateView()
    }
    
    @IBAction private func didPressCloseButton(_ sender: Any) {
        eventHandler?.dissmissDetails()
    }
}

extension RepositoryDetailsViewController: RepositoryDetailsView {
    func showDetailsForRepository(from url: URL) {
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
