//
//  HomeViewController.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class HomeViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!

	private let activityIndicator = UIActivityIndicatorView(style: .medium)

	var viewModel: HomeViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

}

private extension HomeViewController {

	func setup() {
		setupView()
		setupSearchController()
		setupCollectionView()
	}

	func setupView() {
		title = "Home"
		definesPresentationContext = true
		navigationItem.hidesSearchBarWhenScrolling = false
		viewModel.bindToController = { [weak self] in
			self?.update()
		}
	}

	func setupCollectionView() {
		collectionView.backgroundView = activityIndicator
		activityIndicator.hidesWhenStopped = true
		activityIndicator.startAnimating()
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.delaysContentTouches = false
		collectionView.contentInset = .init(top: 15, left: 25, bottom: 30, right: 25)
		let cityCellIdentifier = String(describing: CityCell.self)
		collectionView.register(UINib(nibName: cityCellIdentifier,
									  bundle: .main),
								forCellWithReuseIdentifier: cityCellIdentifier)
	}

	func setupSearchController() {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search cities"
		navigationItem.searchController = searchController
	}

}

private extension HomeViewController {

	func update() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.collectionView.reloadData()
			if self.viewModel.isLoaded {
				self.activityIndicator.stopAnimating()
			} else {
				self.activityIndicator.startAnimating()
			}
		}
	}

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let contentInset = collectionView.contentInset
		let width = collectionView.bounds.width - contentInset.left - contentInset.right
		return .init(width: width,
			  height: 50)
	}

	func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)
		UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) { [weak cell] in
			cell?.transform = .init(scaleX: 0.95, y: 0.95)
		}

	}

	func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)
		UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) { [weak cell] in
			cell?.transform = .identity
		}
	}

}

extension HomeViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.cities.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CityCell.self),
															for: indexPath) as? CityCell else {
			return .init()
		}
		let city = viewModel.cities[indexPath.item]
		cell.update(city: city)
		return cell
	}

}

extension HomeViewController: UISearchResultsUpdating {

	func updateSearchResults(for searchController: UISearchController) {
		let query = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
		if let query = query {
			viewModel.query = query
		}
	}

}
