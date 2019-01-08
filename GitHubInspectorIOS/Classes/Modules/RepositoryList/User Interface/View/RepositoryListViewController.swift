//
//  RepositoryListViewController.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/25/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class RepositoryListViewController: UIViewController {
    weak var eventHandler: (AnyObject & RepositoryListModuleInterface)?
    fileprivate var repositories: RepositoryListDisplayData = RepositoryListDisplayData()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.loadNewPage()
    }
}

extension RepositoryListViewController: RepositoryListView {
    func showRepositories(_ repositories: RepositoryListDisplayData) {
        DispatchQueue.main.async {
            self.repositories = repositories
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: { _ in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
}

extension RepositoryListViewController: UITableViewDataSource {
    static let repositoryCellIdentifier = "RepositorySearchResultCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryListViewController.repositoryCellIdentifier, for: indexPath)
        guard let searchResultCell = cell as? RepositorySearchResultCell else {
            return UITableViewCell()
        }
        let repository = repositories[indexPath.row]
        searchResultCell.configure(displayRepository: repository)
        return searchResultCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1) {
            eventHandler?.loadNewPage()
        }
    }
}

extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories.repository(index: indexPath.row)
        eventHandler?.showDetails(of: repository)
    }
}
