//
//  AppDIContainer.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.apiBaseURL)!,
            queryParameters: [
                "api_key": appConfiguration.apiKey,
                "language": NSLocale.preferredLanguages.first ?? "en"
            ]
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    lazy var imageDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.imagesBaseURL)!
        )
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeLoginSceneDIContainer() -> LoginSceneDIContainer {
        let dependencies = LoginSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService
        )
        return LoginSceneDIContainer(dependencies: dependencies)
    }
    
    func makeTVShowsSceneDIContainer() -> TVShowsSceneDIContainer {
        let dependencies = TVShowsSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService,
            imageDataTransferService: imageDataTransferService
        )
        return TVShowsSceneDIContainer(dependencies: dependencies)
    }
}
