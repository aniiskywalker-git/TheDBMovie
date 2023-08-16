//
//  UseCase.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
