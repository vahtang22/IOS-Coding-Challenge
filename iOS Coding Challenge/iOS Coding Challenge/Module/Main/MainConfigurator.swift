//
//  MainConfigurator.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: MainViewController)
}

class MainConfigurator: MainConfiguratorProtocol {
    func configure(with viewController: MainViewController) {
        let presenter = MainPresenter.init(view: viewController)
        let interactor = MainInteractor.init(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
