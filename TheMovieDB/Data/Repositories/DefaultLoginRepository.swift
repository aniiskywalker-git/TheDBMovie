//
//  DefaultLoginRepository.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

final class DefaultLoginRepository {
    
    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue

    init(
        dataTransferService: DataTransferService,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultLoginRepository: LoginRepository {
    
    func fetchLogin(email: String,
                    password: String,
                    completion: @escaping (Result<Bool, Error>) -> Void
    ) -> Cancellable? {
        let requestDTO = AuthRequestDTO(email: email, password: password)
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.authentication(with: requestDTO)

        task.networkTask = dataTransferService.request(
            with: endpoint,
            on: backgroundQueue
        ) { result in
            switch result {
            case .success( _):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
