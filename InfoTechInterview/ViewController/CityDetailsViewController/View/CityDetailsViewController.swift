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

	weak var coordinator: CityDetailsCoordinator?

	var viewModel: CityDetailsViewModel!

	private var marker: Marker!

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
		scrollView.alwaysBounceVertical = true
		mapView.isUserInteractionEnabled = false
		viewModel.bindToController = { [weak self] in
			self?.update()
		}
	}
}

private extension CityDetailsViewController {

	func update() {
		setCoordinates(viewModel.city.coordinates)
	}

	func setCoordinates(_ coords: Coordinates) {
		mapView.setCenter(coords)
		marker = .init(coordinates: coords)
		mapView.addAnnotation(marker)
	}

}
