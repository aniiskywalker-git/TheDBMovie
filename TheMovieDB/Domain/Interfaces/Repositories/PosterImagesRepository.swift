//
//  PosterImagesRepository.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

protocol PosterImagesRepository {
    func fetchImage(
        with imagePath: String,
        width: Int,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable?
}
