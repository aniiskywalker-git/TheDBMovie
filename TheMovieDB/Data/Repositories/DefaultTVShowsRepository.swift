//
//  DefaultTVShowsRepository.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

final class DefaultTVShowsRepository {

    private let dataTransferService: DataTransferService
    private let cache: TVShowsResponseStorage
    private let backgroundQueue: DataTransferDispatchQueue

    init(
        dataTransferService: DataTransferService,
        cache: TVShowsResponseStorage,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.cache = cache
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultTVShowsRepository: TVShowsRepository {

    func fetchTVShowsList(
        page: Int,
        cached: @escaping (TVShowsPage) -> Void,
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> Cancellable? {

        let requestDTO = TVShowsRequestDTO(page: page)
        let task = RepositoryTask()

        cache.getResponse(for: requestDTO) { [weak self, backgroundQueue] result in

            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            guard !task.isCancelled else { return }

            let endpoint = APIEndpoints.getTVShows(with: requestDTO, path: "3/tv/popular")
            task.networkTask = self?.dataTransferService.request(
                with: endpoint,
                on: backgroundQueue
            ) { result in
                switch result {
                case .success(let responseDTO):
                    self?.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
}
