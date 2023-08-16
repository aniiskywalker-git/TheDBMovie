//
//  APIEndpoint.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

struct APIEndpoints {
    
    static func authentication(with authRequestDTO: AuthRequestDTO) -> Endpoint<AuthResponseDTO> {

        return Endpoint(
            path: "3/authentication",
            method: .post,
            queryParametersEncodable: authRequestDTO
        )
    }
    
    static func getTVShows(with moviesRequestDTO: TVShowsRequestDTO, path: String) -> Endpoint<TVShowsResponseDTO> {

        return Endpoint(
            path: path,
            method: .get,
            queryParametersEncodable: moviesRequestDTO
        )
    }
    
    static func getTVShowPoster(path: String, width: Int) -> Endpoint<Data> {

        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes
            .enumerated()
            .min { abs($0.1 - width) < abs($1.1 - width) }?
            .element ?? sizes.first!
        
        return Endpoint(
            path: "t/p/w\(closestWidth)\(path)",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
}
