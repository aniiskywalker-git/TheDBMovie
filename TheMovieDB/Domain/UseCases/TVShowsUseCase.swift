//
//  TVShowsUseCase.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

protocol TVShowsUseCase {
    func execute(
        requestValue: TVShowsUseCaseRequestValue,
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultTVShowsUseCasee: TVShowsUseCase {

    private let tvShowsRepository: TVShowsRepository

    init(tvShowsRepository: TVShowsRepository) {

        self.tvShowsRepository = tvShowsRepository
    }

    func execute(
        requestValue: TVShowsUseCaseRequestValue,
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> Cancellable? {

        return tvShowsRepository.fetchTVShowsList(
            page: requestValue.page,
            completion: { result in

            if case .success = result { }

            completion(result)
        })
    }
}

struct TVShowsUseCaseRequestValue {
    let page: Int
}
