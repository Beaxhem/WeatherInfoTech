//
//  ApplicationCoordinator.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

protocol ApplicationCoordinator: Coordinator {
	func moveToDetails(city: City)
}


class DefaultApplicationCoordinator: ApplicationCoordinator {

	var navigationController: UINavigationController
	var childCoordinators: [Coordinator] = []
	var parentCoordinator: Coordinator?

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let vc = HomeViewController()
		vc.coordinator = self
		vc.viewModel = DefaultHomeViewModel()
		navigationController.pushViewController(vc, animated: false)
	}

	func moveToDetails(city: City) {
		addChild(DefaultCityDetailsCoordinator(navigationController: navigationController))
	}

}
