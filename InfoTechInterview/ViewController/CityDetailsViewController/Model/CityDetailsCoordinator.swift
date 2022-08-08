//
//  CityDetailsCoordinator.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation
import UIKit

protocol CityDetailsCoordinator: Coordinator {
	func didHide()
}

class DefaultCityDetailsCoordinator: CityDetailsCoordinator {

	var navigationController: UINavigationController
	var childCoordinators: [Coordinator] = []
	var parentCoordinator: Coordinator?

	var city: City

	init(navigationController: UINavigationController, city: City) {
		self.navigationController = navigationController
		self.city = city
	}

	func start() {
		let vc = CityDetailsViewController()
		vc.viewModel = DefaultCityDetailsViewModel(city: city)
		vc.coordinator = self
		navigationController.pushViewController(vc, animated: true)
	}

	func didHide() {
		parentCoordinator?.childDidFinish(self)
	}

}
