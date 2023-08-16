//
//  TVShowsListViewController.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import UIKit



final class TVShowsListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak var segmentedOption: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: TVShowsListViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    
    static func create(
        with viewModel: TVShowsListViewModel,
        posterImagesRepository: PosterImagesRepository?
    ) -> TVShowsListViewController {
        let view = TVShowsListViewController.instantiateViewController()
        view.viewModel = viewModel
        view.posterImagesRepository = posterImagesRepository
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: TVShowsListViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func setupViews() {
        title = viewModel.screenTitle
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
}

extension TVShowsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension TVShowsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionView = UICollectionViewCell()
        return collectionView
    }
    
    
}
