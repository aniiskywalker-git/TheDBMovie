//
//  TVShowsFlowCoordinator.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import UIKit

protocol TVShowsFlowCoordinatorDependencies  {
    func makeTVShowsListViewController(
        actions: TVShowsListViewModelActions
    ) -> TVShowsListViewController
    func makeTVShowsDetailViewController(tvShow: TVShow) -> UIViewController
}

final class TVShowsFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: TVShowsFlowCoordinatorDependencies

    private weak var moviesListVC: TVShowsListViewController?
    private weak var moviesQueriesSuggestionsVC: UIViewController?

    init(navigationController: UINavigationController,
         dependencies: TVShowsFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = TVShowsListViewModelActions(showTVShowDetails: showTVShowsDetails)
        let vc = dependencies.makeTVShowsListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        moviesListVC = vc
    }

    private func showTVShowsDetails(tvShow: TVShow) {
        let vc = dependencies.makeTVShowsDetailViewController(tvShow: tvShow)
        navigationController?.pushViewController(vc, animated: true)
    }
}
