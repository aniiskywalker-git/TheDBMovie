//
//  LoginUseCase.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

protocol LoginUseCase {
    func execute(
        requestValue: LoginUseCaseRequestValue,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultLoginUseCase: LoginUseCase {

    private let loginRepository: LoginRepository

    init(loginRepository: LoginRepository) {

        self.loginRepository = loginRepository
    }

    func execute(
        requestValue: LoginUseCaseRequestValue,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) -> Cancellable? {

        return loginRepository.fetchLogin(
            email: requestValue.email,
            password: requestValue.password,
            completion: { result in
            if case .success = result { }

            completion(result)
        })
    }
}

struct LoginUseCaseRequestValue {
    let email: String
    let password: String
}
