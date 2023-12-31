//
//  DefaultTVShowsRepository.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

final class DefaultTVShowsRepository {

    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue

    init(
        dataTransferService: DataTransferService,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultTVShowsRepository: TVShowsRepository {

    func fetchTVShowsList(
        page: Int,
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> Cancellable? {

        let requestDTO = TVShowsRequestDTO(page: page)
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.getTVShows(with: requestDTO, path: "3/tv/popular")
        task.networkTask = dataTransferService.request(
            with: endpoint,
            on: backgroundQueue
        ) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
