//
//  ApplicationCoordinator.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class ApplicationCoordinator: Coordinator {

	var navigationController: UINavigationController
	var childCoordinators: [Coordinator] = []
	var parentCoordinator: Coordinator?

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let vc = HomeViewController()
		vc.viewModel = DefaultHomeViewModel()
		navigationController.pushViewController(vc, animated: false)
	}

}
