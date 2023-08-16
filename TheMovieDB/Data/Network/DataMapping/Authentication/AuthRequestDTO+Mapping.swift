//
//  AuthRequestDTO+Mapping.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

struct AuthRequestDTO: Encodable {
    let email: String
    let password: String
}
