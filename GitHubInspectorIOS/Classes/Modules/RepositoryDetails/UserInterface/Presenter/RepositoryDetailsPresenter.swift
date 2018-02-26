//
//  RepositoryDetailsPresenter.swift
//  GitHubInspectorIOS
//
//  Created by Vladimir Kalinichenko on 2/26/18.
//  Copyright © 2018 Volodya wovan. All rights reserved.
//

import Foundation

class RepositoryDetailsPresenter {
    private let view: RepositoryDetailsView
    private let interactor: RepositoryDetailsInteractorInput
    private weak var wireframe: RepositoryDetailsWireframe?
    
    init(view: RepositoryDetailsView,
         interactor: RepositoryDetailsInteractorInput,
         wireframe: RepositoryDetailsWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension RepositoryDetailsPresenter: RepositoryDetailsModuleInterface {
    func updateView() {
        interactor.getUrlPageForRepositoryDetails()
    }
    
    func dissmissDetails() {
        wireframe?.dismissRepositoryDetailsView()
    }
}

extension RepositoryDetailsPresenter: RepositoryDetailsInteractorOutput {
    func getUrlPageForRepositoryDetails(_ url: URL) {
        view.showDetailsForRepository(from: url)
    }
}
