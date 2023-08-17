//
//  TVShowsSceneDIContainer.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import UIKit

final class TVShowsSceneDIContainer: TVShowsFlowCoordinatorDependencies {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeTVShowsUseCase() -> TVShowsUseCase {
        DefaultTVShowsUseCasee(
            tvShowsRepository: makeTVShowsRepository()
        )
    }
    
    // MARK: - Repositories
    func makeTVShowsRepository() -> TVShowsRepository {
        DefaultTVShowsRepository(
            dataTransferService: dependencies.apiDataTransferService
        )
    }

    func makePosterImagesRepository() -> PosterImagesRepository {
        DefaultPosterImagesRepository(
            dataTransferService: dependencies.imageDataTransferService
        )
    }
    
    // MARK: - TV Shows List
    func makeTVShowsListViewController(actions: TVShowsListViewModelActions) -> TVShowsListViewController {
        TVShowsListViewController.create(
            with: makeTVShowsListViewModel(actions: actions),
            posterImagesRepository: makePosterImagesRepository()
        )
    }
    
    func makeTVShowsListViewModel(actions: TVShowsListViewModelActions) -> TVShowsListViewModel {
        DefaultTVShowsListViewModel(
            tvShowsUseCase: makeTVShowsUseCase(),
            actions: actions
        )
    }
    
    // MARK: - TV Shows Details
    /*func makeTVShowsDetailViewController(tvShow: TVShow) -> UIViewController {
        TVShowsDetailViewController.create(
            with: makeTVShowsDetailsViewModel(movie: movie)
        )
    }*/
    
    /*func makeTVShowsDetailsViewModel(tvShow: TVShow) -> TVShowDetailViewModel {
        DefaultMovieDetailsViewModel(
            tvShow: tvShow,
            posterImagesRepository: makePosterImagesRepository()
        )
    }*/


    // MARK: - Flow Coordinators
    func makeTVShowsFlowCoordinator(navigationController: UINavigationController) -> TVShowsFlowCoordinator {
        TVShowsFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
