//
//  TVShowsListViewModel.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

struct TVShowsListViewModelActions {
    let showTVShowDetails: (TVShow) -> Void
}

enum TVShowsListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol TVShowsListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

protocol TVShowsListViewModelOutput {
    //TODO: add items
    //var items: Observable<[TVShowsListItemViewModel]> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
}

typealias TVShowsListViewModel = TVShowsListViewModelInput & TVShowsListViewModelOutput

final class DefaultTVShowsListViewModel: TVShowsListViewModel {
    
    private let tvShowsUseCase: TVShowsUseCase
    private let actions: TVShowsListViewModelActions?

    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    var isEmpty: Bool

    private var pages: [TVShowsPage] = []
    private var tvShowsLoadTask: Cancellable? { willSet { tvShowsLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType

    // MARK: - OUTPUT
    //TODO: add items
    //let items: Observable<[TVShowsListItemViewModel]> = Observable([])
    let error: Observable<String> = Observable("")
    //TODO: add if is empty
    //var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    init(
        tvShowsUseCase: TVShowsUseCase,
        actions: TVShowsListViewModelActions? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.tvShowsUseCase = tvShowsUseCase
        self.actions = actions
        self.mainQueue = mainQueue
        self.isEmpty = false
    }

    // MARK: - to append new pages

    private func appendPage(_ tvShowsPage: TVShowsPage) {
        currentPage = tvShowsPage.page
        totalPageCount = tvShowsPage.totalPages

        pages = pages
            .filter { $0.page != tvShowsPage.page }
            + [tvShowsPage]

        //TODO: Add items
        //items.value = pages.tvshows.map(TVShowsListItemViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        //TODO: add items
        //items.value.removeAll()
    }


    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }

}

// MARK: - INPUT. View event methods

extension DefaultTVShowsListViewModel {

    func viewDidLoad() { }

    func didSelectItem(at index: Int) {
        actions?.showTVShowDetails(pages.tvShows[index])
    }
}


private extension Array where Element == TVShowsPage {
    var tvShows: [TVShow] { flatMap { $0.tvShows } }
}
