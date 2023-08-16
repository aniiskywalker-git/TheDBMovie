//
//  TVShow.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

struct TVShow: Equatable {
    typealias Identifier = String
    
    let id: Identifier
    let name: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
}

struct TVShowsPage: Equatable {
    let page: Int
    let totalPages: Int
    let tvShows: [TVShow]
}
