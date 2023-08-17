//
//  TVShowsRepository.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

protocol TVShowsRepository {
    @discardableResult
    func fetchTVShowsList(
        page: Int,
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> Cancellable?
}
