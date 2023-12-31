//
//  TVShowsResponseStorage.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

//MARK: To Storage
protocol TVShowsResponseStorage {
    func getResponse(
        for request: TVShowsRequestDTO,
        completion: @escaping (Result<TVShowsResponseDTO?, Error>) -> Void
    )
    
    func save(response: TVShowsResponseDTO, for requestDto: TVShowsRequestDTO)
}
