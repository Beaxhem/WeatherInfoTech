//
//  Coordinator.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

protocol Coordinator {
	var navigationController: UINavigationController { get set }
	var childCoordinators: [Coordinator] { get set }
	var parentCoordinator: Coordinator? { get set }

	func start()
}
