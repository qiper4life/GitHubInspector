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
    fileprivate var data: RepositoryListDisplayData = RepositoryListDisplayData()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.updateView()
    }
}

extension RepositoryListViewController: RepositoryListView {
    func showData(_ data: RepositoryListDisplayData) {
        DispatchQueue.main.async {
            self.data = data
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = self.data.repositories[indexPath.row]
        let cell = UITableViewCell()
        cell.detailTextLabel?.text = repo.description
        cell.textLabel?.text = repo.name
        return cell
    }
}
