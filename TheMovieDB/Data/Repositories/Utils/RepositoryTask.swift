//
//  RepositoryTask.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias on 16/08/23.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
