//
//  AppFlowCoordinator.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {

        let loginSceneDIContainer = appDIContainer.makeLoginSceneDIContainer()
        let flow = loginSceneDIContainer.makeTVShowsFlowCoordinator(navigationController: navigationController)
        flow.start()

    }
}
