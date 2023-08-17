//
//  LoginFlowCoordinator.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import UIKit

protocol LoginFlowCoordinatorDependencies  {
    func makeLoginViewController() -> LoginViewController
}

final class LoginFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: LoginFlowCoordinatorDependencies
    
    private weak var loginVC: LoginViewController?

    init(navigationController: UINavigationController,
         dependencies: LoginFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeLoginViewController()
        navigationController?.pushViewController(vc, animated: false)
        loginVC = vc
    }
}
