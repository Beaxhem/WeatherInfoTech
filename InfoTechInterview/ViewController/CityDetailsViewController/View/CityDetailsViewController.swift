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
	@IBOutlet weak var gradientView: GradientView!

	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var weatherDescriptionLabel: UILabel!

	@IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var mapTopConstraint: NSLayoutConstraint!

	weak var coordinator: CityDetailsCoordinator?

	var viewModel: CityDetailsViewModel!

	private var mapHeight: CGFloat {
		view.frame.height / 3
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		update()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		coordinator?.didHide()
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		let alpha = traitCollection.userInterfaceStyle == .dark ? 1 : 0.3
		let bottomColor: UIColor = .black.withAlphaComponent(alpha)
		gradientView.colors = [.clear, bottomColor]
	}

}

private extension CityDetailsViewController {

	func setupView() {
		scrollView.delegate = self
		scrollView.alwaysBounceVertical = true
		mapView.isUserInteractionEnabled = false
		mapHeightConstraint.constant = mapHeight
		viewModel.bindToController = { [weak self] in
			DispatchQueue.main.async { [weak self] in 
				self?.update()
			}
		}
		traitCollectionDidChange(nil)
	}

}

private extension CityDetailsViewController {

	func update() {
		setWeatherData()
		setCoordinates(to: viewModel.city)
	}

	func setWeatherData() {
		cityNameLabel.text = viewModel.city.name
		if let weatherData = viewModel.weatherData {
			temperatureLabel.text = "\(weatherData.main.temperature)°"
			weatherDescriptionLabel.text = weatherData.description
		} else {
			temperatureLabel.text = "..."
			weatherDescriptionLabel.text = ""
		}
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
			mapHeightConstraint.constant = mapHeight - scrollView.contentOffset.y
		} else {
			mapHeightConstraint.constant = mapHeight - self.scrollView.contentOffset.y
			mapTopConstraint?.constant = view.frame.origin.y
		}
	}

}
