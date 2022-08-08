//
//  CityDetailsViewController.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit
import MapKit

class CityDetailsViewController: UIViewController {

	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var mapViewContainer: UIView!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var imageView: UIImageView!

	@IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var mapTopConstraint: NSLayoutConstraint!

	weak var coordinator: CityDetailsCoordinator?

	var viewModel: CityDetailsViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		coordinator?.didHide()
	}

}

private extension CityDetailsViewController {

	func setup() {
		setupView()
		update()
	}

	func setupView() {
		scrollView.delegate = self
		scrollView.alwaysBounceVertical = true
		mapView.isUserInteractionEnabled = false
		mapHeightConstraint.constant = Constants.mapViewHeight
		viewModel.bindToController = { [weak self] in
			self?.update()
		}
	}
}

private extension CityDetailsViewController {

	func update() {
		setCoordinates(to: viewModel.city)
	}

	func setCoordinates(to city: City) {
		mapView.setCenter(city.coordinates)
		mapView.removeAllAnnotations()
		mapView.addAnnotation(Marker(city: city))
		displayMap()
	}

	func displayMap() {
		let options = MKMapSnapshotter.Options()
		options.region = mapView.region
		options.mapRect = mapView.visibleMapRect
		options.camera = mapView.camera
		options.pointOfInterestFilter = .includingAll

		let snapshotter = MKMapSnapshotter(options: options)

		snapshotter.start { [weak self] snapshot, error in
			guard let snapshot = snapshot else { return }
			self?.mapView.isHidden = true
			self?.imageView.image = snapshot.image
		}
	}
}

extension CityDetailsViewController: UIScrollViewDelegate {

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y < 0.0 {
			mapHeightConstraint.constant = Constants.mapViewHeight - scrollView.contentOffset.y
		} else {
			mapHeightConstraint.constant = Constants.mapViewHeight - self.scrollView.contentOffset.y
			mapTopConstraint?.constant = view.frame.origin.y
		}
	}

}

extension CityDetailsViewController {

	enum Constants {
		static let mapViewHeight: CGFloat = 200
	}

}
