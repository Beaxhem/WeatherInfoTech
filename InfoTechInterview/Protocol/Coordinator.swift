//
//  Coordinator.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

protocol Coordinator: AnyObject {
	var navigationController: UINavigationController { get set }
	var childCoordinators: [Coordinator] { get set }
	var parentCoordinator: Coordinator? { get set }

	func start()
}

extension Coordinator {

	func addChild(_ coordinator: Coordinator) {
		coordinator.parentCoordinator = self
		childCoordinators.append(coordinator)
		coordinator.start()
	}

	func childDidFinish(_ coordinator: Coordinator) {
		for (index, child) in childCoordinators.enumerated() where child === coordinator {
			childCoordinators.remove(at: index)
			break
		}
	}

}
