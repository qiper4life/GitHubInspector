//
//  RepositorySearchResultCell.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation
import UIKit

class RepositorySearchResultCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    func configure(displayRepository repo: RepositorySearchResultDisplayData) {
        self.titleLabel.text = repo.title
        self.descriptionLabel.text = repo.description
        self.scoreLabel.text = repo.score
    }
}
