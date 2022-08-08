//
//  GradientView.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class GradientView: UIView {

	override class var layerClass: AnyClass { CAGradientLayer.self }

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}

	func setupView() {
		guard let layer = layer as? CAGradientLayer else { return }
		layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
		layer.locations = [0, 1]
	}

}
