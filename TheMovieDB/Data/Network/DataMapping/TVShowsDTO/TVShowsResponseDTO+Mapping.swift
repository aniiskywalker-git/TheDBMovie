//
//  PopularTVShowsResponseDTO+Mapping.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

struct TVShowsResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case tvShows = "results"
    }
    let page: Int
    let totalPages: Int
    let tvShows: [TVShowsDTO]
}

extension TVShowsResponseDTO {
    struct TVShowsDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case posterPath = "poster_path"
            case overview
            case releaseDate = "first_air_date"
            case voteAvg = "vote_average"
        }
        
        let id: Int
        let name: String?
        let posterPath: String?
        let overview: String?
        let releaseDate: String?
        let voteAvg: Double?
    }
}

// MARK: - Mappings to Domain

extension TVShowsResponseDTO {
    func toDomain() -> TVShowsPage {
        return .init(page: page,
                     totalPages: totalPages,
                     tvShows: tvShows.map { $0.toDomain() })
    }
}

extension TVShowsResponseDTO.TVShowsDTO {
    func toDomain() -> TVShow {
        return .init(id: TVShow.Identifier(id),
                     name: name,
                     posterPath: posterPath,
                     overview: overview,
                     releaseDate: dateFormatter.date(from: releaseDate ?? ""))
    }
}


// MARK: - date formatter

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
