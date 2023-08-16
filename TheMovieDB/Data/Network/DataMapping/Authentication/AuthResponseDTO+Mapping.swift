//
//  AuthResponseDTO+Mapping.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

struct AuthResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    let success: Bool
    let statusCode: Int
    let statusMessage: String
}
