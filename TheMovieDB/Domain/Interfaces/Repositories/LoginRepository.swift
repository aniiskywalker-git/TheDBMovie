//
//  LoginRepository.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

protocol LoginRepository {
    func fetchLogin(
        email: String,
        password: String,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) -> Cancellable?
}
