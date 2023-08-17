//
//  LoginSceneDIContainer.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import UIKit

final class LoginSceneDIContainer: LoginFlowCoordinatorDependencies {

    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeLoginUseCase() -> LoginUseCase {
        DefaultLoginUseCase (
            loginRepository: makeLoginRepository()
        )
    }
    
    func makeLoginRepository() -> LoginRepository {
        DefaultLoginRepository(
            dataTransferService: dependencies.apiDataTransferService
        )
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        DefaultLoginViewModel(loginUseCase: makeLoginUseCase())
    }
    
    func makeLoginViewController() -> LoginViewController {
        LoginViewController.create(with: makeLoginViewModel())
    }

    // MARK: - Flow Coordinators
    func makeTVShowsFlowCoordinator(navigationController: UINavigationController) -> LoginFlowCoordinator {
        LoginFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
