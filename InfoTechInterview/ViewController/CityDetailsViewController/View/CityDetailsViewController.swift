//
//  CityDetailsViewController.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class CityDetailsViewController: UIViewController {

	weak var coordinator: CityDetailsCoordinator?

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		coordinator?.didHide()
	}

}
