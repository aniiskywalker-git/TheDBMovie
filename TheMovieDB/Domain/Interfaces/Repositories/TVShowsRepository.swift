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
        cached: @escaping (TVShowsPage) -> Void,
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> Cancellable?
}
